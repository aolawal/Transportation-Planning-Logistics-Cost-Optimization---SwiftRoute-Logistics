# Transportation-Planning-Logistics-Cost-Optimization-SwiftRoute-Logistics
This project designs and implements a centralized SQL database that consolidates transportation operations into a single source of truth, enabling meaningful business analysis and data-driven decision-making.

# Project Overview

SwiftRoute Logistics Ltd. is a transportation and logistics company operating through a combination of internal fleet assets and third-party carriers.

As transportation data becomes distributed across Transportation Management Systems (TMS), carrier reports, spreadsheets, emails, and manual records, management struggles to gain visibility into:

- Transportation costs
- Carrier performance
- Route efficiency
- Delivery reliability
- Customer shipping activity
- Transportation delays


## Business Problem

Fragmented transportation data limits the organization's ability to:

- Control freight spending
- Evaluate carrier performance
- Identify recurring delivery delays
- Monitor route efficiency
- Optimize logistics operations
- Improve customer service levels

The objective of this project is to build a relational database and perform advanced SQL analysis to uncover operational inefficiencies and cost-saving opportunities.

## Database Architecture

The solution was designed using a normalized relational database structure consisting of seven core entities:

| S/N | Table Name            | Table Description                                                                 |
|-----|-----------------------|-----------------------------------------------------------------------------------|
| 1   | Customers             | Stores customer master data.                                                     |
| 2   | Carriers              | Tracks transportation providers and carrier performance metrics.                |
| 3   | Vehicles              | Maintains vehicle information, including capacity and operational status.       |
| 4   | Routes                | Stores transportation lane information, including origin, destination, distance, and standard cost. |
| 5   | Shipments             | Captures shipment transactions and delivery performance.                         |
| 6   | Transportation Costs  | Contains shipment-level transportation cost components.                         |
| 7   | Delivery Events       | Records transportation issues and delivery-related events.                      |

# Project Highlights
This project demonstrates end-to-end SQL analytics capabilities including:
- Relational Database Design
- Data Modelling
- Data Cleaning & Data Quality Validation
- Complex SQL Joins
- Aggregate Calculations
- Business KPI Development
- Subqueries & CTEs
- Window Functions
- Transportation Cost Analysis
- Carrier Performance Analysis
- Logistics Optimization
- Executive-Level Business Recommendations

## SQL Skills Demonstrated
This project showcases:
- Database Design
- Relational Modeling
- Primary Keys
- Data Cleaning
- INSERT, UPDATE, DELETE
- Filtering and Sorting
- Aggregate Functions
- CASE Statements
- INNER JOINS
- LEFT JOINS
- Common Table Expressions (CTEs)
- Subqueries
- Window Functions
- NULL Handling
- Ranking Functions
- Business KPI Development

# Key Business Questions Answered

## Carrier Analysis
- Which carriers handle the highest shipment volumes?
- Which carriers generate the highest transportation costs?
- Which carriers experience the highest delay rates?

## Route Analysis
- Which transportation lanes experience recurring delays?
- Which routes generate unusually high costs per kilometer?

## Customer Analysis
- Which customers drive the highest logistics spending?
- Which customers have the highest average transportation cost?

## Delivery Performance
- What percentage of shipments are delivered on time?
- What are the most common causes of transportation delays?

## Cost Analysis
- How has transportation spending evolved over time?
- Where should management focus cost-reduction initiatives?

# Key Findings

## Carrier Performance
- CR001 (FedEx) achieved the strongest delivery performance.
- CR005 (Evri) recorded the lowest on-time delivery percentage.
- Shipment allocation is not aligned with carrier performance.

## Transportation Delays
- Traffic delays were identified as the leading contributor to late deliveries.
- Several London-bound routes exhibited recurring delivery issues.
- Certain lanes demonstrated significantly higher delay rates than others.

## Logistics Costs
- Driver costs and fuel costs were the largest contributors to total transportation spending.
- Several routes generated disproportionately high transportation costs relative to distance travelled.

## Customer Spending
- Gap, Timberland, and Ralph Lauren generated the highest total transportation spend.
- Versace demonstrated the highest average spend per shipment.

## Shipment Outcomes
- 60% of shipments were successfully delivered.
- 20% of shipments were cancelled.
- Cancellation rates warrant further investigation due to potential operational and customer-service impacts.

## Business Recommendations
### 1. Reallocate Carrier Volume
Increase shipment allocation to high-performing carriers such as CR001 while reviewing underperforming providers.

### 2. Improve Route Planning
Investigate recurring delays on London-bound lanes and redesign transportation schedules where necessary.

### 3. Reduce Traffic-Driven Delays
Implement route optimization and dynamic departure planning to reduce traffic-related transportation disruptions.

### 4. Establish Cost Governance
Monitor fuel and driver costs through recurring transportation cost scorecards.

### 5. Prioritize Route Efficiency and Driver Productivity to Capture the Largest Logistics Savings
Optimize routes, cut empty miles, improve driver utilization, and fix delay-prone lanes to reduce fuel and labor costs, which together make up nearly 72% of logistics spend.

### 6. Investigate Shipment Cancellations
Perform root-cause analysis on cancelled shipments to uncover operational failures and customer-impacting issues.

### 7. Build Customer Profitability Analytics
Differentiate high-volume customers from high-cost customers to improve commercial decision-making.

## Future Enhancements
- Logistics KPI Dashboard (Power BI)
- Vehicle Utilization Monitoring
- Cost-per-Kilometer Optimization
- Customer Profitability Analysis
- Predictive Delay Modeling
- Automated Carrier Scorecards
- Route Optimization Engine

## Tools Used
- MySQL
- SQL
- Relational Database Design
- PowerPoint
- Business Intelligence & Analytics

# SQL Scripts
- **01_database_setup.sql**
- **02_table_creation.sql**
- **03_constraints_keys.sql**
- **04_data_population.sql**
- **05_data_cleaning.sql**
- **06_exploratory_analysis.sql**
- **07_aggregate_analysis.sql**
- **08_join_analysis.sql**
- **09_delivery_performance.sql**
- **10_cte_subqueries.sql**
- **11_window_functions.sql**
- **12_business_questions.sql**
- **13_data_modification.sql**
- **14_views_kpis.sql**
- **15_stored_procedures.sql**
- **16_indexes.sql**
- **17_triggers.sql**
- **18_kpi_dashboard_queries.sql**
- **19_data_dictionary.sql**

**01_database_setup.sql**
```
DROP DATABASE IF EXISTS SwiftRoutelog;

CREATE DATABASE SwiftRoutelog;

USE SwiftRoutelog;
```








  
