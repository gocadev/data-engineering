/* STAGING - UnitOfMeasure */
CREATE TABLE stg_UnitOfMeasure (
    UnitOfMeasureId INT NULL,
    Code NVARCHAR(255) NULL,
    Description NVARCHAR(MAX) NULL
);


/* STAGING - InventoryCategory */
CREATE TABLE stg_InventoryCategory (
    InventoryCategoryId INT NULL,
    Name NVARCHAR(255) NULL,
    Description NVARCHAR(MAX) NULL
);


/* STAGING - PartnerType */
CREATE TABLE stg_PartnerType (
    PartnerTypeId INT NULL,
    Name NVARCHAR(255) NULL
);


/* STAGING - BusinessPartner */
CREATE TABLE stg_BusinessPartner (
    PartnerId INT NULL,
    Name NVARCHAR(255) NULL,
    PartnerTypeId INT NULL,
    Address NVARCHAR(MAX) NULL,
    TaxNumber NVARCHAR(255) NULL,
    RegistrationNumber NVARCHAR(255) NULL,
    Note NVARCHAR(MAX) NULL
);


/* STAGING - Site */
CREATE TABLE stg_Site (
    SiteId INT NULL,
    Name NVARCHAR(255) NULL,
    Type INT NULL,
    Description NVARCHAR(MAX) NULL,
    Address NVARCHAR(MAX) NULL,
    PriceType INT NULL
);


/* STAGING - InventoryItem */
CREATE TABLE stg_InventoryItem (
    InventoryItemId INT NULL,
    Name NVARCHAR(255) NULL,
    Description NVARCHAR(MAX) NULL,
    UnitOfMeasureId INT NULL,
    Price FLOAT NULL,
    InventoryCategoryId INT NULL,
    Brand NVARCHAR(255) NULL
);


/* STAGING - DocumentHeader */
CREATE TABLE stg_DocumentHeader (
    DocumentId INT NULL,
    DocumentTypeId INT NULL,
    DocumentDate DATETIME2 NULL,
    CreatedAt DATETIME2 NULL,
    UpdatedAt DATETIME2 NULL,
    Status INT NULL,
    SiteId INT NULL,
    PartnerId INT NULL,
    Note NVARCHAR(MAX) NULL,
    DocumentNumber NVARCHAR(255) NULL,
    LinkedDocumentNumber NVARCHAR(255) NULL,
    CreatedByUserId NVARCHAR(255) NULL
);


/* STAGING - DocumentLine */
CREATE TABLE stg_DocumentLine (
    LineId INT NULL,
    DocumentId INT NULL,
    LineNumber INT NULL,
    InventoryItemId INT NULL,
    Quantity FLOAT NULL,
    UnitOfMeasureId INT NULL,
    Price FLOAT NULL
);


/* STAGING - BillOfMaterials */
CREATE TABLE stg_BillOfMaterials (
    BillOfMaterialsId INT NULL,
    ProductId INT NULL,
    Description NVARCHAR(MAX) NULL,
    EffectiveDate DATETIME2 NULL,
    Status INT NULL
);


/* STAGING - BillOfMaterialsLine */
CREATE TABLE stg_BillOfMaterialsLine (
    LineId INT NULL,
    BillOfMaterialsId INT NULL,
    LineNumber INT NULL,
    MaterialId INT NULL,
    Quantity FLOAT NULL,
    UnitOfMeasureId INT NULL,
    Scrap FLOAT NULL
);


/* STAGING - ProductionOrder */
CREATE TABLE stg_ProductionOrder (
    ProductionOrderId INT NULL,
    DocumentTypeId INT NULL,
    OrderDate DATETIME2 NULL,
    CreatedAt DATETIME2 NULL,
    UpdatedAt DATETIME2 NULL,
    Status INT NULL,
    MaterialSiteId INT NULL,
    ProductSiteId INT NULL,
    PartnerId INT NULL,
    ProductId INT NULL,
    Quantity FLOAT NULL,
    UnitOfMeasureId INT NULL,
    Price FLOAT NULL,
    BillOfMaterialsId INT NULL,
    LinkedDocumentId INT NULL
);


/* STAGING - ProductionOrderLine */
CREATE TABLE stg_ProductionOrderLine (
    LineId INT NULL,
    ProductionOrderId INT NULL,
    LineNumber INT NULL,
    MaterialId INT NULL,
    Quantity FLOAT NULL,
    UnitOfMeasureId INT NULL,
    Scrap FLOAT NULL
);


/* STAGING - StockCount */
CREATE TABLE stg_StockCount (
    StockCountId INT NULL,
    SiteId INT NULL,
    CountDate DATETIME2 NULL,
    CreatedAt DATETIME2 NULL,
    UpdatedAt DATETIME2 NULL,
    Status INT NULL,
    CreatedByUserId NVARCHAR(255) NULL
);


/* STAGING - StockCountLine */
CREATE TABLE stg_StockCountLine (
    LineId INT NULL,
    StockCountId INT NULL,
    LineNumber INT NULL,
    InventoryItemId INT NULL,
    QuantityRecorded FLOAT NULL,
    QuantityExpected FLOAT NULL,
    UnitOfMeasureId INT NULL
);


/* STAGING - SiteInventory */
CREATE TABLE stg_SiteInventory (
    SiteInventoryId INT NULL,
    SiteId INT NULL,
    InventoryItemId INT NULL,
    Quantity FLOAT NULL,
    Price FLOAT NULL
);

/* STAGING - DocumentType */
CREATE TABLE stg_DocumentType (
    DocumentTypeId INT NULL,
    Name NVARCHAR(255) NULL
);
