-- 1
SELECT ProductName, SupplierName
FROM Products CROSS JOIN Suppliers;

-- 2
SELECT DepartmentName, EmployeeName
FROM Departments CROSS JOIN Employees;

-- 3
SELECT s.SupplierName, p.ProductName
FROM Suppliers s
INNER JOIN Products p ON s.SupplierID = p.SupplierID;

-- 4
SELECT c.CustomerName, o.OrderID
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 5
SELECT s.StudentName, c.CourseName
FROM Students s CROSS JOIN Courses c;

-- 6
SELECT p.ProductName, o.OrderID
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

-- 7
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 8
SELECT s.StudentName, e.CourseID
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID;

-- 9
SELECT p.PaymentID, o.OrderID
FROM Payments p
INNER JOIN Orders o ON p.OrderID = o.OrderID;

-- 10
SELECT o.OrderID, p.ProductName
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100;

-- 11
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID <> d.DepartmentID;

-- 12
SELECT o.OrderID, p.ProductName
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQuantity;

-- 13
SELECT c.CustomerName, s.ProductID
FROM Customers c
INNER JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleAmount >= 500;

-- 14
SELECT s.StudentName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

-- 15
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%';

-- 16
SELECT o.OrderID, p.PaymentAmount
FROM Orders o
INNER JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentAmount < o.TotalAmount;

-- 17
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 18
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

-- 19
SELECT s.SaleID, c.CustomerName
FROM Sales s
INNER JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

-- 20
SELECT o.OrderID, c.CustomerName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount > 100;

-- 21
SELECT e1.EmployeeName AS Employee1, e2.EmployeeName AS Employee2
FROM Employees e1
INNER JOIN Employees e2 ON e1.DepartmentID <> e2.DepartmentID;

-- 22
SELECT p.PaymentID, p.PaidAmount, (o.Quantity * pr.Price) AS ExpectedAmount
FROM Payments p
INNER JOIN Orders o ON p.OrderID = o.OrderID
INNER JOIN Products pr ON o.ProductID = pr.ProductID
WHERE p.PaidAmount <> (o.Quantity * pr.Price);

-- 23
SELECT s.StudentName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IS NULL;

-- 24
SELECT m.EmployeeName AS Manager, e.EmployeeName AS Employee
FROM Employees m
INNER JOIN Employees e ON m.EmployeeID = e.ManagerID
WHERE m.Salary <= e.Salary;

-- 25
SELECT c.CustomerName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;
