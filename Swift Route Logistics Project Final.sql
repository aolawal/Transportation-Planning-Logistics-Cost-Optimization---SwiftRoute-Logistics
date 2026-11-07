
-- PROJECT: SwiftRoute Logistics Cost Optimization
/*
01_database_setup.sql
│
├── Create Database
├── Create Schema
└── Database Initialization

02_table_creation.sql
│
├── Customers
├── Carriers
├── Vehicles
├── Routes
├── Shipments
├── Transportation_Costs
└── Delivery_Events

03_constraints_keys.sql
│
├── Primary Keys
├── Foreign Keys
├── Unique Constraints
├── Default Constraints
└── Check Constraints
*/

-- 01. Database_Setup
/*
=========================================================
PROJECT: SwiftRoute Logistics Cost Optimization
FILE: 01_database_setup.sql
AUTHOR: Segun Lawal
DESCRIPTION:
Creates the project database and initializes environment.
=========================================================
*/

DROP DATABASE IF EXISTS SwiftRoutelog;
CREATE DATABASE SwiftRoutelog;
USE SwiftRoutelog;

/*
=========================================================
DATABASE CREATED SUCCESSFULLY
=========================================================
*/


-- 02. Table_Creation
/*
=========================================================
FILE: 02_table_creation.sql
DESCRIPTION:
Creates all core business entities
=========================================================
*/

-- Customers
CREATE TABLE customers
(
Customer_ID INT PRIMARY KEY,
Customer_Name VARCHAR(50),
Customer_Type VARCHAR(20),
City VARCHAR(50),
Region VARCHAR(50),
Country VARCHAR(50)
);

-- Carriers
CREATE TABLE carriers
(
Carrier_ID VARCHAR(20) PRIMARY KEY,
Carrier_Name VARCHAR(50),
Carrier_Type VARCHAR(50),
Contact_Email VARCHAR(100),
Rating INT,
Active_Status VARCHAR(20)
);

-- Vehicles
CREATE TABLE vehicles
(
Vehicle_ID VARCHAR(20) PRIMARY KEY,
Carrier_ID VARCHAR(20),
Vehicle_Type VARCHAR(20),
Vehicle_Capacity_Kg INT,
Registration_Number VARCHAR(50),
Vehicle_Status VARCHAR(20)
);

-- Routes
CREATE TABLE routes
(
Route_ID VARCHAR(20) PRIMARY KEY,
Origin VARCHAR(50),
Destination VARCHAR(50),
Distance_Km INT,
Estimated_Duration_Hours INT,
Standard_Cost DECIMAL(10,2)
);

-- Shipments
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

-- Transportation Costs
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

-- Delivery Events
CREATE TABLE delivery_events
(
Event_ID VARCHAR(20) PRIMARY KEY,
Shipment_ID VARCHAR(20),
Event_Type VARCHAR(50),
Event_Date DATE,
Location VARCHAR(50),
Notes VARCHAR(255)
);


-- 03. Constraints_keys
/*
=========================================================
FILE: 03_constraints_keys.sql
DESCRIPTION:
Adds foreign keys and business validation rules
=========================================================
*/

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


-- 04_Data_Population
/*
=========================================================
FILE: 04_data_population.sql
DESCRIPTION:
Loads sample operational datasets
=========================================================
*/

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


INSERT INTO carriers (Carrier_ID, Carrier_Name, Carrier_Type, Contact_Email, Rating, Active_Status)
VALUES
("CR001", "FedEx", "Courier ", "fedex@gmail.com", "4", "Active"),
("CR002", "Maersk", "Freight Company", "maersk@gmail.com", "3", "Active"),
("CR003", "SwiftRoute", "Internal Fleet", "bluedart@gmail.com", "5", "Active"),
("CR004", "MSC", "Sea", "msc@gmail.com", "4", "Inactive"),
("CR005", "Evri", "Road", "evri@gmail.com", "3", "Active");


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

