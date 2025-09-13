create database subquerry;
use subquerry;


CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100)
);

INSERT INTO Departments VALUES
(1, 'Engineering', 'New York'),
(2, 'HR', 'Chicago'),
(3, 'Marketing', 'San Francisco'),
(4, 'Finance', 'Boston');

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Salary DECIMAL(10,2),
    DeptID INT,
    ManagerID INT,
    HireDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Employees VALUES
(101, 'Alice', 80000, 1, NULL, '2015-01-01'),
(102, 'Bob', 60000, 1, 101, '2016-05-15'),
(103, 'Charlie', 65000, 1, 101, '2017-07-23'),
(104, 'David', 55000, 2, 106, '2018-09-12'),
(105, 'Eva', 75000, 3, 106, '2019-03-17'),
(106, 'Frank', 90000, 2, NULL, '2014-11-01'),
(107, 'Grace', 72000, 3, 105, '2020-02-01'),
(108, 'Hank', 67000, 4, 109, '2021-01-10'),
(109, 'Ivy', 95000, 4, NULL, '2013-06-11');

