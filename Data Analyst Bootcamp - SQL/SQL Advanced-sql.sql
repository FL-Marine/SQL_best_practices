/* CTEs
*/

WITH CTE_Employee AS
(SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQLTutorial.dbo.EmployeeDemographics AS Emp
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Emp.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee

| FirstName | LastName | Gender | Salary | TotalGender | AvgSalary |
| --------- | -------- | ------ | ------ | ----------- | --------- |
| Angela    | Martin   | Female | 47000  | 1           | 47000     |
| Stanley   | Hudson   | Male   | 48000  | 3           | 58666     |
| Michael   | Scott    | Male   | 65000  | 3           | 58666     |
| Dwight    | Schrute  | Male   | 63000  | 3           | 58666     |

WITH CTE_Employee AS
(SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQLTutorial.dbo.EmployeeDemographics AS Emp
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Emp.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee

| FirstName | AvgSalary |
| --------- | --------- |
| Angela    | 47000     |
| Stanley   | 58666     |
| Michael   | 58666     |
| Dwight    | 58666     |

/* Temp Tables
*/

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

SELECT *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES (
'1001', 'HR', '45000'
)

INSERT INTO #temp_Employee
SELECT *
FROM SQLTutorial..EmployeeSalary
-- Took all of the data from EmployeeSalary and stuck it in this table

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics AS Emp
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Emp.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT * 
FROM #Temp_Employee2

| JobTitle           | EmployeesPerJob | AvgAge | AvgSalary |
| ------------------ | --------------- | ------ | --------- |
| Accountant         | 2               | 31     | 44500     |
| Receptionist       | 1               | 30     | 36000     |
| Regional Manager   | 1               | 35     | 65000     |
| Salesman           | 3               | 32     | 52000     |
| Supplier Relations | 1               | 32     | 41000     |


/* String Functions
*/

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- TRIM, LTRIM, RTRIM

SELECT EmployeeID, TRIM(EmployeeID) AS ID_Trim
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS ID_Trim
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS ID_Trim
FROM EmployeeErrors

-- REPLACE

Select LastName, REPLACE(LastName, '- Fired','') AS LastNameFixed
From EmployeeErrors

| LastName           | LastNameFixed |
| ------------------ | ------------- |
| Halbert            | Halbert       |
| Beasely            | Beasely       |
| Flenderson - Fired | Flenderson    |

-- SUBSTRING

Select FirstName, SUBSTRING(FirstName,1,3)
--Taking the first letter or number and going forward 3 spots
From EmployeeErrors

| FirstName | (No column name) |
| --------- | ---------------- |
| Jimbo     | Jim              |
| Pamela    | Pam              |
| TOby      | TOb              |

-- Fuzzy Match

SELECT err.FirstName, SUBSTRING(err.FirstName,1,3), dem.FirstName, SUBSTRING(dem.FirstName,1,3)
FROM EmployeeErrors AS err
JOIN EmployeeDemographics AS dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)
	
| FirstName | (No column name) | FirstName | (No column name) |
| --------- | ---------------- | --------- | ---------------- |
| Jimbo     | Jim              | Jim       | Jim              |
| Pamela    | Pam              | Pam       | Pam              |

-- Do fuzzy match on Gender, LastName, AGE, DOB ideally

-- UPPER & LOWER

Select FirstName, UPPER(FirstName)
From EmployeeErrors

Select FirstName, LOWER(FirstName)
From EmployeeErrors

CREATE PROCEDURE TEST
AS 
SELECT *
FROM EmployeeDemographics

EXEC TEST
-- EXEC means execute

CREATE PROCEDURE Temp_Employee3
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

SELECT *
FROM #temp_employee

EXEC Temp_Employee3

| JobTitle           | EmployeesPerJob | AvgAge | AvgSalary |
| ------------------ | --------------- | ------ | --------- |
| Accountant         | 2               | 31     | 44500     |
| Receptionist       | 1               | 30     | 36000     |
| Regional Manager   | 1               | 35     | 65000     |
| Salesman           | 3               | 32     | 52000     |
| Supplier Relations | 1               | 32     | 41000     |

-- Altering Stored Procedures
USE [SQLTutorial]
GO
/****** Object:  StoredProcedure [dbo].[Temp_Employee3]    Script Date: 5/16/2023 1:27:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Temp_Employee3]
@JobTitle nvarchar(100)
--This is what is being altered^

-- Adding a specifc input to the stored procedure to get back a specific result

AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
WHERE JobTitle = @JobTitle
--This is what is being altered^
group by JobTitle

SELECT *
FROM #temp_employee

EXEC Temp_Employee3 @JobTitle = 'Salesman'
-- This runs the updated stored procedure^ 

| JobTitle | EmployeesPerJob | AvgAge | AvgSalary |
| -------- | --------------- | ------ | --------- |
| Salesman | 3               | 32     | 52000     |

/* Subqueries (in the SELECT, FROM, and WHERE statements
*/

SELECT *
FROM EmployeeSalary

-- Subquery in SELECT

SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAverageSalary
FROM EmployeeSalary
-- Showing the avg salary for each employee and everyone

| EmployeeID | Salary | (No column name) |
| ---------- | ------ | ---------------- |
| 1001       | 45000  | 48555            |
| 1002       | 36000  | 48555            |
| 1003       | 63000  | 48555            |
| 1004       | 47000  | 48555            |
| 1005       | 50000  | 48555            |
| 1006       | 65000  | 48555            |
| 1007       | 41000  | 48555            |
| 1008       | 48000  | 48555            |
| 1009       | 42000  | 48555            |

-- Why GROUP BY doesn't work

SELECT EmployeeID, Salary, AVG(Salary) AS AllAverageSalary
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1,2
	-- Can't get AllAverage salary because there is a GROUP BY on EmployeeID & Salary
	
| EmployeeID | Salary | AllAverageSalary |
| ---------- | ------ | ---------------- |
| 1001       | 45000  | 45000            |
| 1002       | 36000  | 36000            |
| 1003       | 63000  | 63000            |
| 1004       | 47000  | 47000            |
| 1005       | 50000  | 50000            |
| 1006       | 65000  | 65000            |
| 1007       | 41000  | 41000            |
| 1008       | 48000  | 48000            |
| 1009       | 42000  | 42000            |

-- Subquery in FROM

SELECT a.EmployeeId, AllAverageSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAverageSalary
	FROM EmployeeSalary) AS a
	-- Going to create table and allow for query off of it

| EmployeeId | AllAverageSalary |
| ---------- | ---------------- |
| 1001       | 48555            |
| 1002       | 48555            |
| 1003       | 48555            |
| 1004       | 48555            |
| 1005       | 48555            |
| 1006       | 48555            |
| 1007       | 48555            |
| 1008       | 48555            |
| 1009       | 48555            |

-- Subquery in WHERE

SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
	-- Only want to return employess older than 30
	-- Age column is in EmployeeDemographics table can either JOIN to get that info or use subquery
WHERE EmployeeID IN (
		SELECT EmployeeID 
		FROM EmployeeDemographics
		WHERE Age > 30)
	-- In subquery only can have 1 column selected
	-- If Age column is desired in output will need to do a JOIN and include in SELECT statement

| EmployeeID | JobTitle           | Salary |
| ---------- | ------------------ | ------ |
| 1004       | Accountant         | 47000  |
| 1006       | Regional Manager   | 65000  |
| 1007       | Supplier Relations | 41000  |
| 1008       | Salesman           | 48000  |
| 1009       | Accountant         | 42000  |
