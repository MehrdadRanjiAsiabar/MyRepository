/* Question 5 : Write a stored procedure that accepts a 4-digit year as input and
returns the internet sales growth for each month of the selected year */
CREATE PROCEDURE GetInternetSalesGrowth
    @Year INT
AS
BEGIN
    WITH MonthlySales AS
    (
        SELECT 
            MONTH(f.OrderDate) AS SalesMonth,
            SUM(f.SalesAmount) AS SalesAmount
        FROM 
            FactInternetSales f
        WHERE 
            YEAR(f.OrderDate) = @Year
        GROUP BY 
            MONTH(f.OrderDate)
    ),
    
    Growth AS
    (
        SELECT 
            MS1.SalesMonth,
            MS1.SalesAmount AS CurrentMonthSales,
            MS2.SalesAmount AS PreviousMonthSales,
            CASE 
                WHEN MS2.SalesAmount = 0 THEN NULL 
                ELSE (MS1.SalesAmount - MS2.SalesAmount) / MS2.SalesAmount * 100 
            END AS GrowthPercentage
        FROM 
            MonthlySales MS1
        LEFT JOIN 
            MonthlySales MS2 
        ON 
            MS1.SalesMonth = MS2.SalesMonth + 1
    )

    SELECT 
        SalesMonth,
        CurrentMonthSales,
        PreviousMonthSales,
        GrowthPercentage
    FROM 
        Growth
    ORDER BY 
        SalesMonth;
END;

-- Executing the SP
Exec GetInternetSalesGrowth 2012 ; 
