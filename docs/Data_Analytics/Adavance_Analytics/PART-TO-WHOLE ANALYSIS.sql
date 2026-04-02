--PART-TO-WHOLE ANALYSIS
-- WHICH CATEGORIES CONTRIBUTE THE MOST TO OVERALL SALES?
WITH Category_Sales AS
(
SELECT 
p.Category,
SUM(f.Sales) AS Total_Sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.Product_Key = f.Product_Key
GROUP BY Category
)
SELECT 
Category,
Total_Sales,
SUM(Total_Sales) OVER () Overall_Sales,
CONCAT(ROUND((CAST (Total_SALES AS FLOAT) / SUM(Total_Sales) OVER ()) * 100,2), '%') AS Percent_Total
FROM Category_Sales
ORDER BY Total_Sales DESC