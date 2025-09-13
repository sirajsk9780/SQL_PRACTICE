-- 📅 MySQL DateTime Practice Questions

-- Show employees with hire_date in DD-Mon-YYYY format.
SELECT date_format(hire_date,'%d-%b-%y') as hire_date
from employee_attendance;

-- Extract day name and month name from attendance_date.
SELECT 
		date_format(hire_date,'%W') as Day_Name,
        date_format(hire_date,'%M') as Month_Name
from employee_attendance;

-- Find how many years and months each employee has worked till attendance_date.
SELECT  
		emp_id,
        CONCAT(
        TIMESTAMPDIFF(YEAR, Hire_Date, attendance_date), ' years ',
        TIMESTAMPDIFF(MONTH, Hire_Date, attendance_date) % 12, ' months'
    ) AS Tenure
FROM employee_attendance;

-- Show attendance_date in YYYY/MM/DD format.
SELECT date_format(attendance_date,'%y/%m/%d') as hire_date
from employee_attendance;

-- Find total working hours (logout_time – login_time) per employee.
SELECT 
		emp_name,
        concat(
		timestampdiff(hour,login_time,logout_time),' hours') as Total_work_hour
FROM employee_attendance;

-- Show working hours in minutes.
SELECT 
		emp_name,
        concat(
		timestampdiff(minute,login_time,logout_time),' minutes') as Total_work_minute
FROM employee_attendance;

-- Extract only the hour of login_time.
SELECT hour(login_time) hour_of_login_time
FROM employee_attendance;

-- Show if employee logged in before 9:00 AM (Early/Late).
SELECT emp_id,
       emp_name,
       login_time,
       IF(TIME(login_time) < '09:00:00', 'Early', 'Late') AS login_status
FROM employee_attendance;

-- Get the week number of attendance_date.
select week(attendance_date)
FROM employee_attendance;

-- Show attendance_date in Wed-01-Aug-2024 style.
select 
		date_format(attendance_date,'%a-%d-%b-%y')
FROM employee_attendance;

-- Find employees who logged out after 6:00 PM.
SELECT emp_id,
       emp_name,
       DATE_FORMAT(logout_time, '%h:%i %p') AS formatted_logout,
       IF(TIME(logout_time) > '18:00:00', 'After 6 PM', 'Before 6 PM') AS logout_status
FROM employee_attendance;

-- Display login_time in hh:mm AM/PM format.
SELECT emp_id,
       emp_name,
       DATE_FORMAT(login_time, '%h:%i %p') AS formatted_login
FROM employee_attendance;

-- Show the quarter of hire_date.
SELECT emp_id,
       emp_name,
       quarter(hire_date) Q
FROM employee_attendance;

-- Find difference in days between hire_date and attendance_date.
SELECT emp_id,
       emp_name,
       timestampdiff(day,hire_date,attendance_date) date_diff
FROM employee_attendance;

-- Get the last day of the month of hire_date.
SELECT emp_id,
       emp_name,
       hire_date,
       LAST_DAY(hire_date) AS last_day_of_month
FROM employee_attendance;

-- Extract the month number from attendance_date.
SELECT emp_id,
       emp_name,
       attendance_date,
       date_format(attendance_date,'%m') month_number
FROM employee_attendance;

-- Show employees with hire_date in YYYY-MM-DD (DayName) format.
SELECT emp_id,
       emp_name,
       attendance_date,
       date_format(hire_date,'%y-%m-%W') month_number
FROM employee_attendance;

-- Find average login time for each department.
SELECT department,
       time_format(SEC_TO_TIME(AVG(TIME_TO_SEC(login_time))),'%r') AS avg_login_time
FROM employee_attendance
GROUP BY department;

-- Count number of employees who attended on a Friday.
SELECT DAYNAME(attendance_date) AS dayn,
       COUNT(emp_id) AS tot_emp
FROM employee_attendance
WHERE DAYNAME(attendance_date) = 'Friday'
GROUP BY DAYNAME(attendance_date);


-- Show working hours rounded to 2 decimal hours.
SELECT emp_id,
       emp_name,
       ROUND(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600, 2) AS working_hours
FROM employee_attendance;
