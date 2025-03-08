/* Question 4 : Write a stored procedure that takes the product ID as input and returns the number of
internet sales factors that include that product*/
CREATE PROCEDURE NumberOfInternetSalesFactors @ProductID INT
AS
BEGIN 
	DECLARE @Salesnumber INT ; 
	SELECT @Salesnumber = COUNT(DISTINCT FactInternetSales.SalesOrderNumber) FROM FactInternetSales
	INNER JOIN DimProduct ON FactInternetSales.ProductKey = DimProduct.ProductKey
	WHERE DimProduct.ProductKey = @ProductID
	SELECT @Salesnumber AS [Number of SalesFactors]
END ; 

-- Executing the SP
EXEC NumberOfInternetSalesFactors 346 ; 

