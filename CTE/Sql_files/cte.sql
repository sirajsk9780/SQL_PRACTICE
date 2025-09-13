create DATABASE cte;
use cte;

select * from ctes;

-- 1)calculate the number of years each employee has worked

-- 2)Write a CTE to calculate the average salary per department, and then use
--   it to list employees earning above their department’s average.

WITH total_salary AS (
    SELECT EmployeeID, SUM(Salary) AS tot_sal
    FROM ctes
    GROUP BY EmployeeID
),
avg_salary AS (
    SELECT AVG(tot_sal) AS avg_sal
    FROM total_salary
)
SELECT ts.EmployeeID, ts.tot_sal
FROM total_salary ts
 JOIN avg_salary av
WHERE ts.tot_sal > av.avg_sal;

-- 3)Use a CTE with ROW_NUMBER() to rank employees by salary within each department and return the top 3.

select *,ROW_NUMBER() OVER(ORDER BY Salary DESC) as ranking
from ctes;

with row_num as (
				  select *,ROW_NUMBER() OVER(ORDER BY Salary DESC) as ranking
				  from ctes)
SELECT *
from row_num
WHERE ranking <= 3 ;

-- 4) Build a recursive CTE to display employees along with their manager chain.

select c1.EmployeeName as Employee, c2.EmployeeName as manager
from ctes c1
join ctes c2
on c1.ManagerID = c2.ManagerID;

WITH RECURSIVE EmployeeHierarchy AS (
  -- Anchor: root managers (no manager assigned) OR manager id not present in table
  SELECT
    e.EmployeeID,
    e.EmployeeName,
    e.ManagerID,
    e.EmployeeName AS HierarchyPath,
    CAST(e.EmployeeID AS CHAR(200)) AS PathIDs,   -- used to detect cycles
    1 AS lvl
  FROM ctes e
  WHERE e.ManagerID IS NULL
     OR e.ManagerID NOT IN (SELECT EmployeeID FROM ctes)

  UNION ALL

  -- Recursive step: attach direct reports under the current node
  SELECT
    e.EmployeeID,
    e.EmployeeName,
    e.ManagerID,
    CONCAT(h.HierarchyPath, ' -> ', e.EmployeeName) AS HierarchyPath,
    CONCAT(h.PathIDs, ',', e.EmployeeID) AS PathIDs,
    h.lvl + 1
  FROM ctes e
  JOIN EmployeeHierarchy h
    ON e.ManagerID = h.EmployeeID
  -- Prevent cycles by ensuring the new employee id is not already in the path
  WHERE FIND_IN_SET(e.EmployeeID, h.PathIDs) = 0
)
SELECT
  EmployeeID,
  EmployeeName,
  ManagerID,
  HierarchyPath,
  lvl
FROM EmployeeHierarchy
ORDER BY HierarchyPath, lvl;


-- 4)Salary Bands
-- Create a CTE that assigns employees into salary bands (e.g., <50K, 50K–80K, 80K+) and count how many employees fall into each band.
 
 WITH salary_band_table as (
	SELECT 
    EmployeeID,
    EmployeeName,
    Salary,
    CASE 
        WHEN Salary < 50000 THEN 'Low (<50K)'
        WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium (50K-80K)'
        WHEN Salary BETWEEN 80001 AND 120000 THEN 'High (80K-120K)'
        ELSE 'Very High (>120K)'
    END AS SalaryBand
	FROM ctes)

SELECT SalaryBand,count(EmployeeID) as Total_Employee
FROM salary_band_table
GROUP BY SalaryBand;

-- 5)Find Departments With Above-Average Salary
-- Use a CTE to compute the overall average salary, and then filter departments whose average is higher.

SELECT avg(x.total_Salary) as avg_sal
from (
SELECT Department,SUM(Salary) as total_salary
FROM ctes
GROUP BY Department) x ;

WITH department_wise_total_sal as (
									SELECT Department,SUM(Salary) as total_salary
									FROM ctes
									GROUP BY Department),
	 department_wise_avg_sal as (
									SELECT AVG(total_salary) as avg_salary
                                    FROM department_wise_total_sal)
SELECT *,(ts.total_salary - av.avg_salary) / av.avg_salary * 100 AS pct_diff
FROM department_wise_total_sal as ts
JOIN department_wise_avg_sal as av 
ON ts.total_salary > av.avg_salary;
									
-- 6)Latest Joining Employees per Department
-- Write a CTE that finds the most recently joined employee in each department.

 















-- 7)Running Total of Salaries
-- Use a CTE with SUM() OVER (ORDER BY JoinDate) to calculate cumulative salary expense over time.

WITH RunningSalary AS (
    SELECT 
        EmployeeID,
        EmployeeName,
        Salary,
        JoinDate,
        SUM(Salary) OVER (ORDER BY JoinDate ASC) AS RunningTotalSalary
    FROM ctes
)
SELECT *
FROM RunningSalary
ORDER BY JoinDate ASC;

-- 8)Employees Without Managers
--   Create a CTE to list employees who don’t have a ManagerID assigned.

-- 9)Identify Salary Gaps in Department
--   Use a CTE to find the difference between the highest and lowest salary within each department. '''

WITH maximum_salary as (
						SELECT MAX(Salary) as max_sal from ctes),
	 minimum_salary as (
                        SELECT MIN(Salary) as min_sal from ctes)
                        
SELECT 	min_sal,
		max_sal,
        (max_sal - min_sal) as Salary_gap
FROM maximum_salary,minimum_salary;



















