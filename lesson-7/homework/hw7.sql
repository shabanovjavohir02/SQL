-- 1
SELECT MIN(Price) AS MinPrice FROM Products;

-- 2
SELECT MAX(Salary) AS MaxSalary FROM Employees;

-- 3
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- 4
SELECT COUNT(DISTINCT Category) AS UniqueCategories FROM Products;

-- 5
SELECT SUM(SaleAmount) AS TotalSales FROM Sales WHERE ProductID = 7;

-- 6
SELECT AVG(Age) AS AvgAge FROM Employees;

-- 7
SELECT DeptID, COUNT(*) AS EmployeeCount FROM Employees GROUP BY DeptID;

-- 8
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice FROM Products GROUP BY Category;

-- 9
SELECT CustomerID, SUM(SaleAmount) AS TotalSales FROM Sales GROUP BY CustomerID;

-- 10
SELECT DeptID, COUNT(*) AS EmployeeCount FROM Employees GROUP BY DeptID HAVING COUNT(*) > 5;

-- 11
SELECT Category, SUM(SaleAmount) AS TotalSales, AVG(SaleAmount) AS AvgSales FROM Sales GROUP BY Category;

-- 12
SELECT COUNT(*) AS HREmployees FROM Employees WHERE DeptID = 'HR';

-- 13
SELECT DeptID, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary FROM Employees GROUP BY DeptID;

-- 14
SELECT DeptID, AVG(Salary) AS AvgSalary FROM Employees GROUP BY DeptID;

-- 15
SELECT DeptID, AVG(Salary) AS AvgSalary, COUNT(*) AS EmployeeCount FROM Employees GROUP BY DeptID;

-- 16
SELECT Category, AVG(Price) AS AvgPrice FROM Products GROUP BY Category HAVING AVG(Price) > 400;

-- 17
SELECT YEAR(SaleDate) AS SaleYear, SUM(SaleAmount) AS TotalSales FROM Sales GROUP BY YEAR(SaleDate);

-- 18
SELECT CustomerID FROM Orders GROUP BY CustomerID HAVING COUNT(OrderID) >= 3;

-- 19
SELECT DeptID, AVG(Salary) AS AvgSalary FROM Employees GROUP BY DeptID HAVING AVG(Salary) > 60000;

-- 20
SELECT Category, AVG(Price) AS AvgPrice FROM Products GROUP BY Category HAVING AVG(Price) > 150;

-- 21
SELECT CustomerID, SUM(SaleAmount) AS TotalSales FROM Sales GROUP BY CustomerID HAVING SUM(SaleAmount) > 1500;

-- 22
SELECT DeptID, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary FROM Employees GROUP BY DeptID HAVING AVG(Salary) > 65000;

-- 23
SELECT CustomerID, SUM(Freight) AS TotalAmount, MIN(Freight) AS LeastPurchase
FROM TSQL2012.Sales.Orders
WHERE Freight > 50
GROUP BY CustomerID;

-- 24
SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth,
       SUM(TotalAmount) AS TotalSales, COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;

-- 25
SELECT YEAR(OrderDate) AS OrderYear, MIN(Quantity) AS MinQuantity, MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate);
