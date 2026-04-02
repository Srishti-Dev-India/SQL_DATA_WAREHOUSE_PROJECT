-- CUMULATIVE ANALYSIS
--CALCULATE THE TOTAL SALES 
--CALCULATE THE RUNNING TOTAL OF SALES OVER TIME
--CALCULATE THE AVERAGE PRICE
--CALCULATE THE MOVING AVERAGE PRICE OVER TIME


SELECT
 Order_Date,
 Total_Sales,
 SUM(Total_Sales) OVER (PARTITION BY Order_Date ORDER BY Order_Date) AS Running_Total,
 AVG(Avg_Price) OVER (PARTITION BY Order_Date ORDER BY Order_Date) AS Moving_Average
 FROM
 (
 SELECT
 Order_Date,
 SUM(Sales) AS Total_Sales,
 AVG (Price) AS Avg_Price
 FROM gold.fact_sales
 WHERE Order_Date IS NOT NULL
 GROUP BY Order_Date
 )t