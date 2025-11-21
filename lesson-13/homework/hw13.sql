use Lesson13 

-- Easy Tasks

-- 1
SELECT emp_id || '-' || first_name || ' ' || last_name AS "Emp_Info"
FROM employees;

-- 2
UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999');

-- 3
SELECT first_name AS "First Name", LENGTH(first_name) AS "Name Length"
FROM employees
WHERE first_name LIKE 'A%' OR first_name LIKE 'J%' OR first_name LIKE 'M%'
ORDER BY first_name;

-- 4
SELECT manager_id, SUM(salary) AS "Total Salary"
FROM employees
GROUP BY manager_id;

-- 5
SELECT year,
       GREATEST(Max1, Max2, Max3) AS "Highest_Value"
FROM TestMax;

-- 6
SELECT *
FROM cinema
WHERE MOD(movie_id, 2) = 1 AND description NOT LIKE '%boring%';

-- 7
SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;

-- 8
SELECT COALESCE(column1, column2, column3, column4) AS First_Non_Null
FROM person;


-- Medium Tasks

-- 9
SELECT 
    SPLIT_PART(FullName, ' ', 1) AS FirstName,
    SPLIT_PART(FullName, ' ', 2) AS MiddleName,
    SPLIT_PART(FullName, ' ', 3) AS LastName
FROM Students;

-- 10
SELECT o.*
FROM Orders o
WHERE o.customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE delivery_state = 'California'
) AND o.delivery_state = 'Texas';

-- 11
SELECT GROUP_CONCAT(column_name SEPARATOR ', ') AS ConcatenatedValues
FROM DMLTable;

-- 12
SELECT *
FROM employees
WHERE LENGTH(REGEXP_REPLACE(first_name || last_name, '[^aA]', '', 'g')) >= 3;

-- 13
SELECT department_id,
       COUNT(*) AS Total_Employees,
       ROUND(SUM(CASE WHEN hire_date <= CURRENT_DATE - INTERVAL '3 years' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Percent_Over_3_Years
FROM employees
GROUP BY department_id;


-- Difficult Tasks

-- 14
SELECT id,
       SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Sum
FROM Students;

-- 15
SELECT s1.*
FROM Student s1
JOIN (
    SELECT birthday
    FROM Student
    GROUP BY birthday
    HAVING COUNT(*) > 1
) s2 ON s1.birthday = s2.birthday;

-- 16
SELECT LEAST(PlayerA, PlayerB) AS Player1,
       GREATEST(PlayerA, PlayerB) AS Player2,
       SUM(score) AS Total_Score
FROM PlayerScores
GROUP BY LEAST(PlayerA, PlayerB), GREATEST(PlayerA, PlayerB);

-- 17
SELECT 
    REGEXP_REPLACE('tf56sd#%OqH', '[^A-Z]', '', 'g') AS Uppercase_Letters,
    REGEXP_REPLACE('tf56sd#%OqH', '[^a-z]', '', 'g') AS Lowercase_Letters,
    REGEXP_REPLACE('tf56sd#%OqH', '[^0-9]', '', 'g') AS Numbers,
    REGEXP_REPLACE('tf56sd#%OqH', '[A-Za-z0-9]', '', 'g') AS Other_Characters;
