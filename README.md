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
DESCRIPTION:
Creates the project database and initializes environment.
```
DROP DATABASE IF EXISTS SwiftRoutelog;

CREATE DATABASE SwiftRoutelog;

USE SwiftRoutelog;
```

**02_table_creation.sql**
DESCRIPTION:
Creates all core business entities

#### Customers 

```
CREATE TABLE customers
(
Customer_ID INT PRIMARY KEY,
Customer_Name VARCHAR(50),
Customer_Type VARCHAR(20),
City VARCHAR(50),
Region VARCHAR(50),
Country VARCHAR(50)
);
```

#### Carriers 
```
CREATE TABLE carriers
(
Carrier_ID VARCHAR(20) PRIMARY KEY,
Carrier_Name VARCHAR(50),
Carrier_Type VARCHAR(50),
Contact_Email VARCHAR(100),
Rating INT,
Active_Status VARCHAR(20)
);
```

#### Vehicles
```
CREATE TABLE vehicles
(
Vehicle_ID VARCHAR(20) PRIMARY KEY,
Carrier_ID VARCHAR(20),
Vehicle_Type VARCHAR(20),
Vehicle_Capacity_Kg INT,
Registration_Number VARCHAR(50),
Vehicle_Status VARCHAR(20)
);
```
#### Routes
```
CREATE TABLE routes
(
Route_ID VARCHAR(20) PRIMARY KEY,
Origin VARCHAR(50),
Destination VARCHAR(50),
Distance_Km INT,
Estimated_Duration_Hours INT,
Standard_Cost DECIMAL(10,2)
);
```

#### Shipments
```
CREATE TABLE shipments
(
Shipment_ID VARCHAR(20) PRIMARY KEY,
Customer_ID INT NOT NULL,
Carrier_ID VARCHAR(20),
Vehicle_ID VARCHAR(20),
Route_ID VARCHAR(20),
Shipment_Date DATE,
Expected_Delivery_Date DATE,
Actual_Delivery_Date DATE,
Shipment_Weight_Kg DECIMAL(10,2),
Shipment_Status VARCHAR(20)
);
```

### Transportation Costs
```
CREATE TABLE transportation_costs
(
Cost_ID VARCHAR(20) PRIMARY KEY,
Shipment_ID VARCHAR(20) UNIQUE,
Fuel_Cost DECIMAL(10,2),
Driver_Cost DECIMAL(10,2),
Toll_Cost DECIMAL(10,2),
Carrier_Fee DECIMAL(10,2),
Maintenance_Cost DECIMAL(10,2),
Other_Cost DECIMAL(10,2),
Total_Transport_Cost DECIMAL(10,2)
);
```

### Delivery Events
```
CREATE TABLE delivery_events
(
Event_ID VARCHAR(20) PRIMARY KEY,
Shipment_ID VARCHAR(20),
Event_Type VARCHAR(50),
Event_Date DATE,
Location VARCHAR(50),
Notes VARCHAR(255)
);
```

 **03_constraints_keys.sql**

DESCRIPTION:
Adding foreign keys and business validation rules

```
ALTER TABLE vehicles
ADD CONSTRAINT fk_vehicle_carrier
FOREIGN KEY (Carrier_ID)
REFERENCES carriers(Carrier_ID);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipment_customer
FOREIGN KEY (Customer_ID)
REFERENCES customers(Customer_ID);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipment_carrier
FOREIGN KEY (Carrier_ID)
REFERENCES carriers(Carrier_ID);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipment_vehicle
FOREIGN KEY (Vehicle_ID)
REFERENCES vehicles(Vehicle_ID);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipment_route
FOREIGN KEY (Route_ID)
REFERENCES routes(Route_ID);

ALTER TABLE transportation_costs
ADD CONSTRAINT fk_cost_shipment
FOREIGN KEY (Shipment_ID)
REFERENCES shipments(Shipment_ID);

ALTER TABLE delivery_events
ADD CONSTRAINT fk_event_shipment
FOREIGN KEY (Shipment_ID)
REFERENCES shipments(Shipment_ID);

ALTER TABLE carriers
ADD CONSTRAINT chk_rating
CHECK (Rating BETWEEN 1 AND 5);
```


**04_data_population.sql**
DESCRIPTION:
Loads sample operational datasets

### Loading records in the Customers Table

