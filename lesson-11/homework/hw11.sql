-- EASY LEVEL TASKS

-- 1. 
SELECT o.OrderID, c.CustomerName, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022;

-- 2. 
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');

-- 3. 
SELECT d.DepartmentName, MAX(e.Salary) AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 4. 
SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 2023;

-- 5. 
SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

-- 6. 
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');

-- 7. 
SELECT c.CustomerName, MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;


-- MEDIUM LEVEL TASKS

-- 1. 
SELECT c.CustomerName, o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;

-- 2. 
SELECT p.ProductName, s.SaleDate, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;

-- 3. 
SELECT p.ProductName, SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;

-- 4. 
SELECT e.EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR' AND e.Salary > 60000;

-- 5. 
SELECT p.ProductName, s.SaleDate, p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100;

-- 6. 
SELECT e.EmployeeName, d.DepartmentName, e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020;


-- HARD LEVEL TASKS

-- 1. 
SELECT c.CustomerName, o.OrderID, c.Address, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA' AND c.Address LIKE '____%';

-- 2. 
SELECT p.ProductName, p.Category, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE p.Category = 'Electronics' OR s.SaleAmount > 350;

-- 3.
SELECT Category AS CategoryName, COUNT(ProductID) AS ProductCount
FROM Products
GROUP BY Category;

-- 4. 
SELECT c.CustomerName, c.City, o.OrderID, o.TotalAmount AS Amount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300;

-- 5. 
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('HR', 'Finance')
   OR (LENGTH(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(e.EmployeeName), 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', '')) <= LENGTH(e.EmployeeName) - 4);

-- 6. 
SELECT e.EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing') AND e.Salary > 60000;

