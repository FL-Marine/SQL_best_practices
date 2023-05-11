
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


