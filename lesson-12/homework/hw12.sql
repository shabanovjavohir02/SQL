-- 1
SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;

-- 2
SELECT e1.name
FROM Employee e1
JOIN Employee e2 ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;

-- 3
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

-- 4
DELETE p1
FROM Person p1
JOIN Person p2
ON p1.email = p2.email AND p1.id > p2.id;

-- 5
SELECT DISTINCT g.ParentName
FROM girls g
LEFT JOIN boys b ON g.ParentName = b.ParentName
WHERE b.ParentName IS NULL;

-- 6
SELECT CustomerID, SUM(Amount) AS TotalAmount, MIN(Weight) AS LeastWeight
FROM Sales.Orders
WHERE Weight > 50
GROUP BY CustomerID;

-- 7
SELECT c1.Item AS ItemCart1, c2.Item AS ItemCart2
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2 ON c1.Item = c2.Item;

-- 8
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;

-- 9
SELECT s.student_id, s.student_name, sub.subject_name, 
       COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
  ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
