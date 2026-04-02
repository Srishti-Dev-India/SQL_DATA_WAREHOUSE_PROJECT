--RANKING EXPLORATION

--WHICH 5 Products generate the highest revenue
SELECT  TOP 5 
p.Product_Name,
SUM (f.Sales) AS Total_Revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.Product_Key = f.Product_Key
GROUP BY p.Product_Name
ORDER BY Total_Revenue DESC

--WHICH 5 Products are worst-performing
SELECT  TOP 5 
p.Product_Name,
SUM (f.Sales) AS Total_Revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.Product_Key = f.Product_Key
GROUP BY p.Product_Name
ORDER BY Total_Revenue 