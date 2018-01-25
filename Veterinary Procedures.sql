
--Species
CREATE PROC sp_Species	
	@Species varchar(35)

	

AS
BEGIN

select atr.Species, CONCAT(c.firstname, ', ', c.lastname) [Client], cc.*, p.PatName
from AnimalTypeReferences atr
inner join
Patients p
on p.AnimalType = atr.AnimalTypeID
inner join
Clients c
on c.ClientID = p.ClientID
inner join
ClientContacts cc
on cc.ClientID = c.ClientID
where Species = @Species

END
GO

exec sp_Species 'Dog'

--Breeds
GO
ALTER PROC sp_Breed	
	@Breed varchar(35)

	

AS
BEGIN

select atr.Breed, CONCAT(c.firstname, ', ', c.lastname) [Client], cc.*, p.PatName
from AnimalTypeReferences atr
inner join
Patients p
on p.AnimalType = atr.AnimalTypeID
inner join
Clients c
on c.ClientID = p.ClientID
inner join
ClientContacts cc
on cc.ClientID = c.ClientID
where Breed = @Breed

END
GO

exec sp_Breed 'Poodle'

--Billing and Payment Information

GO
ALTER PROC sp_BillingAndPayment

	@ClientID INT

AS
BEGIN

	select c.ClientID ,b.BillDate, p.PaymentDate, CAST(v.starttime as date) [Visit Date]
	from Billing b
	inner join
	Payments p
	on b.BillID = p.BillID
	inner join
	Clients c
	on c.ClientID = b.ClientID
	inner join
	Visits v
	on v.VisitID = b.VisitID
	where c.ClientID = @ClientID
END
Go

exec sp_BillingAndPayment 3

--Mailing List

GO
CREATE PROC sp_MailingList

	@EmployeeID INT

AS
BEGIN

select e.EmployeeID, CONCAT(e.firstname, ' ', e.lastname) [Employee Name],eci.AddressLine1, eci.AddressLine2,
		eci.City, eci.StateProvince, eci.PostalCode, eci.Phone
from Employees e
inner join
EmployeeContactInfo eci
on e.EmployeeID = eci.EmployeeID
where e.EmployeeID = @EmployeeID

END

GO

exec sp_MailingList 1

--Client Procedure
GO
ALTER PROCEDURE sp_NewClient

	@FirstName varchar(25),
	@LastName varchar(25),
	@MiddleName varchar(25),
	@AddressType int,
	@AddressLine1 varchar(50),
	@AddressLine2 varchar(50),
	@City varchar(35),
	@StateProvince varchar(25),
	@PostalCode varchar(15),
	@Phone varchar(15),
	@AltPhone varchar(15),
	@Email varchar(35),
	@ClientID int
	AS
	BEGIN
		
	INSERT INTO Clients
		(FirstName, LastName, MiddleName)
		VALUES
		(@FirstName, @LastName, @MiddleName)
		
		SET @ClientID = SCOPE_IDENTITY()
		
	INSERT INTO ClientContacts
		(ClientID ,AddressType, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, Email)
		VALUES
		(@ClientID ,@AddressType, @AddressLine1, @AddressLine2, @City, @StateProvince, @PostalCode, @Phone, @AltPhone, @Email)

	SELECT @ClientID
	FROM Clients
END
GO

exec sp_NewClient 'Bob', 'John', 'Taylor', @clientid, 1, '111 Yolo Street', '11', 'Ocala', 'Florida', '33333', '352-111-1111', '352-222-2222', 'test@gmail.com'

select * from Clients