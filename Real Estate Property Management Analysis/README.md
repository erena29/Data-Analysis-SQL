# Real Estate Property Management Data Anlysis Using SQL and PowerBI
This project provides an in-depth analysis of a real estate property management dataset using SQL and PowerBI. The goal is to derive actionable business insights for property management, sales performance, and expense monitoring, helping stakeholders make informed decisions.

## Dataset Details
The dataset consists of three main tables – Sales, Property, and Expense – each detailing various aspects of property transactions and management. 

### Sales Table
| Column          | Description                                                                                               |
|-----------------|-----------------------------------------------------------------------------------------------------------|
| SaleID          | Unique identifier for each sale transaction.                                                              |
| PropertyID_Sale | Identifier linking the sale to a specific property in the property table.                                 |
| SaleDate        | Date when the sale transaction occurred.                                                                  |
| MeansofSales    | Method or channel through which the sale was conducted (broker, direct, online).                    |
| PaymentStatus   | Status of the payment for the sale (e.g., paid or pending                        |

### Property Table
| Column         | Description                                                                                               |
|----------------|-----------------------------------------------------------------------------------------------------------|
| PropertyID     | Unique identifier for each property.                                                                      |
| Type           | Type of property (townhouse, apartment, single family, townhouse).                                  |
| SquareFootage  | Size of the property in square feet.                                                                      |
| Price          | Listed price or valuation of the property.                                                                |
| Status         | Current status of the property (available, sold).                                                   |

### Expense Table
| Column           | Description                                                                                               |
|------------------|-----------------------------------------------------------------------------------------------------------|
| ExpenseID        | Unique identifier for each expense transaction.                                                           |
| PropertyID_Expense | Identifier linking the expense to a specific property in the property table.                            |
| ExpenseType      | Type or category of the expense (maintenance, property taxes, renovation).                          |
| Amount           | Amount of the expense in monetary units.                                                                  |

## Key Analysis Questions

## Requirements
- **SQL** (BigQuey and SQLite) : For performing analytical queries on the data.
- **PowerBI**: For create interactive visualizations for better decision-making.

---

> LinkedIn [profile](https://www.linkedin.com/in/e-rena/)<br>
