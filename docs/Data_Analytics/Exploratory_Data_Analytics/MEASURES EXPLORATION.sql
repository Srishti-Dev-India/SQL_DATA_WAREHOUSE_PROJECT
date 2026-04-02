-- MEASURES EXPLORATION

-- FIND THE TOTAL SALES
-- FIND HOW MANY ITEAMS ARE SOLD
-- FIND THE AVERAGE SELLING PRICE
--FIND THE TOTAL NUMBER OF ORDER
-- FIND THE TOTAL NUMBER OF CUSTOMERS THAT HAS PLACED ON ORDER
SELECT 
SUM(Sales) AS Total_Sales,
SUM(Quantity) AS Total_Sell,
AVG(Price) AS Avg_Price,
COUNT(DISTINCT Order_Number) AS Total_Sales,
COUNT(DISTINCT Customer_Key) True_Customers
FROM gold.fact_sales

--FIND THE TOTAL NUMBER OF PRODUCTS
SELECT
COUNT(DISTINCT Product_Name) AS Total_Products
FROM gold.dim_products

--FIND THE TOTAL NUMBER OF CUSTOMERS
SELECT
COUNT(Customer_Key) AS Total_Customers
FROM gold.dim_customer

-- Generate a Report That shows all key metrics of the buisness
SELECT 'Total Sales' AS measure_name, SUM(Sales) AS Measure_Value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(Quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price',AVG(Price) FROM gold.fact_sales
UNION ALL
SELECT 'Total No. Order',COUNT(DISTINCT Order_Number) FROM gold.fact_sales
UNION ALL
SELECT 'Total No. Products',COUNT(Product_Name) FROM gold.dim_products
UNION ALL
SELECT 'Total No. Customers',COUNT(Customer_Key) FROM gold.dim_customer