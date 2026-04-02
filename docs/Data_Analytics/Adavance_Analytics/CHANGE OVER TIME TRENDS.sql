--CHANGE OVER TIME TRENDS
--ANALYZE SALES PERFORMANCE OVER TIME
SELECT 
Order_Date,
SUM(Sales) Total_Sales
FROM gold.fact_sales
WHERE Order_Date IS NOT NULL
GROUP BY Order_Date
ORDER BY Order_Date

SELECT 
YEAR(Order_Date) Order_Year,
MONTH(Order_Date) Order_Month,
SUM(Sales) Total_Sales,
COUNT(DISTINCT Customer_Key)
FROM gold.fact_sales
WHERE Order_Date IS NOT NULL 
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY YEAR(Order_Date), MONTH(Order_Date)

SELECT 
DATETRUNC (MONTH,Order_Date) Order_Month,
SUM(Sales) Total_Sales,
COUNT(DISTINCT Customer_Key)
FROM gold.fact_sales
WHERE Order_Date IS NOT NULL 
GROUP BY DATETRUNC (MONTH,Order_Date)
ORDER BY DATETRUNC (MONTH,Order_Date)
