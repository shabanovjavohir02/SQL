-- 1
SELECT sale_id, customer_id, customer_name, 
       SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date ROWS UNBOUNDED PRECEDING) AS running_total
FROM sales_data;

-- 2
SELECT product_category, COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;

-- 3
SELECT product_category, MAX(total_amount) AS max_total_amount
FROM sales_data
GROUP BY product_category;

-- 4
SELECT product_category, MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;

-- 5
SELECT order_date, 
       AVG(total_amount) OVER(ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
FROM sales_data;

-- 6
SELECT region, SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;

-- 7
SELECT customer_id, customer_name, 
       RANK() OVER(PARTITION BY region ORDER BY SUM(total_amount) DESC) AS customer_rank
FROM sales_data
GROUP BY customer_id, customer_name, region;

-- 8
SELECT sale_id, customer_id, total_amount,
       total_amount - LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS diff_prev
FROM sales_data;

-- 9
SELECT product_category, product_name, unit_price
FROM (
    SELECT product_category, product_name, unit_price,
           ROW_NUMBER() OVER(PARTITION BY product_category ORDER BY unit_price DESC) AS rn
    FROM sales_data
) t
WHERE rn <= 3;

-- 10
SELECT region, order_date, 
       SUM(total_amount) OVER(PARTITION BY region ORDER BY order_date ROWS UNBOUNDED PRECEDING) AS cumulative_sales
FROM sales_data;

-- 11
SELECT product_category, SUM(total_amount) OVER(ORDER BY product_category ROWS UNBOUNDED PRECEDING) AS cumulative_revenue
FROM sales_data;

-- 12
SELECT customer_id, COUNT(DISTINCT product_category) AS categories_count
FROM sales_data
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) > 1;

-- 13
SELECT customer_id, region, SUM(total_amount) AS total_spending
FROM sales_data
GROUP BY customer_id, region
HAVING SUM(total_amount) > AVG(SUM(total_amount)) OVER(PARTITION BY region);

-- 14
SELECT customer_id, region, SUM(total_amount) AS total_amount,
       RANK() OVER(PARTITION BY region ORDER BY SUM(total_amount) DESC) AS rank_in_region
FROM sales_data
GROUP BY customer_id, region;

-- 15
SELECT customer_id, order_date, 
       SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date ROWS UNBOUNDED PRECEDING) AS cumulative_sales
FROM sales_data;

-- 16
SELECT FORMAT(order_date, 'yyyy-MM') AS month,
       (SUM(total_amount) - LAG(SUM(total_amount)) OVER(ORDER BY FORMAT(order_date,'yyyy-MM'))) / LAG(SUM(total_amount)) OVER(ORDER BY FORMAT(order_date,'yyyy-MM')) * 100 AS growth_rate
FROM sales_data
GROUP BY FORMAT(order_date, 'yyyy-MM');

-- 17
SELECT *
FROM sales_data s
WHERE total_amount > LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date);

-- 18
SELECT *
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);

-- 19
WITH summed AS (
    SELECT Grp, SUM(Val1 + Val2) AS Tot
    FROM MyData
    GROUP BY Grp
)
SELECT m.Id, m.Grp, m.Val1, m.Val2, CASE WHEN ROW_NUMBER() OVER(PARTITION BY m.Grp ORDER BY m.Id) = 1 THEN s.Tot ELSE NULL END AS Tot
FROM MyData m
JOIN summed s ON m.Grp = s.Grp
ORDER BY m.Id;

-- 20
SELECT ID, SUM(Cost) AS Cost, SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;

-- 21
SELECT s1.SeatNumber + 1 AS GapStart, MIN(s2.SeatNumber) - 1 AS GapEnd
FROM Seats s1
CROSS JOIN Seats s2
WHERE s2.SeatNumber > s1.SeatNumber
GROUP BY s1.SeatNumber
HAVING MIN(s2.SeatNumber) - s1.SeatNumber > 1
ORDER BY GapStart;

-- 22
SELECT Value, SUM(Value) OVER(ORDER BY Value ROWS UNBOUNDED PRECEDING) AS Sum_Previous
FROM OneColumn;

-- 23
SELECT customer_id, SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date ROWS UNBOUNDED PRECEDING) AS cumulative_sales
FROM sales_data;
