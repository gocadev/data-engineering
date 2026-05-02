/** CONSTRAINTS — Document Management  **/

/* DocumentType */

ALTER TABLE DocumentType
ADD CONSTRAINT PK_DocumentType PRIMARY KEY (DocumentTypeId);

/* DocumentHeader */

ALTER TABLE DocumentHeader
ADD CONSTRAINT PK_DocumentHeader PRIMARY KEY (DocumentId);

ALTER TABLE DocumentHeader
ADD CONSTRAINT FK_DocumentHeader_DocumentType
FOREIGN KEY (DocumentTypeId) REFERENCES DocumentType(DocumentTypeId);

ALTER TABLE DocumentHeader
ADD CONSTRAINT FK_DocumentHeader_Site
FOREIGN KEY (SiteId) REFERENCES Site(SiteId);

ALTER TABLE DocumentHeader
ADD CONSTRAINT FK_DocumentHeader_BusinessPartner
FOREIGN KEY (PartnerId) REFERENCES BusinessPartner(PartnerId);

/* DocumentLine */

ALTER TABLE DocumentLine
ADD CONSTRAINT PK_DocumentLine PRIMARY KEY (LineId);

ALTER TABLE DocumentLine
ADD CONSTRAINT FK_DocumentLine_DocumentHeader
FOREIGN KEY (DocumentId) REFERENCES DocumentHeader(DocumentId);

ALTER TABLE DocumentLine
ADD CONSTRAINT FK_DocumentLine_InventoryItem
FOREIGN KEY (InventoryItemId) REFERENCES InventoryItem(InventoryItemId);

ALTER TABLE DocumentLine
ADD CONSTRAINT FK_DocumentLine_UnitOfMeasure
FOREIGN KEY (UnitOfMeasureId) REFERENCES UnitOfMeasure(UnitOfMeasureId);

ALTER TABLE DocumentLine
ADD CONSTRAINT UQ_DocumentLine_LineNumber UNIQUE (DocumentId, LineNumber);

/* DocumentTransport */

ALTER TABLE DocumentTransport
ADD CONSTRAINT PK_DocumentTransport PRIMARY KEY (DocumentId);

ALTER TABLE DocumentTransport
ADD CONSTRAINT FK_DocumentTransport_DocumentHeader
FOREIGN KEY (DocumentId) REFERENCES DocumentHeader(DocumentId);

ALTER TABLE DocumentTransport
ADD CONSTRAINT FK_DocumentTransport_Vehicle
FOREIGN KEY (VehicleId) REFERENCES Vehicle(VehicleId);

ALTER TABLE DocumentTransport
ADD CONSTRAINT FK_DocumentTransport_Driver
FOREIGN KEY (DriverId) REFERENCES Driver(DriverId);

ALTER TABLE DocumentTransport
ADD CONSTRAINT FK_DocumentTransport_Carrier
FOREIGN KEY (CarrierId) REFERENCES BusinessPartner(PartnerId);

/* DocumentLink */

ALTER TABLE DocumentLink
ADD CONSTRAINT PK_DocumentLink PRIMARY KEY (DocumentId, LinkedDocumentId);

ALTER TABLE DocumentLink
ADD CONSTRAINT FK_DocumentLink_Document
FOREIGN KEY (DocumentId) REFERENCES DocumentHeader(DocumentId);

ALTER TABLE DocumentLink
ADD CONSTRAINT FK_DocumentLink_LinkedDocument
FOREIGN KEY (LinkedDocumentId) REFERENCES DocumentHeader(DocumentId);

/** CONSTRAINTS — Inventory  **/

/* InventoryCategory */

ALTER TABLE InventoryCategory
ADD CONSTRAINT PK_InventoryCategory PRIMARY KEY (InventoryCategoryId);

/* UnitOfMeasure */

ALTER TABLE UnitOfMeasure
ADD CONSTRAINT PK_UnitOfMeasure PRIMARY KEY (UnitOfMeasureId);

/* InventoryItem */

