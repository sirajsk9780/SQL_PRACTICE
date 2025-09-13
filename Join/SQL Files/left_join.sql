#All employees with department names
select 
		e.EmpID,
        e.EmpName,
        d.DeptName
from employees e
left join departments d
on d.DeptID = e.DeptID;

#All projects and their departments
select 
	p.ProjID,
    p.ProjName,
    d.DeptName
from projects p
left join departments d
on d.DeptID = p.DeptID;

#All employees and their assigned projects (if any)
select 
		e.EmpID,
        e.EmpName,
        a.ProjID,
        p.ProjName
from employees e
left join assignments a on a.EmpID = e.EmpID
left join projects p on p.ProjID = a.ProjID ; 

#List all employees and who they report to (even if no manager)
SELECT e1.EmpName as subordinate , e2.EmpName as manager_name
FROM employees e1
LEFT JOIN employees e2
ON e2.EmpID = e1.ManagerID;

#All assignments including those with no matching employee
select 
		a.ProjID,
        a.HoursWorked,
        e.EmpName
from assignments a
left join employees e 
on e.EmpID = a.EmpID;

#All departments and their employees
select 
		d.DeptID,d.DeptName,e.EmpName
FROM departments d
left join employees e
on e.DeptID = d.DeptID;

#Employees with or without any assignments
select 
		e.EmpID,
        e.EmpName,
		a.ProjID,
        a.HoursWorked
from employees e
left join assignments a
on e.EmpID = a.EmpID;

#Projects with or without employees
select 
		p.ProjID,
        p.ProjName,
        e.EmpName
from projects p
left join assignments a on a.ProjID = p.ProjID
left join employees e on e.EmpID = a.EmpID; 

#Managers and their subordinates (some may have none)
select 
		e1.EmpName as manager,
        e2.EmpName as employee
from employees e1
left join employees e2
on e1.EmpID = e2.ManagerID;

#Employees and departments (some with null dept)
select 
		e.EmpName,
        d.DeptName
from employees e 
left join departments d 
on d.DeptID = e.DeptID;