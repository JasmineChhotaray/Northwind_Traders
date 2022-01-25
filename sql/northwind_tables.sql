-- ***********************************************************************************************************************************
--                             CATEGORIES
-- ***********************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS categories CASCADE;

-- Creating categories table --
CREATE TABLE categories (
    category_ID SERIAL NOT NULL PRIMARY KEY,
    category_Name VARCHAR(25) NOT NULL,
    description VARCHAR(255) ,
    picture BYTEA
);

-- Inserting Data --
\copy categories FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\categories.csv' DELIMITER ',' CSV HEADER;



-- ***********************************************************************************************************************************
--                                  CUSTOMERS
-- ***********************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS customers CASCADE;

-- Creating customers table --
CREATE TABLE customers (
    customer_ID VARCHAR(20) not null PRIMARY KEY,
    company_Name VARCHAR(50) not NULL,
    contact_Name VARCHAR(30),
    contact_Title VARCHAR(30),
    address VARCHAR(100),
    city VARCHAR(30),
    region VARCHAR(30),
    postal_Code VARCHAR(50),
    country VARCHAR(30),
    phone VARCHAR(25),
    fax VARCHAR(25)
);

-- Inserting Data --
\copy customers FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\customers.csv' DELIMITER ',' CSV HEADER;



-- *************************************************************************************************************************************
--                                     EMPLOYEES
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS employees CASCADE;

-- Creating employees table --
CREATE TABLE employees (
    employee_ID SERIAL not null PRIMARY KEY,
    last_Name VARCHAR(50) not NULL,
    first_Name VARCHAR(50) not NULL,
    title VARCHAR(100),
    titleOfCourtesy VARCHAR(15),
    birth_Date TIMESTAMP,
    hire_Date TIMESTAMP,
    address VARCHAR(100),
    city VARCHAR(30),
    region VARCHAR(30),
    postal_Code VARCHAR(20),
    country VARCHAR(30),
    home_Phone VARCHAR(25),
    extension VARCHAR(15),
    photo BYTEA,
    notes TEXT,
    reports_To INT REFERENCES employees,  --Foreign Key constraint
    photo_Path VARCHAR(255)
);

-- Inserting Data --
\copy employees FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\employees.csv' DELIMITER ',' CSV HEADER NULL 'NULL';




-- *************************************************************************************************************************************
--                                     SUPPLIERS
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS suppliers CASCADE;

-- Creating suppliers table --
CREATE TABLE suppliers (
    supplier_ID SERIAL not null PRIMARY KEY,
    company_Name VARCHAR(100) not NULL,
    contact_Name VARCHAR(150),
    contact_Title VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(30),
    region VARCHAR(30),
    postal_Code VARCHAR(20),
    country VARCHAR(30),
    phone VARCHAR(25),
    fax VARCHAR(25),
    home_Page TEXT 
);

-- Inserting Data --
\copy suppliers FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\suppliers.csv' DELIMITER ',' CSV HEADER;




-- *************************************************************************************************************************************
--                                     PRODUCTS
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS products CASCADE;

-- Creating products table --
CREATE TABLE products (
    product_ID SERIAL not null primary KEY,
    product_Name VARCHAR(100) NOT NULL,
    supplier_ID INT REFERENCES suppliers,
    category_ID INT REFERENCES categories,
    quantity_Per_Unit VARCHAR(255),
    unit_Price FLOAT,
    units_In_Stock INT,
    units_On_Order INT,
    reorder_Level INT,
    discontinued INT not NULL
);

-- Inserting Data --
\copy products FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\products.csv' DELIMITER ',' CSV HEADER;



-- *************************************************************************************************************************************
--                                     REGIONS
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS regions CASCADE;

-- Creating regions table --
CREATE TABLE regions (
    region_ID SERIAL not null PRIMARY KEY,
    region_Description VARCHAR(255) not NULL
);

-- Inserting Data --
\copy regions FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\regions.csv' DELIMITER ',' CSV HEADER;





-- *************************************************************************************************************************************
--                                     SHIPPERS
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS shippers CASCADE;

-- Creating shippers table --
CREATE TABLE shippers (
    shipper_ID SERIAL not null PRIMARY KEY,
    company_Name VARCHAR(50) NOT NULL,
    phone VARCHAR(25)
);

-- Inserting Data --
\copy shippers FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\shippers.csv' DELIMITER ',' CSV HEADER;




-- *************************************************************************************************************************************
--                                     ORDERS
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS orders CASCADE;

-- Creating orders table --
CREATE TABLE orders (
    order_ID INT not null PRIMARY KEY,
    customer_ID VARCHAR(20) REFERENCES customers,
    employee_ID INT REFERENCES employees,
    order_Date TIMESTAMP,
    required_Date TIMESTAMP,
    shipped_Date TIMESTAMP,
    ship_Via INT REFERENCES shippers,
    freight FLOAT,
    ship_Name VARCHAR(50),
    ship_Address VARCHAR(50),
    ship_City VARCHAR(50),
    ship_Region VARCHAR(50),
    ship_Postal_Code VARCHAR(20),
    ship_Country VARCHAR(20)
);



-- Inserting Data --
\copy orders FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\orders.csv' DELIMITER ',' CSV HEADER NULL 'NULL';




-- *************************************************************************************************************************************
--                                     TERRITORIES
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS territories CASCADE;

-- Creating territories table --
CREATE TABLE territories (
    territory_ID SERIAL not null PRIMARY KEY,
    territory_Description VARCHAR(50) not NULL,
    region_ID INT not null REFERENCES regions
);

-- Inserting Data --
\copy territories FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\territories.csv' DELIMITER ',' CSV HEADER;



-- *************************************************************************************************************************************
--                                     EMPLOYEE TERRITORIES
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS employee_territories;

-- Creating employee_territories table --
CREATE TABLE employee_territories (
    employee_ID INT not NULL,
    territory_ID INT NOT NULL,
    primary key (employee_ID, territory_ID),
    FOREIGN KEY (employee_ID) REFERENCES employees (employee_ID),
    FOREIGN KEY (territory_ID) REFERENCES territories (territory_ID)
);

-- Inserting Data --
\copy employee_territories FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\employee_territories.csv' DELIMITER ',' CSV HEADER;




-- *************************************************************************************************************************************
--                                     ORDER DETAILS
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS order_details CASCADE;

-- Creating order_details table --
CREATE TABLE order_details (
    order_ID INT not null references orders,
    product_ID INT NOT null references products,
    unit_Price FLOAT not NULL,
    quantity INT not NULL,
    discount FLOAT not null,
    primary key (order_ID, product_ID)
);

-- Inserting Data --
\copy order_details FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\order_details.csv' DELIMITER ',' CSV HEADER;




-- *************************************************************************************************************************************
--                                     COUNTRY CODES
-- *************************************************************************************************************************************

-- Drop Table if already exists --
DROP TABLE IF EXISTS country_codes CASCADE;

-- Creating country_codes table --
CREATE TABLE country_codes (
    country_name VARCHAR(100),
    country_alpha_2 VARCHAR(10)
);

-- Inserting Data --
\copy country_codes FROM 'F:\Data_Science\My_Practice\05_sql\dashboard_project\northwind_data\data\country_codes.csv' DELIMITER ',' CSV HEADER;