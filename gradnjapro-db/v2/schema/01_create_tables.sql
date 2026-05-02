/** Document Management **/

/* DocumentType */

CREATE TABLE DocumentType (
    DocumentTypeId INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Code NVARCHAR(10) NOT NULL,
    Category NVARCHAR(20) NOT NULL
);

/* DocumentHeader */

CREATE TABLE DocumentHeader (
    DocumentId INT IDENTITY(1,1) NOT NULL,
    DocumentTypeId INT NULL,
    DocumentDate DATETIME2(7) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL,
    UpdatedAt DATETIME2(7) NOT NULL,
    Status INT NOT NULL,
    SiteId INT NULL,
    PartnerId INT NULL,
    Note NVARCHAR(200) NULL,
    DocumentNumber NVARCHAR(30) NOT NULL,
    LinkedDocumentNumber NVARCHAR(30) NULL,
    CreatedByUserId NVARCHAR(128) NULL
);

/* DocumentLine */

CREATE TABLE DocumentLine (
    LineId INT IDENTITY(1,1) NOT NULL,
    DocumentId INT NOT NULL,
    LineNumber INT NOT NULL,
    InventoryItemId INT NOT NULL,
    Quantity FLOAT NOT NULL,
    UnitOfMeasureId INT NOT NULL,
    Price FLOAT NOT NULL
);

/* DocumentTransport */

CREATE TABLE DocumentTransport (
    DocumentId INT NOT NULL,
    VehicleId INT NULL,
    DriverId INT NULL,
    CarrierId INT NULL
);

/* DocumentLink */

CREATE TABLE DocumentLink (
    DocumentId INT NOT NULL,
    LinkedDocumentId INT NOT NULL,
    LinkTypeId INT NOT NULL
);

/** Inventory & Materials  **/

/* InventoryCategory */

CREATE TABLE InventoryCategory (
    InventoryCategoryId INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200) NULL
);

/* UnitOfMeasure */

CREATE TABLE UnitOfMeasure (
    UnitOfMeasureId INT IDENTITY(1,1) NOT NULL,
    Code NVARCHAR(10) NOT NULL,
    Description NVARCHAR(50) NULL
);

/* InventoryItem */

CREATE TABLE InventoryItem (
    InventoryItemId INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200) NULL,
    UnitOfMeasureId INT NOT NULL,
    Price FLOAT NULL,
    InventoryCategoryId INT NULL,
    Brand NVARCHAR(50) NULL
);

/* Site */

CREATE TABLE Site (
    SiteId INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Type INT NOT NULL,
    Description NVARCHAR(200) NULL,
    Address NVARCHAR(200) NULL,
    PriceType INT NOT NULL
);

/* SiteInventory */

CREATE TABLE SiteInventory (
    SiteInventoryId INT IDENTITY(1,1) NOT NULL,
    SiteId INT NOT NULL,
    InventoryItemId INT NOT NULL,
    Quantity FLOAT NOT NULL,
    Price FLOAT NOT NULL
);

/** Partners & Logistics **/

/* PartnerType */

CREATE TABLE PartnerType (
    PartnerTypeId INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL
);

/* BusinessPartner */

CREATE TABLE BusinessPartner (
    PartnerId INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    PartnerTypeId INT NOT NULL,
    Address NVARCHAR(200) NULL,
    TaxNumber NVARCHAR(20) NULL,
    RegistrationNumber NVARCHAR(30) NULL,
    Note NVARCHAR(200) NULL
);

/* Vehicle */

CREATE TABLE Vehicle (
    VehicleId INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200) NULL,
    RegistrationNumber NVARCHAR(20) NOT NULL
);

/* Driver */

CREATE TABLE Driver (
    DriverId INT IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL
);

/** Production / Manufacturing * */

/* BillOfMaterials */

CREATE TABLE BillOfMaterials (
    BillOfMaterialsId INT IDENTITY(1,1) NOT NULL,
    ProductId INT NOT NULL,
    Description NVARCHAR(200) NULL,
    EffectiveDate DATETIME2(7) NOT NULL,
    Status INT NOT NULL
);

/* BillOfMaterialsLine */

CREATE TABLE BillOfMaterialsLine (
    LineId INT IDENTITY(1,1) NOT NULL,
    BillOfMaterialsId INT NOT NULL,
    LineNumber INT NOT NULL,
    MaterialId INT NOT NULL,
    Quantity FLOAT NOT NULL,
    UnitOfMeasureId INT NOT NULL,
    Scrap FLOAT NOT NULL
);

/* ProductionOrder */

CREATE TABLE ProductionOrder (
    ProductionOrderId INT IDENTITY(1,1) NOT NULL,
    DocumentTypeId INT NULL,
    OrderDate DATETIME2(7) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL,
    UpdatedAt DATETIME2(7) NOT NULL,
    Status INT NOT NULL,
    MaterialSiteId INT NOT NULL,
    ProductSiteId INT NOT NULL,
    PartnerId INT NULL,
    ProductId INT NOT NULL,
    Quantity FLOAT NOT NULL,
    UnitOfMeasureId INT NOT NULL,
    Price FLOAT NOT NULL,
    BillOfMaterialsId INT NULL,
    LinkedDocumentId INT NULL
);

/* ProductionOrderLine */

CREATE TABLE ProductionOrderLine (
    LineId INT IDENTITY(1,1) NOT NULL,
    ProductionOrderId INT NOT NULL,
    LineNumber INT NOT NULL,
    MaterialId INT NOT NULL,
    Quantity FLOAT NOT NULL,
    UnitOfMeasureId INT NOT NULL,
    Scrap FLOAT NOT NULL
);

/** Stock Counting **/

/* StockCount */

CREATE TABLE StockCount (
    StockCountId INT IDENTITY(1,1) NOT NULL,
    SiteId INT NOT NULL,
    CountDate DATETIME2(7) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL,
    UpdatedAt DATETIME2(7) NOT NULL,
    Status INT NOT NULL,
    CreatedByUserId NVARCHAR(128) NULL
);

/* StockCountLine */

CREATE TABLE StockCountLine (
    LineId INT IDENTITY(1,1) NOT NULL,
    StockCountId INT NOT NULL,
    LineNumber INT NOT NULL,
    InventoryItemId INT NOT NULL,
    QuantityRecorded FLOAT NOT NULL,
    QuantityExpected FLOAT NOT NULL,
    UnitOfMeasureId INT NOT NULL
);