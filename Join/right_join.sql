#All departments and their employees
select 
		d.DeptID,
        d.DeptName,
        e.EmpName
from employees e 
right join departments d 
on d.DeptID = e.DeptID;

#All projects and their owners
select p.ProjID,p.ProjName,e.EmpName
from employees e 
right join assignments a on a.EmpID = e.EmpID 
right join projects p on p.ProjID = a.ProjID;



#All employees (even if not assigned) and project assignment
select 
		e.EmpName,
        a.ProjID,
        p.ProjName,
        a.HoursWorked
from projects p 
right join assignments a on a.ProjID=p.ProjID
right join employees e on e.EmpID = a.EmpID;

SELECT 
    e.EmpName,
    a.ProjID,
    p.ProjName,
    a.HoursWorked
FROM Assignments a
RIGHT JOIN Employees e ON e.EmpID = a.EmpID
LEFT JOIN Projects p ON p.ProjID = a.ProjID;


#Projects and departments (even if dept is missing)
select 
		p.ProjID,
        p.ProjName,
        d.DeptName
from departments d 
right join projects p 
on p.DeptID = d.DeptID;

#All assignments with or without matching employee
select 
		a.ProjID,
        a.HoursWorked,
        e.EmpName
from employees e 
right join assignments a 
on a.EmpID = e.EmpID;

#Subordinates even if they don't have manager entry
select 
	e2.EmpName as employee ,
    e1.EmpName as manager
from employees e1 
right join employees e2 
on e1.EmpID = e2.ManagerID;

#All employees who report to someone
select 
	e2.EmpName as employee ,
    e1.EmpName as manager
from employees e1 
right join employees e2 
on e1.EmpID = e2.ManagerID;

#All projects regardless of employees
select 
		p.ProjID,
        p.ProjName,
        e.EmpName
from assignments a
left join employees e on e.EmpID = a.EmpID
right join projects p on p.ProjID = a.ProjID;

#All departments even if no employees assigned
select 
	d.DeptID,
    d.DeptName,e.EmpName
from employees e 
right join departments d 
on d.DeptID = e.DeptID;

#Employees with or without project
select 
		e.EmpID,
        e.EmpName,
        p.ProjName
from assignments a 
left join projects p on p.ProjID = a.ProjID 
right join employees e on e.EmpID = a.EmpID;
