1-Task

SELECT DISTINCT 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl


2-Task

SELECT *
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0)


3-Task

SELECT *
FROM section1
WHERE id % 2 = 1

4-Task

SELECT TOP 1 *
FROM section1
ORDER BY id ASC


5-Task

SELECT TOP 1 *
FROM section1
ORDER BY id DESC


6-Task

SELECT *
FROM section1
WHERE name LIKE 'B%'


7-Task

SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\'


