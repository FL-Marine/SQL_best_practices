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


