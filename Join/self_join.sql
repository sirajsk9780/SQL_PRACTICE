#Find employee and their manager names
select e1.EmpName as employee,e2.EmpName as manager
from employees e1
left join employees e2
on e1.ManagerID=e2.EmpID;

#Who reports to whom
select 
		e1.EmpName as employee,
        e2.EmpName as report_to
from employees e1
join employees e2
on e2.EmpID = e1.ManagerID;


#All employees in same department
select 
		e1.EmpID as emp_e1_id,
        e1.EmpName as emp_e1_name,
        e2.EmpID as emp_e2_id,
		e2.EmpName as emp_e2_name,
        e1.DeptID
from employees e1 
join employees e2
on e1.DeptID = e2.DeptID
where e1.EmpID<e2.EmpID;


#Find top-level employees (no manager)
SELECT e1.EmpID, e1.EmpName
FROM Employees e1
LEFT JOIN Employees e2 ON e1.ManagerID = e2.EmpID
WHERE e2.EmpID IS NULL;

#Count number of subordinates each manager has
SELECT 
    e1.EmpID AS ManagerID,
    e1.EmpName AS ManagerName,
    COUNT(e2.EmpID) AS SubordinateCount
FROM Employees e1
JOIN Employees e2 ON e2.ManagerID = e1.EmpID
GROUP BY e1.EmpID, e1.EmpName;


#Find employees in same team (same manager)
SELECT 
    e1.EmpName AS Employee1,
    e2.EmpName AS Employee2,
    m.EmpName AS Manager
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID AND e1.EmpID < e2.EmpID
JOIN Employees m ON m.EmpID = e1.ManagerID;


#Peer employees (same department and same manager)
SELECT 
    e1.EmpID AS employee_id,
    e1.EmpName AS employee_name,
    e2.EmpID AS peer_id,
    e2.EmpName AS peer_name,
    e1.DeptID,
    e1.ManagerID
FROM employees e1
JOIN employees e2 
    ON e1.DeptID = e2.DeptID 
   AND e1.ManagerID = e2.ManagerID
   AND e1.EmpID <> e2.EmpID;

#Employee with same dept and same manager

#Chain of management
WITH RECURSIVE org_chart AS (
    SELECT emp_id, name, manager_id, CAST(name AS CHAR) AS path, 1 AS level
    FROM employees
    WHERE manager_id IS NULL  -- Start from top manager (like CEO)

    UNION ALL

    SELECT e.emp_id, e.name, e.manager_id,
           CONCAT(oc.path, ' → ', e.name), oc.level + 1
    FROM employees e
    JOIN org_chart oc ON e.manager_id = oc.emp_id
)
SELECT * FROM org_chart
ORDER BY path;

#Employees who are managers
SELECT DISTINCT m.EmpID, m.EmpName
FROM employees e
JOIN employees m ON e.ManagerID = m.EmpID;
