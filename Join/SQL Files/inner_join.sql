use join_in_sql;

select * from  employees;
select * from  assignments ;
select * from  departments;
select * from  projects;

#Employees with assigned departments
SELECT e.DeptID,e.EmpName,d.DeptName
FROM employees e
join departments d
on d.DeptID = e.DeptID;

#Employees with project assignments
SELECT e.EmpID,e.EmpName,a.ProjID,p.ProjName,a.HoursWorked
FROM employees e
join assignments a on a.EmpID = e.EmpID
join projects p on p.ProjID = a.ProjID;

#Projects with departments
SELECT d.DeptID,d.DeptName,p.ProjID,p.ProjName
FROM departments d
JOIN projects p
ON d.DeptID = p.DeptID;

#Employees with assignments and project names
SELECT e.EmpID,e.EmpName,a.ProjID,p.ProjName,a.HoursWorked
FROM employees e
join assignments a on a.EmpID = e.EmpID
join projects p on p.ProjID = a.ProjID;

#Managers and subordinates
SELECT e1.EmpName as subordinate , e2.EmpName as manager_name
FROM employees e1
JOIN employees e2
ON e2.EmpID = e1.ManagerID;

#Projects worked on by IT department employees
SELECT DISTINCT 
    p.ProjID,
    p.ProjName,
    e.EmpName,
    d.DeptName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
JOIN Assignments a ON a.EmpID = e.EmpID
JOIN Projects p ON p.ProjID = a.ProjID
WHERE d.DeptName = 'IT';
 

#Assignments with > 20 hours
select 
		e.EmpID,
        e.EmpName,
        a.ProjID,
        a.HoursWorked
from employees e
join assignments a
on a.EmpID = e.EmpID 
where a.HoursWorked > 20;


#Employees working on same dept’s projects
select
	e.EmpName,d.DeptName,p.ProjName,d.DeptID
from employees e
join departments d on e.DeptID = d.DeptID
join projects p on p.DeptID = d.DeptID
order by d.DeptID;


#Employees with manager and project
SELECT 
    e1.EmpName AS employee_name,
    e2.EmpName AS manager_name,
    p.ProjName AS project
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.EmpID
JOIN Assignments a ON e1.EmpID = a.EmpID
JOIN Projects p ON a.ProjID = p.ProjID;


#Common records between Employees & Assignments
select 
		e.EmpID,
        e.EmpName,
        e.DeptID,
        a.ProjID,
        a.HoursWorked
from employees e
join assignments a 
on a.EmpID = e.EmpID;