ALTER TABLE InventoryItem
ADD CONSTRAINT PK_InventoryItem PRIMARY KEY (InventoryItemId);

ALTER TABLE InventoryItem
ADD CONSTRAINT FK_InventoryItem_UnitOfMeasure
FOREIGN KEY (UnitOfMeasureId) REFERENCES UnitOfMeasure(UnitOfMeasureId);

ALTER TABLE InventoryItem
ADD CONSTRAINT FK_InventoryItem_InventoryCategory
FOREIGN KEY (InventoryCategoryId) REFERENCES InventoryCategory(InventoryCategoryId);

/* Site */

ALTER TABLE Site
ADD CONSTRAINT PK_Site PRIMARY KEY (SiteId);

/* SiteInventory */

ALTER TABLE SiteInventory
ADD CONSTRAINT PK_SiteInventory PRIMARY KEY (SiteInventoryId);

ALTER TABLE SiteInventory
ADD CONSTRAINT FK_SiteInventory_Site
FOREIGN KEY (SiteId) REFERENCES Site(SiteId);

ALTER TABLE SiteInventory
ADD CONSTRAINT FK_SiteInventory_InventoryItem
FOREIGN KEY (InventoryItemId) REFERENCES InventoryItem(InventoryItemId);

ALTER TABLE SiteInventory
ADD CONSTRAINT UQ_SiteInventory UNIQUE (SiteId, InventoryItemId);

/** CONSTRAINTS — Partners & Logistics  **/

/* PartnerType */
 
ALTER TABLE PartnerType
ADD CONSTRAINT PK_PartnerType PRIMARY KEY (PartnerTypeId);

/* BusinessPartner */

ALTER TABLE BusinessPartner
ADD CONSTRAINT PK_BusinessPartner PRIMARY KEY (PartnerId);

ALTER TABLE BusinessPartner
ADD CONSTRAINT FK_BusinessPartner_PartnerType
FOREIGN KEY (PartnerTypeId) REFERENCES PartnerType(PartnerTypeId);

/* Vehicle */

ALTER TABLE Vehicle
ADD CONSTRAINT PK_Vehicle PRIMARY KEY (VehicleId);

/* Driver */

ALTER TABLE Driver
ADD CONSTRAINT PK_Driver PRIMARY KEY (DriverId);

/** CONSTRAINTS — Production  **/

/* BillOfMaterials */

ALTER TABLE BillOfMaterials
ADD CONSTRAINT PK_BillOfMaterials PRIMARY KEY (BillOfMaterialsId);

ALTER TABLE BillOfMaterials
ADD CONSTRAINT FK_BillOfMaterials_Product
FOREIGN KEY (ProductId) REFERENCES InventoryItem(InventoryItemId);

/* BillOfMaterialsLine */

ALTER TABLE BillOfMaterialsLine
ADD CONSTRAINT PK_BillOfMaterialsLine PRIMARY KEY (LineId);

ALTER TABLE BillOfMaterialsLine
ADD CONSTRAINT FK_BillOfMaterialsLine_BillOfMaterials
FOREIGN KEY (BillOfMaterialsId) REFERENCES BillOfMaterials(BillOfMaterialsId);

ALTER TABLE BillOfMaterialsLine
ADD CONSTRAINT FK_BillOfMaterialsLine_Material
FOREIGN KEY (MaterialId) REFERENCES InventoryItem(InventoryItemId);

ALTER TABLE BillOfMaterialsLine
ADD CONSTRAINT FK_BillOfMaterialsLine_UnitOfMeasure
FOREIGN KEY (UnitOfMeasureId) REFERENCES UnitOfMeasure(UnitOfMeasureId);

ALTER TABLE BillOfMaterialsLine
ADD CONSTRAINT UQ_BillOfMaterialsLine UNIQUE (BillOfMaterialsId, LineNumber);

/* ProductionOrder */

ALTER TABLE ProductionOrder
ADD CONSTRAINT PK_ProductionOrder PRIMARY KEY (ProductionOrderId);

