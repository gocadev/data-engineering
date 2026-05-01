Gradnjapro Database (Construction ERP Model)

This repository contains a domain‑specific relational database model originally developed for construction and civil engineering workflows.The original system was built in Serbian; table names and business terminology reflect real industry usage. English equivalents are provided throughout the documentation for clarity.

Repository Structure

niskogradnja-db/
│
├── schema/
│   ├── 01_create_tables.sql
│   ├── 02_constraints.sql
│   ├── 03_indexes.sql
│
├── mock_data/
│   ├── sites.csv
│   ├── partners.csv
│   ├── inventory_items.csv
│   ├── documents.csv
│   ├── document_items.csv
│   ├── production_orders.csv
│   ├── production_order_items.csv
│   ├── stock_counts.csv
│   ├── stock_count_items.csv
│   └── bill_of_materials.csv
│
├── erd/
│   ├── full_model.png
│   ├── domain_documents.png
│   ├── domain_inventory.png
│   ├── domain_production.png
│   └── domain_stockcount.png
│
├── etl/
│   ├── extract.sql
│   ├── transform.sql
│   └── load.sql
│
└── README.md

1. Overview

This project represents a complete relational data model for managing construction operations, including:
- material inventory
- incoming/outgoing documents
- internal transfers
- production processes (asphalt, concrete, aggregates)
- bill of materials
- stock counts
- partners, vehicles, drivers
- multi‑site material tracking

The model is suitable for:
- database design portfolios
- data engineering pipelines
- ETL demonstrations
- analytics and reporting
- teaching relational modeling

2. Domain Description

The system models real‑world construction workflows:

Inventory (Zalihe / InventoryItem)
Materials such as cement, sand, gravel, bitumen, reinforcement steel, etc.

Documents (Dokument / Document)
Business documents representing:
- material entry (ulaz)
- material exit (izlaz)
- internal transfer (prenos)
- production‑related documents
Each document contains multiple items (stavke).

Construction Sites (Objekat / Site)
Multiple sites, warehouses, asphalt bases, etc.

Logistics
Vehicles, drivers, carriers (prevoznici).

Production (ProizvodniNalog / ProductionOrder)
Production of asphalt, concrete, or other materials.

Bill of Materials (Receptura / BillOfMaterials)
Defines material composition for production.

Stock Count (Popis / StockCount)
Periodic inventory checks.

3. Dual‑Language Naming Convention
The original system uses Serbian table and column names.English equivalents are provided for clarity and international readability.

Example:

Serbian                                     English

Dokument                                    Document

DokumentStavka                              DocumentItem

Objekat                                     Site

Zalihe                                      InventoryItem

ProizvodniNalog                             ProductionOrder

Receptura                                   BillOfMaterials

A full dual‑language mapping is included in the documentation sections below.

4. Entity‑Relationship Diagrams (ERD)
ERD diagrams are located in the /erd folder:
- full_model.png — complete database model
- domain_documents.png — document workflow
- domain_inventory.png — inventory and stock
- domain_production.png — production and BOM
- domain_stockcount.png — stock count domain

These diagrams were generated from the SQL schema and represent the logical and physical structure of the system.

5. Schema
SQL scripts are located in /schema:

- 01_create_tables.sql — table definitions
- 02_constraints.sql — foreign keys and relationships
- 03_indexes.sql — indexes and performance structures

The schema is normalized and follows standard relational modeling practices.

6. Mock Data
All data in /mock_data is synthetic, safe, and realistic.It simulates real construction workflows without exposing any business‑sensitive information.

Examples include:
- construction sites
- partners and vendors
- inventory items
- documents and document items
- production orders
- bill of materials
- stock counts

These datasets can be used for:
- ETL pipelines
- analytics
- Power BI dashboards
- SQL practice
- data modeling demonstrations

7. ETL Examples
The /etl folder contains example SQL scripts demonstrating:

extract.sql
- loading raw data
- staging tables
- initial transformations

transform.sql
- cleaning
- standardizing units
- deriving metrics
- joining business entities

load.sql
- loading into analytical tables
- star schema examples
- fact and dimension modeling

These scripts illustrate how the model can be used in a real data engineering workflow.

8. Use Cases
This repository can be used for:

- Data Engineering Portfolio
Showcase ETL, modeling, and domain understanding.

- Database Design
Demonstrate normalization, constraints, and relational modeling.

- Analytics
Build dashboards for:
    - material consumption
    - stock levels
    - production efficiency
    - site‑level material flow

- Teaching
Use as a realistic example of a domain‑specific ERP model.

9. License
This project contains synthetic data and original schema design.It is free to use for:
- learning
- teaching
- portfolio building
- non‑commercial projects

10. Notes
- Original system terminology is preserved for authenticity.
- English equivalents are provided for clarity.
- No real business data is included.

11. Author
Created by Gordana, software developer and data engineering enthusiast.This repository is part of a broader effort to publish real‑world domain models for educational and portfolio purposes.