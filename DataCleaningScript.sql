/*

Cleaning Data in SQL QUeries

*/

Select * 
From
PortfolioProject..NashvilleHousing
--------------------------------------------------------------------------------------------------------------------------------------

--Standardize Date Format

Select CONVERT(Date, SaleDate), SaleDateConverted
From
PortfolioProject..NashvilleHousing

Alter Table NashvilleHousing
Add SaleDateConverted Date;

update NashvilleHousing
Set SaleDateConverted = CONVERT(Date, SaleDate)


--------------------------------------------------------------------------------------------------------------------------------------

--Populate property Address Data

Select *
From
PortfolioProject..NashvilleHousing
--where PropertyAddress is null
order by ParcelID

Select A.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From
PortfolioProject..NashvilleHousing as A
JOIN
PortfolioProject..NashvilleHousing as B
ON A.ParcelID = B.ParcelID
AND A.[UniqueID ]<>B.[UniqueID ]
where a.PropertyAddress is null

update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN
PortfolioProject..NashvilleHousing as B
ON A.ParcelID = B.ParcelID
AND A.[UniqueID ]<>B.[UniqueID ]
where a.PropertyAddress is null

--------------------------------------------------------------------------------------------------------------------------------------

--Breaking Out Address into individual columns (Address, City, State)

Select PropertyAddress
From
PortfolioProject..NashvilleHousing
--where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1 ) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) as Address
From PortfolioProject..NashvilleHousing

Alter Table Portfolioproject..NashvilleHousing
Add PropertySplitAddress NVARCHAR(255);

update Portfolioproject..NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1 )

Alter Table Portfolioproject..NashvilleHousing
Add  NVARCHAR(255);

update Portfolioproject..NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))

SELECT PropertySplitAddress, PropertySplitCity
From
PortfolioProject..NashvilleHousing

SELECT OwnerAddress
From 
PortfolioProject..NashvilleHousing
where OwnerAddress is not null

SELECT	
PARSENAME(REPLACE(OwnerAddress, ',' , '.'), 3) as Address
,PARSENAME(REPLACE(OwnerAddress, ',' , '.'), 2) as City
,PARSENAME(REPLACE(OwnerAddress, ',' , '.'), 1) as State
From 
PortfolioProject..NashvilleHousing
Where OwnerAddress is not null

Alter Table Portfolioproject..NashvilleHousing
Add OwnerSplitAddress NVARCHAR(255);

update Portfolioproject..NashvilleHousing
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',' , '.'), 3)

Alter Table Portfolioproject..NashvilleHousing
Add OwnerSplitCity NVARCHAR(255);

update Portfolioproject..NashvilleHousing
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',' , '.'), 2)

Alter Table Portfolioproject..NashvilleHousing
Add OwnerSplitState NVARCHAR(255);

update Portfolioproject..NashvilleHousing
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',' , '.'), 1)

Select *
from PortfolioProject..NashvilleHousing
where OwnerAddress is not null


--------------------------------------------------------------------------------------------------------------------------------------

--Change Y and N to Yes and No in "Sold as vacant" Field

Select Distinct(SoldAsVacant), Count(SoldASVacant)
from PortfolioProject..NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End
from PortfolioProject..NashvilleHousing

Update PortfolioProject..NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End

--------------------------------------------------------------------------------------------------------------------------------------

--Remove Duplicates

With RowNumDuplicate AS (
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) AS row_num
From PortfolioProject..NashvilleHousing
)
Select *
From RowNumDuplicate
Where row_num > 1
Order by PropertyAddress


--------------------------------------------------------------------------------------------------------------------------------------
--Delete unused columns

Select *
From PortfolioProject..NashvilleHousing

Alter Table PortfolioProject..NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table PortfolioProject..NashvilleHousing
Drop Column SaleDate
