

ALTER PROCEDURE spBinaryConversion 239
	@Number INT
AS

    BEGIN
	DECLARE @256 int = round((@Number/2), 1)
	DECLARE @128 int = round((@256/2), 1)
	DECLARE @64 int = round((@128/2), 1)
	DECLARE @32 int = round((@64/2), 1)
	DECLARE @16 int = round((@32/2), 1)
	DECLARE @8 int = round((@16/2), 1)
	DECLARE @4 int = round((@8/2), 1)
	DECLARE @2 int = round((@4/2), 1)
	DECLARE @1 int = round((@2/2), 1)
	
	PRINT 
	CAST((@256 % 2) as Nvarchar) + 
	CAST((@128 % 2) as NVARCHAR) +
	CAST((@64 % 2) as NVARCHAR) +
	CAST((@32 % 2) as NVARCHAR) +
	CAST((@16 % 2) as NVARCHAR) +
	CAST((@8 % 2) as NVARCHAR) +
	CAST((@2 % 2) as NVARCHAR) +
	CAST((@1 % 2) as NVARCHAR) 
	END





