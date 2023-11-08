--SELECT *
--FROM 
--PortfolioProject..CovidDeaths

--SELECT *
--FROM 
--CovidVaccinations
--ORDER BY 3,4

--Select Location, date, total_cases, new_cases, total_deaths, population
--From
--PortfolioProject..CovidDeaths
--Order by 1,2

--Total Cases vs Total Deaths

--Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeaths
--where Location like '%states%'
--order by 1,2

--Total Cases vs Population
--shows what percentage got covid

--Select Location, date, population, total_cases, (total_cases/population)*100 as CasePercentagePerPopulation
--From PortfolioProject..CovidDeaths
--where Location like '%states%'
--order by 1,2

--countries with highest infection rate compared to population

--Select Location, population, MAX(total_cases) as HighestInfecionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
--From PortfolioProject..CovidDeaths
--Group by location, population
--order by PercentPopulationInfected desc


--Countries with highest death count per population

--Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
--From PortfolioProject..CovidDeaths
--where continent is not null
--Group by location
--order by TotalDeathCount desc

--Break things down by Coontinent
--Select continent,  MAX(cast(total_deaths as int)) as TotalDeathCount
--From PortfolioProject..CovidDeaths
--where continent is not null
--Group by continent
--order by TotalDeathCount Desc

--showing continents with highest death counts per population

--Select continent, MAX(population) as MaxPopulation, MAX(cast(total_deaths as int)) as TotalDeathCount, (MAX(cast(total_deaths as int))/MAX(population))*100 as DeathCountsPerPopulation
--From PortfolioProject..CovidDeaths
--where continent is not null
--Group by continent
--order by DeathCountsPerPopulation Desc

--Global Numbers

--Select  SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, (SUM(cast(new_deaths as int))/SUM(new_cases)) *100 as DeathPercentage
--From PortfolioProject..CovidDeaths
--where continent is not null
----Group by Date
--Order by DeathPercentage Desc

--looking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(new_vaccinations as int)) OVER (partition by dea.location) as TotalVaccinationsPerLocation
from CovidDeaths as dea
Join CovidVaccinations as vac
	on dea.location = vac.location 
	and dea.date=vac.date
where dea.continent is not null
order by 2,3

--highest vaccinated by location
select dea. continent, dea.location, SUM(cast(new_vaccinations as int)) as TotalVaccinated
from CovidDeaths as dea
Join CovidVaccinations as vac
	on dea.location = vac.location 
	and dea.date=vac.date
where dea.continent is not null
group by dea.location, dea.continent
order by TotalVaccinated desc

--Highest vaccinated by continent
select dea. continent,  SUM(cast(new_vaccinations as int)) as TotalVaccinated
from CovidDeaths as dea
Join CovidVaccinations as vac
	on dea.location = vac.location 
	and dea.date=vac.date
where dea.continent is not null
group by dea.continent
order by TotalVaccinated desc