```
INSERT INTO customers (Customer_ID, Customer_Name, Customer_Type, City, Region, Country)
VALUES
("1", "Tommy Hilfiger", "Platinum", "Elmira", "New York", "United States"),
("2", "Calvin Klein", "Gold", "Bronx", "New York", "United States"),
("3", "Ralph Lauren", "Gold", "Bronx", "New York", "United States"),
("4", "Timberland", "Platinum", "Stratham", "New Hampshire", "United States"),
("5", "Gucci", "Gold", "Florence ", "Tuscany", "Italy"),
("6", "Giorgio Armani", "Premium", "Piacenza", "Emilia-Romagna", "Italy"),
("7", "Burberry", "Silver", "Basingstoke", "Hampshire", "United Kingdom"),
("8", "Gap", "Standard", "San Francisco", "California", "United States"),
("9", "H&M", "Silver", "Västerås", "Västmanland County", "Sweden"),
("10", "Versace", "Gold", "Reggio Calabria", "Calabria", "Italy");
```


### Loading records in the Carriers Table
```
INSERT INTO carriers (Carrier_ID, Carrier_Name, Carrier_Type, Contact_Email, Rating, Active_Status)
VALUES
("CR001", "FedEx", "Courier ", "fedex@gmail.com", "4", "Active"),
("CR002", "Maersk", "Freight Company", "maersk@gmail.com", "3", "Active"),
("CR003", "SwiftRoute", "Internal Fleet", "bluedart@gmail.com", "5", "Active"),
("CR004", "MSC", "Sea", "msc@gmail.com", "4", "Inactive"),
("CR005", "Evri", "Road", "evri@gmail.com", "3", "Active");
```

### Loading records in the Vehicles Table
```
INSERT INTO vehicles (Vehicle_ID, Carrier_ID, Vehicle_Type, Vehicle_Capacity_Kg, Registration_Number, Vehicle_Status)
VALUES
("VI001", "CR001", "Truck", "25000", "TRK-1001", "Available"),
("VI002", "CR003", "Van", "1800", "VAN-1003", "Available"),
("VI003", "CR003", "Pickup", "900", "PUP-1005", "In Transit "),
("VI004", "CR001", "Minibus", "1000", "MNB-1007", "Available"),
("VI005", "CR003", "Van", "2200", "VAN-1004", "Maintenance"),
("VI006", "CR001", "Truck", "18000", "TRK-1005", "In Transit "),
("VI007", "CR002", "Truck", "20000", "TRK-1003", "Out of Service"),
("VI008", "CR004", "Van", "1500", "VAN-1008", "In Transit "),
("VI009", "CR002", "Pickup", "1200", "PUP-1006", "Available"),
("VI010", "CR005", "Truck", "15000", "TRK-1002", "Maintenance");
```

#### Updating the Vehicles records
TRIM() removes leading and trailing spaces from a text value.
```
UPDATE vehicles
SET Vehicle_Status = TRIM(Vehicle_Status)
WHERE Vehicle_Status = 'In Transit ';
```


### Loading records in the Routes Table
```
INSERT INTO routes (Route_ID, Origin, Destination, Distance_Km, Estimated_Duration_Hours, Standard_Cost)
VALUES
("R001", "Florence", "London", "1200", "18", "2500"),
("R002", "Milan", "New York", "6700", "72", "8800"),
("R003", "Reggio Calabria", "Los Angeles", "8800", "96", "11500"),
("R004", "London", "Chicago", "5350", "60", "7400"),
("R005", "New York", "Rome", "7800", "84", "9600"),
("R006", "San Francisco", "Milan", "9700", "108", "12800"),
("R007", "Manchester", "Rome", "1850", "28", "3700"),
("R008", "Los Angeles", "London", "8750", "94", "11300"),
("R009", "Venice", "Boston", "6500", "70", "8500"),
("R010", "Chicago", "Florence", "7700", "82", "9900");
```

