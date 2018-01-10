CREATE VIEW [HumanResources].[TopTenRecentEmployees]
	WITH SCHEMABINDING
AS

SELECT TOP 10 CONCAT(p.LastName, ' ', p.FirstName) [Employee Name], e.JobTitle, e.HireDate
FROM HumanResources.Employee e
INNER JOIN
Person.Person p
on p.BusinessEntityID = e.BusinessEntityID
ORDER BY e.HireDate DESC
GO

