# Superstore Sales Analysis — SQL Project

A relational database + analytical SQL project built on a 3,000-record sample of the classic "Superstore" retail dataset (sampled from 9,994 orders, category-stratified to preserve real-world proportions).

## What This Project Does
- Designs a normalized MySQL schema (6 tables) from raw flat Excel data
- Loads 3,000 order-line records with full referential integrity
- Runs 15 analytical SQL queries covering sales, profit, regional, customer, and product-level performance
- Translates query output into business insights (see `INSIGHTS.md`)

## Tech Stack
- **Database:** MySQL 8.0
- **Data Prep:** Python (pandas) — cleaning, sampling, transformation from raw `.xls`
- **Techniques used:** JOINs, GROUP BY / HAVING, window functions (`LAG() OVER`), CASE-based bucketing, date functions

## Project Structure
```
superstore-sql-analysis/
├── README.md
├── INSIGHTS.md
├── sql/
│   ├── 01_schema_and_data.sql      # Creates DB, tables, and loads all data
│   └── 02_analysis_queries.sql     # 15 business analysis queries
└── screenshots/
    ├── 01_overview_results.png
    ├── 02_category_performance.png
    ├── 03_regional_performance.png
    └── ...                        # add your Workbench result screenshots here
```

## Database Schema
| Table | Description |
|---|---|
| `customers` | Customer details (segment, location, region) |
| `products` | Product catalog (category, sub-category) |
| `orders` | Order-level info (dates, ship mode) |
| `order_details` | Fact table — one row per line item (sales, quantity, discount, profit) |
| `returns` | Orders that were returned |
| `regional_managers` | Region → manager mapping |

## How to Run
1. Open `sql/01_schema_and_data.sql` in MySQL Workbench and execute — creates the database and loads all data.
2. Open `sql/02_analysis_queries.sql` and run each query to reproduce the results.

## Key Findings
See [`INSIGHTS.md`](./INSIGHTS.md) for the full write-up. Highlights:
- Furniture generates ~30% of revenue but under 6% of total profit
- Tables is the only sub-category operating at a net loss
- No-discount orders run ~29% margin; heavy discounting turns several categories unprofitable
- West and East regions drive ~67% of total sales

## Query Results (Screenshots)

**Overview — Total Sales, Profit, Margin**
![Overview Results](screenshots/01_overview_results.png)

**Category Performance**
![Category Performance](screenshots/02_category_performance.png)

**Regional Performance**
![Regional Performance](screenshots/03_regional_performance.png)

**Top 10 Customers**
![Top Customers](screenshots/04_top_customers.png)

**Monthly Sales Trend**
![Monthly Sales Trend](screenshots/05_monthly_sales_trend.png)

---
*Dataset: Sample Superstore dataset (public retail analytics dataset used widely for SQL/BI practice).*