### Loading records in the Shipments Table
```
INSERT INTO shipments (Shipment_ID, Customer_ID, Carrier_ID, Vehicle_ID, Route_ID, Shipment_Date, Expected_Delivery_Date,
Actual_Delivery_Date, Shipment_Weight_Kg, Shipment_Status)
VALUES
("S001", "4", "CR003", "VI001", "R008", "2026-08-09", "2026-09-14", '2026-09-13', 12.5, "Delivered"),
("S002", "5", "CR004", "VI008", "R008", "2026-09-14", "2026-09-22", '2026-09-24', 245.8, "Delivered"),
("S003", "8", "CR001", "VI006", "R003", "2026-08-20", "2026-08-23", '2026-08-23', 78.4, "Delivered"),
("S004", "6", "CR004", "VI008", "R003", "2026-09-05", "2026-09-12", NULL, 1250.6, "Delayed"),
("S005", "9", "CR002", "VI008", "R008", "2026-09-10", "2026-09-16", '2026-09-16', 35.2, "Delivered"),
("S006", "6", "CR005", "VI002", "R009", "2026-08-28", "2026-09-03", '2026-09-02', 486.75, "Delivered"),
("S007", "3", "CR005", "VI007", "R008", "2026-09-12", "2026-09-19", NULL, 92.6, "Pending"),
("S008", "3", "CR004", "VI006", "R004", "2026-08-31", "2026-09-04", '2026-09-04', 18.9, "Delivered"),
("S009", "4", "CR004", "VI001", "R008", "2026-08-27", "2026-09-01", '2026-09-02', 735.4, "Delivered"),
("S010", "8", "CR005", "VI008", "R007", "2026-09-12", "2026-09-18", NULL, 164.3, "In Transit"),
("S011", "9", "CR003", "VI007", "R010", "2026-08-25", "2026-08-31", NULL, 52.8, "Cancelled"),
("S012", "3", "CR005", "VI002", "R001", "2026-09-11", "2026-09-18", '2026-09-20', 2180.5, "Delivered"),
("S013", "8", "CR004", "VI005", "R008", "2026-08-22", "2026-08-27", NULL, 320.65, "Cancelled"),
("S014", "5", "CR004", "VI007", "R009", "2026-09-15", "2026-09-22", '2026-09-21', 8.4, "Delivered"),
("S015", "4", "CR003", "VI008", "R003", "2026-09-19", "2026-09-27", '2026-09-29', 615.2, "Delivered"),
("S016", "10", "CR004", "VI005", "R008", "2026-08-27", "2026-09-01", '2026-08-31', 145.9, "Delivered"),
("S017", "10", "CR002", "VI002", "R004", "2026-09-19", "2026-09-26", NULL, 980.75, "Cancelled"),
("S018", "5", "CR005", "VI007", "R006", "2026-09-14", "2026-09-22", NULL, 27.6, "In Transit"),
("S019", "3", "CR004", "VI003", "R003", "2026-08-26", "2026-09-01", '2026-09-01', 410.3, "Delivered"),
("S020", "6", "CR005", "VI005", "R004", "2026-09-12", "2026-09-18", NULL, 68.5, "Pending"),
("S021", "1", "CR004", "VI004", "R006", "2026-08-23", "2026-08-30", '2026-08-31', 1540.8, "Delivered"),
("S022", "8", "CR002", "VI009", "R009", "2026-08-29", "2026-09-04", NULL, 205.4, "Cancelled"),
("S023", "4", "CR004", "VI007", "R010", "2026-08-20", "2026-08-26", NULL, 43.7, "Cancelled"),
("S024", "7", "CR003", "VI010", "R001", "2026-09-06", "2026-09-13", '2026-09-12', 825.6, "Delivered"),
("S025", "8", "CR005", "VI001", "R004", "2026-09-02", "2026-09-08", '2026-09-10', 115.25, "Delivered"),
("S026", "5", "CR001", "VI009", "R008", "2026-09-12", "2026-09-20", NULL, 9.8, "In Transit"),
("S027", "5", "CR003", "VI003", "R001", "2026-08-28", "2026-09-04", '2026-09-03', 368.9, "Delivered"),
("S028", "1", "CR001", "VI006", "R001", "2026-07-28", "2026-08-03", '2026-08-05', 1875.3, "Delivered"),
("S029", "8", "CR005", "VI010", "R008", "2026-08-10", "2026-08-17", '2026-08-19', 56.4, "Delivered"),
("S030", "2", "CR003", "VI005", "R007", "2026-09-18", "2026-09-25", NULL, 290.75, "Pending"),
("S031", "2", "CR004", "VI001", "R005", "2026-08-25", "2026-09-01", '2026-09-03', 710.2, "Delivered"),
("S032", "10", "CR005", "VI008", "R004", "2026-09-19", "2026-09-27", '2026-09-26', 23.5, "Delivered"),
("S033", "4", "CR004", "VI006", "R010", "2026-09-22", "2026-09-30", NULL, 1105.6, "In Transit"),
("S034", "2", "CR001", "VI006", "R001", "2026-08-04", "2026-08-09", NULL, 182.8, "Cancelled"),
("S035", "6", "CR002", "VI001", "R005", "2026-09-04", "2026-09-11", '2026-09-13', 475.9, "Delivered"),
("S036", "8", "CR001", "VI004", "R004", "2026-08-21", "2026-08-28", '2026-08-27', 15.6, "Delivered"),
("S037", "4", "CR004", "VI009", "R001", "2026-08-07", "2026-08-14", NULL, 560.45, "Cancelled"),
("S038", "10", "CR004", "VI010", "R003", "2026-08-23", "2026-08-30", '2026-08-29', 95.3, "Delivered"),
("S039", "8", "CR005", "VI002", "R002", "2026-08-06", "2026-08-13", NULL, 1420.7, "Cancelled"),
("S040", "2", "CR001", "VI003", "R001", "2026-09-03", "2026-09-09", '2026-09-08', 305.2, "Delivered"),
("S041", "6", "CR002", "VI007", "R008", "2026-08-15", "2026-08-21", NULL, 38.9, "Cancelled"),
("S042", "9", "CR003", "VI002", "R002", "2026-09-02", "2026-09-10", NULL, 895.5, "Delayed"),
("S043", "9", "CR003", "VI009", "R002", "2026-09-03", "2026-09-11", '2026-09-10', 130.6, "Delivered"),
("S044", "3", "CR003", "VI001", "R004", "2026-07-26", "2026-08-01", '2026-08-03', 2450.8, "Delivered"),
("S045", "6", "CR002", "VI005", "R003", "2026-09-16", "2026-09-22", NULL, 62.75, "In Transit"),
("S046", "3", "CR002", "VI006", "R001", "2026-09-18", "2026-09-25", NULL, 520.4, "Delayed"),
("S047", "5", "CR004", "VI006", "R007", "2026-08-05", "2026-08-09", '2026-08-08', 210.9, "Delivered"),
("S048", "9", "CR001", "VI008", "R008", "2026-09-05", "2026-09-12", NULL, 1680.25, "Cancelled"),
("S049", "7", "CR002", "VI001", "R009", "2026-08-06", "2026-08-13", '2026-08-12', 44.8, "Delivered"),
("S050", "4", "CR002", "VI009", "R009", "2026-09-09", "2026-09-16", NULL, 645.7, "Delayed");
```

