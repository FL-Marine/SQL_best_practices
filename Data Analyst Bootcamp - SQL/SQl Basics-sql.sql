Table 1 Query:
Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Table 1 Insert:
Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Age]
      ,[Gender]
  FROM [SQLTutorial].[dbo].[EmployeeDemographics]
  
  | EmployeeID | FirstName | LastName   | Age | Gender |
| ---------- | --------- | ---------- | --- | ------ |
| 1001       | Jim       | Halpert    | 30  | Male   |
| 1002       | Pam       | Beasley    | 30  | Female |
| 1003       | Dwight    | Schrute    | 29  | Male   |
| 1004       | Angela    | Martin     | 31  | Female |
| 1005       | Toby      | Flenderson | 32  | Male   |
| 1006       | Michael   | Scott      | 35  | Male   |
| 1007       | Meredith  | Palmer     | 32  | Female |
| 1008       | Stanley   | Hudson     | 38  | Male   |
| 1009       | Kevin     | Malone     | 31  | Male   |
  
  
Table 2 Query:
Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)

Table 2 Insert:
Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [EmployeeID]
      ,[JobTitle]
      ,[Salary]
  FROM [SQLTutorial].[dbo].[EmployeeSalary]

| EmployeeID | JobTitle           | Salary |
| ---------- | ------------------ | ------ |
| 1001       | Salesman           | 45000  |
| 1002       | Receptionist       | 36000  |
| 1003       | Salesman           | 63000  |
| 1004       | Accountant         | 47000  |
| 1005       | HR                 | 50000  |
| 1006       | Regional Manager   | 65000  |
| 1007       | Supplier Relations | 41000  |
| 1008       | Salesman           | 48000  |
| 1009       | Accountant         | 42000  |

 /*
  Select Statement
  *, Top, Distinct, Count, As, Max, Min, Avg
  */

  -- SELECT evertthing 
  SELECT * 
  FROM EmployeeDemographics

  -- TOP 5 * 
  SELECT TOP 5 *
  FROM EmployeeDemographics

  -- DISTINCT
  SELECT DISTINCT(EmployeeID)
  FROM EmployeeDemographics

  -- COUNT
  SELECT COUNT(LastName) AS LastNameCount
  FROM EmployeeDemographics

  -- MAX
  SELECT MAX(Salary)
  FROM EmployeeSalary
  
  -- MIN
  SELECT MIN(Salary)
  FROM EmployeeSalary
  
  -- AVG
  SELECT AVG(Salary)
  FROM EmployeeSalary

  /* WHERE statement
  =, <>, <, >, AND, OR, LIKE, NULL, NOT NULL, IN
  */

  -- =
  SELECT * 
  FROM EmployeeDemographics
  WHERE FirstName = 'Jim'

  -- <> Not equal
  SELECT * 
  FROM EmployeeDemographics
  WHERE FirstName <> 'Jim'

  -- > greater than
  SELECT * 
  FROM EmployeeDemographics
  WHERE Age > 30

   -- >= greater than or equal to
  SELECT * 
  FROM EmployeeDemographics
  WHERE Age >= 30

  -- < less than
  SELECT * 
  FROM EmployeeDemographics
  WHERE Age < 32

   -- <= less than or equal to
  SELECT * 
  FROM EmployeeDemographics
  WHERE Age <= 32

  -- <= less than or equal to AND
  SELECT * 
  FROM EmployeeDemographics
  WHERE Age <= 32 AND Gender = 'Male'

  -- <= less than or equal to & OR 
  SELECT * 
  FROM EmployeeDemographics
  WHERE Age <= 32 OR Gender = 'Male'

  -- LIKE % = wild card
  SELECT * 
  FROM EmployeeDemographics
  WHERE LastName LIKE 'S%'

  -- LIKE % = wild card
  SELECT * 
  FROM EmployeeDemographics
  WHERE LastName LIKE '%S%'
  -- LIKE '%S%' searching for the letter 'S' anywhere in their name

  -- LIKE % = wild card
  SELECT * 
  FROM EmployeeDemographics
  WHERE LastName LIKE 'S%o%'
  -- Searching for letters 'S' & 'O'

  -- NULL 
  SELECT * 
  FROM EmployeeDemographics
  WHERE FirstName IS NULL

  -- NOT NULL
  SELECT * 
  FROM EmployeeDemographics
  WHERE FirstName IS NOT NULL

  -- IN - condensed way to say equal for multiple things
  SELECT * 
  FROM EmployeeDemographics
  WHERE FirstName IN ('Jim', 'Michael')

  /* GROUP BY, ORDER BY
  */

  -- GROUP BY
  SELECT Gender, COUNT(Gender) AS CountGender
  FROM EmployeeDemographics
  WHERE Age > 31
  GROUP BY Gender
  ORDER BY CountGender DESC

  -- ORDER BY
  SELECT * 
  FROM EmployeeDemographics
  ORDER BY Age DESC, Gender DESC
