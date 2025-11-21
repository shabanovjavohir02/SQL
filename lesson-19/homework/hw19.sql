-- Task 1: Stored Procedure for Employee Bonuses
CREATE PROCEDURE sp_EmployeeBonus
AS
BEGIN
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * b.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus b ON e.Department = b.Department;

    SELECT * FROM #EmployeeBonus;
END;

-- Task 2: Stored Procedure to Increase Salary by Department
CREATE PROCEDURE sp_IncreaseSalaryByDepartment
    @Department NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @Department;

    SELECT * FROM Employees WHERE Department = @Department;
END;

-- Task 3: MERGE Products
MERGE INTO Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN 
    UPDATE SET target.ProductName = source.ProductName,
               target.Price = source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

SELECT * FROM Products_Current;

-- Task 4: Tree Node Types
SELECT 
    t.id,
    CASE 
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN NOT EXISTS (SELECT 1 FROM Tree WHERE p_id = t.id) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t
ORDER BY t.id;

-- Task 5: Confirmation Rate
SELECT 
    s.user_id,
    COALESCE(
        CAST(SUM(CASE WHEN c.action='confirmed' THEN 1 ELSE 0 END) AS DECIMAL(10,2)) 
        / NULLIF(COUNT(c.action),0), 0
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;

-- Task 6: Employees with lowest salary using subquery
SELECT *
FROM employees_low
WHERE salary = (SELECT MIN(salary) FROM employees_low);

-- Task 7: Stored Procedure for Product Sales Summary
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
