/*
-- UNION: Employees in dept 1 OR dept 2
SELECT EmpID, EmpName FROM Employees WHERE DeptID = 1
UNION
SELECT EmpID, EmpName FROM Employees WHERE DeptID = 2;

-- UNION ALL: show duplicates
SELECT EmpID, EmpName FROM Employees WHERE DeptID = 1
UNION ALL
SELECT EmpID, EmpName FROM Employees WHERE DeptID = 2;
*/

#Employees from multiple departments

#Projects from IT and HR

#Assigned employees and unassigned

#Managers and subordinates list

#Top-level employees and project leaders

#Combine HR and Finance employee list

#Duplicate entries with UNION ALL

#Compare UNION vs UNION ALL on duplicates

#Employees with assignment vs without

#Project names vs department names (same structure, diff meaning)

