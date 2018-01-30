select p.LastName, p.FirstName, e.BusinessEntityID
from Person.Person p
inner join
HumanResources.Employee e
on p.BusinessEntityID = e.BusinessEntityID
intersect
select p.LastName, p.FirstName, sp.BusinessEntityID
from Person.Person p
inner join
sales.SalesPerson sp
on p.BusinessEntityID = sp.BusinessEntityID

select p.LastName, p.FirstName, e.BusinessEntityID
from Person.Person p
inner join
HumanResources.Employee e
on e.BusinessEntityID = p.BusinessEntityID
inner join
sales.SalesPerson sp
on sp.BusinessEntityID = e.BusinessEntityID
where e.BusinessEntityID = sp.BusinessEntityID

--QUERY 1 59%
--QUERY 2 41%