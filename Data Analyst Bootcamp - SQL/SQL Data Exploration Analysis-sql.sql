select *
from CovidDeaths
order by 3,4

--select *
--from CovidVaccinations
--order by 3,4

-- Gather the data to be analyzed

SELECT
	Location,
	date,
	total_cases,
	new_cases,
	total_deaths,
	population
FROM CovidDeaths
ORDER BY Location, date

-- Total Cases vs Total Deaths

/*
SELECT
	Location,
	date,
	total_cases,
	total_deaths,
	(total_deaths/total_cases)*100
FROM CovidDeaths
ORDER BY Location, date
-- Get this error - Msg 8134, Level 16, State 1, Line 22
Divide by zero error encountered.
*/


SELECT
	Location,
	date,
	total_cases,
	total_deaths,
	CASE WHEN total_cases = 0 THEN NULL ELSE (total_deaths * 100.0 / NULLIF(total_cases, 0)) END AS death_percentage
FROM CovidDeaths
ORDER BY Location, date;
	-- This query shows how likely it is if you contract covid

-- Total cases vs population

SELECT
	Location,
	date,
	total_cases,
	population,
	CASE WHEN total_cases = 0 THEN NULL ELSE (total_cases * 100.0 / NULLIF(population, 0)) END AS population_percentage
FROM CovidDeaths
ORDER BY Location, date;
	-- Shows what % of population got covid

-- Countries with highest infection rate vs population
--	 This query will not run as the data is only 1k rows of United States
--SELECT
--	Location,
--	population,
--	MAX(total_cases) AS HightestInfectionCount,
--	CASE WHEN total_cases = 0 THEN NULL ELSE MAX((total_cases * 100.0 / NULLIF(population, 0))) END AS population_percentage
--FROM CovidDeaths
--WHERE location LIKE '%Cuba%'
--GROUP BY location, population, total_cases
--ORDER BY population_percentage DESC

-- Countries with highest death count per population

SELECT
	Location,
	MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
-- WHERE location LIKE '%Cuba%'
GROUP BY Location
ORDER BY TotalDeathCount DESC

SELECT
	Location,
	MAX(CAST(total_deaths AS int)) AS TotalDeathCount
	-- if #'s are an issue check data type if wrong type CAST as correct type
FROM CovidDeaths
-- WHERE location LIKE '%Cuba%'
GROUP BY Location
ORDER BY TotalDeathCount DESC


-- Breakdown by Contnent

----SELECT
----	continent,
----	MAX(CAST(total_deaths AS int)) AS TotalDeathCount
----	-- if #'s are an issue check data type if wrong type CAST as correct type
----FROM CovidDeaths
------ WHERE location LIKE '%Cuba%'
----WHERE continent IS NULL
----GROUP BY continent
----ORDER BY TotalDeathCount DESC

-- US Numbers

SELECT
	Location,
	date,
	SUM(total_cases) AS TotalNewCases,
	SUM(total_deaths) AS TotalNewDeaths,
	CASE WHEN total_cases = 0 THEN NULL ELSE (total_deaths * 100.0 / NULLIF(total_cases, 0)) END AS death_percentage
FROM CovidDeaths
GROUP BY Location, date, total_cases, total_deaths;

--- Joining covid vaccines tables
-- Total population vs vaccinated

SELECT *
FROM CovidDeaths AS Cdea
JOIN CovidVaccinations AS Cvac
	ON Cdea.location = Cvac.location
	AND Cdea.date = Cvac.date

SELECT 
	--Cdea.continent,
	--Cdea.location,
	Cdea.date,
	Cdea.population,
	Cvac.new_vaccinations
FROM CovidDeaths AS Cdea
JOIN CovidVaccinations AS Cvac
	ON Cdea.location = Cvac.location
	AND Cdea.date = Cvac.date
-- Vaccines started 2020-12-14 4,848 on this day

-- Showing new vaccinations per day
SELECT 
	Cdea.location,
	Cdea.date,
	Cdea.population,
	Cvac.new_vaccinations
	--SUM(CONVERT(int,Cvac.new_vaccinations)) OVER (PARTITION BY Cdea.date)
	-- CONVERT is like CAST function
FROM CovidDeaths AS Cdea
JOIN CovidVaccinations AS Cvac
	ON Cdea.location = Cvac.location
	AND Cdea.date = Cvac.date

-- CTE population vs vaccinated

WITH PopvsVac (location, date, population, new_vaccinations)
AS
(
SELECT 
	Cdea.location,
	Cdea.date,
	Cdea.population,
	Cvac.new_vaccinations
	--SUM(CONVERT(int,Cvac.new_vaccinations)) OVER (PARTITION BY Cdea.date)
	-- CONVERT is like CAST function
FROM CovidDeaths AS Cdea
JOIN CovidVaccinations AS Cvac
	ON Cdea.location = Cvac.location
	AND Cdea.date = Cvac.date
)
SELECT *
FROM PopvsVac

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
