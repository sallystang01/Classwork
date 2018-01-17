use AdventureWorks2012
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

--RESET

update sales.SalesOrderHeader
set [Status] = 5


--FUNCTION

--ProductID

GO
CREATE FUNCTION [Production].[fnidProdqty]

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
CREATE FUNCTION [Production].[fnNameProdqty]

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

--Third Part



GO
CREATE PROC sp_ShippedOrders
AS
BEGIN
WITH ShippedOrders AS
(
select SOH.*
from Sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
join Production.ProductInventory inv
on sod.ProductID = inv.ProductID
where [Status] in (1,2,3) and
soh.creditcardID IS NOT NULL AND
soh.creditcardapprovalcode is NOT NULL AND
soh.ShipToAddressID IS NOT NULL AND
soh.BillToAddressID IS NOT NULL AND
inv.Quantity >= SOD.OrderQty)

UPDATE sales.SalesOrderHeader
SET [Status] = 5
WHERE SalesOrderID IN
	(SELECT SalesOrderID
	FROM ShippedOrders)
	END
	GO

	sp_ShippedOrders

	select * from sales.SalesOrderHeader


	 