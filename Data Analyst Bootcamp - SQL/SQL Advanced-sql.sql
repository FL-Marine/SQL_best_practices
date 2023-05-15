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

Select SUBSTRING(FirstName,1,3)
--Taking the first letter or number and going forward 3 spots
From EmployeeErrors

-- Fuzzy Match

SELECT err.FirstName, SUBSTRING(err.FirstName,1,3), dem.FirstName, SUBSTRING(dem.FirstName,1,3)
FROM EmployeeErrors AS err
JOIN EmployeeDemographics AS dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

-- Do fuzzy match on Gender, LastName, AGE, DOB ideally

-- UPPER & LOWER

Select FirstName, UPPER(FirstName)
From EmployeeErrors

Select FirstName, LOWER(FirstName)
From EmployeeErrors