-- TRIM() removes leading and trailing spaces from a text value.
UPDATE vehicles
SET Vehicle_Status = TRIM(Vehicle_Status)
WHERE Vehicle_Status = 'In Transit ';

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


-- 05_Data_Cleaning
/*
=========================================================
FILE: 06_exploratory_analysis.sql
DESCRIPTION:
Initial database exploration
=========================================================
*/

SELECT * 
FROM customers;

SELECT * 
FROM carriers;

SELECT * 
FROM vehicles;

SELECT * 
FROM routes;

SELECT * 
FROM shipments;

SELECT * 
FROM transportation_costs;

SELECT * 
FROM delivery_events;

-- Unique shipment statuses

SELECT DISTINCT Shipment_Status
FROM shipments;

-- Unique vehicle types

SELECT DISTINCT Vehicle_Type
FROM vehicles;

-- 07_Aggregate_Analysis
/*
=========================================================
FILE: 07_aggregate_analysis.sql
DESCRIPTION:
Aggregate transportation metrics
=========================================================
*/

-- Shipment volume by carrier
SELECT
s.Carrier_ID, c.Carrier_Name,
COUNT(*) AS Shipment_Count
FROM shipments s
LEFT JOIN carriers c
ON s.Carrier_ID = c.Carrier_ID
GROUP BY Carrier_ID
ORDER BY Shipment_Count DESC;

-- Transportation spend summary
SELECT
SUM(Total_Transport_Cost) AS Total_Logistics_Expenditure,
AVG(Total_Transport_Cost) AS Average_Cost,
MIN(Total_Transport_Cost) AS Min_Cost,
MAX(Total_Transport_Cost) AS Max_Cost
FROM transportation_costs;

-- 08_Join_Analysis
/*
=========================================================
FILE: 08_join_analysis.sql
DESCRIPTION:
Cross-table business reporting
=========================================================
*/

SELECT
s.Shipment_ID,
c.Customer_Name,
ca.Carrier_Name,
v.Vehicle_Type,
r.Origin,
r.Destination,
s.Shipment_Status
FROM shipments s
JOIN customers c
ON s.Customer_ID = c.Customer_ID
JOIN carriers ca
ON s.Carrier_ID = ca.Carrier_ID
JOIN vehicles v
ON s.Vehicle_ID = v.Vehicle_ID
JOIN routes r
ON s.Route_ID = r.Route_ID;


-- 09_delivery_performance
/*
=========================================================
FILE: 09_delivery_performance.sql
DESCRIPTION:
Delivery KPI calculations
=========================================================
*/

WITH Delivery_Status AS
(
    SELECT
        s.Shipment_ID,
        s.Carrier_ID,
        c.Carrier_Name,
        CASE
            WHEN Actual_Delivery_Date <= Expected_Delivery_Date
            THEN 'On Time'
            ELSE 'Late'
        END AS Delivery_Status
    FROM shipments s
    LEFT JOIN carriers c
	ON s.Carrier_ID = c.Carrier_ID
    WHERE Actual_Delivery_Date IS NOT NULL
)

SELECT
    Carrier_ID, 
    Carrier_Name,
    COUNT(*) Total_Deliveries
FROM Delivery_Status
GROUP BY Carrier_ID;

-- 10_CTE_Subqueries
/*
=========================================================
FILE: 10_cte_subqueries.sql
DESCRIPTION:
Advanced SQL using subqueries and CTEs
=========================================================
*/

-- Above average shipment cost

SELECT *
FROM transportation_costs
WHERE Total_Transport_Cost >
(
    SELECT AVG(Total_Transport_Cost)
    FROM transportation_costs
);

-- High-cost routes

WITH Route_Costs AS
(
    SELECT
        r.Route_ID,
        AVG(t.Total_Transport_Cost) Avg_Cost
    FROM routes r
    JOIN shipments s
        ON r.Route_ID = s.Route_ID
    JOIN transportation_costs t
        ON s.Shipment_ID = t.Shipment_ID
    GROUP BY r.Route_ID
)

