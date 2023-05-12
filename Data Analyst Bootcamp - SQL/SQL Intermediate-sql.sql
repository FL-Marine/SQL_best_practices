
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



