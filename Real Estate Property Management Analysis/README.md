# Real Estate Property Management Data Anlysis Using SQL and PowerBI
## Overview

## Dataset Details
### Sales Table
| Column          | Description                                                                                               |
|-----------------|-----------------------------------------------------------------------------------------------------------|
| SaleID          | Unique identifier for each sale transaction.                                                              |
| PropertyID_Sale | Identifier linking the sale to a specific property in the property table.                                 |
| SaleDate        | Date when the sale transaction occurred.                                                                  |
| MeansofSales    | Method or channel through which the sale was conducted (e.g., online, in-person).                         |
| PaymentStatus   | Status of the payment for the sale, indicating whether it has been completed, pending, or failed.         |

### Property Table
| Column         | Description                                                                                               |
|----------------|-----------------------------------------------------------------------------------------------------------|
| PropertyID     | Unique identifier for each property.                                                                      |
| Type           | Type of property (e.g., residential, commercial).                                                         |
| SquareFootage  | Size of the property in square feet.                                                                      |
| Price          | Listed price or valuation of the property.                                                                |
| Status         | Current status of the property (e.g., available, sold).                                                   |

### Expense Table
| Column           | Description                                                                                               |
|------------------|-----------------------------------------------------------------------------------------------------------|
| ExpenseID        | Unique identifier for each expense transaction.                                                           |
| PropertyID_Expense | Identifier linking the expense to a specific property in the property table.                            |
| ExpenseType      | Type or category of the expense (e.g., maintenance, utilities).                                          |
| Amount           | Amount of the expense in monetary units.                                                                  |

## Requirements
