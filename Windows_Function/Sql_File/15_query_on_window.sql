use windows_function;
SELECT * FROM sales;

-- 1)Assign a sequential row number to each sale within its department ordered by sale_date.
SELECT s.*,
ROW_NUMBER () OVER (PARTITION BY department ORDER BY sale_date) as rn
FROM sales s;

-- 2)Rank sales by sale_amount within each department and identify ties.
SELECT s.*,
RANK() OVER(PARTITION BY department ORDER BY sale_amount DESC)as rnk
FROM sales s;

-- 3)Retrieve only the top 3 highest sale_amount per department.
SELECT *
 FROM
	(SELECT s.*,
	 DENSE_RANK () OVER (PARTITION BY department ORDER BY sale_amount DESC) as drnk
	 FROM sales s) as x
 WHERE x.drnk < 4;

-- 4)Calculate the running total of sale_amount for each department ordered by sale_date.
SELECT s.*,
SUM(sale_amount) OVER (
  PARTITION BY department 
  ORDER BY sale_date 
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_total
FROM sales s;

-- 5)Calculate the running average of sale_amount for each department ordered by sale_date.
SELECT 
  department,
  sale_date,
  employee_name,
  sale_amount,
  AVG(sale_amount) OVER (
      PARTITION BY department 
      ORDER BY sale_date 
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_average
FROM sales;

-- 6)Show the previous sale_amount for each record within the same department.
SELECT s.*,
coalesce(lag(sale_amount) OVER (PARTITION BY department ORDER BY sale_date),0) as previous_sale
FROM sales s;

-- 7)Show the next sale_amount for each record within the same department.
SELECT s.*,
coalesce(lead(sale_amount) OVER (PARTITION BY department ORDER BY sale_date),0) as next_sale
FROM sales s;

-- 8)Find the difference between the current sale_amount and the previous sale_amount in the same department.
SELECT x.*,
(x.sale_amount - x.previous_sale) as diff_from_prev
 FROM 
(SELECT s.*,
coalesce(lag(sale_amount) OVER (PARTITION BY department ORDER BY sale_date),0) as previous_sale
FROM sales s) x ;

-- 9)Identify the first and last sale_amount within each department.
SELECT s.*,
FIRST_VALUE(sale_amount) OVER (PARTITION BY department) as first_value_sale,
LAST_VALUE(sale_amount) OVER (
  PARTITION BY department 
  ORDER BY sale_date 
  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_value_sale
FROM sales s;

-- 10)Divide all sales into 4 equal groups based on sale_amount.
SELECT s.*,
NTILE(4) OVER (PARTITION BY department ORDER BY sale_amount) as first_value_sale
FROM sales s;

-- 11)Calculate the percentage contribution of each sale to the total sales of its department.
SELECT 
  department,
  employee_name,
  sale_amount,
  ROUND(
    (sale_amount * 100.0 / SUM(sale_amount) OVER (PARTITION BY department)),
    2
  ) AS pct_contribution
FROM sales;

-- 12)Show the highest sale_amount in each department on every row without using GROUP BY.
select s.*,
FIRST_VALUE (sale_amount) over(PARTITION BY department ORDER BY sale_amount desc) as highest_sale_value
FROM sales s;

-- 13)Show the lowest sale_amount in each department on every row without using GROUP BY.
select s.*,
LAST_VALUE (sale_amount) over(PARTITION BY department ORDER BY sale_amount desc
 ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) as lowest_sale_value
FROM sales s;
-- 14)Find the employees whose sale_amount is above the department’s average sale_amount.
SELECT x.* FROM
(SELECT s.*,
AVG(sale_amount) OVER(PARTITION BY department) as avg_sale
FROM sales s) x 
WHERE x.sale_amount > x.avg_sale;

-- 15)Show the cumulative percentage of sales within each department ordered by sale_amount.
SELECT 
  department,
  employee_name,
  sale_amount,
  -- Running total of sales within department ordered by sale_amount (descending)
  SUM(sale_amount) OVER (
    PARTITION BY department 
    ORDER BY sale_amount DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_sales,
  
  -- Total sales per department
  SUM(sale_amount) OVER (PARTITION BY department) AS dept_total,
  
  -- Cumulative percentage
  ROUND(
    SUM(sale_amount) OVER (
      PARTITION BY department 
      ORDER BY sale_amount DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) 
    * 100.0 / SUM(sale_amount) OVER (PARTITION BY department), 2
  ) AS cumulative_pct
FROM sales
ORDER BY department, sale_amount DESC;
