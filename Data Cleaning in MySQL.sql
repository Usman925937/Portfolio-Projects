DATA CLEANING 

-- 1. Removing Duplicates
-- 2. Standardizing the Data (Converting str to date, etc)
-- 3. Null Values or blank values
-- 4. Removing Columns

USE world_layoffs;
SELECT * 
FROM layoffs;
-- SELECT * FROM world_layoffs.dbo.layoffs (FOR MS SQL SERVER)


-- Creating a table like original table (As we will clean the table and also remove columns)

-- SELECT * INTO layoffs_staging FROM layoffs (FOR MS SQL SERVER)
CREATE TABLE layoffs_staging
LIKE layoffs

INSERT layoffs_staging
SELECT * FROM layoffs

SELECT * FROM layoffs_staging

-- Removing Duplicates

SELECT *, ROW_NUMBER() OVER (PARTITION BY
							company, 
							'location', 
							industry, 
							total_laid_off, 
							percentage_laid_off, 
							'date', 
							stage, 
							country, 
							funds_raised_millions
							ORDER BY 
							company
							) AS row_num	
FROM layoffs_staging

-- Using CTE for identifying duplicates

WITH duplicate_cte AS(
SELECT *, ROW_NUMBER() OVER (PARTITION BY
							company, 
							location, 
							industry, 
							total_laid_off, 
							percentage_laid_off, 
							`date`, 
							stage, 
							country, 
							funds_raised_millions
							-- ORDER BY 
							-- total_laid_off
							) AS row_num	
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num >1


-- Verifying the CTE whether the CTE Output contains duplicates or not
SELECT * FROM layoffs_staging
WHERE company = 'Casper'

SELECT * FROM layoffs_staging
WHERE company = 'Hibob'

SELECT * FROM layoffs_staging
WHERE company = 'Yahoo'


-- Deleting Duplicates & Verifying

-- (FOR MS SQL SERVER)
-- WITH duplicate_cte AS(
-- SELECT *, ROW_NUMBER() OVER (PARTITION BY
	-- 						company, 
	-- 						location, 
	-- 						industry, 
	-- 						total_laid_off, 
	-- 						percentage_laid_off, 
	-- 						date, 
	-- 						stage, 
	-- 						country, 
	-- 						funds_raised_millions
	-- 						ORDER BY 
	-- 						total_laid_off
	-- 						) AS row_num	
-- FROM layoffs_staging
-- )
-- SELECT *
-- DELETE 
-- FROM duplicate_cte
-- WHERE row_num >1

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *, ROW_NUMBER() OVER (PARTITION BY
							company, 
							location, 
							industry, 
							total_laid_off, 
							percentage_laid_off, 
							`date`, 
							stage, 
							country, 
							funds_raised_millions
							-- ORDER BY 
							-- total_laid_off
							) AS row_num	
FROM layoffs_staging

SELECT * 
FROM layoffs_staging2
WHERE row_num >1

DELETE
FROM layoffs_staging2
WHERE row_num >1


-- Standardizing Data

SELECT * FROM layoffs_staging2
-- ORDER BY company

SELECT company, TRIM(company)
FROM layoffs_staging2
ORDER BY company

UPDATE layoffs_staging2
SET company = TRIM(company)

SELECT * FROM layoffs_staging2
WHERE company = 'E Inc.'

-- SELECT industry FROM layoffs_staging
SELECT DISTINCT(industry) FROM layoffs_staging2
ORDER BY industry -- We can also do ORDER BY 1	

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'

SELECT DISTINCT(industry) FROM layoffs_staging2
-- SELECT * FROM layoffs_staging2 

-- SELECT DISTINCT(location) 
-- FROM layoffs_staging2

SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1

SELECT DISTINCT(country), TRIM(TRAILING '.' FROM country)  --TRAILING MEANS GOING AT THE END
FROM layoffs_staging2
ORDER BY 1

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'

SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1

SELECT * FROM layoffs_staging2

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')

SELECT `date`
FROM layoffs_staging2

ALTER TABLE layoffs_staging2
MODIFY COLUMN  `date` DATE; 

-- Populating NULL Values


SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%'

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ''

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb'

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT * FROM layoffs_staging2

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL

SELECT * FROM layoffs_staging2

ALTER TABLE layoffs_staging2
DROP COLUMN row_num



















