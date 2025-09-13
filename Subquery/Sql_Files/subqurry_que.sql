#🔍 Subquery Practice Questions

select * from departments;
select * from employees;



#🔹 Beginner Level
#Find employees who earn more than the average salary.
select 
		EmpID,EmpName,Salary
from employees
where Salary >(select avg(Salary) from employees);

#List employees who work in the same department as ‘Bob’.
select
		EmpName,DeptID
from employees 
where DeptID = (select DeptID
				from employees
                where EmpName = 'Bob');

#Find the highest salary in each department.

select DeptID,max(Salary)
 from employees
 group by DeptID;
 
 SELECT e.EmpName,e.Salary
FROM Employees e
WHERE (e.DeptID, e.Salary) IN (
    SELECT DeptID, MAX(Salary)
    FROM Employees
    GROUP BY DeptID
);



#List all managers (employees who have others reporting to them).
select * from employees
where EmpID in
(select distinct ManagerID from employees WHERE ManagerID IS NOT NULL);

#Get the names of employees who joined before their manager.
SELECT EmpName
FROM employees e
WHERE HireDate < (
    SELECT HireDate
    FROM Employees
    WHERE EmpID = e.ManagerID
);

#Find departments that have no employees
select e.EmpName,d.DeptName
from departments d 
left join employees e 
on e.DeptID = d.DeptID
where e.EmpName IS null;

SELECT d.DeptName
FROM departments d
WHERE NOT EXISTS ( SELECT 1
					FROM employees e
                    WHERE e.DeptID = d.DeptID);

SELECT d.DeptName 
FROM departments d
WHERE d.DeptID NOT IN ( SELECT DISTINCT e.DeptID
						FROM employees e
                        WHERE e.DeptID is NOT NULL);


#🔹 Intermediate Level
#Find employees whose salary is higher than any employee in the HR department.
SELECT EmpID,
	   EmpName,
       Salary,
       DeptID
FROM employees 
where Salary > ANY(SELECT Salary 
				   FROM employees 
				   WHERE (SELECT DeptID 
						  FROM departments
                          WHERE DeptName = 'HR')
					) and DeptID != 2;

#Get the name of the employee(s) with the second highest salary.
SELECT EmpName,Salary
FROM employees
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;

SELECT *
FROM employees 
where salary = ( SELECT max(Salary)
				 FROM employees 
                 WHERE Salary < (SELECT max(Salary)
								 FROM employees));

#List employees who are not managers.
SELECT EmpID,EmpName
FROM employees 
where EmpID  NOT in (SELECT DISTINCT ManagerID 
					  FROM employees 
					  WHERE ManagerID IS NOT NULL);


#Find employees who have the same salary as someone else.
SELECT e1.EmpID, e1.EmpName, e1.Salary
FROM employees e1
WHERE e1.Salary IN (
    SELECT Salary
    FROM employees
    GROUP BY Salary
    HAVING COUNT(*) > 1
);

#Get employees who earn more than the department average salary.
SELECT *
FROM employees e1
Where Salary > (select avg(Salary)
				FROM employees e2
                WHERE e2.DeptID = e1.DeptID
);

#List employees hired after the average hire date.
SELECT * from employees where HireDate > 
(SELECT avg(HireDate) from employees);

/*🔍 Explanation:
UNIX_TIMESTAMP(HireDate) converts HireDate into the number of seconds since '1970-01-01'.

You can safely take the AVG() of that numeric value.

Then compare each employee’s hire date (in seconds) to the average.*/

SELECT * 
FROM employees 
WHERE UNIX_TIMESTAMP(HireDate) > (
    SELECT AVG(UNIX_TIMESTAMP(HireDate)) 
    FROM employees
);

#If you want to display the actual average hire date for reference:
SELECT 
    FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(HireDate))) AS AverageHireDate
FROM employees;

#Find departments where the maximum salary is above 80,000.
SELECT DISTINCT DeptID
FROM employees e1
Where 80000 < (select max(Salary)
				FROM employees e2
                WHERE e2.DeptID = e1.DeptID
);

SELECT DISTINCT e.DeptID , d.DeptName
FROM employees e
join departments d
on d.DeptID = e.DeptID
WHERE e.DeptID IN (
    SELECT DeptID
    FROM employees
    GROUP BY DeptID
    HAVING MAX(Salary) > 80000
);


#🔹 Advanced Level
#Find employees who earn more than their own manager.

select e.EmpID,e.EmpName,Salary
from employees e 
WHERE Salary > (
				SELECT Salary
                FROM employees
                WHERE EmpID = e.ManagerID
                );

#List all employees whose department has more than 2 employees.
SELECT *
FROM employees e
WHERE (
    SELECT COUNT(*)
    FROM employees
    WHERE DeptID = e.DeptID
) > 2;



#Get the departments where the total salary is higher than all others.
SELECT x.DeptID, x.TotalSalary
FROM (
    SELECT DeptID, SUM(Salary) AS TotalSalary
    FROM employees 
    GROUP BY DeptID
) AS x
ORDER BY x.TotalSalary DESC
LIMIT 1;




#List employees who earn the highest salary in their department.

#Find employees who do not share a department with any other employee.

#List managers who manage employees in more than one department.

#Find employees who joined in the same year as their manager.

#Get all employees who do not report to any manager (top-level).

#Find departments where all employees earn above 60,000.

#List employees who have the lowest salary in the company.

#Find employees whose salary is equal to the average salary of their department.

#Find all pairs of employees who work in the same department but are not the same person.

#Get employees who joined before all others in their department.

#Find departments where the sum of salaries is more than twice the average department salary sum.