
--=========================================QUESTION 1=========================================--
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




--=========================================QUESTION 2=========================================--


--select * from Person.BusinessEntity
--select * from Person.Person
--select * from HumanResources.Employee
--select * from Person.[Address]
--select * from Person.BusinessEntityAddress
--select * from HumanResources.EmployeeDepartmentHistory
--select * from HumanResources.EmployeePayHistory
--select * from sales.SalesPerson
--select * from sales.SalesPersonQuotaHistory
--select * from sales.SalesTerritoryHistory
--select * from Person.EmailAddress
--select * from Person.PersonPhone
--select * from HumanResources.Department

INSERT INTO Person.BusinessEntity (ModifiedDate)
VALUES (getdate())

INSERT INTO Person.Person (BusinessEntityID, PersonType, NameStyle, Title,FirstName, MiddleName, LastName, 
							EmailPromotion, ModifiedDate)
VALUES (20778, 'EM', 0, 'Mr.', 'Hunter', 'Bryce', 'Duerr', 0, GETDATE())

INSERT INTO HumanResources.Employee (BusinessEntityID, NationalIDNumber, LoginID,
									JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SalariedFlag, VacationHours, SickLeaveHours,
									CurrentFlag)
VALUES (20778, '123564250', 'adventure-works\duerr0', 'Sales Representative', '1999-05-21', 'S', 'M', '2016-01-01', 1, 87, 43, 1)

INSERT INTO Person.[Address] (AddressLine1, AddressLine2, City, StateProvinceID, PostalCode)
VALUES ('115 Janice Drive', '672', 'Hollister', '15', '32147')

INSERT INTO Person.BusinessEntityAddress (BusinessEntityID,AddressID , AddressTypeID)
VALUES (20778,32522, 2)

INSERT INTO HumanResources.EmployeeDepartmentHistory (BusinessEntityID, DepartmentID, ShiftID, StartDate, EndDate)
VALUES (20778, 4, 1, '2016-01-01', '2017-01-01')
INSERT INTO HumanResources.EmployeeDepartmentHistory (BusinessEntityID, DepartmentID, ShiftID, StartDate)
VALUES (20778, 3, 1, '2017-01-01')

INSERT INTO HumanResources.EmployeePayHistory (BusinessEntityID, RateChangeDate, Rate, PayFrequency)
VALUES (20778, '2016-01-01', 13.50, 2)

INSERT INTO HumanResources.EmployeePayHistory (BusinessEntityID, RateChangeDate, Rate, PayFrequency)
VALUES (20778, '2017-01-01', 23.50, 2)

INSERT INTO sales.SalesPerson (BusinessEntityID, TerritoryID, SalesQuota, Bonus, CommissionPct, SalesYTD, SalesLastYear)
VALUES (20778, 5, 250000.00, 2000.00, 0.016, 24500000, 56100000)

INSERT INTO Sales.SalesTerritoryHistory (BusinessEntityID, TerritoryID, StartDate)
VALUES (20778, 5, '2017-01-01')

INSERT INTO Sales.SalesPersonQuotaHistory (BusinessEntityID, QuotaDate, SalesQuota)
VALUES (20778, '2017-01-31', 500000.00),
		(20778, '2017-04-01', 1000000.00),
		(20778, '2017-07-01', 1500000.00),
		(20778, '2017-10-01', 2000000.00)

INSERT INTO [Person].EmailAddress (BusinessEntityID, EmailAddress)
VALUES (20778, 'duerr0@adventure-works.com')

INSERT INTO Person.PersonPhone (BusinessEntityID, PhoneNumber, PhoneNumberTypeID)
VALUES (20778, '561-307-2954', 1)



--=========================================QUESTION 3=========================================--

CREATE TABLE [Purchasing].[VendorIssues]
(
ReportID int not null IDENTITY(1, 1),
PurchaseOrderID int not null,
EntryDate date not null DEFAULT getdate(),
IssueDetails varchar(3500) not null,
VendorResponse varchar(3500),
Resolved bit not null,
PRIMARY KEY (ReportID),
CONSTRAINT FK_PurhcaseOrderID FOREIGN KEY (PurchaseOrderID)
REFERENCES Purchasing.PurchaseOrderHeader(PurchaseOrderID)
)

