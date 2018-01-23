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
CREATE FUNCTION PrimeNumbers

(
@Number int
)

DECLARE @PRIME_BASE INT = 6    -- Start testing on either side of 6
DECLARE @TEST_VALUE INT = 2
DECLARE @UPPER_LIMIT INT = 1000000
DECLARE @PRIME BIT = 1                -- Start by assuming the number is prime.
DECLARE @PRIME_CANDIDATE INT = @PRIME_BASE - 1

WHILE @PRIME_CANDIDATE <= @UPPER_LIMIT
    BEGIN


    WHILE @TEST_VALUE !> SQRT(@PRIME_CANDIDATE)
        BEGIN

        IF (@PRIME_CANDIDATE % @TEST_VALUE = 0)
            BEGIN
                SET @PRIME = 0 -- Set prime to false.
                BREAK
            END
        SET @TEST_VALUE = @TEST_VALUE + 1
        END

    IF @PRIME != 0
        PRINT @PRIME_CANDIDATE

    IF @PRIME_CANDIDATE = (@PRIME_BASE - 1)
            SET @PRIME_CANDIDATE = @PRIME_CANDIDATE + 2
    ELSE
        BEGIN
            SET @PRIME_BASE = @PRIME_BASE + 6
            SET @PRIME_CANDIDATE = @PRIME_BASE - 1
        END

    SET @PRIME = 1 -- Reset
    SET @TEST_VALUE = 2 -- Reset

    END 