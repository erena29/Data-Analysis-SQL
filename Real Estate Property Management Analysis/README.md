# Real Estate Property Management Analysis Using SQL and PowerBI
This project provides an in-depth analysis of a real estate property management dataset using SQL and PowerBI. The goal is to derive actionable business insights for property management, sales performance, and expense monitoring, helping stakeholders make informed decisions.

## Dataset Details
The dataset consists of three main tables – Sales, Property, and Expense – which are linked by the `PropertyID` column. This relationship connects sales transactions and expenses to specific properties.

### Sales Table
| Column          | Description                                                                                               |
|-----------------|-----------------------------------------------------------------------------------------------------------|
| SaleID          | Unique identifier for each sale transaction.                                                              |
| PropertyID_Sale | Identifier linking the sale to a specific property in the property table.                                 |
| SaleDate        | Date when the sale transaction occurred.                                                                  |
| MeansofSales    | Method through which the sale was conducted (broker, direct, online).                                     |
| PaymentStatus   | Status of the payment for the sale (paid or pending).                                                     |

### Property Table
| Column         | Description                                                                                               |
|----------------|-----------------------------------------------------------------------------------------------------------|
| PropertyID     | Unique identifier for each property.                                                                      |
| Type           | Type of property (townhouse, apartment, single family, townhouse).                                        |
| SquareFootage  | Size of the property in square feet.                                                                      |
| Price          | Price of the property.                                                                                    |
| Status         | Current status of the property (available, sold).                                                         |

### Expense Table
| Column           | Description                                                                                               |
|------------------|-----------------------------------------------------------------------------------------------------------|
| ExpenseID        | Unique identifier for each expense transaction.                                                           |
| PropertyID_Expense | Identifier linking the expense to a specific property in the property table.                            |
| ExpenseType      | Type or category of the expense (maintenance, property taxes, renovation).                                |
| Amount           | Amount of the expense.                                                                                    |

## Key Analysis Insights
1. Yearly Financial Overview and Property Sales
2. Months with Repeated Top 3 Revenue for Each Year
3. Months with Repeated Revenue Below the Yearly Average
4. Revenue by Property Type and Year
5. Percentage of Sold Properties and Net Income by Price Category
6. Frequency of Sales by Means of Sale
7. Comparison of Payment Status by Means of Sale
8. Total Expenses by Property Type and Expense Category

## Requirements
- **SQL** (BigQuey and SQLite) : For performing analytical queries on the data.
- **PowerBI**: For create interactive visualizations for better decision-making.

## Visualization 
[PowerBI](https://app.powerbi.com/view?r=eyJrIjoiOWI5ODIzZTUtNjBlYi00N2I4LTg2OTctMTNkMGM3ZTM4YWU4IiwidCI6ImM3NTk5NWEzLWY1YjctNDkyMy1hM2IyLWZjMTg3NzM5M2MxZiIsImMiOjEwfQ%3D%3D)

---

> LinkedIn [profile](https://www.linkedin.com/in/e-rena/)<br>
