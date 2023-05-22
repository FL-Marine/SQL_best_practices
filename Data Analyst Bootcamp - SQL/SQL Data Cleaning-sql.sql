SELECT *
FROM NashvilleHousing

----------------------------------------------------------------------------------------------------------------------

-- Changing sales date 

SELECT SaleDate
FROM NashvilleHousing

/* To covert from date time to just date do the below query and update the database

SELECT SalesDate, CONVERT(Date, SalesDate)
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SalesDate = CONVERT(Date, SalesDate)

Or run the ALTER & UPDATE below

ALTER TABLE NashvilleHousing
Add SaleDateCoverted Date;

UPDATE NashvilleHousing
SET SaleDateCoverted  = CONVERT(Date, SalesDate)

*/

----------------------------------------------------------------------------------------------------------------------

-- Populate Property Address Data

SELECT *
FROM NashvilleHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

/* Doing a self join because some property addresses are NULL to fill in any NULLs
Some property addresses are blank although they may share same Parcel ID
*/

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
-- ISNULL is being used to fill in missing addresses 
FROM NashvilleHousing AS a
JOIN NashvilleHousing AS b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing AS a
JOIN NashvilleHousing AS b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

----------------------------------------------------------------------------------------------------------------------

-- Break out addresses into Adress, City, State

SELECT PropertyAddress
FROM NashvilleHousing
-- WHERE PropertyAddress IS NULL
-- ORDER BY ParcelID

SELECT
SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1) AS Address,
-- Looking at the first value in property address and then searching for the comma
-- -1 Gets rid of the comma
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) AS Address
-- Gets the city
FROM NashvilleHousing

/* Updating the tables
*/
ALTER TABLE NashvilleHousing
Add PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) 

SELECT * 
FROM NashvilleHousing
-- Verifying columns were added to table

/*Splitting out owner addeess
*/

SELECT OwnerAddress
FROM NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
--PARSENAME looks for periods not commas
--REPLACE looks for commas first then changes to period
-- Is listed as 3,2,1 because it PARSENAME runs everything backwards
FROM NashvilleHousing

/* Updating table again
*/
ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

SELECT *
FROM NashvilleHousing

----------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

