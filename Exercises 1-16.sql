


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

-- #2

-- From the HumanResources.EmployeePayHistory table, retrieve the latest record 
-- for each current employee into another temporary table. Include the BusinessEntityID, RateChangeDate and Rate fields.

select e.BusinessEntityID, eph.RateChangeDate, eph.Rate
into TempEmployeePayHistory
from HumanResources.EmployeePayHistory eph
inner join
HumanResources.Employee e
on e.BusinessEntityID = eph.BusinessEntityID
where e.CurrentFlag <> 0


select * from TempEmployeePayHistory

-- #3

--Finally, using the two temporary tables you've created, write a query to return a list of employees 
--with their names, titles, gender, current rate of pay and the date it was last changed. 
--Sort by the date the pay was last changed in ascending order.

select te.Employee, te.JobTitle, te.Gender, teph.Rate, teph.RateChangeDate
from TempEmployees te
inner join
TempEmployeePayHistory teph
on te.BusinessEntityID = teph.BusinessEntityID
order by teph.RateChangeDate 