ALTER TABLE ProductionOrder
ADD CONSTRAINT FK_ProductionOrder_DocumentType
FOREIGN KEY (DocumentTypeId) REFERENCES DocumentType(DocumentTypeId);

ALTER TABLE ProductionOrder
ADD CONSTRAINT FK_ProductionOrder_MaterialSite
FOREIGN KEY (MaterialSiteId) REFERENCES Site(SiteId);

ALTER TABLE ProductionOrder
ADD CONSTRAINT FK_ProductionOrder_ProductSite
FOREIGN KEY (ProductSiteId) REFERENCES Site(SiteId);

ALTER TABLE ProductionOrder
ADD CONSTRAINT FK_ProductionOrder_BusinessPartner
FOREIGN KEY (PartnerId) REFERENCES BusinessPartner(PartnerId);

ALTER TABLE ProductionOrder
ADD CONSTRAINT FK_ProductionOrder_Product
FOREIGN KEY (ProductId) REFERENCES InventoryItem(InventoryItemId);

ALTER TABLE ProductionOrder
ADD CONSTRAINT FK_ProductionOrder_UnitOfMeasure
FOREIGN KEY (UnitOfMeasureId) REFERENCES UnitOfMeasure(UnitOfMeasureId);

ALTER TABLE ProductionOrder
ADD CONSTRAINT FK_ProductionOrder_BillOfMaterials
FOREIGN KEY (BillOfMaterialsId) REFERENCES BillOfMaterials(BillOfMaterialsId);

ALTER TABLE ProductionOrder
ADD CONSTRAINT FK_ProductionOrder_LinkedDocument
FOREIGN KEY (LinkedDocumentId) REFERENCES DocumentHeader(DocumentId);

/* ProductionOrderLine */

ALTER TABLE ProductionOrderLine
ADD CONSTRAINT PK_ProductionOrderLine PRIMARY KEY (LineId);

ALTER TABLE ProductionOrderLine
ADD CONSTRAINT FK_ProductionOrderLine_ProductionOrder
FOREIGN KEY (ProductionOrderId) REFERENCES ProductionOrder(ProductionOrderId);

ALTER TABLE ProductionOrderLine
ADD CONSTRAINT FK_ProductionOrderLine_Material
FOREIGN KEY (MaterialId) REFERENCES InventoryItem(InventoryItemId);

ALTER TABLE ProductionOrderLine
ADD CONSTRAINT FK_ProductionOrderLine_UnitOfMeasure
FOREIGN KEY (UnitOfMeasureId) REFERENCES UnitOfMeasure(UnitOfMeasureId);

ALTER TABLE ProductionOrderLine
ADD CONSTRAINT UQ_ProductionOrderLine UNIQUE (ProductionOrderId, LineNumber);

/** CONSTRAINTS — Stock Counting **/

/* StockCount */

ALTER TABLE StockCount
ADD CONSTRAINT PK_StockCount PRIMARY KEY (StockCountId);

ALTER TABLE StockCount
ADD CONSTRAINT FK_StockCount_Site
FOREIGN KEY (SiteId) REFERENCES Site(SiteId);

/* StockCountLine */

ALTER TABLE StockCountLine
ADD CONSTRAINT PK_StockCountLine PRIMARY KEY (LineId);

ALTER TABLE StockCountLine
ADD CONSTRAINT FK_StockCountLine_StockCount
FOREIGN KEY (StockCountId) REFERENCES StockCount(StockCountId);

ALTER TABLE StockCountLine
ADD CONSTRAINT FK_StockCountLine_InventoryItem
FOREIGN KEY (InventoryItemId) REFERENCES InventoryItem(InventoryItemId);

ALTER TABLE StockCountLine
ADD CONSTRAINT FK_StockCountLine_UnitOfMeasure
FOREIGN KEY (UnitOfMeasureId) REFERENCES UnitOfMeasure(UnitOfMeasureId);

ALTER TABLE StockCountLine
ADD CONSTRAINT UQ_StockCountLine UNIQUE (StockCountId, LineNumber);