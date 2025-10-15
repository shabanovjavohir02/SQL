Lesson 2

1
CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))

2
INSERT INTO Employees VALUES (1, 'John', 5000)
INSERT INTO Employees VALUES (2, 'Sara', 6000), (3, 'Mike', 5500)

3
UPDATE Employees SET Salary = 7000 WHERE EmpID = 1

4
DELETE FROM Employees WHERE EmpID = 2

5
-- DELETE removes specific rows
-- TRUNCATE removes all rows but keeps structure
-- DROP removes the table completely

6
ALTER TABLE Employees ALTER COLUMN Name VARCHAR(100)

7
ALTER TABLE Employees ADD Department VARCHAR(50)

8
ALTER TABLE Employees ALTER COLUMN Salary FLOAT

9
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50))

10
TRUNCATE TABLE Employees

11
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'IT' UNION ALL
SELECT 3, 'Finance' UNION ALL
SELECT 4, 'Sales' UNION ALL
SELECT 5, 'Marketing'

12
UPDATE Employees SET Department = 'Management' WHERE Salary > 5000

13
TRUNCATE TABLE Employees

14
ALTER TABLE Employees DROP COLUMN Department

15
EXEC sp_rename 'Employees', 'StaffMembers'

16
DROP TABLE Departments

17
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Category VARCHAR(50),
Price DECIMAL(10,2),
Description VARCHAR(100)
)

18
ALTER TABLE Products ADD CONSTRAINT CHK_Price CHECK (Price > 0)

19
ALTER TABLE Products ADD StockQuantity INT DEFAULT 50

20
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN'

21
INSERT INTO Products VALUES
(1, 'Phone', 'Electronics', 600, 'Smartphone'),
(2, 'TV', 'Electronics', 1200, 'LED TV'),
(3, 'Table', 'Furniture', 300, 'Wooden Table'),
(4, 'Chair', 'Furniture', 150, 'Office Chair'),
(5, 'Laptop', 'Electronics', 1500, 'Gaming Laptop')

22
SELECT * INTO Products_Backup FROM Products

23
EXEC sp_rename 'Products', 'Inventory'

24
ALTER TABLE Inventory ALTER COLUMN Price FLOAT

25
ALTER TABLE Inventory ADD ProductCode INT IDENTITY(1000,5)