### Loading records in the Transportation_Costs Table
```
INSERT INTO transportation_costs (Cost_ID, Shipment_ID, Fuel_Cost, Driver_Cost, Toll_Cost, Carrier_Fee, Maintenance_Cost,
 Other_Cost, Total_Transport_Cost)
VALUES
("CID001", "S001", "85.5", "120", "12.5", "45", "18", "8.5", "289.5"),
("CID002", "S002", "112.75", "145", "18", "55", "22.5", "12", "365.25"),
("CID003", "S003", "64.2", "95", "0", "35", "14", "6.5", "214.7"),
("CID004", "S004", "145.8", "175", "25.5", "70", "30", "15", "461.3"),
("CID005", "S005", "92.4", "130", "8.5", "48", "19.5", "9", "307.4"),
("CID006", "S006", "58.75", "85", "0", "30", "12", "5.5", "191.25"),
("CID007", "S007", "128.6", "160", "22", "62", "26", "13.5", "412.1"),
("CID008", "S008", "76.9", "110", "6.5", "40", "16", "7", "256.4"),
("CID009", "S009", "105.25", "140", "15", "52", "21", "10.5", "343.75"),
("CID010", "S010", "158.4", "190", "32", "78", "35", "18", "511.4"),
("CID011", "S011", "70.5", "100", "0", "38", "15", "6", "229.5"),
("CID012", "S012", "98.8", "135", "11.5", "50", "20", "9.5", "324.8"),
("CID013", "S013", "135.6", "165", "24", "65", "28", "14", "431.6"),
("CID014", "S014", "62.3", "90", "4.5", "32", "13", "5", "206.8"),
("CID015", "S015", "118.9", "150", "19.5", "58", "24", "11.5", "381.9"),
("CID016", "S016", "88.2", "125", "9", "46", "18.5", "8", "294.7"),
("CID017", "S017", "172.5", "205", "35", "85", "38", "20", "555.5"),
("CID018", "S018", "73.6", "105", "5", "39", "15.5", "7.5", "245.6"),
("CID019", "S019", "101.4", "138", "14", "51", "21.5", "10", "335.9"),
("CID020", "S020", "83.75", "118", "7.5", "44", "17", "8.5", "278.75"),
("CID021", "S021", "124.3", "155", "20", "60", "25", "12", "396.3"),
("CID022", "S022", "55.8", "80", "0", "28", "11", "4.5", "179.3"),
("CID023", "S023", "142.6", "172", "27.5", "68", "29", "15.5", "454.6"),
("CID024", "S024", "95.7", "132", "10", "49", "19", "9", "314.7"),
("CID025", "S025", "109.5", "142", "16.5", "54", "22", "11", "355"),
("CID026", "S026", "68.4", "98", "3.5", "36", "14.5", "6", "226.4"),
("CID027", "S027", "151.2", "182", "29", "73", "32", "16.5", "483.7"),
("CID028", "S028", "87.6", "122", "8", "45", "18", "8", "288.6"),
("CID029", "S029", "116.8", "148", "17", "57", "23", "11.5", "373.3"),
("CID030", "S030", "63.9", "92", "0", "33", "13.5", "5.5", "207.9"),
("CID031", "S031", "132.4", "163", "23.5", "64", "27", "13", "422.9"),
("CID032", "S032", "79.3", "112", "6", "41", "16.5", "7", "261.8"),
("CID033", "S033", "103.6", "139", "13.5", "52", "21", "10", "339.1"),
("CID034", "S034", "165.7", "198", "33.5", "82", "36", "19", "534.2"),
("CID035", "S035", "72.8", "103", "4", "37", "15", "6.5", "238.3"),
("CID036", "S036", "121.5", "152", "19", "59", "24.5", "12", "388"),
("CID037", "S037", "90.6", "127", "9.5", "47", "19", "8.5", "301.6"),
("CID038", "S038", "147.3", "178", "26", "71", "31", "16", "469.3"),
("CID039", "S039", "60.5", "88", "0", "31", "12.5", "5", "197"),
("CID040", "S040", "114.2", "146", "16", "56", "22.5", "11", "365.7"),
("CID041", "S041", "96.4", "134", "12", "50", "20", "9.5", "321.9"),
("CID042", "S042", "138.7", "168", "25", "67", "28.5", "14.5", "441.7"),
("CID043", "S043", "75.2", "108", "5.5", "40", "16", "7", "251.7"),
("CID044", "S044", "126.9", "158", "21.5", "61", "26", "12.5", "405.9"),
("CID045", "S045", "54.6", "78", "0", "27", "10.5", "4", "174.1"),
("CID046", "S046", "155.8", "185", "30.5", "76", "33", "17", "497.3"),
("CID047", "S047", "84.9", "119", "8.5", "44.5", "17.5", "8", "282.4"),
("CID048", "S048", "107.3", "143", "15.5", "53", "22", "10.5", "351.3"),
("CID049", "S049", "130.5", "161", "22.5", "63", "27", "13.5", "417.5"),
("CID050", "S050", "69.8", "99", "3", "36.5", "14", "6", "228.3");
```

