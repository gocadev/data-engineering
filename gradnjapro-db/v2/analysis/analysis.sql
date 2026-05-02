/*  01 - Top 10 items by revenue */
SELECT TOP 10 
    i.Name AS Item,
    SUM(l.Quantity * l.Price) AS Revenue
FROM DocumentLine l
JOIN InventoryItem i ON i.InventoryItemId = l.InventoryItemId
GROUP BY i.Name
ORDER BY Revenue DESC;


/* 02 - Document count by document type */
SELECT 
    dt.Name AS DocumentType,
    COUNT(*) AS TotalDocuments
FROM DocumentHeader h
JOIN DocumentType dt ON dt.DocumentTypeId = h.DocumentTypeId
GROUP BY dt.Name
ORDER BY TotalDocuments DESC;


/* 03 - Average number of lines per document */
SELECT 
    AVG(LineCount) AS AvgLinesPerDocument
FROM (
    SELECT DocumentId, COUNT(*) AS LineCount
    FROM DocumentLine
    GROUP BY DocumentId
) x;


/* 04 - Partner activity by number of documents */
SELECT TOP 10 
    p.Name AS Partner,
    COUNT(*) AS Documents
FROM DocumentHeader h
JOIN BusinessPartner p ON p.PartnerId = h.PartnerId
GROUP BY p.Name
ORDER BY Documents DESC;


/* 05 - Revenue by site */
SELECT 
    s.Name AS Site,
    SUM(l.Quantity * l.Price) AS Revenue
FROM DocumentLine l
JOIN DocumentHeader h ON h.DocumentId = l.DocumentId
JOIN Site s ON s.SiteId = h.SiteId
GROUP BY s.Name
ORDER BY Revenue DESC;


/* 06 - Inventory value per site */
SELECT 
    s.Name AS Site,
    SUM(si.Quantity * si.Price) AS InventoryValue
FROM SiteInventory si
JOIN Site s ON s.SiteId = si.SiteId
GROUP BY s.Name
ORDER BY InventoryValue DESC;


/* 07 - Top 20 items by inventory value */
SELECT TOP 20
    i.Name,
    SUM(si.Quantity * si.Price) AS Value
FROM SiteInventory si
JOIN InventoryItem i ON i.InventoryItemId = si.InventoryItemId
GROUP BY i.Name
ORDER BY Value DESC;


/* 08 - Total stock count difference per item  */
SELECT 
    i.Name,
    SUM(scl.QuantityExpected - scl.QuantityRecorded) AS TotalDifference
FROM StockCountLine scl
JOIN InventoryItem i ON i.InventoryItemId = scl.InventoryItemId
GROUP BY i.Name
ORDER BY TotalDifference DESC;


/* 09 - Sites with highest stock count deviations */
SELECT 
    s.Name AS Site,
    SUM(ABS(scl.QuantityExpected - scl.QuantityRecorded)) AS TotalDeviation
FROM StockCountLine scl
JOIN StockCount sc ON sc.StockCountId = scl.StockCountId
JOIN Site s ON s.SiteId = sc.SiteId
GROUP BY s.Name
ORDER BY TotalDeviation DESC;


/* 10 - Top produced products by quantity */
SELECT 
    i.Name AS Product,
    SUM(po.Quantity) AS TotalProduced
FROM ProductionOrder po
JOIN InventoryItem i ON i.InventoryItemId = po.ProductId
GROUP BY i.Name
ORDER BY TotalProduced DESC;


/* 11 - Material usage per production order */
SELECT 
    po.ProductionOrderId,
    SUM(pol.Quantity) AS TotalMaterialUsed
FROM ProductionOrderLine pol
JOIN ProductionOrder po ON po.ProductionOrderId = pol.ProductionOrderId
GROUP BY po.ProductionOrderId
ORDER BY TotalMaterialUsed DESC;


/* 12 - Most used materials in production */
SELECT TOP 20
    i.Name AS Material,
    SUM(pol.Quantity) AS TotalUsed
FROM ProductionOrderLine pol
JOIN InventoryItem i ON i.InventoryItemId = pol.MaterialId
GROUP BY i.Name
ORDER BY TotalUsed DESC;


/* 13 - Scrap analysis by material */
SELECT 
    i.Name AS Material,
    SUM(pol.Scrap) AS TotalScrap
FROM ProductionOrderLine pol
JOIN InventoryItem i ON i.InventoryItemId = pol.MaterialId
GROUP BY i.Name
ORDER BY TotalScrap DESC;


/* 14 - Number of materials per BOM */
SELECT 
    b.BillOfMaterialsId,
    COUNT(*) AS MaterialCount
FROM BillOfMaterialsLine bl
JOIN BillOfMaterials b ON b.BillOfMaterialsId = bl.BillOfMaterialsId
GROUP BY b.BillOfMaterialsId
ORDER BY MaterialCount DESC;


/* 15 - Most complex products by number of components */
SELECT TOP 10
    i.Name AS Product,
    COUNT(*) AS Components
FROM BillOfMaterialsLine bl
JOIN BillOfMaterials b ON b.BillOfMaterialsId = bl.BillOfMaterialsId
JOIN InventoryItem i ON i.InventoryItemId = b.ProductId
GROUP BY i.Name
ORDER BY Components DESC;


/* 16 - Total material quantity per BOM */
SELECT 
    b.BillOfMaterialsId,
    SUM(bl.Quantity) AS TotalMaterialQty
FROM BillOfMaterialsLine bl
JOIN BillOfMaterials b ON b.BillOfMaterialsId = bl.BillOfMaterialsId
GROUP BY b.BillOfMaterialsId
ORDER BY TotalMaterialQty DESC;


/* 17 - Top partners by revenue */
SELECT TOP 10
    p.Name,
    SUM(l.Quantity * l.Price) AS Revenue
FROM DocumentLine l
JOIN DocumentHeader h ON h.DocumentId = l.DocumentId
JOIN BusinessPartner p ON p.PartnerId = h.PartnerId
GROUP BY p.Name
ORDER BY Revenue DESC;


/* 18 - Top partners by document count */
SELECT TOP 10
    p.Name,
    COUNT(*) AS Documents
FROM DocumentHeader h
JOIN BusinessPartner p ON p.PartnerId = h.PartnerId
GROUP BY p.Name
ORDER BY Documents DESC;


/* 19 - Items with highest price */
SELECT TOP 20
    Name,
    Price
FROM InventoryItem
ORDER BY Price DESC;


/* 20 - Most frequently used items in documents */
SELECT TOP 20
    i.Name,
    COUNT(*) AS Appearances
FROM DocumentLine l
JOIN InventoryItem i ON i.InventoryItemId = l.InventoryItemId
GROUP BY i.Name
ORDER BY Appearances DESC;
