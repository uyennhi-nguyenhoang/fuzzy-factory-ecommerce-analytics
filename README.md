# 🛍️ Fuzzy Factory – E-Commerce Analytics Portfolio

## Project Overview

**Fuzzy Factory** is a fictional e-commerce toy company. This end-to-end analytics project analyzes 3 years of business data (March 2012 – March 2015) across sales performance, product strength, digital marketing, and customer funnel behavior.

The project demonstrates a full analytics workflow: raw data → SQL transformation → Tableau dashboards → business insights.

**Duration:** March 9 – April 29, 2026 (7 weeks)  
**Tools:** SQL (Google BigQuery) · Tableau Public  
**Data Source:** Maven Analytics – Fuzzy Factory (fictional e-commerce dataset)

---

## 📊 Dashboards

| # | Dashboard | Description |
|---|---|---|
| 1 | **Sales Summary** | Overall revenue, orders, margin, CAGR, refund rate trends |
| 2 | **Product Deep Dive** | Product-level performance, cost structure, combo analysis |
| 3 | **Digital Performance** | Traffic sources, conversion rates, device and campaign analysis |
| 4 | **Funnel Analysis** | Step-by-step conversion funnel with drop-off analysis |

🔗 [View on Tableau Public](https://public.tableau.com/views/FuzzyFactoryPublishedV1/ProductDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## 🗄️ Data Structure

| Table | Description |
|---|---|
| `website_sessions` | Each user visit – source, campaign, device, timestamp |
| `website_pageviews` | Pages viewed within each session |
| `orders` | Completed purchases with revenue and COGS |
| `order_items` | Individual products within each order |
| `order_item_refunds` | Refund records per order item |

## ✅ Data Quality
Data quality was validated before analysis – 
see [`00_data_cleaning_validation.sql`](/sql/00_data_cleaning_validation.sql).
All 5 raw tables were validated before analysis:
- **0 NULL values** across all key columns
- **0 blank/empty strings** in string fields
- **0 duplicate records** across all tables
---
## 🔧 Data Preparation

5 analytical tables were built from raw BigQuery data.
Full SQL queries available in the [`/sql`](/sql) folder.

| File | Table Created | Description |
|---|---|---|
| `01_traffic_performance.sql` | `traffic_performance` | Sessions, orders, revenue by source/campaign/device/date |
| `02_order_and_refund_by_product.sql` | `order_and_refund_by_product` | Daily product-level revenue, COGS, refunds |
| `03_revenue_summary_by_order.sql` | `revenue_summary_by_order` | Daily distinct order count and revenue |
| `04_order_combo_summary.sql` | `order_combo_summary` | Product pairing frequency for cross-sell analysis |
| `05_funnel_analysis.sql` | `funnel_analysis` | Session-level funnel flags by source/campaign/device/date |
| `06_customer_type_by_month.sql` | `customer_type_by_month` | Monthly new vs returning customer classification |


---

## 💡 Key Findings

1. **Strong overall growth** – Revenue grew at 188.5% CAGR (2012–2014), driven by order volume. The business expanded from 1 product to a 4-product portfolio, though Mr. Fuzzy still accounts for 62.5% of total revenue – a concentration risk.

2. **River Bear is an underrated asset** – The Hudson River Mini Bear has the lowest revenue due to its late 2014 launch, but the highest gross margin (~67%) and lowest refund rate (~1.28%). Additionally, River Bear is the most frequently paired product in combo orders: customers who buy Mr. Fuzzy most often choose River Bear as their second product (3,142 combo orders). This combination of strong unit economics and natural cross-sell affinity with the best-selling product suggests River Bear has significant untapped potential and deserves more targeted marketing investment.


3. **Digital: gsearch drives volume, direct converts best** – gsearch drives the majority of sessions and revenue, making it the primary acquisition engine. Meanwhile, direct/unknown traffic yields the highest conversion rate across all sources, indicating a strong returning customer base. Socialbook drives low volume and converts poorly. On device, desktop converts at 8.5% vs mobile at 3.09%, a significant gap suggesting the mobile experience needs improvement. 

4. **Cart is the critical funnel drop-off** – 54.8% of visitors who reach a product detail page do not proceed to cart. This pattern is consistent across all devices, sources, and campaigns – suggesting possible causes in pricing competitiveness, UX friction, or lack of purchase urgency.

---

## 📁 Repository Structure

```
fuzzy-factory-ecommerce-analytics/
├── README.md
└── sql/
    ├── 00_data_cleaning_validation.sql
    ├── 01_traffic_performance.sql
    ├── 02_order_and_refund_by_product.sql
    ├── 03_revenue_summary_by_order.sql
    ├── 04_order_combo_summary.sql
    ├── 05_funnel_analysis.sql
    └── 06_customer_type_by_month.sql
```

---

## 👤 Author

Built as a fresher data analyst portfolio project.  
**Tools:** SQL · Tableau · Google BigQuery  
**Contact:** [Linkedin](https://www.linkedin.com/in/uyennhi-nghoang/)


