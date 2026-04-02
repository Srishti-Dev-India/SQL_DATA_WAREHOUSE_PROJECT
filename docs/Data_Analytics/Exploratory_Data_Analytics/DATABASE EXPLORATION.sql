---DATABASE EXPLORATION
--Explore all Object in the Database 
SELECT * FROM INFORMATION_SCHEMA.TABLES

--Explore all Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fact_sales'
