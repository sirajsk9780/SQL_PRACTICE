
select * from employee_attendance;

-- 📅 Date-based Questions

-- Find the tenure (in years and months) of each employee from Hire_Date till Report_Date.

SELECT  
		emp_id,
        CONCAT(
        TIMESTAMPDIFF(YEAR, Hire_Date, attendance_date), ' years ',
        TIMESTAMPDIFF(MONTH, Hire_Date, attendance_date) % 12, ' months'
    ) AS Tenure
FROM employee_attendance;

-- Get the employees hired before 2022.
SELECT *
FROM employee_attendance
WHERE YEAR(Hire_Date) < 2022;

-- Find employees who completed more than 2 years in the company by the Report_Date.

SELECT * 
FROM employee_attendance
WHERE timestampdiff(YEAR,Hire_Date, attendance_date) > 2;

-- Extract the day of week (e.g., Monday, Tuesday) of each employee’s Hire_Date.
SELECT emp_id,
	   emp_name,
       Hire_Date,
	   dayname(Hire_Date) as dname
from employee_attendance;

-- Get the month name of each employee’s Hire_Date.
SELECT emp_id,
	   emp_name,
       Hire_Date,
	   monthname(Hire_Date) as mname
from employee_attendance;

-- .🕒 Time-based Questions

-- Calculate the working hours for each employee on their Login and Logout times.
select  
		emp_id,
		emp_name,
        login_time,
        logout_time,
        timestampdiff(hour,login_time,logout_time) working_hours
from employee_attendance;

-- Find employees who worked more than 8 hours in a day.
select  
		emp_id,
		emp_name,
        login_time,
        logout_time,
        timestampdiff(hour,login_time,logout_time) working_hours
from employee_attendance
where timestampdiff(hour,login_time,logout_time) > 8;

-- Extract the hour of login for each employee.
select  
		emp_id,
		emp_name,
        login_time,
        logout_time,
        hour(login_time) as login_hour
from employee_attendance;

-- Find who logged in before 9:00 AM.
select  
		emp_id,
		emp_name,
        login_time,
        logout_time,
        hour(login_time) as login_hour
from employee_attendance
where  hour(login_time) < 9;

-- Find who logged out after 6:00 PM.
select  
		emp_id,
		emp_name,
        login_time,
        logout_time,
        hour(login_time) as login_hour
from employee_attendance
where  hour(logout_time)%12 > 6;

-- 🔀 Combined Date & Time

-- Calculate the age of an employee in days at the time of Report_Date.
SELECT 
    emp_id,
	emp_name,
    login_time,
    logout_time,
    timestampdiff(minute,login_time,logout_time) AS Age_in_Days
FROM employee_attendance;


-- Find the total minutes worked between Login and Logout.
SELECT 
    emp_id,
	emp_name,
    Hire_Date,
    attendance_date,
    DATEDIFF(attendance_date, Hire_Date) AS Age_in_Days
FROM employee_attendance;

-- Get employees who worked on a Friday (based on Report_Date).
SELECT 
    emp_id,
	emp_name,
	dayname(attendance_date) Name_of_Data
FROM employee_attendance
WHERE dayname(attendance_date) = 'Friday';


-- Find the difference in days between Hire_Date and Report_Date.
SELECT 
    emp_id,
	emp_name,
    Hire_Date,
    attendance_date,
    timestampdiff(day, Hire_Date,attendance_date) AS Diff_Days
FROM employee_attendance;

-- Find the earliest login time and latest logout time for each department.
SELECT 
    emp_id,
	emp_name,
    login_time,
    logout_time   
FROM employee_attendance
order by login_time,logout_time;


-- ⭐ Advanced (Window + Date Functions)

-- Rank employees based on their working hours on each Report_Date.
select 
		emp_id,
        emp_name,
        attendance_date,
        login_time,
        logout_time,
        timestampdiff(hour , login_time, logout_time) as working_hour,
        DENSE_RANK() OVER(PARTITION BY attendance_date order by timestampdiff(hour , login_time, logout_time) desc) as Ranking
from employee_attendance;

-- Find the average working hours of each department.
select 
		emp_id,
        emp_name,
        attendance_date,
        department,
        login_time,
        logout_time,
        timestampdiff(hour , login_time, logout_time) as working_hour,
        AVG(timestampdiff(hour , login_time, logout_time)) OVER(PARTITION BY department ) as avg
from employee_attendance;

SELECT 
    department,
    AVG(TIMESTAMPDIFF(HOUR, login_time, logout_time)) AS avg_working_hours
FROM employee_attendance
GROUP BY department;


-- Calculate the cumulative working hours of each employee across all Report_Dates.
SELECT 
    emp_id,
    emp_name,
    attendance_date,
    TIMESTAMPDIFF(HOUR, login_time, logout_time) AS working_hour,
    SUM(TIMESTAMPDIFF(HOUR, login_time, logout_time)) 
        OVER (PARTITION BY emp_id ORDER BY attendance_date) AS cumulative_hours
FROM employee_attendance;

-- Get the longest serving employee (max difference between Hire_Date and Report_Date).
SELECT 
    emp_id,
	emp_name,
    Hire_Date,
    attendance_date,
    timestampdiff(day, Hire_Date,attendance_date) AS Diff_Days
FROM employee_attendance
ORDER BY Diff_Days desc
Limit 1;

-- Find employees who worked overtime (more than 9 hours).
SELECT 
    emp_id,
	emp_name,
    login_time,
    logout_time,
    timestampdiff(hour,login_time,logout_time) AS Age_in_Days
FROM employee_attendance
where (timestampdiff(hour,login_time,logout_time)) >= 9;