/* Question 1 : Write a Query that shows total sales based on country */

USE AdventureWorksDW2022
GO
SELECT
	DimSalesTerritory.SalesTerritoryCountry AS Country ,
	SUM(OrderQuantity) As [Total Sales] FROM FactInternetSales
INNER JOIN DimSalesTerritory ON FactInternetSales.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey
GROUP BY SalesTerritoryCountry
ORDER BY [Total Sales] DESC; 

