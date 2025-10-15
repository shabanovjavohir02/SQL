Lesson 3

1 BULK INSERT is used to quickly load data from a file (like CSV or TXT) into a SQL Server table
2 Common file formats for import: CSV, TXT, XML, JSON
3 CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))
4 INSERT INTO Products VALUES (1,'Phone',700.00),(2,'Laptop',1200.00),(3,'Tablet',400.00)
5 NULL means no value. NOT NULL means a value must always be given
6 ALTER TABLE Products ADD CONSTRAINT UQ_ProductName UNIQUE(ProductName)
7 -- This query creates the Products table
8 ALTER TABLE Products ADD CategoryID INT
9 CREATE TABLE Categories (CategoryID INT PRIMARY KEY, CategoryName VARCHAR(50) UNIQUE)
10 IDENTITY is used to make numbers auto-increase for each new row
11 BULK INSERT Products FROM 'C:\data\products.txt' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n')
12 ALTER TABLE Products ADD CONSTRAINT FK_Products_Categories FOREIGN KEY(CategoryID) REFERENCES Categories(CategoryID)
13 PRIMARY KEY is unique and cannot be NULL. UNIQUE is also unique but can have NULL
14 ALTER TABLE Products ADD CONSTRAINT CHK_Price CHECK(Price>0)
15 ALTER TABLE Products ADD Stock INT NOT NULL
16 SELECT ProductID, ISNULL(Price,0) AS Price FROM Products
17 FOREIGN KEY connects two tables and keeps data consistent
18 CREATE TABLE Customers (CustomerID INT PRIMARY KEY, Name VARCHAR(50), Age INT CHECK(Age>=18))
19 CREATE TABLE AutoIDs (ID INT IDENTITY(100,10), Info VARCHAR(50))
20 CREATE TABLE OrderDetails (OrderID INT, ProductID INT, Quantity INT, PRIMARY KEY(OrderID, ProductID))
21 COALESCE returns the first non-NULL value. ISNULL checks only one value
22 CREATE TABLE Employees (EmpID INT PRIMARY KEY, Email VARCHAR(100) UNIQUE, Name VARCHAR(50))
23 CREATE TABLE Orders (OrderID INT PRIMARY KEY, CustomerID INT, FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE)
