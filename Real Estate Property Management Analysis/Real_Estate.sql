
--1. Yearly Financial Overview and Property Sales
SELECT 
  EXTRACT(YEAR FROM SaleDate) AS Year,
  SUM(Amount) AS Total_Expense,
  SUM(Price) - SUM(Amount) AS Total_Income,
  COUNT(*) AS Properties_Sold,
FROM real_estate.sales AS s 
LEFT JOIN real_estate.property AS p ON s.PropertyID_Sale = p.PropertyID
LEFT JOIN real_estate.expense AS e ON s.PropertyID_Sale = e.PropertyID_Expense
GROUP BY Year
ORDER BY Year;

--2. Months with Repeated Top 3 Revenue for Each Year
-- Aggregate Monthly Revenue by Year and Month
WITH MonthlyRevenue AS (
  SELECT
    EXTRACT(YEAR FROM SaleDate) AS Year,
    FORMAT_DATE('%B', DATE(SaleDate)) AS Month,
    SUM(Price) AS Revenue
  FROM real_estate.sales AS s
  LEFT JOIN real_estate.property AS p
    ON s.PropertyID_Sale = p.PropertyID
  GROUP BY Year, Month
)

SELECT
  Month
FROM (
  -- Rank months within each year by revenue
  SELECT
    Year,
    Month,
    Revenue,
    ROW_NUMBER() OVER (PARTITION BY Year ORDER BY Revenue DESC) AS Rank
  FROM MonthlyRevenue
)
WHERE Rank <= 3
GROUP BY Month
HAVING COUNT(Month) > 1
ORDER BY Month;

--3. Months with Repeated Revenue Below the Yearly Average
-- Calculate the Average Yearly Revenue for each year
WITH avg_year AS (
  SELECT
    Year,
    ROUND(AVG(Monthly_Revenue), 2) AS Avg_Yearly_Revenue
  FROM (
    SELECT
      EXTRACT(YEAR FROM SaleDate) AS Year,
      FORMAT_DATE('%B', DATE(SaleDate)) AS Month,
      SUM(Price) AS Monthly_Revenue
    FROM real_estate.sales AS s
    LEFT JOIN real_estate.property AS p
      ON s.PropertyID_Sale = p.PropertyID
    GROUP BY Year, Month
  ) AS Monthly_Revenues
  GROUP BY Year
  ORDER BY Year
)
--Filter the months where revenue is below the yearly average
, filtered_months AS(
  SELECT
    EXTRACT(YEAR FROM SaleDate) AS Year,
    FORMAT_DATE('%B', DATE(SaleDate)) AS Month,
    SUM(Price) AS Revenue
  FROM real_estate.sales AS s
  LEFT JOIN real_estate.property AS p
    ON s.PropertyID_Sale = p.PropertyID
  JOIN avg_year AS avg
    ON EXTRACT(YEAR FROM SaleDate) = avg.Year
  GROUP BY Year, Month, avg.Avg_Yearly_Revenue
  HAVING SUM(p.Price) < avg.Avg_Yearly_Revenue
  ORDER BY Month DESC
)
--Select months that appear more than once
SELECT Month
FROM filtered_months
GROUP BY Month
HAVING COUNT(Month) > 1
ORDER BY Month;

--4. Revenue by Property Type and Year
SELECT
  Type AS Property_Type,
  SUM(CASE WHEN EXTRACT(YEAR FROM SaleDate) = 2022 THEN Price ELSE 0 END) AS Revenue_2022,
  SUM(CASE WHEN EXTRACT(YEAR FROM SaleDate) = 2023 THEN Price ELSE 0 END) AS Revenue_2023,
  SUM(CASE WHEN EXTRACT(YEAR FROM SaleDate) = 2024 THEN Price ELSE 0 END) AS Revenue_2024,
  SUM(Price) AS Total_Revenue
FROM real_estate.sales AS s
LEFT JOIN real_estate.property AS p
  ON s.PropertyID_Sale = p.PropertyID
GROUP BY Property_Type
ORDER BY Total_Revenue DESC;

--5. Percentage of Sold Properties and Net Income by Price Category
SELECT
    CASE
        WHEN Price BETWEEN 0 AND 300000 THEN '1. Low'
        WHEN Price BETWEEN 300001 AND 500000 THEN '2. Affordable'
        WHEN Price BETWEEN 500001 AND 800000 THEN '3. Mid-Range'
        WHEN Price > 800000 THEN '4. High'
    END AS PriceCategory,
    ROUND(AVG(Price),2) AS Average_Price,
    ROUND(COUNT(CASE WHEN Status = 'Sold' THEN 1 END) * 100.0 / COUNT(*), 2) AS Sold_Percentage,
    SUM(Price) - SUM(Amount) AS Total_Income
FROM real_estate.property AS p
LEFT JOIN real_estate.expense AS e ON p.PropertyID = e.PropertyID_Expense
GROUP BY PriceCategory
ORDER BY PriceCategory

--6. Frequency of Sales by Means of Sale
SELECT
  MeansofSales,
  COUNT(MeansofSales) AS Count
FROM real_estate.sales
GROUP BY MeansofSales

--7. Comparison of Payment Status by Means of Sale
SELECT
    MeansofSales,
    COUNT(CASE WHEN PaymentStatus = 'Paid' THEN 1 END) AS Paid_Count,
    COUNT(CASE WHEN PaymentStatus = 'Pending' THEN 1 END) AS Pending_Count,
    ROUND(
        (COUNT(CASE WHEN PaymentStatus = 'Paid' THEN 1 END) * 100.0) / COUNT(*),
        2
    ) AS Paid_Percentage
FROM real_estate.sales
GROUP BY MeansofSales
ORDER BY MeansofSales;

--8. Total Expenses by Property Type and Expense Category
SELECT
    COALESCE(Type, 'Total') AS Property_Type,
    SUM(CASE WHEN ExpenseType = 'Maintenance' THEN Amount END) AS Maintenance,
    SUM(CASE WHEN ExpenseType = 'Property Taxes' THEN Amount END) AS PropTaxes,
    SUM(CASE WHEN ExpenseType = 'Renovation' THEN Amount END) AS Renovation
FROM real_estate.expense e
LEFT JOIN real_estate.property p ON e.PropertyID_Expense = p.PropertyID
GROUP BY ROLLUP(Type)
ORDER BY 
    CASE WHEN Type IS NULL THEN 1 ELSE 0 END,
    Type;


