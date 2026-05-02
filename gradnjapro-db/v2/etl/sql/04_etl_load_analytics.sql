/***** LOAD DIMENSION TABLES *****/

/* LOAD DIMENSION: dim_Item */

TRUNCATE TABLE dim_Item;

INSERT INTO dim_Item (
    ItemId,
    Name,
    Description,
    Category,
    Brand,
    UnitOfMeasure,
    Price
)
SELECT
    i.InventoryItemId,
    i.Name,
    i.Description,
    c.Name AS Category,
    i.Brand,
    u.Code AS UnitOfMeasure,
    i.Price
FROM stg_InventoryItem i
LEFT JOIN stg_InventoryCategory c ON c.InventoryCategoryId = i.InventoryCategoryId
LEFT JOIN stg_UnitOfMeasure u ON u.UnitOfMeasureId = i.UnitOfMeasureId;



/* LOAD DIMENSION: dim_Site */

TRUNCATE TABLE dim_Site;

INSERT INTO dim_Site (
    SiteId,
    Name,
    Type,
    Address,
    PriceType
)
SELECT
    SiteId,
    Name,
    Type,
    Address,
    PriceType
FROM stg_Site;



/* LOAD DIMENSION: dim_Partner */

TRUNCATE TABLE dim_Partner;

INSERT INTO dim_Partner (
    PartnerId,
    Name,
    PartnerType,
    Address,
    TaxNumber,
    RegistrationNumber
)
SELECT
    p.PartnerId,
    p.Name,
    pt.Name AS PartnerType,
    p.Address,
    p.TaxNumber,
    p.RegistrationNumber
FROM stg_BusinessPartner p
LEFT JOIN stg_PartnerType pt ON pt.PartnerTypeId = p.PartnerTypeId;



/* LOAD DIMENSION: dim_DocumentType */

TRUNCATE TABLE dim_DocumentType;

INSERT INTO dim_DocumentType (
    DocumentTypeId,
    Name
)
SELECT
    DocumentTypeId,
    Name
FROM stg_DocumentType;



/* LOAD DIMENSION: dim_UnitOfMeasure */

TRUNCATE TABLE dim_UnitOfMeasure;

INSERT INTO dim_UnitOfMeasure (
    UnitOfMeasureId,
    Code,
    Description
)
SELECT
    UnitOfMeasureId,
    Code,
    Description
FROM stg_UnitOfMeasure;



/* LOAD DIMENSION: dim_InventoryCategory */

TRUNCATE TABLE dim_InventoryCategory;

INSERT INTO dim_InventoryCategory (
    InventoryCategoryId,
    Name,
    Description
)
SELECT
    InventoryCategoryId,
    Name,
    Description
FROM stg_InventoryCategory;



/* LOAD DIMENSION: dim_BOMProduct */

TRUNCATE TABLE dim_BOMProduct;

INSERT INTO dim_BOMProduct (
    BillOfMaterialsId,
    ProductId,
    ProductName,
    EffectiveDate,
    Status
)
SELECT
    b.BillOfMaterialsId,
    b.ProductId,
    i.Name AS ProductName,
    b.EffectiveDate,
    b.Status
FROM stg_BillOfMaterials b
LEFT JOIN stg_InventoryItem i ON i.InventoryItemId = b.ProductId;



/* LOAD DIMENSION: dim_Date
   Note: This dimension is generated, not loaded from staging. */

TRUNCATE TABLE dim_Date;

DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2030-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO dim_Date (
        DateKey,
        FullDate,
        Year,
        Quarter,
        Month,
        MonthName,
        Day,
        DayOfWeek,
        DayName
    )
    SELECT
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate);

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;

GO

/***** LOAD FACT TABLES *****/
/* FACT: fact_DocumentLine */

TRUNCATE TABLE fact_DocumentLine;

INSERT INTO fact_DocumentLine (
    DateKey,
    DocumentTypeKey,
    SiteKey,
    PartnerKey,
    ItemKey,
    DocumentId,
    LineNumber,
    Quantity,
    Price,
    Revenue
)
SELECT
    d.DateKey,
    dt.DocumentTypeKey,
    s.SiteKey,
    p.PartnerKey,
    i.ItemKey,
    l.DocumentId,
    l.LineNumber,
    l.Quantity,
    l.Price,
    l.Quantity * l.Price AS Revenue
FROM stg_DocumentLine l
JOIN stg_DocumentHeader h ON h.DocumentId = l.DocumentId
LEFT JOIN dim_Date d ON d.FullDate = CAST(h.DocumentDate AS DATE)
LEFT JOIN dim_DocumentType dt ON dt.DocumentTypeId = h.DocumentTypeId
LEFT JOIN dim_Site s ON s.SiteId = h.SiteId
LEFT JOIN dim_Partner p ON p.PartnerId = h.PartnerId
LEFT JOIN dim_Item i ON i.ItemId = l.InventoryItemId;



