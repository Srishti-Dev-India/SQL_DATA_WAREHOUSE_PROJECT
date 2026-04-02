--PERFORMANCE ANALYSIS
/* ANALYZE THE YEARLY PERFORMANCE OF PRODUCT BY COMPARING EACH PRODUCTS'S SALES
TO BOTH THE AVERAGE SALE PERFORMANCE OF THE PRODUCT AND THE PREVIOUS YEAR'S SALES*/
WITH Yearly_Product_Sales AS (
SELECT 
YEAR (f.Order_Date) AS Order_Year,
p.Product_Name,
SUM(f.Sales) AS Current_Sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.Product_Key = p.Product_Key
WHERE f.Order_Date IS NOT NULL
GROUP BY
YEAR (f.order_date), p.Product_Name
)
SELECT 
Order_Year, 
Product_Name,
Current_Sales,
AVG(Current_Sales) OVER (PARTITION BY Product_Name) Avg_Sale,
Current_Sales - AVG(Current_Sales) OVER (PARTITION BY Product_Name) as Avg_Diff,
CASE WHEN Current_Sales - AVG(Current_Sales) OVER (PARTITION BY Product_Name) > 0 THEN 'Above Avg'
	 WHEN Current_Sales - AVG(Current_Sales) OVER (PARTITION BY Product_Name) < 0 THEN 'Below Avg'
	 ELSE 'Avg'
END Avg_Change,
-- YOY Analysis
LAG(Current_Sales) OVER (PARTITION BY Product_Name ORDER BY Order_Year) Previous_Year_Sales,
Current_Sales - LAG(Current_Sales) OVER (PARTITION BY Product_Name ORDER BY Order_Year) Previous_Year_Diff,
CASE WHEN Current_Sales - LAG(Current_Sales) OVER (PARTITION BY Product_Name ORDER BY Order_Year) > 0 THEN 'Increase'
	 WHEN Current_Sales - LAG(Current_Sales) OVER (PARTITION BY Product_Name ORDER BY Order_Year) < 0 THEN 'Decrease'
	 ELSE 'No Change'
END Py_Avg_Change
FROM Yearly_Product_Sales
ORDER BY Product_Name, Order_Year