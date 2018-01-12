
--CURSOR

DECLARE StatusCursor CURSOR 
	FOR SELECT top 1000 SalesOrderID, [status] FROM Sales.SalesOrderHeader
		

OPEN StatusCursor
		
		
	WHILE @@FETCH_STATUS = 0 
		BEGIN
			
		update sales.SalesOrderHeader
		set [Status] = (select round(((rand() + .5) * 2), 0)) 
		where current of StatusCursor 
				
				FETCH NEXT FROM statuscursor
		END
				
	
CLOSE StatusCursor
DEALLOCATE StatusCursor

select [status] from sales.SalesOrderHeader


--OTHER METHOD

update sales.SalesOrderHeader
set [Status] = (select round(((rand() + .5) * 2), 0)) 
where [Status] = 5

--FUNCTION

--ProductID

GO
ALTER FUNCTION [Production].[fnidProdqty]

(
@id int
)

RETURNS int
AS
BEGIN

DECLARE @QTY int

set @QTY = (

select sum(Quantity)
from production.ProductInventory
where ProductID = @id
group by ProductID
)


Return

@QTY

END


select Production.fnidProdqty(1)

select * from Production.ProductInventory
--Product Name

GO
Alter FUNCTION [Production].[fnNameProdqty]

(
@name varchar(max)
)

RETURNS int
AS
BEGIN

DECLARE @QTY INT

set @QTY = (

select sum(Quantity)
from production.ProductInventory pv
inner join
Production.Product p
on pv.ProductID = p.ProductID
where p.Name = @NAME
group by p.ProductID
)


Return

@QTY

END

select production.fnNameProdqty('Adjustable Race')

select * from Production.Product