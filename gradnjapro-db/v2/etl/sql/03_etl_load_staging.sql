/* LOAD STAGING: UnitOfMeasure */
TRUNCATE TABLE stg_UnitOfMeasure;

INSERT INTO stg_UnitOfMeasure
SELECT *
FROM UnitOfMeasure;


/* LOAD STAGING: InventoryCategory */
TRUNCATE TABLE stg_InventoryCategory;

INSERT INTO stg_InventoryCategory
SELECT *
FROM InventoryCategory;


/* LOAD STAGING: PartnerType */
TRUNCATE TABLE stg_PartnerType;

INSERT INTO stg_PartnerType
SELECT *
FROM PartnerType;


/* LOAD STAGING: BusinessPartner */
TRUNCATE TABLE stg_BusinessPartner;

INSERT INTO stg_BusinessPartner
SELECT *
FROM BusinessPartner;


/* LOAD STAGING: Site */
TRUNCATE TABLE stg_Site;

INSERT INTO stg_Site
SELECT *
FROM Site;


/* LOAD STAGING: InventoryItem */
TRUNCATE TABLE stg_InventoryItem;

INSERT INTO stg_InventoryItem
SELECT *
FROM InventoryItem;


/* LOAD STAGING: DocumentType */
TRUNCATE TABLE stg_DocumentType;

INSERT INTO stg_DocumentType
SELECT DocumentTypeId, Name
FROM DocumentType;


/* LOAD STAGING: DocumentHeader */
TRUNCATE TABLE stg_DocumentHeader;

INSERT INTO stg_DocumentHeader
SELECT *
FROM DocumentHeader;


/* LOAD STAGING: DocumentLine */
TRUNCATE TABLE stg_DocumentLine;

INSERT INTO stg_DocumentLine
SELECT *
FROM DocumentLine;


/* LOAD STAGING: BillOfMaterials= */
TRUNCATE TABLE stg_BillOfMaterials;

INSERT INTO stg_BillOfMaterials
SELECT *
FROM BillOfMaterials;


/* LOAD STAGING: BillOfMaterialsLine */
TRUNCATE TABLE stg_BillOfMaterialsLine;

INSERT INTO stg_BillOfMaterialsLine
SELECT *
FROM BillOfMaterialsLine;


/*LOAD STAGING: ProductionOrder */
TRUNCATE TABLE stg_ProductionOrder;

INSERT INTO stg_ProductionOrder
SELECT *
FROM ProductionOrder;


/* LOAD STAGING: ProductionOrderLine */
TRUNCATE TABLE stg_ProductionOrderLine;

INSERT INTO stg_ProductionOrderLine
SELECT *
FROM ProductionOrderLine;


/* LOAD STAGING: StockCount */
TRUNCATE TABLE stg_StockCount;

INSERT INTO stg_StockCount
SELECT *
FROM StockCount;


/* LOAD STAGING: StockCountLine */
TRUNCATE TABLE stg_StockCountLine;

INSERT INTO stg_StockCountLine
SELECT *
FROM StockCountLine;


/* LOAD STAGING: SiteInventory */
TRUNCATE TABLE stg_SiteInventory;

INSERT INTO stg_SiteInventory
SELECT *
FROM SiteInventory;