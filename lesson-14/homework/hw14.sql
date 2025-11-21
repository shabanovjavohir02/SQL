use lesson14

-- Easy Tasks

-- 1. Split Name column by comma into Name and Surname
SELECT 
    LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS Name,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns;

-- 2. Find strings containing %
SELECT *
FROM TestPercent
WHERE Strs LIKE '%[%]%';

-- 3. Split string based on dot (.)
SELECT Id, value AS SplitPart
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');

-- 4. Return rows where Vals contains more than two dots
SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

-- 5. Count spaces in the string
SELECT texts, LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

-- 6. Employees earning more than their managers
SELECT e.Name, e.Salary, m.Name AS ManagerName, m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;

-- 7. Employees with 10-15 years of service
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
       DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15;


-- Medium Tasks

-- 1. Dates with higher temperature than previous date
SELECT w1.Id, w1.RecordDate, w1.Temperature
FROM weather w1
JOIN weather w2 ON w1.RecordDate = DATEADD(DAY, 1, w2.RecordDate)
WHERE w1.Temperature > w2.Temperature;

-- 2. First login date for each player
SELECT player_id, MIN(event_date) AS FirstLoginDate
FROM Activity
GROUP BY player_id;

-- 3. Return third item from comma-separated fruits list
SELECT value AS ThirdFruit
FROM fruits
CROSS APPLY STRING_SPLIT(fruit_list, ',')
WHERE (SELECT COUNT(*) FROM STRING_SPLIT(fruit_list, ',') f2 WHERE f2.value <= value) = 3;

-- 4. Employment Stage based on HIRE_DATE
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
       CASE 
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
           ELSE 'Veteran'
       END AS EmploymentStage
FROM Employees;

-- 5. Extract integer at start of string in Vals
SELECT Id, 
       CAST(SUBSTRING(VALS, 1, PATINDEX('%[^0-9]%', VALS + 'X') - 1) AS INT) AS IntegerValue
FROM GetIntegers
WHERE VALS IS NOT NULL;


-- Difficult Tasks

-- 1. Swap first two letters of comma-separated string
SELECT Id,
       CASE 
           WHEN LEN([Vals]) >= 2 THEN 
               CONCAT(SUBSTRING([Vals],2,1), SUBSTRING([Vals],1,1), SUBSTRING([Vals],3,LEN([Vals])))
           ELSE [Vals]
       END AS SwappedVals
FROM MultipleVals;

-- 2. Split each character into a row (example string: 'sdgfhsdgfhs@121313131')
DECLARE @str NVARCHAR(MAX) = 'sdgfhsdgfhs@121313131';
WITH CTE AS (
    SELECT 1 AS pos, SUBSTRING(@str, 1, 1) AS ch
    UNION ALL
    SELECT pos + 1, SUBSTRING(@str, pos + 1, 1)
    FROM CTE
    WHERE pos + 1 <= LEN(@str)
)
SELECT ch
FROM CTE
OPTION (MAXRECURSION 0);

-- 3. First logged in device per player
SELECT player_id, device_id, MIN(event_date) AS FirstLoginDate
FROM Activity
GROUP BY player_id, device_id
HAVING event_date = MIN(event_date);

-- 4. Separate integer and character values
DECLARE @val NVARCHAR(MAX) = 'rtcfvty34redt';
WITH CTE AS (
    SELECT SUBSTRING(@val, number, 1) AS ch
    FROM master..spt_values
    WHERE type='P' AND number BETWEEN 1 AND LEN(@val)
)
SELECT 
    STRING_AGG(ch, '') WITHIN GROUP (ORDER BY ch) AS CharactersOnly
FROM CTE
WHERE ch LIKE '[A-Za-z]';

SELECT 
    STRING_AGG(ch, '') WITHIN GROUP (ORDER BY ch) AS NumbersOnly
FROM CTE
WHERE ch LIKE '[0-9]';