/* FACT: fact_Inventory */

TRUNCATE TABLE fact_Inventory;

INSERT INTO fact_Inventory (
    SiteKey,
    ItemKey,
    Quantity,
    Price,
    Value
)
SELECT
    s.SiteKey,
    i.ItemKey,
    si.Quantity,
    si.Price,
    si.Quantity * si.Price AS Value
FROM stg_SiteInventory si
LEFT JOIN dim_Site s ON s.SiteId = si.SiteId
LEFT JOIN dim_Item i ON i.ItemId = si.InventoryItemId;



/* FACT: fact_Production */

TRUNCATE TABLE fact_Production;

INSERT INTO fact_Production (
    DateKey,
    SiteKey,
    PartnerKey,
    ItemKey,
    MaterialKey,
    ProductionOrderId,
    LineNumber,
    QuantityProduced,
    MaterialQuantity,
    Scrap
)
SELECT
    d.DateKey,
    s.SiteKey,
    p.PartnerKey,
    prodItem.ItemKey AS ProductKey,
    matItem.ItemKey AS MaterialKey,
    po.ProductionOrderId,
    pol.LineNumber,
    po.Quantity AS QuantityProduced,
    pol.Quantity AS MaterialQuantity,
    pol.Scrap
FROM stg_ProductionOrderLine pol
JOIN stg_ProductionOrder po ON po.ProductionOrderId = pol.ProductionOrderId
LEFT JOIN dim_Date d ON d.FullDate = CAST(po.OrderDate AS DATE)
LEFT JOIN dim_Site s ON s.SiteId = po.ProductSiteId
LEFT JOIN dim_Partner p ON p.PartnerId = po.PartnerId
LEFT JOIN dim_Item prodItem ON prodItem.ItemId = po.ProductId
LEFT JOIN dim_Item matItem ON matItem.ItemId = pol.MaterialId;



/* FACT: fact_StockCount */

TRUNCATE TABLE fact_StockCount;

INSERT INTO fact_StockCount (
    DateKey,
    SiteKey,
    ItemKey,
    StockCountId,
    LineNumber,
    QuantityExpected,
    QuantityRecorded,
    Difference
)
SELECT
    d.DateKey,
    s.SiteKey,
    i.ItemKey,
    sc.StockCountId,
    scl.LineNumber,
    scl.QuantityExpected,
    scl.QuantityRecorded,
    scl.QuantityRecorded - scl.QuantityExpected AS Difference
FROM stg_StockCountLine scl
JOIN stg_StockCount sc ON sc.StockCountId = scl.StockCountId
LEFT JOIN dim_Date d ON d.FullDate = CAST(sc.CountDate AS DATE)
LEFT JOIN dim_Site s ON s.SiteId = sc.SiteId
LEFT JOIN dim_Item i ON i.ItemId = scl.InventoryItemId;



/* FACT: fact_BOMUsage */

TRUNCATE TABLE fact_BOMUsage;

INSERT INTO fact_BOMUsage (
    BOMProductKey,
    ItemKey,
    BillOfMaterialsId,
    LineNumber,
    Quantity,
    Scrap
)
SELECT
    bp.BOMProductKey,
    i.ItemKey,
    bl.BillOfMaterialsId,
    bl.LineNumber,
    bl.Quantity,
    bl.Scrap
FROM stg_BillOfMaterialsLine bl
LEFT JOIN dim_BOMProduct bp ON bp.BillOfMaterialsId = bl.BillOfMaterialsId
LEFT JOIN dim_Item i ON i.ItemId = bl.MaterialId;



/* FACT: fact_DocumentHeader (optional) */

TRUNCATE TABLE fact_DocumentHeader;

INSERT INTO fact_DocumentHeader (
    DateKey,
    DocumentTypeKey,
    SiteKey,
    PartnerKey,
    DocumentId,
    TotalLines,
    TotalQuantity,
    TotalRevenue
)
SELECT
    d.DateKey,
    dt.DocumentTypeKey,
    s.SiteKey,
    p.PartnerKey,
    h.DocumentId,
    COUNT(l.LineId) AS TotalLines,
    SUM(l.Quantity) AS TotalQuantity,
    SUM(l.Quantity * l.Price) AS TotalRevenue
FROM stg_DocumentHeader h
LEFT JOIN stg_DocumentLine l ON l.DocumentId = h.DocumentId
LEFT JOIN dim_Date d ON d.FullDate = CAST(h.DocumentDate AS DATE)
LEFT JOIN dim_DocumentType dt ON dt.DocumentTypeId = h.DocumentTypeId
LEFT JOIN dim_Site s ON s.SiteId = h.SiteId
LEFT JOIN dim_Partner p ON p.PartnerId = h.PartnerId
GROUP BY
    d.DateKey,
    dt.DocumentTypeKey,
    s.SiteKey,
    p.PartnerKey,
    h.DocumentId;