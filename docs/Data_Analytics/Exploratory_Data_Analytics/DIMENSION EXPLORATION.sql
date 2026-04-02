--DIMENSION EXPLORATION

-- Explore all Countries our customers come from.
SELECT DISTINCT Country FROM gold.dim_customer

--Explore all categories "The major Division"
SELECT DISTINCT category, Sub_Category, Product_Name FROM gold.dim_products
ORDER BY 1,2,3