use adventureworks2012

--#1

GO

ALTER FUNCTION [Production].[ProductCharacter]
(
	@Characters varchar(max)

)
	


RETURNS TABLE
AS 
RETURN
(
	SELECT Name
	FROM Production.Product
	where Name like '%' + @Characters + '%'
	)
	GO

SELECT * from	[Production].[ProductCharacter]('Ad')

--#2

GO

ALTER FUNCTION [Sales].[LatestOrders]
(
	@RecordLimit int

)
	


RETURNS TABLE
AS 
RETURN
(
	SELECT TOP (@RecordLimit) * FROM sales.SalesOrderHeader
	order by OrderDate desc
	)
	GO

SELECT * from	Sales.LatestOrders(20)

--#3

GO

ALTER FUNCTION [Person].[PhoneNumberLookup]
(
	@Number varchar(max)

)
	


RETURNS TABLE
AS 
RETURN
(
	select p.*, pp.PhoneNumber
	from Person.Person p
	inner join
	Person.PersonPhone pp
	on p.BusinessEntityID = pp.BusinessEntityID
	where pp.PhoneNumber like '%' + @Number + '%'
	)
	GO

	select * from Person.PhoneNumberLookup(612)

--#4

GO
ALTER FUNCTION [dbo].[PrimeNumbers]

(
@StartNumber int,																																																																																																																																																																																								 
@PrimeCount int
)

RETURNS TABLE
AS
RETURN

(
WITH temp AS

(

    SELECT @StartNumber AS Value 
    UNION ALL
    SELECT t.Value+1 AS VAlue 
    FROM temp t
    WHERE t.Value < @PrimeCount
)
SELECT * 
FROM temp t
WHERE NOT EXISTS
            (   SELECT 1 FROM temp t2
                WHERE t.Value % t2.Value = 0 
                AND t.Value != t2. Value

            )

)

GO

select * from dbo.primenumbers(2, 5) option (maxrecursion 0)