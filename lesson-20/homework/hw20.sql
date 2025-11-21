-- 1. Customers who purchased at least one item in March 2024
SELECT DISTINCT CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND MONTH(s2.SaleDate) = 3
      AND YEAR(s2.SaleDate) = 2024
);

-- 2. Product with highest total sales revenue
SELECT TOP 1 Product
FROM #Sales
GROUP BY Product
ORDER BY SUM(Quantity * Price) DESC;

-- 3. Second highest sale amount
SELECT MAX(Quantity * Price) AS SecondHighestSale
FROM #Sales
WHERE Quantity * Price < (
    SELECT MAX(Quantity * Price)
    FROM #Sales
);

-- 4. Total quantity of products sold per month
SELECT YEAR(SaleDate) AS SaleYear, MONTH(SaleDate) AS SaleMonth, 
       SUM(Quantity) AS TotalQuantity
FROM #Sales
GROUP BY YEAR(SaleDate), MONTH(SaleDate);

-- 5. Customers who bought same products as another customer
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.Product = s1.Product
      AND s2.CustomerName <> s1.CustomerName
);

-- 6. Fruits count per person at individual fruit level
SELECT Name,
       SUM(CASE WHEN Fruit='Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit='Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit='Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

-- 7. Older people in the family with younger ones
SELECT f1.ParentId AS PID, f2.ChildID AS CHID
FROM Family f1
JOIN Family f2 ON f1.ParentId < f2.ChildID
ORDER BY f1.ParentId, f2.ChildID;

-- 8. Customers with delivery to California having Texas orders
SELECT o.*
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders o2
      WHERE o2.CustomerID = o.CustomerID
        AND o2.DeliveryState = 'CA'
  );

-- 9. Insert names if missing
SELECT resid, 
       COALESCE(PARSENAME(REPLACE(fullname, ' ', '.'), 2), '') AS Name, 
       address
FROM #residents;

-- 10. Route from Tashkent to Khorezm
;WITH RecursiveRoutes AS (
    SELECT DepartureCity, ArrivalCity, CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route, Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT r.DepartureCity, rr.ArrivalCity, rr.Route + ' - ' + r.ArrivalCity, rr.Cost + r.Cost
    FROM #Routes r
    JOIN RecursiveRoutes rr ON r.DepartureCity = rr.ArrivalCity
)
SELECT Route, Cost
FROM RecursiveRoutes
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC;

-- 11. Rank products based on insertion order
SELECT ID, Vals, 
       ROW_NUMBER() OVER (PARTITION BY Vals ORDER BY ID) AS RankWithinValue
FROM #RankingPuzzle;

-- 12. Employees with sales higher than avg in their dept
SELECT e.*
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);

-- 13. Employees with highest sales in any month
SELECT e1.*
FROM #EmployeeSales e1
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e1.SalesMonth
      AND e2.SalesYear = e1.SalesYear
    GROUP BY e2.SalesMonth, e2.SalesYear
    HAVING MAX(e2.SalesAmount) = e1.SalesAmount
);

-- 14. Employees who made sales in every month
SELECT DISTINCT e1.EmployeeName
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT SalesMonth, SalesYear FROM #EmployeeSales) AS m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales e2
        WHERE e2.EmployeeName = e1.EmployeeName
          AND e2.SalesMonth = m.SalesMonth
          AND e2.SalesYear = m.SalesYear
    )
);

-- 15. Products more expensive than average
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 16. Products with stock lower than highest stock
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

-- 17. Products in same category as 'Laptop'
SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name='Laptop');

-- 18. Products whose price greater than lowest Electronics price
SELECT Name
FROM Products
WHERE Price > (SELECT MIN(Price) FROM Products WHERE Category='Electronics');

-- 19. Products with price higher than average of their category
SELECT Name
FROM Products p
WHERE Price > (SELECT AVG(Price) FROM Products WHERE Category = p.Category);

-- 20. Products that have been ordered at least once
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

-- 21. Products ordered more than avg quantity
SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);

-- 22. Products never ordered
SELECT Name
FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM Orders);

-- 23. Product with highest total quantity ordered
SELECT TOP 1 p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY SUM(o.Quantity) DESC;