SELECT *
FROM Route_Costs;

-- 11_Window_Functions
/*
=========================================================
FILE: 11_window_functions.sql
DESCRIPTION:
Ranking and cumulative analysis
=========================================================
*/

-- Carrier ranking

SELECT
    s.Carrier_ID,
	c.Carrier_Name,
    SUM(t.Total_Transport_Cost) Total_Cost,
    RANK() OVER
    (
        ORDER BY SUM(t.Total_Transport_Cost) DESC
    ) AS Carrier_Rank
FROM shipments s
JOIN transportation_costs t
ON s.Shipment_ID = t.Shipment_ID
LEFT JOIN carriers c
ON s.Carrier_ID = c.Carrier_ID
GROUP BY s.Carrier_ID;

-- Running transportation spend

SELECT
    Shipment_Date,
    SUM(Total_Transport_Cost)
        OVER
        (
            ORDER BY Shipment_Date
        ) AS Running_Total
FROM shipments s
JOIN transportation_costs t
ON s.Shipment_ID = t.Shipment_ID;

/*
=========================================================
FILE: 12_business_questions.sql
DESCRIPTION:
Executive-level business analysis
=========================================================
*/
-- Which carrier handles most shipments?
-- Highest transportation spend?
-- Most delayed carrier?
-- Most delayed route?
-- Highest spending customers?
-- Transportation spend trend?
-- Cost reduction opportunities?

-- 1.	Which carriers handle the most shipments?
SELECT s.Carrier_ID, 
c.Carrier_Name, 
COUNT(s.Shipment_ID) Shipment_Count
FROM shipments s
    LEFT JOIN carriers c
	ON s.Carrier_ID = c.Carrier_ID
GROUP BY Carrier_ID
ORDER BY COUNT(Shipment_ID) DESC;

-- 2.	Which carriers generate the highest transportation costs?
SELECT c.Carrier_ID,
c.Carrier_Name, 
SUM(t.Total_Transport_Cost) Total_Transport_Cost
FROM carriers c
LEFT JOIN shipments s
ON c.Carrier_ID = s.Carrier_ID
LEFT JOIN transportation_costs t
ON t.Shipment_ID = s.Shipment_ID
GROUP BY Carrier_ID
ORDER BY Total_Transport_Cost DESC;

-- 3.	Which carriers have the highest number of delayed shipments?
-- N.B: Delayed shipment with Null Actual Delivery Date included i.e. not yet delivered shipment)
SELECT s.Carrier_ID, 
c.Carrier_Name,
COUNT(*) Count_of_Delayed_Shipment
FROM shipments s
LEFT JOIN carriers c
ON s.Carrier_ID = c.Carrier_ID
WHERE(
Actual_Delivery_Date > Expected_Delivery_Date
OR (Actual_Delivery_Date IS NULL
AND Shipment_Status = 'Delayed')
)
GROUP BY Carrier_ID
ORDER BY COUNT(*) DESC;


-- 4. Which routes experience recurring delivery delays?
SELECT 
r.Route_ID, 
r.Origin, 
r.Destination,
COUNT(*) AS Delayed_Shipments
FROM shipments s
JOIN routes r
ON s.Route_ID = r.Route_ID
WHERE Shipment_Status = 'Delayed'
   OR Actual_Delivery_Date > Expected_Delivery_Date
GROUP BY r.Route_ID, r.Origin, r.Destination
ORDER BY Delayed_Shipments DESC;

-- 5. Which routes have unusually high costs per kilometer?
SELECT r.Origin, r.Destination, r.Distance_Km,
SUM(t.Total_Transport_Cost) AS Total_Cost,
ROUND(SUM(t.Total_Transport_Cost) /
NULLIF(r.Distance_KM * COUNT(DISTINCT s.Shipment_ID), 0),2
       ) AS Cost_Per_KM