### Loading records in the Delivery_Events Table
```
INSERT INTO delivery_events (Event_ID, Shipment_ID, Event_Type, Event_Date, Location, Notes)
VALUES
("E001", "S003", "Shipment Picked Up", "2026-09-06", "Rome", "Returned"),
("E002", "S017", "Vehicle Breakdown", "2026-09-27", "Boston", "Pending"),
("E003", "S004", "Delivery Attempt", "2026-09-02", "Manchester", "Missing"),
("E004", "S011", "Warehouse Delay", "2026-09-03", "Rome", "Address_Issue"),
("E005", "S022", "Traffic Delay", "2026-09-23", "Rome", "Customs_Hold"),
("E006", "S023", "Warehouse Delay", "2026-09-14", "London", "Missing"),
("E007", "S012", "Traffic Delay", "2026-09-29", "Florence", "Recipient_Absent"),
("E008", "S018", "Delivery Attempt", "2026-09-29", "Boston", "Okay"),
("E009", "S024", "Warehouse Delay", "2026-09-02", "Florence", "Recipient_Absent"),
("E010", "S036", "Vehicle Breakdown", "2026-09-04", "Los Angeles", "Pending"),
("E011", "S040", "Delivery Attempt", "2026-09-05", "Los Angeles", "Damaged"),
("E012", "S026", "Vehicle Breakdown", "2026-09-23", "Los Angeles", "Address_Issue"),
("E013", "S020", "Vehicle Breakdown", "2026-09-20", "Los Angeles", "Customs_Hold"),
("E014", "S015", "Traffic Delay", "2026-09-29", "Milan", "Pending"),
("E015", "S048", "Vehicle Breakdown", "2026-09-24", "Boston", "Returned"),
("E016", "S007", "Shipment Picked Up", "2026-09-04", "London", "Returned"),
("E017", "S019", "Traffic Delay", "2026-09-28", "New York", "Pending"),
("E018", "S021", "Traffic Delay", "2026-09-21", "London", "Failed"),
("E019", "S010", "Warehouse Delay", "2026-09-12", "New York", "Okay"),
("E020", "S027", "Vehicle Breakdown", "2026-09-18", "San Francisco", "Recipient_Absent"),
("E021", "S039", "Shipment Picked Up", "2026-09-28", "Venice", "Missing"),
("E022", "S044", "Traffic Delay", "2026-09-21", "Rome", "Delayed"),
("E023", "S042", "Vehicle Breakdown", "2026-09-14", "Reggio Calabria", "Rescheduled"),
("E024", "S045", "Delivery Attempt", "2026-09-21", "Los Angeles", "Okay"),
("E025", "S050", "Traffic Delay", "2026-09-16", "Milan", "Delayed"),
("E026", "S041", "Delivery Attempt", "2026-09-07", "Manchester", "Failed"),
("E027", "S028", "Warehouse Delay", "2026-09-26", "Manchester", "Customs_Hold"),
("E028", "S043", "Warehouse Delay", "2026-09-01", "San Francisco", "Failed"),
("E029", "S033", "Traffic Delay", "2026-09-02", "London", "Returned"),
("E030", "S049", "Shipment Picked Up", "2026-09-20", "Milan", "Recipient_Absent");
```


