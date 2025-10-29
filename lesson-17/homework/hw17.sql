1-Task
  
  WITH Regions AS (
  SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
  SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT 
  r.Region,
  d.Distributor,
  ISNULL(s.Sales, 0) AS Sales
FROM Distributors d
CROSS JOIN Regions r
LEFT JOIN #RegionSales s
  ON s.Region = r.Region AND s.Distributor = d.Distributor
ORDER BY 
  d.Distributor,
  CASE r.Region
    WHEN 'North' THEN 1
    WHEN 'South' THEN 2
    WHEN 'East' THEN 3
    WHEN 'West' THEN 4
  END

2-Task

SELECT e.name
FROM Employee e
JOIN Employee r ON e.id = r.managerId
GROUP BY e.id, e.name
HAVING COUNT(r.id) >= 5

3-Task
  
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100

4-Task
WITH VendorCount AS (
  SELECT CustomerID, Vendor, COUNT(*) AS OrdersCount
  FROM Orders
  GROUP BY CustomerID, Vendor
),
Ranked AS (
  SELECT CustomerID, Vendor, OrdersCount,
         ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrdersCount DESC) AS rn
  FROM VendorCount
)
SELECT CustomerID, Vendor
FROM Ranked
WHERE rn = 1

5-Task
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2, @isPrime BIT = 1;
WHILE @i <= SQRT(@Check_Prime)
BEGIN
  IF @Check_Prime % @i = 0
  BEGIN
    SET @isPrime = 0;
    BREAK;
  END;
  SET @i = @i + 1;
END;
IF @isPrime = 1
  PRINT 'This number is prime';
ELSE
  PRINT 'This number is not prime'

6-Task
WITH LocationCount AS (
  SELECT Device_id, Locations, COUNT(*) AS Signals
  FROM Device
  GROUP BY Device_id, Locations
),
MaxLocation AS (
  SELECT Device_id, MAX(Signals) AS MaxSignals
  FROM LocationCount
  GROUP BY Device_id
)
SELECT 
  l.Device_id,
  COUNT(DISTINCT l.Locations) AS no_of_location,
  MAX(CASE WHEN l.Signals = m.MaxSignals THEN l.Locations END) AS max_signal_location,
  SUM(l.Signals) AS no_of_signals
FROM LocationCount l
JOIN MaxLocation m ON l.Device_id = m.Device_id
GROUP BY l.Device_id

7-Task
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN (
  SELECT DeptID, AVG(Salary) AS AvgSalary
  FROM Employee
  GROUP BY DeptID
) a ON e.DeptID = a.DeptID
WHERE e.Salary > a.AvgSalary

8-Task
WITH TicketMatch AS (
  SELECT t.TicketID, COUNT(n.Number) AS MatchCount
  FROM Tickets t
  LEFT JOIN Numbers n ON t.Number = n.Number
  GROUP BY t.TicketID
),
Result AS (
  SELECT SUM(CASE WHEN MatchCount = (SELECT COUNT(*) FROM Numbers) THEN 100
                  WHEN MatchCount > 0 THEN 10
                  ELSE 0 END) AS TotalWinnings
  FROM TicketMatch
)
SELECT '$' + CAST(TotalWinnings AS VARCHAR) AS Total_Winnings FROM Result

9-Task
WITH Platforms AS (
  SELECT Spend_date, User_id,
         SUM(CASE WHEN Platform='Mobile' THEN Amount ELSE 0 END) AS Mobile,
         SUM(CASE WHEN Platform='Desktop' THEN Amount ELSE 0 END) AS Desktop
  FROM Spending
  GROUP BY Spend_date, User_id
),
Aggregated AS (
  SELECT Spend_date, 'Mobile' AS Platform,
         SUM(CASE WHEN Mobile>0 AND Desktop=0 THEN Mobile END) AS Total_Amount,
         COUNT(DISTINCT CASE WHEN Mobile>0 AND Desktop=0 THEN User_id END) AS Total_users
  FROM Platforms GROUP BY Spend_date
  UNION ALL
  SELECT Spend_date, 'Desktop',
         SUM(CASE WHEN Desktop>0 AND Mobile=0 THEN Desktop END),
         COUNT(DISTINCT CASE WHEN Desktop>0 AND Mobile=0 THEN User_id END)
  FROM Platforms GROUP BY Spend_date
  UNION ALL
  SELECT Spend_date, 'Both',
         SUM(CASE WHEN Mobile>0 AND Desktop>0 THEN Mobile+Desktop END),
         COUNT(DISTINCT CASE WHEN Mobile>0 AND Desktop>0 THEN User_id END)
  FROM Platforms GROUP BY Spend_date
)
SELECT ROW_NUMBER() OVER(ORDER BY Spend_date, Platform) AS Row,
       Spend_date, Platform, Total_Amount, Total_users
FROM Aggregated

10-Task
WITH Numbers AS (
  SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
  SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL
  SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product

