--DATA SEGMENTATION
/* SEGMENT PRODUCT INTO COST RANGE AND
COUNT HOW MANY PRODUCTS FALL INTO EACH SEGMENTS*/
WITH Product_Segement AS
(
SELECT 
Product_Key,
Product_Name,
Cost,
CASE WHEN Cost <100 THEN 'Below 100'
	 WHEN Cost BETWEEN 100 AND 500 THEN '100 - 500'
	 WHEN Cost BETWEEN 500 AND 1000 THEN '500 - 1000'
	 ELSE 'Above 1000'
END Product_Range
FROM gold.dim_products
)
SELECT
Product_Range,
COUNT(Product_Key) AS Total_Products
FROM Product_Segement
GROUP BY Product_Range

/* GROUP CUSTOMERS INTO 3 SEGEMENTS BASED ON THIER SPENDING BEHAVIOR:
-VIP: AT LEAST 12 MONTHS OF HISTORY AND SPENDING MORE THAN $5000
-REGULAR: AT LEAST 12 MONTHS OF HISTORY BUT SPENDING $5000 OR LESS.
-NEW: LIFESPAN LESS THAN 12 MONTHS
AND FIND THE TOTAL NUMBER OF CUSTOMER BY EACH GROUP*/

WITH Customer_Spending AS
(
SELECT
c.Customer_Key,
SUM(f.Sales) Total_Spending,
MIN(Order_Date) First_Order,
MAX (Order_Date) Last_Order,
DATEDIFF(month, MIN(Order_Date), MAX (Order_Date)) AS Life_Span  
FROM gold.fact_sales f
LEFT JOIN gold.dim_customer c
ON f.Customer_Key = c.Customer_Key
GROUP BY c.Customer_Key
)

SELECT 
Customer_Category,
COUNT(Customer_Key) Total_Customers
FROM (
SELECT
Customer_Key,
CASE WHEN Life_Span >= 12 AND Total_Spending >= 5000 THEN 'VIP'
	 WHEN Life_Span >= 12 AND Total_Spending < 5000 THEN 'Regular'
	 ELSE 'NEW'
END Customer_Category
FROM Customer_Spending)t
GROUP BY Customer_Category
ORDER BY Total_Customers

 

