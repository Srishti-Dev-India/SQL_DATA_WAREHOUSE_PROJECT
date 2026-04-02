/*
====================================================================================
Product Report
====================================================================================
Purpose:
	- This report consolidate key product metrics and behaviors.

Highlights:
	1. Gather essential fields such as product name, category, subcategory and cost.
	2. Segements products by revenue to identify High-Performers, Mid-Range, or Low-Performer.
	3. Aggregates product-level metrics:
		- total order
		- total sales
		- total quantity sold 
		- total customers (unique)
		- lifespan (in months)
	4. Calculate valuable KPIs:
		- recency(months since last sale)
		- average order revenue 
		- average monthly revenue
====================================================================================
*/
CREATE VIEW gold.report_products AS
WITH Base_Query AS
(
/*----------------------------------------------------------------------------------
1) Base Query: Retrieves core columns from fact_sales and dim/-products
----------------------------------------------------------------------------------*/
SELECT 
f.Order_Number,
f.Order_Date,
f.Customer_Key,
f.Sales,
f.Quantity,
p.Product_Key,
p.Product_Name,
p.Category,
p.Sub_Category,
p.Cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.Product_Key = f.Product_Key
WHERE Order_Date IS NOT NULL
),
Product_Aggregation AS
(
/*----------------------------------------------------------------------------------
1) Product_Aggregation: Summarizes the key metrics at product level
----------------------------------------------------------------------------------*/
SELECT 
Product_Key,
Product_Name,
Category,
Sub_Category,
Cost,
DATEDIFF(MONTH, MIN(Order_Date),MAX(Order_Date)) as Life_Span,
MAX(Order_Date) AS Last_Sale_Date,
COUNT(DISTINCT Order_Number) AS Total_Orders,
COUNT(DISTINCT Customer_Key) AS Total_Customers,
SUM(Sales) AS Total_Sales,
SUM(Quantity) AS Total_Quantity,
ROUND(AVG(CAST(Sales AS FLOAT)/ NULLIF (Quantity,0)),1) AS Avg_Selling_Price
FROM Base_Query
GROUP BY 
Product_Key,
Product_Name,
Category,
Sub_Category,
Cost
)
SELECT
Product_Key,
Product_Name,
Category,
Sub_Category,
Cost,
Last_Sale_Date,
DATEDIFF(MONTH, Last_Sale_Date, GETDATE()) AS Recency,
CASE WHEN Total_Sales > 50000 THEN 'High Performer'
	 WHEN Total_Sales >=10000 THEN 'Mid Range'
	 ELSE 'Low Performer'
END AS Product_Segment,
Life_Span,
Total_Orders,
Total_Sales,
Total_Quantity,
Avg_Selling_Price,
--Avg Order Revenue (AOR)
CASE WHEN Total_Orders = 0 THEN 0
	 ELSE Total_Sales / Total_Orders
END AS Avg_Order_Revenue,
--Avg Monthly Revenue 
CASE WHEN Life_Span = 0 THEN Total_Sales
	 ELSE Total_Sales / Life_Span
END AS Avg_Monthly_Revenue
FROM Product_Aggregation