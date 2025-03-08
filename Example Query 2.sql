/*Question 2 : Write a query that displays the second customer with
the highest total internet purchase amount
based on the total purchases of each customer */

USE AdventureWorksDW2022
GO
SELECT 
    FirstName,
    LastName,
	[Total Buy Amount],
    PurchaseRank
    
FROM (
    SELECT
        DimCustomer.FirstName,
        DimCustomer.LastName,
        RANK() OVER (ORDER BY SUM(FactInternetSales.SalesAmount) DESC) AS PurchaseRank,
        SUM(FactInternetSales.SalesAmount) AS [Total Buy Amount]
    FROM 
        FactInternetSales
    JOIN 
        DimCustomer ON DimCustomer.CustomerKey = FactInternetSales.CustomerKey
    GROUP BY 
        DimCustomer.FirstName, DimCustomer.LastName
) AS RankedCustomers
WHERE 
    PurchaseRank = 2
ORDER BY 
    PurchaseRank;