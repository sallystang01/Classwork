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

CREATE FUNCTION [Sales].[LatestOrders]
(
	@Characters varchar(max)

)

RETURNS @t TABLE

(
	
	ProductName varchar(max)
)

AS 
BEGIN

	INSERT INTO @t
	SELECT Name
	FROM Production.Product
	where Name like @Characters

END

select * from sales.SalesOrderHeader