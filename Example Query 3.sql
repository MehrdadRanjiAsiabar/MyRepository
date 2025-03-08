/* Question 3 : Write a query that calculates the total internet sales
for each product subcategory and then sorts and ranks these subcategories
within each category.*/

USE AdventureWorksDW2022
GO
WITH SubCategorySales AS (
    SELECT 
        DimProductCategory.EnglishProductCategoryName AS Category,
        DimProductSubcategory.EnglishProductSubcategoryName AS SubCategory,
        SUM(FactInternetSales.SalesAmount) AS TotalSales
    FROM FactInternetSales 
    JOIN DimProduct ON FactInternetSales.ProductKey = DimProduct.ProductKey
    JOIN DimProductSubcategory  ON DimProduct.ProductSubcategoryKey =  DimProductSubcategory.ProductSubcategoryKey
    JOIN DimProductCategory  ON  DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
    GROUP BY DimProductCategory.EnglishProductCategoryName,  DimProductSubcategory.EnglishProductSubcategoryName
)
SELECT 
    Category,
    SubCategory,
    TotalSales,
    RANK() OVER (PARTITION BY Category ORDER BY TotalSales DESC) AS RankInCategory
FROM SubCategorySales
ORDER BY Category, RankInCategory;