FROM routes r
LEFT JOIN shipments s
ON s.Route_ID = r.Route_ID
LEFT JOIN transportation_costs t
ON t.Shipment_ID = s.Shipment_ID
GROUP BY r.Origin, r.Destination, r.Distance_KM
ORDER BY Cost_Per_KM DESC;

-- 6. Which customers generate the highest logistics spending?
-- Total Logistics Spending
SELECT c.Customer_ID, c.Customer_Name, SUM(t.Total_Transport_Cost) High_Logistics_Spending
FROM customers c
LEFT JOIN shipments s
ON c.Customer_ID = s.Customer_ID
LEFT JOIN transportation_costs t
ON s.Shipment_ID = t.Shipment_ID
GROUP BY c.Customer_ID
ORDER BY SUM(t.Total_Transport_Cost) DESC;

-- Average Logistics Spending
SELECT c.Customer_ID, c.Customer_Name, ROUND(AVG(t.Total_Transport_Cost),2) AVG_Logistics_Spending
FROM customers c
LEFT JOIN shipments s
ON c.Customer_ID = s.Customer_ID
LEFT JOIN transportation_costs t
ON s.Shipment_ID = t.Shipment_ID
GROUP BY c.Customer_ID
ORDER BY AVG(t.Total_Transport_Cost) DESC;


-- 7.	What are the most common causes of transportation delays? 
-- (some issues were multiple under event type but didn't result in delay)
-- e.g vehicle breakdown more than ONCE but only 1 resulted in delayed shipment
SELECT d.Event_Type, COUNT(d.Event_Type) Count_of_Delays
FROM delivery_events d
JOIN shipments s
ON d.Shipment_ID = s.Shipment_ID
WHERE(
s.Actual_Delivery_Date > s.Expected_Delivery_Date
OR (s.Actual_Delivery_Date IS NULL
AND s.Shipment_Status = 'Delayed')
)
GROUP BY d.Event_Type
ORDER BY COUNT(d.Event_Type) DESC;

-- 8.	How has transportation spending changed over time?
-- Overall % change in Total Expenditure over the period
WITH Expenditure AS (
    SELECT
        s.Shipment_Date,
        t.Total_Transport_Cost,
        SUM(t.Total_Transport_Cost) OVER (
            ORDER BY s.Shipment_Date
        ) AS Cumulative_Expenditure
    FROM shipments s
    LEFT JOIN transportation_costs t
        ON s.Shipment_ID = t.Shipment_ID)
SELECT *, ROUND(
        (Cumulative_Expenditure -
         LAG(Cumulative_Expenditure) OVER (ORDER BY Shipment_Date))
        * 100.0 /
        NULLIF(LAG(Cumulative_Expenditure) OVER (ORDER BY Shipment_Date), 0),
        2
    ) AS Percentage_Increase
FROM Expenditure
ORDER BY Shipment_Date;

-- % in Expenditure over the period by Customer_ID
WITH Expenditure AS (
    SELECT
        s.Customer_ID,
        s.Shipment_Date,
        t.Total_Transport_Cost,
        SUM(t.Total_Transport_Cost) OVER (
            PARTITION BY s.Customer_ID
            ORDER BY s.Shipment_Date
        ) AS Cumulative_Expenditure
    FROM shipments s
    LEFT JOIN transportation_costs t
        ON s.Shipment_ID = t.Shipment_ID
)
SELECT *,
    ROUND(
        (Cumulative_Expenditure -
         LAG(Cumulative_Expenditure) OVER (
             PARTITION BY Customer_ID
             ORDER BY Shipment_Date
         )) * 100.0 /
        NULLIF(
            LAG(Cumulative_Expenditure) OVER (
                PARTITION BY Customer_ID
                ORDER BY Shipment_Date
            ), 0
        ), 2
    ) AS Percentage_Increase
FROM Expenditure
ORDER BY Customer_ID, Shipment_Date;


-- 9.	Are longer routes always more expensive? 
-- That's not true from the result shown - bar chart
SELECT
    Route_ID,
    Origin,
    Destination,
    Distance_Km,
    (Standard_Cost / NULLIF(Distance_Km, 0)) AS Cost_per_Km
FROM routes
ORDER BY Cost_per_Km DESC;

-- 10.	Where should management investigate opportunities to reduce logistics costs? DRIVER AND FUEL COST
SELECT
    Cost_ID,
    Shipment_ID,
    ROUND(Fuel_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0), 2) AS Fuel_Cost_Percent,
    ROUND(Driver_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0), 2) AS Driver_Cost_Percent,
    ROUND(Toll_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0), 2) AS Toll_Cost_Percent,
    ROUND(Carrier_Fee * 100.0 / NULLIF(Total_Transport_Cost, 0), 2) AS Carrier_Fee_Percent,
    ROUND(Maintenance_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0), 2) AS Maintenance_Cost_Percent,
    ROUND(Other_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0), 2) AS Other_Cost_Percent
