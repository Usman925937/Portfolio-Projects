USE PortfolioProject;
SELECT * FROM PortfolioProject..NashvilleHousing


-- Standardize the date format

SELECT SaleDate 
FROM PortfolioProject..NashvilleHousing

SELECT SaleDate, CONVERT(Date, SaleDate) 
FROM PortfolioProject..NashvilleHousing


-- UPDATE NashvilleHousing
-- SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

SELECT SaleDateConverted 
FROM PortfolioProject..NashvilleHousing


-- Populate Property Address Data

SELECT PropertyAddress 
FROM PortfolioProject..NashvilleHousing
WHERE PropertyAddress IS NULL

SELECT * 
FROM PortfolioProject..NashvilleHousing
-- WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress,b.ParcelID ,b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


-- Breaking out Property Address into Individual Columns (Address, City, State)

SELECT PropertyAddress FROM PortfolioProject..NashvilleHousing

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255)

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)


ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255)

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

-- ALTER TABLE NashvilleHousing
-- DROP COLUMN PropertySplitCity

SELECT * FROM PortfolioProject.dbo.NashvilleHousing


-- OTHER/ EASY WAY - USING PARSE NAME

SELECT OwnerAddress FROM PortfolioProject.dbo.NashvilleHousing

SELECT
-- PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
-- ,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
-- ,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortfolioProject.dbo.NashvilleHousing

-- 1 
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

-- 2
ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

-- 3
ALTER TABLE NashvilleHousing
ADD OwnerSplitState NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

-- SELECT * FROM PortfolioProject.dbo.NashvilleHousing


-- CONVERTING Y to Yes & N to No in SoldAsVacant Column

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldAsVacant

SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END


-- REMOVING DUPLICATES
-- USING CTE

WITH RowNumCTE AS(
SELECT *, ROW_NUMBER() OVER
				(
				PARTITION BY
				ParcelID,
				PropertyAddress,
				SaleDate,
				SalePrice,
				LegalReference
				ORDER BY
					UniqueID
					) row_num

FROM PortfolioProject.dbo.NashvilleHousing
)
SELECT * 
FROM RowNumCTE
WHERE row_num >1
-- Order by PropertyAddress

-- Deleting Unused Columns

SELECT * FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN PropertyAddress, OwnerAddress

ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate