# 3-Way Marketplace Analytics Engine & Predictive ETA Pipeline
## Hyperlocal Operational Optimization Study (Barcelona Ecosystem Proxy)

[Python]
[SQL]
[Power BI]
[XGBoost]

---

## 📌 Executive Summary
This project designs and deploys an end-to-end analytics data pipeline simulating a three-way logistics marketplace (Users, Merchants, Couriers) based on the operational models of urban delivery platforms like **Glovo**. 

Moving beyond flat-file analytical reporting, this framework tracks marketplace volatility, isolates localized supply/demand bottlenecks across Barcelona districts, evaluates platform unit economics, and implements an advanced machine learning model forecasting end-to-door fulfillment timelines.

---

## ⚙️ Core Architecture & Data Pipeline
The ecosystem runs as a continuous technical loop:
1. Data Ingestion Engine (Python): Generates 5,000 highly transactional order matrices spanning a 7-day loop across realistic Barcelona districts, injecting operational constraints such as peak meal rushes, vehicle performance baselines, and environmental friction.
2. Relational Storage Layer (SQLite/DBeaver): Implements a relational database schema structured around rigid Star Schema normalization guidelines, executing domain check constraints and ensuring cascading structural referential integrity.
3. Advanced Analytics & Unit Economics (SQL/DAX): Leverages modular CTE transformations, multi-criteria joins, window tracking percentiles, and complex dynamic measures to track performance and calculate monetization parameters.
4. Predictive Forecasting Model (XGBoost): Evaluates ongoing feature matrices via machine learning trees to accurately output predictive delivery expectations.

---

## 📊 Marketplace Unit Economics & Financial Modeling
To evaluate platform sustainability, the model tracks four interconnected data layers mimicking true platform monetization models:
* Gross Merchandise Value (GMV): The total monetary volume flowing through the system.
* Partner Commissions (22% Cut): High-margin enterprise revenue charged to partner merchants for traffic generation.
* Delivery Fees: Logistics-focused user revenue used directly to offset courier deployment costs.
* Take Rate %: The core platform financial health index, measuring the efficiency of turning total GMV into internal revenue.

## Core DAX Measures Implemented:
```dax
GMV = SUM(orders[basket_value_euros])

Total Delivery Fees = SUM(orders[delivery_fee_euros])

Total Commissions = SUM(orders[commission_euros])

Total Revenue = [Total Commissions] + [Total Delivery Fees]

Take Rate % = DIVIDE([Total Revenue], [GMV], 0)

Fulfillment Rate = DIVIDE(CALCULATE(COUNT(orders[order_id]), orders[order_status] = "Delivered"),COUNT(orders[order_id]),0)





