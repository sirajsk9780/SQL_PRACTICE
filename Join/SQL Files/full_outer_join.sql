/*(Use UNION of LEFT + RIGHT JOINs for MySQL, since FULL JOIN not supported natively)

-- Example
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
LEFT JOIN Departments d ON e.DeptID = d.DeptID
UNION
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
RIGHT JOIN Departments d ON e.DeptID = d.DeptID;
Practice full join to find:*/

#All employees and departments (even unmatched)
select 
		e.EmpID, e.EmpName, d.DeptName
from employees e 
left join departments d
on d.DeptID = e.DeptID 
union all  
select
		e.EmpID, e.EmpName, d.DeptName
from employees e 
right join departments d
on d.DeptID=e.DeptID;

#All projects and departments (even unmatched)


#All employees and their manager names

#All employees and their projects (even if one side is missing)

#All departments and employees (regardless of match)

#Employees with/without department + departments with/without employees

#All assignments regardless of employee or project match
-- Part 1: All assignments with employee and project info
SELECT 
    a.EmpID,
    e.EmpName,
    a.ProjID,
    p.ProjName,
    a.HoursWorked
FROM Assignments a
LEFT JOIN Employees e ON a.EmpID = e.EmpID
LEFT JOIN Projects p ON a.ProjID = p.ProjID

UNION

-- Part 2: Projects with no matching assignments
SELECT 
    NULL AS EmpID,
    NULL AS EmpName,
    p.ProjID,
    p.ProjName,
    NULL AS HoursWorked
FROM Projects p
WHERE p.ProjID NOT IN (SELECT ProjID FROM Assignments)

UNION

-- Part 3: Employees with no matching assignments
SELECT 
    e.EmpID,
    e.EmpName,
    NULL AS ProjID,
    NULL AS ProjName,
    NULL AS HoursWorked
FROM Employees e
WHERE e.EmpID NOT IN (SELECT EmpID FROM Assignments);


#Combine unmatched departments/projects/employees

#Full mapping of projects to employees

#Who is not mapped anywhere