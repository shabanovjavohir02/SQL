-------------------------------------------
-- 📘 EASY TASKS
-------------------------------------------

-- 1. Create a numbers table using a recursive query from 1 to 1000
WITH Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM Numbers
    WHERE num < 1000
)
SELECT num FROM Numbers;


-- 2. Find total sales per employee using a derived table (Sales, Employees)
SELECT e.EmployeeName, t.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(Amount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS t
ON e.EmployeeID = t.EmployeeID;


-- 3. CTE to find the average salary of employees (Employees)
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT * FROM AvgSalary;


-- 4. Derived table to find the highest sales for each product (Sales, Products)
SELECT p.ProductName, t.MaxSale
FROM Products p
JOIN (
    SELECT ProductID, MAX(Amount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) AS t
ON p.ProductID = t.ProductID;


-- 5. Beginning at 1, double the number for each record, stop when < 1,000,000
WITH Doubles AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2 FROM Doubles WHERE num * 2 < 1000000
)
SELECT num FROM Doubles;


-- 6. CTE to get names of employees who made more than 5 sales (Sales, Employees)
WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT e.EmployeeName
FROM Employees e
JOIN SalesCount s ON e.EmployeeID = s.EmployeeID
WHERE s.SaleCount > 5;


-- 7. CTE to find products with sales > $500 (Sales, Products)
WITH ProductSales AS (
    SELECT ProductID, SUM(Amount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;


-- 8. Employees with salaries above average
WITH AvgSal AS (
    SELECT AVG(Salary) AS avg_salary FROM Employees
)
SELECT e.EmployeeName, e.Salary
FROM Employees e, AvgSal a
WHERE e.Salary > a.avg_salary;


-------------------------------------------
-- 📙 MEDIUM TASKS
-------------------------------------------

-- 9. Top 5 employees by number of orders (Employees, Sales)
SELECT TOP 5 e.EmployeeName, COUNT(s.SaleID) AS TotalOrders
FROM Employees e
JOIN Sales s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeName
ORDER BY TotalOrders DESC;


-- 10. Sales per product category (Sales, Products)
SELECT p.Category, SUM(s.Amount) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;


-- 11. Return factorial of each value (Numbers1)
WITH Factorial AS (
    SELECT num, CAST(1 AS BIGINT) AS fact
    FROM Numbers1
    WHERE num = 1
    UNION ALL
    SELECT n.num, f.fact * n.num
    FROM Numbers1 n
    JOIN Factorial f ON n.num = f.num + 1
)
SELECT * FROM Factorial;


-- 12. Recursion to split a string into rows of substrings
WITH SplitCTE AS (
    SELECT 1 AS pos, SUBSTRING('HELLO', 1, 1) AS ch
    UNION ALL
    SELECT pos + 1, SUBSTRING('HELLO', pos + 1, 1)
    FROM SplitCTE
    WHERE pos + 1 <= LEN('HELLO')
)
SELECT ch FROM SplitCTE;


-- 13. Sales difference between current and previous month (Sales)
WITH MonthlySales AS (
    SELECT 
        YEAR(SaleDate) AS Yr,
        MONTH(SaleDate) AS Mo,
        SUM(Amount) AS Total
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
Diff AS (
    SELECT Yr, Mo,
           Total - LAG(Total) OVER (ORDER BY Yr, Mo) AS DiffFromPrev
    FROM MonthlySales
)
SELECT * FROM Diff;


-- 14. Derived table: employees with sales > 45000 in each quarter
SELECT e.EmployeeName, q.Quarter, q.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(Amount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) q ON e.EmployeeID = q.EmployeeID
WHERE q.TotalSales > 45000;


-------------------------------------------
-- 📕 DIFFICULT TASKS
-------------------------------------------

-- 15. Recursive Fibonacci
WITH Fibonacci AS (
    SELECT 1 AS n, 0 AS a, 1 AS b
    UNION ALL
    SELECT n + 1, b, a + b
    FROM Fibonacci
    WHERE n < 20
)
SELECT n, a AS FibonacciNumber FROM Fibonacci;


-- 16. Find string where all characters are same and length > 1
SELECT str
FROM FindSameCharacters
WHERE LEN(str) > 1
AND LEN(REPLACE(str, LEFT(str,1), '')) = 0;


-- 17. Numbers table that grows like: 1, 12, 123, 1234, 12345 (for n=5)
WITH Seq AS (
    SELECT 1 AS n, CAST('1' AS VARCHAR(20)) AS num
    UNION ALL
    SELECT n + 1, CONCAT(num, CAST(n + 1 AS VARCHAR(10)))
    FROM Seq
    WHERE n < 5
)
SELECT num FROM Seq;


-- 18. Employees with most sales in last 6 months (Employees, Sales)
SELECT TOP 1 e.EmployeeName, SUM(s.Amount) AS TotalSales
FROM Employees e
JOIN Sales s ON e.EmployeeID = s.EmployeeID
WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())
GROUP BY e.EmployeeName
ORDER BY TotalSales DESC;


-- 19. Remove duplicate integer values and single integer characters from string column
;WITH Clean AS (
    SELECT id,
           STRING_AGG(value, '') AS Cleaned
    FROM (
        SELECT id,
               value
        FROM (
            SELECT id, value,
                   ROW_NUMBER() OVER (PARTITION BY id, value ORDER BY (SELECT NULL)) AS rn
            FROM STRING_SPLIT(ColumnName, '')
        ) x
        WHERE rn = 1 AND ISNUMERIC(value) = 0
    ) y
    GROUP BY id
)
SELECT * FROM Clean;