FROM transportation_costs;

SELECT
    ROUND(AVG(Fuel_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0)), 2) AS Avg_Fuel_Percent,
    ROUND(AVG(Driver_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0)), 2) AS Avg_Driver_Percent,
    ROUND(AVG(Toll_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0)), 2) AS Avg_Toll_Percent,
    ROUND(AVG(Carrier_Fee * 100.0 / NULLIF(Total_Transport_Cost, 0)), 2) AS Avg_Carrier_Percent,
    ROUND(AVG(Maintenance_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0)), 2) AS Avg_Maintenance_Percent,
    ROUND(AVG(Other_Cost * 100.0 / NULLIF(Total_Transport_Cost, 0)), 2) AS Avg_Other_Percent
FROM transportation_costs;


-- 13_data_modification
/*
=========================================================
FILE: 13_data_modification.sql
DESCRIPTION:
INSERT, UPDATE, DELETE examples
=========================================================
*/

-- INSERT

INSERT INTO customers
VALUES
(
11,
'Zara',
'Standard',
'Arteixo',
'A Coruna',
'Spain'
);

-- UPDATE

UPDATE shipments
SET Shipment_Status = 'Delivered'
WHERE Shipment_ID = 'S010';

-- DELETE

DELETE FROM customers
WHERE Customer_ID = 11;

select *
from customers;

/*
IMPORTANT

Always use WHERE clauses
when executing UPDATE and DELETE statements.

Failure to do so may modify or delete
every record in the table.
*/

-- 14_Views_KPIs
/*
=========================================================
FILE: 14_views_kpis.sql
DESCRIPTION:
Reusable analytics views
=========================================================
*/

CREATE VIEW vw_carrier_performance AS
SELECT
    Carrier_ID,
    COUNT(*) Total_Shipments
FROM shipments
GROUP BY Carrier_ID;

CREATE VIEW vw_customer_spending AS
SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(t.Total_Transport_Cost) Total_Spending
FROM customers c
JOIN shipments s
    ON c.Customer_ID = s.Customer_ID
JOIN transportation_costs t
    ON s.Shipment_ID = t.Shipment_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name;

CREATE VIEW vw_route_cost_analysis AS
SELECT
    r.Route_ID,
    r.Origin,
    r.Destination,
    AVG(t.Total_Transport_Cost) Avg_Transport_Cost
FROM routes r
JOIN shipments s
    ON r.Route_ID = s.Route_ID
JOIN transportation_costs t
    ON s.Shipment_ID = t.Shipment_ID
GROUP BY
    r.Route_ID,
    r.Origin,
    r.Destination;
    
-- 15_Stored_Procedures.
/*
=========================================================
FILE: 15_stored_procedures.sql
PROJECT: SwiftRoute Logistics
DESCRIPTION:
Reusable business procedures for reporting
and operational management.
=========================================================
*/

-- Procedure 1: Get Carrier Performance
/*
=========================================================
PROCEDURE:
sp_carrier_performance

PURPOSE:
Returns shipment volume, delayed shipments
and on-time delivery percentage by carrier.
=========================================================
*/

