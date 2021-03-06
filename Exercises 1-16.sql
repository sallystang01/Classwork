
use adventureworks2012

-- #1

--For all current employees, get the BusinessEntityID, last name, first name, gender,
-- job title and hire date. Use report-friendly column names and sort by hire date descending.

SELECT e.BusinessEntityID, concat(p.lastname,', ', p.firstname) [Employee], e.Gender, e.JobTitle,
	e.HireDate
INTO TempEmployees
FROM Person.Person p
inner join
HumanResources.Employee e
on p.BusinessEntityID = e.BusinessEntityID
order by HireDate desc

select * from TempEmployees


-- From the HumanResources.EmployeePayHistory table, retrieve the latest record 
-- for each current employee into another temporary table. Include the BusinessEntityID, RateChangeDate and Rate fields.

select e.BusinessEntityID, max(eph.RateChangeDate) [Rate Change Date], max(eph.Rate) [Rate]
into TempEmployeePayHistory
from HumanResources.EmployeePayHistory eph
inner join
HumanResources.Employee e
on e.BusinessEntityID = eph.BusinessEntityID
where e.CurrentFlag <> 0
group by e.BusinessEntityID


select * from TempEmployeePayHistory



--Finally, using the two temporary tables you've created, write a query to return a list of employees 
--with their names, titles, gender, current rate of pay and the date it was last changed. 
--Sort by the date the pay was last changed in ascending order.

select te.BusinessEntityID ,te.Employee [Employee], te.JobTitle [Job Title], 
	 te.Gender [Gender], teph.Rate [Rate of Pay], teph.[Rate Change Date] [Rate Change Date]
from TempEmployees te
inner join
TempEmployeePayHistory teph
on te.BusinessEntityID = teph.BusinessEntityID
order by teph.[Rate Change Date]


select * from HumanResources.EmployeePayHistory

--

--# 2

DECLARE OrderDate SCROLL CURSOR
	FOR SELECT top 25 * FROM Purchasing.PurchaseOrderHeader order by OrderDate desc
		

OPEN OrderDate
		Fetch First From OrderDate
		
	WHILE @@FETCH_STATUS = 0 
		BEGIN 
			
	 
				
				FETCH NEXT FROM OrderDate
		END
				
	
CLOSE OrderDate
DEALLOCATE OrderDate

open OrderDate

--#3

alter table 
[Sales].[SalesOrderHeader]
drop constraint [DF_SalesOrderHeader_OrderDate]

--#4

select  p.BusinessEntityID, concat(AddressLine1, ', ' , AddressLine2, ', ' ,City, ', ' ,sp.Name,', ' ,cr.Name) [Address]
from Person.Person p
left join
Person.BusinessEntity be
on be.BusinessEntityID = p.BusinessEntityID
left join
Person.BusinessEntityAddress bea
on bea.BusinessEntityID = be.BusinessEntityID
left join
Person.[Address] a
on a.AddressID = bea.AddressID
left join 
Person.StateProvince sp
on sp.StateProvinceID = a.StateProvinceID
left join
Person.CountryRegion cr
on cr.CountryRegionCode = sp.CountryRegionCode
order by p.BusinessEntityID


GO
ALTER FUNCTION [Person].[AddressSearch]

(
@id int
)

RETURNS varchar(max)
AS
BEGIN

DECLARE @address varchar(max)

set @address = (

select top 1 concat(AddressLine1, ', ' , AddressLine2, ', ' ,City, ', ' ,sp.Name,', ' ,cr.Name) [Address]
from Person.Person p
inner join
Person.BusinessEntityAddress bea
on bea.BusinessEntityID = p.BusinessEntityID
inner join
Person.[Address] a
on a.AddressID = bea.AddressID
inner join 
Person.StateProvince sp
on sp.StateProvinceID = a.StateProvinceID
inner join
Person.CountryRegion cr
on cr.CountryRegionCode = sp.CountryRegionCode
where p.BusinessEntityID = @id and p.BusinessEntityID is not null and bea.AddressID is not null
)


Return

@Address

END

select Person.AddressSearch(291) [Address]

select Person.AddressSearch(p.BusinessEntityID) [Address], p.BusinessEntityID
from Person.Person p

order by p.BusinessEntityID



select  p.BusinessEntityID,a.* from Person.Person p
inner join 
Person.BusinessEntityAddress bea
on p.BusinessEntityID = bea.BusinessEntityID
inner join
Person.Address a
on a.AddressID = bea.AddressID
order by p.BusinessEntityID

select * from Person.Person
select * from Person.BusinessEntityAddress
select * from Person.[Address]