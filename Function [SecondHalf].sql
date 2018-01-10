GO
ALTER FUNCTION [Sales].[fnCardExpirationDate]

(
@card nvarchar(25)
)

RETURNS VARCHAR(MAX)
AS
BEGIN

DECLARE @Expiration VARCHAR(MAX)

set @Expiration = (

select EOMONTH(CONVERT(DATE, CAST((cc.expyear * 100 + cc.expmonth) AS varchar (15)) + '01'))
from sales.CreditCard cc
where CardNumber = @card
)


Return

@Expiration

END


select sales.fnCardExpirationDate(33332664695310) [Expiration]

select * from sales.CreditCard