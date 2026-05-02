CREATE TABLE dim_Item (
    ItemKey INT IDENTITY(1,1) PRIMARY KEY,
    ItemId INT,
    Name NVARCHAR(255),
    Description NVARCHAR(MAX),
    Category NVARCHAR(255),
    Brand NVARCHAR(255),
    UnitOfMeasure NVARCHAR(255),
    Price FLOAT
);


CREATE TABLE dim_Site (
    SiteKey INT IDENTITY(1,1) PRIMARY KEY,
    SiteId INT,
    Name NVARCHAR(255),
    Type INT,
    Address NVARCHAR(MAX),
    PriceType INT
);


CREATE TABLE dim_Partner (
    PartnerKey INT IDENTITY(1,1) PRIMARY KEY,
    PartnerId INT,
    Name NVARCHAR(255),
    PartnerType NVARCHAR(255),
    Address NVARCHAR(MAX),
    TaxNumber NVARCHAR(255),
    RegistrationNumber NVARCHAR(255)
);


CREATE TABLE dim_DocumentType (
    DocumentTypeKey INT IDENTITY(1,1) PRIMARY KEY,
    DocumentTypeId INT,
    Name NVARCHAR(255)
);


CREATE TABLE dim_Date (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName NVARCHAR(20),
    Day INT,
    DayOfWeek INT,
    DayName NVARCHAR(20)
);


CREATE TABLE dim_UnitOfMeasure (
    UnitKey INT IDENTITY(1,1) PRIMARY KEY,
    UnitOfMeasureId INT,
    Code NVARCHAR(255),
    Description NVARCHAR(MAX)
);


CREATE TABLE dim_InventoryCategory (
    CategoryKey INT IDENTITY(1,1) PRIMARY KEY,
    InventoryCategoryId INT,
    Name NVARCHAR(255),
    Description NVARCHAR(MAX)
);

CREATE TABLE dim_BOMProduct (
    BOMProductKey INT IDENTITY(1,1) PRIMARY KEY,
    BillOfMaterialsId INT,
    ProductId INT,
    ProductName NVARCHAR(255),
    EffectiveDate DATE,
    Status INT
);

CREATE TABLE fact_DocumentLine (
    DocumentLineKey INT IDENTITY(1,1) PRIMARY KEY,

    -- Foreign keys to dimensions (surrogate keys)
    DateKey INT,
    DocumentTypeKey INT,
    SiteKey INT,
    PartnerKey INT,
    ItemKey INT,

    -- Business identifiers
    DocumentId INT,
    LineNumber INT,

    -- Measures
    Quantity FLOAT,
    Price FLOAT,
    Revenue FLOAT
);


CREATE TABLE fact_Inventory (
    InventoryKey INT IDENTITY(1,1) PRIMARY KEY,

    -- Dimension keys
    SiteKey INT,
    ItemKey INT,

    -- Measures
    Quantity FLOAT,
    Price FLOAT,
    Value FLOAT
);


CREATE TABLE fact_Production (
    ProductionKey INT IDENTITY(1,1) PRIMARY KEY,

    -- Dimension keys
    DateKey INT,
    SiteKey INT,
    PartnerKey INT,
    ItemKey INT,          -- product
    MaterialKey INT,      -- material

    -- Business identifiers
    ProductionOrderId INT,
    LineNumber INT,

    -- Measures
    QuantityProduced FLOAT,
    MaterialQuantity FLOAT,
    Scrap FLOAT
);


CREATE TABLE fact_StockCount (
    StockCountKey INT IDENTITY(1,1) PRIMARY KEY,

    -- Dimension keys
    DateKey INT,
    SiteKey INT,
    ItemKey INT,

    -- Business identifiers
    StockCountId INT,
    LineNumber INT,

    -- Measures
    QuantityExpected FLOAT,
    QuantityRecorded FLOAT,
    Difference FLOAT
);


CREATE TABLE fact_BOMUsage (
    BOMUsageKey INT IDENTITY(1,1) PRIMARY KEY,

    -- Dimension keys
    BOMProductKey INT,
    ItemKey INT,   -- material

    -- Business identifiers
    BillOfMaterialsId INT,
    LineNumber INT,

    -- Measures
    Quantity FLOAT,
    Scrap FLOAT
);


CREATE TABLE fact_DocumentHeader (
    DocumentHeaderKey INT IDENTITY(1,1) PRIMARY KEY,

    -- Dimension keys
    DateKey INT,
    DocumentTypeKey INT,
    SiteKey INT,
    PartnerKey INT,

    -- Business identifiers
    DocumentId INT,

    -- Measures
    TotalLines INT,
    TotalQuantity FLOAT,
    TotalRevenue FLOAT
);



