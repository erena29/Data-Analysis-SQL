SELECT *
FROM superstore.sales;

-- Total Transactions Each Month  
WITH month_trans AS(
  SELECT
    EXTRACT(YEAR FROM Order_Date) AS Year,
    EXTRACT(Month FROM Order_Date) AS Month,
    COUNT(*) AS Total_Transaction
  FROM(
      SELECT 
        Order_ID,
        Order_Date
      FROM superstore.sales
      GROUP BY Order_ID,Order_Date)
  GROUP BY Year,Month)

SELECT
  Month,
  SUM(CASE WHEN Year = 2019 THEN Total_Transaction ELSE 0 END) AS Transaction_2019,
  SUM(CASE WHEN Year = 2020 THEN Total_Transaction ELSE 0 END) AS Transaction_2020
FROM month_trans
GROUP BY Month
ORDER BY Month

-- Top 5 Total Amount Each Transaction
SELECT 
  Order_ID,
  ROUND(SUM(Price),2) AS Total_Amount
FROM superstore.sales
GROUP BY Order_ID
ORDER BY Total_Amount DESC
LIMIT 5;

-- Top 5 Sub-Categories with the Highest Sales in the Top 10 of Product Rankings
WITH Rank_Product AS (
  SELECT 
    *,
    DENSE_RANK() OVER (ORDER BY Total_Product DESC) AS Product_Rank
  FROM (
    SELECT 
      Product_Name,
      Sub_Category,
      Category, 
      SUM(Quantity) AS Total_Product
    FROM superstore.sales
    GROUP BY Product_Name, Sub_Category, Category
  )AS ProductSummary
  ORDER BY Product_Rank
)

SELECT *
FROM (
    SELECT
      Sub_Category, 
      Category,
      SUM(Total_Product) AS Total,
      ROW_NUMBER() OVER (ORDER BY SUM(Total_Product) DESC) AS Sub_Category_Rank
    FROM Rank_Product 
    WHERE Product_Rank <= 10
    GROUP BY Sub_Category, Category)
WHERE Sub_Category_Rank <=5

-- Top Selling Product for Each Sub-Category
WITH Rank_Product AS (  
  SELECT
    *,
    DENSE_RANK() OVER (PARTITION BY Sub_Category ORDER BY Total_Sales DESC) AS Product_Rank
  FROM(
    SELECT
      Sub_Category,
      Product_Name,
      SUM(Quantity) AS Total_Sales
    FROM superstore.sales
    GROUP BY Sub_Category,Product_Name)
)

SELECT
  Sub_Category,
  Product_Name
FROM Rank_Product
WHERE Product_Rank=1

-- High-Demand Products: Top 3 by Average Order Quantity per Transaction
WITH Rank_Product AS (
  SELECT
    Product_Name,
    CEIL(AVG(Total_Order)) AS Average_Total_Order,
    DENSE_RANK() OVER (ORDER BY CEIL(AVG(Total_Order)) DESC) AS Product_Rank
  FROM (
    SELECT 
      Order_ID,
      Product_Name,
      SUM(Quantity) AS Total_Order
    FROM superstore.sales
    GROUP BY Order_ID, Product_Name
  ) AS Subquery
  GROUP BY Product_Name
)
SELECT
  Product_Rank,
  Product_Name,
  Average_Total_Order
FROM Rank_Product
WHERE Product_Rank <= 3
ORDER BY Product_Rank;


--Top 5 Sub-Categories by Profit for Each Year
WITH Rank_Sub_Category AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY Year ORDER BY Total_Profit DESC) AS Sub_Category_Rank
  FROM(
      SELECT
        EXTRACT(YEAR FROM Order_Date) AS Year,
        Sub_Category,
        ROUND(SUM(Profit), 2) AS Total_Profit
      FROM superstore.sales
      GROUP BY Year,Sub_Category)
)

SELECT 
  MAX(CASE WHEN Year = 2019 THEN Sub_Category END) AS Sub_Category_2019,
  MAX(CASE WHEN Year = 2020 THEN Sub_Category END) AS Sub_Category_2020
FROM Rank_Sub_Category
WHERE Sub_Category_Rank <= 5
GROUP BY Sub_Category_Rank
ORDER BY Sub_Category_Rank

-- Sub-Categories with Negative Profit Each Year
SELECT
  EXTRACT(YEAR FROM Order_Date) AS Year,
  Sub_Category,
  ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore.sales
GROUP BY Sub_Category,Year
HAVING SUM(Profit) < 0
ORDER BY Year;

-- States with Reduced Profitability in 2020
SELECT
  State
FROM (
  SELECT 
    State,
    SUM(CASE WHEN EXTRACT(YEAR FROM Order_Date) = 2019 THEN Profit ELSE 0 END) AS Profit_2019,
    SUM(CASE WHEN EXTRACT(YEAR FROM Order_Date) = 2020 THEN Profit ELSE 0 END) AS Profit_2020
  FROM superstore.sales
  GROUP BY State
)
WHERE Profit_2019>Profit_2020

--States with Total Profit Lower Than the Average
WITH profit_state AS(
  SELECT 
    State,
    ROUND(SUM(Profit),2) AS Total_Profit
  FROM superstore.sales
  GROUP BY State
  ORDER BY Total_Profit DESC
)
SELECT
  State
FROM profit_state
WHERE Total_Profit<(SELECT AVG(Total_Profit) FROM profit_state)

-- Return Rate by Payment Mode
SELECT
  Payment_Mode,
  ROUND((COUNT(CASE WHEN Returns = TRUE THEN 1 END) * 100.0) / COUNT(*),2) AS Return_Rate
FROM superstore.sales
GROUP BY Payment_Mode
ORDER BY Return_Rate DESC

-- Order Processing Time: Days to Ship
SELECT
  EXTRACT(DAY FROM (Ship_Date-Order_Date)) AS Days_to_Ship,
  Count(*) AS Total
FROM superstore.sales
GROUP BY Days_to_Ship
ORDER BY Days_to_Ship





