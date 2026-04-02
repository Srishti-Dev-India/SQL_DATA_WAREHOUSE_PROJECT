--Date Exploration
-- FIND THE DATE OF THE FIRST AND LAST ORDER 
-- How many of years are available
SELECT 
MIN(Order_Date) First_Order, 
MAX(Order_Date) Last_Order,
DATEDIFF(YEAR , MIN(Order_Date) , MAX(Order_Date)) Order_Range_Year,
DATEDIFF(MONTH , MIN(Order_Date) , MAX(Order_Date)) Order_Range_Month
FROM gold.fact_sales
--Find the youngest and oldest customer
SELECT
MIN(Birth_Date) Oldest_Customer, 
MAX(Birth_Date) Youngest_Customer,
DATEDIFF(YEAR , MIN(Birth_Date) , GETDATE()) Age_Oldest_Customer,
DATEDIFF(YEAR , MAX(Birth_Date) , GETDATE()) Age_Youngest_Customer
FROM gold.dim_customer
