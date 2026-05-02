# Construction ERP (V2 Schema)
**
## Overview

This repository contains Version 2 (V2) of the database schema for a Construction ERP system.V2 is a complete architectural refactor of the original V1 schema, designed to:

- improve domain separation

- introduce clean English naming conventions

- normalize the data model

- remove legacy workarounds

- support analytics, ETL and reporting

- provide a professional, recruiter‑ready portfolio example

- The system models real‑world processes used in civil engineering, construction logistics, materials management, production, and stock control.

## Key Improvements in V2

V2 is not a cosmetic update — it is a full redesign based on real business logic and modern database architecture principles.

## English naming conventions

All tables, columns, and domains are now named using clear, industry‑standard English terminology.

## Domain‑driven structure

The schema is divided into 5 logical domains:

- Document Management

- Inventory & Materials

- Partners & Logistics

- Production / Manufacturing

- Stock Counting

## Clean architecture

- No overloaded tables

- No ambiguous column names

- No workaround fields

- No mixed responsibilities

Strong relational integrity

- All primary keys defined

- All foreign keys defined

- All unique constraints defined

- LineNumber uniqueness enforced per document/order/BOM

## Ready for analytics

The schema is designed to support:

- ETL pipelines

- Power BI dashboards

- Star schema transformations

- Audit and traceability

## Domain Overview

### 1. Document Management

Handles all inbound/outbound/internal documents:

- DocumentHeader

- ocumentLine

- DocumentTransport

- DocumentLink

- DocumentType

Supports: receipts, issues, transfers, delivery notes, production documents, etc.

### 2. Inventory & Materials

Core material management:

- InventoryItem

- InventoryCategory

- UnitOfMeasure

- Site

- SiteInventory

Supports: stock levels, pricing, categorization, UOM, multi‑site operations.

### 3. Partners & Logistics

Business entities and transport:

- BusinessPartner

- PartnerType

- Vehicle

- Driver

Supports: suppliers, carriers, customers, subcontractors.

### 4. Production / Manufacturing

Production orders and bill of materials:

- ProductionOrder

- ProductionOrderLine

- BillOfMaterials

- BillOfMaterialsLine

Supports: material consumption, product output, scrap, multi‑site production.

### 5. Stock Counting

Physical inventory control:

- StockCount

- StockCountLine

Supports: reconciliation, variance tracking, audit.

ERD Diagrams

- Logical ERD (dbdiagram.io)

- Example:

/v2/erd/dbdiagram_erd.png

This diagram shows the clean, domain‑driven logical model.

Example:

/v2/erd/ssms_erd.png

This diagram shows the actual physical implementation in SQL Server.

Folder Structure

/v2
   /schema
       create_tables.sql
       constraints.sql
   /erd
       dbdiagram_erd.png
       ssms_erd.png
   README_v2.md

## How to Deploy the Schema

### 1. Create a new database

CREATE DATABASE construction_erp_v2;
GO

### 2. Run all CREATE TABLE scripts

Located in /v2/schema/create_tables.sql.

### 3. Disable FK checks (optional)

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT ALL";

### 4. Run constraints

Located in /v2/schema/constraints.sql.

### 5. Re‑enable FK checks

EXEC sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT ALL";

## About This Project

This schema is based on a real construction ERP system, originally developed in Serbian (V1).V2 represents a complete redesign using:

- English naming

- domain‑driven design

- normalized structure

- enterprise‑grade modeling

The goal is to present a professional, realistic, and technically strong database model suitable for:

- Data Engineering

- Database Development

- BI & Analytics

- ETL pipelines

- Portfolio demonstration

## Next Steps

Planned additions:

- Mock data (CSV)

- ETL examples

- Star schema (fact + dimensions)

- Data quality rules

- Stored procedures for document processing

## License

This project is open for educational and portfolio use.