--SET IDENTITY_INSERT purchasing.vendorissues OFF
--GO
INSERT INTO Purchasing.VendorIssues (ReportID, PurchaseOrderID, EntryDate, IssueDetails, VendorResponse, Resolved)
VALUES	(5, 2, GETDATE(), 'It does not work', 'Too bad', 1)
INSERT INTO Purchasing.VendorIssues (PurchaseOrderID, EntryDate, IssueDetails, VendorResponse, Resolved)
VALUES	(7, GETDATE(), 'It does not work', 'Too bad', 1)
INSERT INTO Purchasing.VendorIssues (PurchaseOrderID, EntryDate, IssueDetails, VendorResponse, Resolved)
VALUES	(1, GETDATE(), 'It does not work', 'Too bad', 1)
INSERT INTO Purchasing.VendorIssues (PurchaseOrderID, EntryDate, IssueDetails, VendorResponse, Resolved)
VALUES	(15, GETDATE(), 'It does not work', 'Too bad', 1)
INSERT INTO Purchasing.VendorIssues (PurchaseOrderID, EntryDate, IssueDetails, VendorResponse, Resolved)
VALUES	(200, GETDATE(), 'It does not work', 'Too bad', 1)
INSERT INTO Purchasing.VendorIssues (PurchaseOrderID, EntryDate, IssueDetails, VendorResponse, Resolved)
VALUES	(78, GETDATE(), 'It does not work', 'Too bad', 1)

select * from [Purchasing].VendorIssues

--ReportID auto increments from the identity insert instead of restarting at 1

--=========================================QUESTION 4=========================================--

ALTER VIEW vwSalesPersonMailingList
AS

select p.BusinessEntityID ,p.Title, CONCAT(p.firstname, ' ', p.MiddleName, ' ', p.LastName) [Full Name], ea.EmailAddress, pp.PhoneNumber,
		a.AddressLine1, a.AddressLine2, a.City, stp.Name [State], cr.Name [Country], a.PostalCode, e.CurrentFlag
from Person.Person p
inner join
Sales.SalesPerson sp
on sp.BusinessEntityID = p.BusinessEntityID
inner join
HumanResources.Employee e
on e.BusinessEntityID = p.BusinessEntityID
inner join
Person.EmailAddress ea
on ea.BusinessEntityID = p.BusinessEntityID
inner join
Person.PersonPhone pp
on pp.BusinessEntityID = p.BusinessEntityID
inner join
Person.BusinessEntityAddress bea
on bea.BusinessEntityID = p.BusinessEntityID
inner join
Person.[Address] a
on a.AddressID = bea.AddressID
inner join
Person.StateProvince stp
on stp.StateProvinceID = a.StateProvinceID
inner join
Person.CountryRegion cr
on cr.CountryRegionCode = stp.CountryRegionCode
where e.CurrentFlag <> 0

WITH CHECK OPTION

GO

--=========================================QUESTION 5=====================================================--
select * from vwSalesPersonMailingList

UPDATE vwSalesPersonMailingList
SET CurrentFlag = 0
WHERE BusinessEntityID = 283

--Update failed because WITH CHECK OPTION
--=========================================QUESTION 6=====================================================--
ALTER TABLE HumanResources.Employee
ADD Title nvarchar(8),
FirstName nvarchar(50),
MiddleName nvarchar(50),
LastName nvarchar(50)

update E
	set E.Title = p.Title, e.FirstName = p.FirstName, e.MiddleName = p.MiddleName, e.LastName = p.LastName
FROM HumanResources.Employee AS E
INNER JOIN Person.Person AS P
	on e.BusinessEntityID = p.BusinessEntityID
where p.BusinessEntityID = e.BusinessEntityID


--====================================QUESTION 7======================================================--

CREATE TABLE HumanResources.EmployeeAddresses
(
BusinessEntityID int not null,
AddressLine1 nvarchar(60) not null,
AddressLine2 nvarchar(60),
City nvarchar(30) not null,
[State] nvarchar(50) not null,
ZIP nvarchar(15) not null,
Country nvarchar(50) not null
PRIMARY KEY (BusinessEntityID)
CONSTRAINT FK_BUSINESSENTITYID FOREIGN KEY (BusinessEntityID)
REFERENCES HumanResources.Employee(BusinessEntityID)
)


INSERT INTO HumanResources.EmployeeAddresses (BusinessEntityID, AddressLine1, AddressLine2, City, [State], ZIP, Country)
SELECT e.BusinessEntityID, a.AddressLine1, a.AddressLine2, a.City, sp.Name [state], a.PostalCode, cr.Name [country]
FROM HumanResources.Employee e
INNER JOIN Person.BusinessEntityAddress bea
	on bea.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.[Address] a
	on a.AddressID = bea.AddressID
INNER JOIN Person.StateProvince sp
	on a.StateProvinceID = sp.StateProvinceID
INNER JOIN Person.CountryRegion cr
	on cr.CountryRegionCode = sp.CountryRegionCode


--select * from HumanResources.EmployeeAddresses