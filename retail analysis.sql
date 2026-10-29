-- 1. Create the Database
CREATE DATABASE retail_analysis;
USE retail_analysis;

-- 2. Create the Table Schema (Matches your clean CSV structure)
CREATE TABLE retail_transactions (
    Invoice VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    Price DECIMAL(10, 2),
    CustomerID INT,
    Country VARCHAR(100)
);

-- (Note: After running the Python `to_sql` push to populate this table, run the queries below)

-- 3. Core Analytics Queries

-- Query 1: Monthly Revenue Trend
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS YearMonth,
    SUM(Quantity * Price) AS TotalRevenue,
    COUNT(DISTINCT Invoice) AS TotalOrders
FROM retail_transactions
GROUP BY YearMonth
ORDER BY YearMonth;

-- Query 2: Top 10 Customers by Lifetime Value (LTV)
SELECT 
    CustomerID,
    SUM(Quantity * Price) AS LifetimeValue,
    COUNT(DISTINCT Invoice) AS TotalOrders
FROM retail_transactions
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY LifetimeValue DESC
LIMIT 10;

-- Query 3: Top 10 Best-Selling Products
SELECT 
    Description,
    SUM(Quantity) AS TotalUnitsSold,
    SUM(Quantity * Price) AS TotalProductRevenue
FROM retail_transactions
GROUP BY Description
ORDER BY TotalUnitsSold DESC
LIMIT 10;