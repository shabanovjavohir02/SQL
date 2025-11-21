-- 1
SELECT ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum, *
FROM ProductSales
ORDER BY SaleDate;

-- 2
SELECT ProductName,
       SUM(Quantity) AS TotalQuantity,
       RANK() OVER (ORDER BY SUM(Quantity) DESC) AS RankQuantity
FROM ProductSales
GROUP BY ProductName
ORDER BY TotalQuantity DESC;

-- 3
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) t
WHERE rn = 1;

-- 4
SELECT SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales
ORDER BY SaleDate;

-- 5
SELECT SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales
ORDER BY SaleDate;

-- 6
SELECT SaleID, SaleAmount
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSale
    FROM ProductSales
) t
WHERE SaleAmount > PrevSale;

-- 7
SELECT ProductName, SaleAmount,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffPrev
FROM ProductSales
ORDER BY ProductName, SaleDate;

-- 8
SELECT SaleID, SaleAmount,
       ((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount)/SaleAmount)*100 AS PercentChangeToNext
FROM ProductSales
ORDER BY SaleDate;

-- 9
SELECT ProductName, SaleAmount,
       SaleAmount / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS RatioToPrev
FROM ProductSales
ORDER BY ProductName, SaleDate;

-- 10
SELECT ProductName, SaleAmount,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales
ORDER BY ProductName, SaleDate;

-- 11
SELECT ProductName, SaleAmount, SaleDate
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSale
    FROM ProductSales
) t
WHERE PrevSale IS NOT NULL AND SaleAmount > PrevSale
ORDER BY ProductName, SaleDate;

-- 12
SELECT *, SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM ProductSales
ORDER BY SaleDate;

-- 13
SELECT SaleID, SaleAmount,
       AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM ProductSales
ORDER BY SaleDate;

-- 14
SELECT SaleID, SaleAmount,
       SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales
ORDER BY SaleDate;

-- 15
SELECT Name, Department, Salary,
       DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees1
ORDER BY Department, Salary DESC;

-- 16
SELECT Name, Department, Salary
FROM (
    SELECT *, DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM Employees1
) t
WHERE rnk <= 2
ORDER BY Department, Salary DESC;

-- 17
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees1
) t
WHERE rn = 1;

-- 18
SELECT *,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM Employees1
ORDER BY Department, HireDate;

-- 19
SELECT DISTINCT Department,
       SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees1
ORDER BY Department;

-- 20
SELECT DISTINCT Department,
       AVG(Salary) OVER (PARTITION BY Department) AS AvgSalary
FROM Employees1
ORDER BY Department;

-- 21
SELECT Name, Department, Salary,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1
ORDER BY Department, Salary DESC;

-- 22
SELECT Name, Department, Salary,
       AVG(Salary) OVER (PARTITION BY Department ORDER BY HireDate
                         ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM Employees1
ORDER BY Department, HireDate;

-- 23
SELECT SUM(Salary) AS SumLast3Hired
FROM (
    SELECT TOP 3 Salary
    FROM Employees1
    ORDER BY HireDate DESC
) t;
