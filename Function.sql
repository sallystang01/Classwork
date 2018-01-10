

GO
ALTER FUNCTION dbo.fnInventoryTest
(
@product INT
) 
RETURNS varchar(200) 
AS   

BEGIN 
 
	DECLARE @Out VARCHAR(10)
	

	SET @Out = ( select i.inventory_id, i.location
						from inventory i
						where i.location = 'Out'
	)
RETURN 
	CASE
		WHEN @Product = @Out THEN 'Checked Out'
		Else 'In Stock'

	END
 
    

END; 
--GO
--CREATE FUNCTION fnLongDateTest
--(
--	@FullDate DATETIME
--)
--RETURNS VARCHAR(MAX)

--	AS
--	BEGIN

--		RETURN 
--		DATENAME(DW, @FULLDATE) + ' ' +
--		DATENAME(D, @FULLDATE) + ' ' +
--		DATENAME(M, @FULLDATE) + ' ' +
--		DATENAME(YY, @FULLDATE)
		


--END

--select dbo.fnLongDateTest(indate)
--from inventory

select dbo.fnInventoryTest(2001)