USE PortfolioProject;

SELECT * FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
	ORDER BY location, date;

SELECT * FROM PortfolioProject..CovidVaccinations 
WHERE continent IS NOT NULL
	ORDER BY location, date;


--Selecting Data what we would be using

SELECT location, date, total_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
	ORDER BY location, date;


--Finding the % of Deaths out of the total_cases
--The Probability of dying if COVID spreads in your country

SELECT location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL AND location LIKE '%states%'
	ORDER BY location, date;


--Finding the % of Infected people out of the Population
--Shows what % of Population got attacked by COVID 19

SELECT location, date, total_cases, population, (total_cases/population)*100 AS PercentInfectedPop
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
--WHERE location LIKE '%states%'
	ORDER BY location, date;


--What countries have the highest infection rate out of the population?

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentInfectedPop
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
	GROUP BY location, population
	ORDER BY PercentInfectedPop DESC;


--Showing Countries with Highest Death Counts

SELECT location, MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
	GROUP BY location
	ORDER BY TotalDeathCount DESC;


--BREAKING THINGS DOWN BY CONTINENT
--Showing continents with the highest death count

SELECT continent, MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
	GROUP BY continent
	ORDER BY TotalDeathCount DESC;


-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int)) / SUM(new_cases)*100 as DeathPercentage 
FROM PortfolioProject..CovidDeaths
WHERE continent is not NULL
	GROUP BY date
	ORDER BY date, total_cases;

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int)) / SUM(new_cases)*100 AS DeathPercentage 
FROM PortfolioProject..CovidDeaths
WHERE continent is not NULL
	ORDER BY 1,2;


-- Looking at Total Population vs Vaccinated

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
-- SUM(CAST(vac.new_vaccinations as int)) OVER (Partition By dea.location) 
SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition By dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population) * 100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not NULL
	ORDER BY 2,3;


-- Using CTE (Common Table Expressions)

With PopvsVac (Continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
-- SUM(CAST(vac.new_vaccinations as int)) OVER (Partition By dea.location) 
SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition By dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population) * 100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not NULL
-- ORDER BY 2,3
)
Select *, (RollingPeopleVaccinated/population) * 100
FROM PopvsVac;



-- TEMP TABLE
DROP TABLE if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar (255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
-- SUM(CAST(vac.new_vaccinations as int)) OVER (Partition By dea.location) 
SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition By dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population) * 100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not NULL
-- ORDER BY 2,3

Select *, (RollingPeopleVaccinated/Population) * 100
FROM #PercentPopulationVaccinated;


-- Creating Views to store Data for later Visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
-- SUM(CAST(vac.new_vaccinations as int)) OVER (Partition By dea.location) 
SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition By dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population) * 100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not NULL
-- ORDER BY 2,3

SELECT * FROM PercentPopulationVaccinated;