# 05_Data_Cleaning

DESCRIPTION:
Initial database exploration

```
SELECT * 
FROM customers;
```
<img width="653" height="216" alt="image" src="https://github.com/user-attachments/assets/dc42f3a4-b5f9-4abf-b79c-a5eded1eb681" />


```
SELECT * 
FROM carriers;
```
<img width="538" height="134" alt="image" src="https://github.com/user-attachments/assets/6097a590-2557-46ad-86ec-0a8a4d2ce429" />

```
SELECT * 
FROM vehicles;
```
<img width="598" height="221" alt="image" src="https://github.com/user-attachments/assets/754ebca0-b2b8-4378-8203-46446fec08df" />


```
SELECT * 
FROM routes;
```
<img width="592" height="223" alt="image" src="https://github.com/user-attachments/assets/685781e2-f117-4b02-aad3-80392fb89d11" />


```
SELECT * 
FROM shipments;
```
<img width="993" height="214" alt="image" src="https://github.com/user-attachments/assets/bc01a572-d307-4abb-9a7d-bf854c1d04a8" />

```
SELECT * 
FROM transportation_costs;
```
<img width="754" height="218" alt="image" src="https://github.com/user-attachments/assets/b1570910-f546-4e39-8f8c-f344f5e6ae96" />


```
SELECT * 
FROM delivery_events;
```
<img width="547" height="224" alt="image" src="https://github.com/user-attachments/assets/e90d18cc-1af0-47b3-98af-1e56d1f61c7d" />

#### Unique shipment statuses

``
SELECT DISTINCT Shipment_Status
FROM shipments;
```
<img width="363" height="140" alt="image" src="https://github.com/user-attachments/assets/ef99d550-08f3-4115-95cf-185b42ae3224" />

#### Unique vehicle types
```
SELECT DISTINCT Vehicle_Type
FROM vehicles;
```
<img width="370" height="140" alt="image" src="https://github.com/user-attachments/assets/3b33ebdf-f12b-4308-866e-3d2a90535695" />

**07_aggregate_analysis.sql**
DESCRIPTION:
Aggregate transportation metrics

### Shipment volume by carrier
```
SELECT
s.Carrier_ID, c.Carrier_Name,
COUNT(*) AS Shipment_Count
FROM shipments s
LEFT JOIN carriers c
ON s.Carrier_ID = c.Carrier_ID
GROUP BY Carrier_ID
ORDER BY Shipment_Count DESC;
```


