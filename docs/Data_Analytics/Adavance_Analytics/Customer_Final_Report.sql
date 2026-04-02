/*
====================================================================================
Customer Report
====================================================================================
Purpose
	-This report conslidates key customer metrics and behaviors

Highlights:
	1. Gather essential field such as names, age, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
	 - total orders
	 - total sales 
	 - total quantity purchased
	 - total products
	 - lifespan (in months)
	4. Calculate valueable KPIs:
	 - recency (months since last order)
	 - average order value
	 - average monthly spend
====================================================================================
*/

CREATE VIEW gold.report_customers AS 

WITH Base_Query AS
/*----------------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
----------------------------------------------------------------------------------*/
(
SELECT 
f.Order_Number,
f.Product_Key,
f.Order_Date,
f.Sales,
f.Quantity,
c.Customer_Key,
c.Customer_Number,
CONCAT(c.First_Name, ' ' , c.Last_Name) Customer_Name,
DATEDIFF (YEAR, c.Birth_Date, GETDATE()) Age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customer c
ON c.Customer_Key = f.Customer_Key
WHERE Order_Date IS NOT NULL
),
Customer_Aggregation AS 
/*----------------------------------------------------------------------------------
2) Customer_Aggregation: Summarixes key metrics at the customer level
----------------------------------------------------------------------------------*/
(
SELECT
Customer_Key,
Customer_Number,
Customer_Name,
Age,
COUNT(DISTINCT Order_Number) AS Total_Order,
SUM(Quantity) AS Total_Quantity,
SUM(Sales) AS Total_Sales,
COUNT(DISTINCT Product_Key) AS Total_Products,
MAX(Order_Date) AS Last_Order_Date,
DATEDIFF(MONTH , MIN(Order_Date), MAX(Order_Date)) AS Life_Span
FROM Base_Query
GROUP BY
Customer_Key,
Customer_Number,
Customer_Name,
Age
)
SELECT
Customer_Key,
Customer_Number,
Customer_Name,
Age,
CASE WHEN Age < 20 THEN 'Under 20'
	 WHEN Age BETWEEN 20 and 29 THEN '20-29'
	 WHEN Age BETWEEN 20 and 29 THEN '20-29'
	 WHEN Age BETWEEN 20 and 29 THEN '20-29'
	 ELSE '50 and above'
END AS Age_Group,
Total_Sales,
CASE WHEN Life_Span >= 12 AND Total_Sales >= 5000 THEN 'VIP'
	 WHEN Life_Span >= 12 AND Total_Sales < 5000 THEN 'Regular'
	 ELSE 'NEW'
END Customer_Category,
Last_Order_Date,
DATEDIFF( MONTH,Last_Order_Date, GETDATE()) AS Recency,
Total_Order,
Total_Quantity,
Total_Products,
Life_Span,
--Compute average order value (AVO)
CASE WHEN Total_Sales = 0 THEN 0
	 ELSE Total_Sales/ Total_Order 
END AS Average_Order_Value,
--Compute average monthly spend
CASE WHEN Life_Span = 0 THEN Total_Sales
	 ELSE Total_Sales/ Life_Span 
END AS Average_Monthly_Spend
FROM Customer_Aggregation