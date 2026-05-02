/* QUALITY CHECK REPORT — unified output */

WITH Checks AS (

    /* 1) RAW vs STAGING row count mismatch */
    SELECT
        'RowCount_InventoryItem' AS CheckName,
        CASE WHEN (SELECT COUNT(*) FROM InventoryItem) = (SELECT COUNT(*) FROM stg_InventoryItem)
             THEN 'OK' ELSE 'FAIL' END AS Status,
        ABS((SELECT COUNT(*) FROM InventoryItem) - (SELECT COUNT(*) FROM stg_InventoryItem)) AS Count,
        NULL AS Sample

    UNION ALL
    SELECT
        'RowCount_DocumentHeader',
        CASE WHEN (SELECT COUNT(*) FROM DocumentHeader) = (SELECT COUNT(*) FROM stg_DocumentHeader)
             THEN 'OK' ELSE 'FAIL' END,
        ABS((SELECT COUNT(*) FROM DocumentHeader) - (SELECT COUNT(*) FROM stg_DocumentHeader)),
        NULL


    /* 2) ORPHANS — DocumentLine without Header */
    UNION ALL
    SELECT
        'Orphan_DocumentLine_NoHeader',
        CASE WHEN NOT EXISTS (
            SELECT 1
            FROM stg_DocumentLine l
            LEFT JOIN stg_DocumentHeader h ON h.DocumentId = l.DocumentId
            WHERE h.DocumentId IS NULL
        ) THEN 'OK' ELSE 'FAIL' END,
        (SELECT COUNT(*)
         FROM stg_DocumentLine l
         LEFT JOIN stg_DocumentHeader h ON h.DocumentId = l.DocumentId
         WHERE h.DocumentId IS NULL),
        (SELECT TOP 1 CONCAT('LineId=', l.LineId, ', DocumentId=', l.DocumentId)
         FROM stg_DocumentLine l
         LEFT JOIN stg_DocumentHeader h ON h.DocumentId = l.DocumentId
         WHERE h.DocumentId IS NULL)


    /* 3) ORPHANS — DocumentHeader without Site */
    UNION ALL
    SELECT
        'Orphan_DocumentHeader_NoSite',
        CASE WHEN NOT EXISTS (
            SELECT 1
            FROM stg_DocumentHeader h
            LEFT JOIN stg_Site s ON s.SiteId = h.SiteId
            WHERE s.SiteId IS NULL
        ) THEN 'OK' ELSE 'FAIL' END,
        (SELECT COUNT(*)
         FROM stg_DocumentHeader h
         LEFT JOIN stg_Site s ON s.SiteId = h.SiteId
         WHERE s.SiteId IS NULL),
        (SELECT TOP 1 CONCAT('DocumentId=', h.DocumentId, ', SiteId=', h.SiteId)
         FROM stg_DocumentHeader h
         LEFT JOIN stg_Site s ON s.SiteId = h.SiteId
         WHERE s.SiteId IS NULL)


    /* 4) DUPLICATES — DocumentHeader */
    UNION ALL
    SELECT
        'Duplicate_DocumentHeader',
        CASE WHEN NOT EXISTS (
            SELECT DocumentId
            FROM stg_DocumentHeader
            GROUP BY DocumentId
            HAVING COUNT(*) > 1
        ) THEN 'OK' ELSE 'FAIL' END,
        (SELECT COUNT(*)
         FROM (
             SELECT DocumentId
             FROM stg_DocumentHeader
             GROUP BY DocumentId
             HAVING COUNT(*) > 1
         ) x),
        (SELECT TOP 1 CONCAT('DocumentId=', DocumentId)
         FROM (
             SELECT DocumentId
             FROM stg_DocumentHeader
             GROUP BY DocumentId
             HAVING COUNT(*) > 1
         ) x)


    /* 5) NULL CHECKS — critical columns */
    UNION ALL
    SELECT
        'NullCheck_DocumentLine_Quantity',
        CASE WHEN NOT EXISTS (
            SELECT 1 FROM stg_DocumentLine WHERE Quantity IS NULL
        ) THEN 'OK' ELSE 'FAIL' END,
        (SELECT COUNT(*) FROM stg_DocumentLine WHERE Quantity IS NULL),
        (SELECT TOP 1 CONCAT('LineId=', LineId) FROM stg_DocumentLine WHERE Quantity IS NULL)


    /* 6) VALUE SANITY — negative quantities */
    UNION ALL
    SELECT
        'Negative_Quantity',
        CASE WHEN NOT EXISTS (
            SELECT 1 FROM stg_DocumentLine WHERE Quantity < 0
        ) THEN 'OK' ELSE 'FAIL' END,
        (SELECT COUNT(*) FROM stg_DocumentLine WHERE Quantity < 0),
        (SELECT TOP 1 CONCAT('LineId=', LineId, ', Qty=', Quantity)
         FROM stg_DocumentLine WHERE Quantity < 0)


    /* 7) FACT → DIM missing keys */
    UNION ALL
    SELECT
        'Fact_DocumentLine_MissingKeys',
        CASE WHEN NOT EXISTS (
            SELECT 1
            FROM fact_DocumentLine
            WHERE DateKey IS NULL
               OR DocumentTypeKey IS NULL
               OR SiteKey IS NULL
               OR PartnerKey IS NULL
               OR ItemKey IS NULL
        ) THEN 'OK' ELSE 'FAIL' END,
        (SELECT COUNT(*)
         FROM fact_DocumentLine
         WHERE DateKey IS NULL
            OR DocumentTypeKey IS NULL
            OR SiteKey IS NULL
            OR PartnerKey IS NULL
            OR ItemKey IS NULL),
        (SELECT TOP 1 CONCAT('DocumentLineKey=', DocumentLineKey)
         FROM fact_DocumentLine
         WHERE DateKey IS NULL
            OR DocumentTypeKey IS NULL
            OR SiteKey IS NULL
            OR PartnerKey IS NULL
            OR ItemKey IS NULL)

)

SELECT *
FROM Checks
ORDER BY Status DESC, CheckName;