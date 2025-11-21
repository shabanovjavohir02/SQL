-- 1
SELECT Id, Dt, RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;

-- 2
SELECT COUNT(DISTINCT Id) AS Distinct_Ids, rID, SUM(MaxVal) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rID
) t
GROUP BY rID;

-- 3
SELECT * 
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;

-- 4
SELECT t1.ID, t1.Item, t1.Vals
FROM TestMaximum t1
JOIN (
    SELECT ID, MAX(Vals) AS MaxVal
    FROM TestMaximum
    GROUP BY ID
) t2 ON t1.ID = t2.ID AND t1.Vals = t2.MaxVal;

-- 5
SELECT Id, SUM(MaxVal) AS SumOfMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;

-- 6
SELECT Id, a, b,
CASE WHEN a - b <> 0 THEN a - b ELSE NULL END AS OUTPUT
FROM TheZeroPuzzle;

-- 7
SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue FROM Sales;

-- 8
SELECT AVG(UnitPrice) AS AverageUnitPrice FROM Sales;

-- 9
SELECT COUNT(*) AS TotalTransactions FROM Sales;

-- 10
SELECT MAX(QuantitySold) AS MaxUnitsSold FROM Sales;

-- 11
SELECT Category, SUM(QuantitySold) AS TotalProductsSold
FROM Sales
GROUP BY Category;

-- 12
SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;

-- 13
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Product
ORDER BY Revenue DESC;

-- 14
SELECT SaleDate, SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotalRevenue
FROM Sales;

-- 15
SELECT Category, SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER () AS CategoryContribution
FROM Sales
GROUP BY Category;

-- 16
SELECT s.*, c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

-- 17
SELECT * FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 FROM Sales s WHERE s.CustomerID = c.CustomerID
);

-- 18
SELECT CustomerID, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY CustomerID;

-- 19
SELECT TOP 1 CustomerID, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY CustomerID
ORDER BY TotalRevenue DESC;

-- 20
SELECT CustomerID, SUM(QuantitySold * UnitPrice) AS TotalSales
FROM Sales
GROUP BY CustomerID;

-- 21
SELECT * FROM Products p
WHERE EXISTS (
    SELECT 1 FROM Sales s WHERE s.Product = p.ProductName
);

-- 22
SELECT * FROM Products
WHERE SellingPrice = (SELECT MAX(SellingPrice) FROM Products);

-- 23
SELECT * FROM Products p
WHERE SellingPrice > (
    SELECT AVG(SellingPrice) FROM Products WHERE Category = p.Category
);
