
  /* INNER, FULL, LEFT, RIGHT, OUTER JOINS
  */

  SELECT *
  FROM EmployeeDemographics

  SELECT *
  FROM EmployeeSalary

  -- INNER JOIN
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
INNER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- FULL OUTER
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
FULL OUTER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- LEFT	OUTER JOIN
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
LEFT OUTER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- RIGHT OUTER JOIN
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
RIGHT OUTER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT
	EmployeeDemographics.EmployeeID,
	FirstName,
	LastName,
	Salary
FROM SQLTutorial.dbo.EmployeeDemographics
INNER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT JobTitle, AVG(Salary) AS AvgSalary
FROM SQLTutorial.dbo.EmployeeDemographics
INNER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

/* UNION, UNION ALL
*/

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
UNION
SELECT * 
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
UNION ALL
SELECT * 
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics
ORDER BY Employeeid

/* CASE Statement
*/

--SELECT FirstName, LastName, Age,
--CASE 
--	WHEN Age > 30 THEN 'Old'
--	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
--	ELSE 'Baby'
--END
--FROM SQLTutorial.dbo.EmployeeDemographics
--WHERE Age IS NOT NULL
--ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary,
CASE 
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
	ELSE Salary + (Salary * 0.3)
END AS SalaryAfterRaise
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

| FirstName | LastName   | JobTitle           | Salary | SalaryAfterRaise |
| --------- | ---------- | ------------------ | ------ | ---------------- |
| Jim       | Halpert    | Salesman           | 45000  | 49500            |
| Pam       | Beasley    | Receptionist       | 36000  | 46800            |
| Dwight    | Schrute    | Salesman           | 63000  | 69300            |
| Angela    | Martin     | Accountant         | 47000  | 49350            |
| Toby      | Flenderson | HR                 | 50000  | 50000.05         |
| Michael   | Scott      | Regional Manager   | 65000  | 84500            |
| Meredith  | Palmer     | Supplier Relations | 41000  | 53300            |
| Stanley   | Hudson     | Salesman           | 48000  | 52800            |
| Kevin     | Malone     | Accountant         | 42000  | 44100            |

/* HAVING Clause
*/

SELECT JobTitle, COUNT(JobTitle) AS JobTitleCount
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

| JobTitle   | JobTitleCount |
| ---------- | ------------- |
| Accountant | 2             |
| Salesman   | 3             |

SELECT JobTitle, Avg(Salary) AS AvgSalary
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING Avg(Salary) > 45000
ORDER BY Avg(Salary)

| JobTitle         | AvgSalary |
| ---------------- | --------- |
| HR               | 50000     |
| Salesman         | 52000     |
| Regional Manager | 65000     |

/* Updating/Deleting Data
*/

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

DELETE FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1005

/* Aliasing
*/

SELECT FirstName + ' ' + LastName AS FullName
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT AVG(Age) AS AvgAge
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT Demo.EmployeeID, Sal.Salary
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID

/* Partition By
*/

SELECT FirstName, LastName, Gender, Salary, 
	COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
-- Allows for all desired columns to be in the output while keeping an aggregation function

| FirstName | LastName | Gender | Salary | TotalGender |
| --------- | -------- | ------ | ------ | ----------- |
| Pam       | Beasley  | Female | 36000  | 3           |
| Angela    | Martin   | Female | 47000  | 3           |
| Meredith  | Palmer   | Female | 41000  | 3           |
| Jim       | Halpert  | Male   | 45000  | 5           |
| Stanley   | Hudson   | Male   | 48000  | 5           |
| Kevin     | Malone   | Male   | 42000  | 5           |
| Michael   | Scott    | Male   | 65000  | 5           |
| Dwight    | Schrute  | Male   | 63000  | 5           |

SELECT Gender, COUNT(Gender)
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY Gender
-- Rolls up what is being queried without seeing other columns that maybe selected
