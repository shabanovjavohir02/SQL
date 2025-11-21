use lesson15 

-- Level 1: Basic Subqueries

-- 1. Employees with Minimum Salary
SELECT * 
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

-- 2. Products Above Average Price
SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);


-- Level 2: Nested Subqueries with Conditions

-- 3. Employees in Sales Department
SELECT *
FROM employees
WHERE department_id = (SELECT id FROM departments WHERE department_name = 'Sales');

-- 4. Customers with No Orders
SELECT *
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);


-- Level 3: Aggregation and Grouping in Subqueries

-- 5. Products with Max Price in Each Category
SELECT *
FROM products p1
WHERE price = (
    SELECT MAX(price) 
    FROM products p2 
    WHERE p2.category_id = p1.category_id
);

-- 6. Employees in Department with Highest Average Salary
SELECT *
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);


-- Level 4: Correlated Subqueries

-- 7. Employees Earning Above Department Average
SELECT *
FROM employees e1
WHERE salary > (
    SELECT AVG(salary) 
    FROM employees e2 
    WHERE e2.department_id = e1.department_id
);

-- 8. Students with Highest Grade per Course
SELECT *
FROM grades g1
WHERE grade = (
    SELECT MAX(grade)
    FROM grades g2
    WHERE g2.course_id = g1.course_id
);


-- Level 5: Subqueries with Ranking and Complex Conditions

-- 9. Third-Highest Price per Category
SELECT *
FROM products p1
WHERE 3 = (
    SELECT COUNT(DISTINCT price) 
    FROM products p2 
    WHERE p2.category_id = p1.category_id AND p2.price >= p1.price
);

-- 10. Employees with Salary Between Company Avg and Department Max
SELECT *
FROM employees e1
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND salary < (
      SELECT MAX(salary) 
      FROM employees e2 
      WHERE e2.department_id = e1.department_id
  );