DELIMITER $$

CREATE PROCEDURE sp_carrier_performance()
BEGIN

    SELECT
        c.Carrier_ID,
        c.Carrier_Name,

        COUNT(s.Shipment_ID) AS Total_Shipments,

        SUM(
            CASE
                WHEN s.Actual_Delivery_Date >
                     s.Expected_Delivery_Date
                OR (
                    s.Actual_Delivery_Date IS NULL
                    AND s.Shipment_Status = 'Delayed'
                )
                THEN 1
                ELSE 0
            END
        ) AS Delayed_Shipments,

        ROUND(
            SUM(
                CASE
                    WHEN s.Actual_Delivery_Date <=
                         s.Expected_Delivery_Date
                    THEN 1
                    ELSE 0
                END
            ) * 100.0 /
            NULLIF(COUNT(s.Shipment_ID),0),
        2) AS On_Time_Delivery_Percentage

    FROM carriers c
    LEFT JOIN shipments s
        ON c.Carrier_ID = s.Carrier_ID

    GROUP BY
        c.Carrier_ID,
        c.Carrier_Name;

END$$

DELIMITER ;

CALL sp_carrier_performance();


-- Procedure 2: Customer Logistics Spend
/*
=========================================================
PROCEDURE:
sp_customer_spend
=========================================================
*/

DELIMITER $$

CREATE PROCEDURE sp_customer_spend()
BEGIN

SELECT

    c.Customer_ID,
    c.Customer_Name,

    COUNT(s.Shipment_ID) AS Total_Shipments,

    ROUND(
        SUM(t.Total_Transport_Cost),
        2
    ) AS Total_Logistics_Spend,

    ROUND(
        AVG(t.Total_Transport_Cost),
        2
    ) AS Average_Logistics_Spend

FROM customers c

LEFT JOIN shipments s
    ON c.Customer_ID=s.Customer_ID

LEFT JOIN transportation_costs t
    ON s.Shipment_ID=t.Shipment_ID

GROUP BY
    c.Customer_ID,
    c.Customer_Name

ORDER BY
    Total_Logistics_Spend DESC;

END$$

DELIMITER ;

CALL sp_customer_spend();


-- Procedure 3: Route Cost Analysis
/*
=========================================================
PROCEDURE:
sp_route_cost_analysis
=========================================================
*/

DELIMITER $$

CREATE PROCEDURE sp_route_cost_analysis()
BEGIN

SELECT

    r.Route_ID,
    r.Origin,
    r.Destination,

    COUNT(s.Shipment_ID) AS Shipment_Count,

    ROUND(
        AVG(t.Total_Transport_Cost),
        2
    ) AS Avg_Shipment_Cost,

    ROUND(
        SUM(t.Total_Transport_Cost),
        2
    ) AS Total_Route_Cost

FROM routes r

LEFT JOIN shipments s
    ON r.Route_ID=s.Route_ID

LEFT JOIN transportation_costs t
    ON s.Shipment_ID=t.Shipment_ID

GROUP BY
    r.Route_ID,
    r.Origin,
    r.Destination

ORDER BY
    Total_Route_Cost DESC;

END$$

DELIMITER ;

CALL sp_route_cost_analysis();

-- Procedure 4: Delayed Shipments
/*
=========================================================
PROCEDURE:
sp_delayed_shipments
=========================================================
*/

DELIMITER $$

CREATE PROCEDURE sp_delayed_shipments()
BEGIN

SELECT *

FROM shipments

WHERE

(
Actual_Delivery_Date > Expected_Delivery_Date

OR

(
Actual_Delivery_Date IS NULL
AND Shipment_Status='Delayed'
)

);

END$$

DELIMITER ;

CALL sp_delayed_shipments();

-- Procedure 5: Shipment Lookup
/*
=========================================================
PROCEDURE:
sp_shipment_lookup

PURPOSE:
Returns a complete shipment report
for a given shipment ID.
=========================================================
*/

DELIMITER $$

CREATE PROCEDURE sp_shipment_lookup
(
IN p_shipment_id VARCHAR(20)
)

BEGIN

SELECT

    s.Shipment_ID,
    c.Customer_Name,
    ca.Carrier_Name,
    v.Vehicle_Type,
    r.Origin,
    r.Destination,
    s.Shipment_Date,
    s.Expected_Delivery_Date,
    s.Actual_Delivery_Date,
    s.Shipment_Status

FROM shipments s

JOIN customers c
ON s.Customer_ID=c.Customer_ID

JOIN carriers ca
ON s.Carrier_ID=ca.Carrier_ID

JOIN vehicles v
ON s.Vehicle_ID=v.Vehicle_ID

JOIN routes r
ON s.Route_ID=r.Route_ID

WHERE s.Shipment_ID = p_shipment_id;

END$$

DELIMITER ;

CALL sp_shipment_lookup('S025');

-- Procedure 6: Top Spending Customers
-- Parameterized procedure.
/*
=========================================================
PROCEDURE:
sp_top_customers
=========================================================
*/

DELIMITER $$

CREATE PROCEDURE sp_top_customers
(
IN p_top_n INT
)

BEGIN

SELECT

    c.Customer_ID,
    c.Customer_Name,

    ROUND(
        SUM(t.Total_Transport_Cost),
        2
    ) AS Total_Spend

FROM customers c

JOIN shipments s
ON c.Customer_ID=s.Customer_ID

JOIN transportation_costs t
ON s.Shipment_ID=t.Shipment_ID

GROUP BY
    c.Customer_ID,
    c.Customer_Name

ORDER BY
    Total_Spend DESC

LIMIT p_top_n;

END$$

DELIMITER ;

CALL sp_top_customers(5);


-- Procedure 7: Carrier Spend Analysis
/*
=========================================================
PROCEDURE:
sp_carrier_cost_analysis
=========================================================
*/

DELIMITER $$

CREATE PROCEDURE sp_carrier_cost_analysis()
BEGIN

SELECT

    c.Carrier_ID,
    c.Carrier_Name,

    COUNT(s.Shipment_ID) AS Shipment_Count,

    ROUND(
        SUM(t.Total_Transport_Cost),
        2
    ) AS Total_Spend,

    ROUND(
        AVG(t.Total_Transport_Cost),
        2
    ) AS Avg_Spend

FROM carriers c

LEFT JOIN shipments s
    ON c.Carrier_ID=s.Carrier_ID

LEFT JOIN transportation_costs t
    ON s.Shipment_ID=t.Shipment_ID

GROUP BY
    c.Carrier_ID,
    c.Carrier_Name

ORDER BY
    Total_Spend DESC;

END$$

DELIMITER ;
    
CALL sp_carrier_cost_analysis();


-- Procedure 8: Executive KPI Dashboard Procedure
/*
=========================================================
PROCEDURE:
sp_executive_dashboard
=========================================================
*/

DROP PROCEDURE IF EXISTS sp_executive_dashboard;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_executive_dashboard;

DELIMITER $$

CREATE PROCEDURE sp_executive_dashboard()
BEGIN

    SELECT
        COUNT(*) AS Total_Shipments,
        SUM(CASE WHEN Shipment_Status = 'Delivered' THEN 1 ELSE 0 END) AS Delivered,
        SUM(CASE WHEN Shipment_Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled,
        SUM(CASE WHEN Shipment_Status = 'Delayed'   THEN 1 ELSE 0 END) AS Delayed_Shipments,
        ROUND(
            100.0 * SUM(CASE WHEN Shipment_Status = 'Delivered' THEN 1 ELSE 0 END)
            / COUNT(*),
            2
        ) AS Delivery_Rate
    FROM shipments;

END$$

DELIMITER ;

CALL sp_executive_dashboard();

