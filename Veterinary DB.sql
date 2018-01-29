 USE MASTER
if (select count(*) 
    from sys.databases where name = 'Veterinary') > 0
BEGIN
		DROP DATABASE Veterinary;
END


CREATE DATABASE Veterinary;

GO
USE Veterinary;

exec sp_changedbowner 'sa'

CREATE TABLE Clients
(
ClientID int not null identity(1, 1),
FirstName varchar(25) not null,
LastName varchar(25) not null,
MiddleName varchar(25),
CreateDate date DEFAULT getdate(),
PRIMARY KEY (ClientID)
)

CREATE TABLE ClientContacts
(
AddressID int not null identity(1, 1),
ClientID int not null,
AddressType int not null,
AddressLine1 varchar(50) not null,
AddressLine2 varchar(50),
City varchar(35) not null,
StateProvince varchar(25) not null,
PostalCode varchar(15) not null,
Phone varchar(15) not null,
AltPhone varchar(15),
Email varchar(35),
PRIMARY KEY (AddressID),
CONSTRAINT FK_ClientID FOREIGN KEY (ClientID)
REFERENCES Clients(ClientID),
CONSTRAINT CK_ADDRESSTYPE CHECK (AddressType = 1 or AddressType = 2)
)

CREATE TABLE Patients
(
PatientID int not null identity(1, 1),
ClientID int not null,
PatName varchar(35) not null,
AnimalType int not null,
Color varchar(25) not null,
Gender varchar(2) not null,
BirthYear varchar(4) not null,
[Weight] decimal(10,2) not null,
[Description] varchar(1024) not null,
GeneralNotes varchar(2048) not null,
Chipped bit not null,
RabiesVacc datetime
PRIMARY KEY (PatientID)
CONSTRAINT FK_PClientID FOREIGN KEY (ClientID)
REFERENCES Clients(ClientID)
)

CREATE TABLE AnimalTypeReferences
(
AnimalTypeID int not null identity(1, 1),
Species varchar(35) not null,
Breed varchar(35) not null
PRIMARY KEY (AnimalTypeID)
)

CREATE TABLE Employees
(
EmployeeID int not null identity(1, 1),
LastName varchar(25) not null,
FirstName varchar(25) not null,
MiddleName varchar(25) not null,
HireDate date not null,
Title varchar(50) not null
PRIMARY KEY (EmployeeID)
)

CREATE TABLE Visits
(
VisitID int not null identity(1, 1),
StartTime datetime not null,
EndTime datetime not null,
Appointment bit not null,
DiagnosisCode varchar(12) not null,
ProcedureCode varchar(12) not null,
VisitNotes varchar(2048) not null,
PatientID int not null,
EmployeeID int not null
PRIMARY KEY (VisitID)
CONSTRAINT FK_PatientID FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID),
CONSTRAINT FK_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Employees(EmployeeID),
CONSTRAINT CK_EndTime CHECK (EndTime > StartTime)
)

CREATE TABLE EmployeeContactInfo
(
AddressID int not null identity(1, 1),
AddressLine1 varchar(50) not null,
AddressLine2 varchar(50),
City varchar(35) not null,
StateProvince varchar(25) not null,
PostalCode varchar(15) not null,
Phone varchar(15) not null,
AltPhone varchar(15),
EmployeeID int not null
PRIMARY KEY (AddressID)
CONSTRAINT FK_1EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Employees(EmployeeID)
)

CREATE TABLE Billing
(
BillID int not null identity(1, 1),
BillDate Date not null,
ClientID int not null,
VisitID int not null,
Amount decimal(10, 2) not null
PRIMARY KEY (BillID)
CONSTRAINT FK_1ClientID FOREIGN KEY (ClientID)
REFERENCES Clients(ClientID),
CONSTRAINT FK_VisitID FOREIGN KEY (VisitID)
REFERENCES Visits(VisitID),
CONSTRAINT CK_BillDate CHECK (BillDate <= getdate())
)


CREATE TABLE Payments
(
PaymentID int not null identity(1, 1),
PaymentDate date not null,
BillID int not null,
Notes varchar(2048) not null,
Amount decimal not null
PRIMARY KEY (PaymentID)
CONSTRAINT FK_BillID FOREIGN KEY (BillID)
REFERENCES Billing(BillID),
CONSTRAINT CK_PaymentDate CHECK (PaymentDate <= getdate())
)

----------------------------------------------------------------INSERTS----------------------------------------------------------------------

use Veterinary

Insert into Clients
(FirstName, LastName, MiddleName)
VALUES
('John', 'Swagger', 'Paul'),
('Chris', 'Young', 'Tyler'),
('Griffen', 'Yohn', 'Webb'),
('Jewel', 'Taylor', 'Amanda'),
('Cameryn', 'Tucker', 'Alisa')

insert into ClientContacts (ClientID, AddressType, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, Email) values (1, 2, '66223 Mcbride Avenue', null, 'Monticello', 'Minnesota', '55565', '763-635-6916', '212-762-7826', 'ltrehearn0@github.com');
insert into ClientContacts (ClientID, AddressType, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, Email) values (2, 2, '8321 Bowman Drive', null, 'Clearwater', 'Florida', '34620', '727-488-7635', '727-675-4506', 'slighton1@berkeley.edu');
insert into ClientContacts (ClientID, AddressType, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, Email) values (3, 1, '5301 Thackeray Lane', null, 'Fairfield', 'Connecticut', '06825', '203-874-3892', '617-710-7409', 'coldacre2@seattletimes.com');
insert into ClientContacts (ClientID, AddressType, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, Email) values (4, 1, '599 Brickson Park Avenue', null, 'Clearwater', 'Florida', '34615', '727-506-8550', '954-696-0206', 'mbartelli3@cargocollective.com');
insert into ClientContacts (ClientID, AddressType, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, Email) values (5, 1, '63 Mendota Point', null, 'East Saint Louis', 'Illinois', '62205', '618-204-2837', '614-147-5764', 'alacaze4@plala.or.jp');


Insert into AnimalTypeReferences
(Species, Breed)
Values 
('Dog', 'Labrador Retriever'),
('Dog', 'German Shepard'),
('Dog', 'Poodle'),
('Dog', 'Bulldog'),
('Dog', 'Chihuahua'),
('Dog', 'Beagle'),
('Dog', 'Great Dane'),
('Dog', 'Golden Retriever'),
('Dog', 'Siberian Husky'),
('Cat', 'British Shorthair'),
('Cat', 'Siamese cat'),
('Cat', 'Persian cat'),
('Cat', 'Ragdoll')

insert into Patients (ClientID, PatName, AnimalType, Color, Gender, BirthYear, Weight, Description, GeneralNotes, Chipped, RabiesVacc) values (2, 'Effie', 10, 'Khaki', 'F', '1998', 109.01, 'at velit vivamus vel nulla eget eros', 'pede ullamcorper augue a suscipit nulla elit ac', 1, '2016-03-13 11:42:46');
insert into Patients (ClientID, PatName, AnimalType, Color, Gender, BirthYear, Weight, Description, GeneralNotes, Chipped, RabiesVacc) values (3, 'Merilee', 3, 'Crimson', 'F', '1995', 58.39, 'eget semper rutrum nulla nunc purus', 'enim blandit mi in porttitor pede', 1, '2016-10-12 21:56:22');
insert into Patients (ClientID, PatName, AnimalType, Color, Gender, BirthYear, Weight, Description, GeneralNotes, Chipped, RabiesVacc) values (2, 'Quintana', 5, 'Khaki', 'F', '1998', 168.9, 'ultrices posuere cubilia curae mauris viverra diam', 'dui luctus rutrum nulla tellus in', 1, '2016-02-13 22:38:02');
insert into Patients (ClientID, PatName, AnimalType, Color, Gender, BirthYear, Weight, Description, GeneralNotes, Chipped, RabiesVacc) values (4, 'Nichols', 12, 'Teal', 'M', '2000', 41.25, 'maecenas ut massa quis augue luctus tincidunt nulla mollis', 'interdum mauris non ligula', 1, '2016-02-03 00:11:51');
insert into Patients (ClientID, PatName, AnimalType, Color, Gender, BirthYear, Weight, Description, GeneralNotes, Chipped, RabiesVacc) values (3, 'Andi', 4, 'Crimson', 'F', '1998', 83.93, 'tincidunt in leo', 'faucibus accumsan odio curabitur convallis duis consequat', 0, null);
insert into Patients (ClientID, PatName, AnimalType, Color, Gender, BirthYear, Weight, Description, GeneralNotes, Chipped, RabiesVacc) values (4, 'Zonnya', 7, 'Crimson', 'F', '2006', 167.44, 'volutpat in congue', 'vel nisl duis ac nibh fusce lacus', 0, null);
insert into Patients (ClientID, PatName, AnimalType, Color, Gender, BirthYear, Weight, Description, GeneralNotes, Chipped, RabiesVacc) values (3, 'Baird', 9, 'Teal', 'M', '2006', 40.65, 'ante nulla justo aliquam quis', 'ac', 0, '2017-08-03 07:32:35');

insert into Employees (LastName, FirstName, MiddleName, HireDate, Title) values ('Curlis', 'Cleavland', 'Jemimah', '2016-01-05 18:58:26', 'Veterinarian');
insert into Employees (LastName, FirstName, MiddleName, HireDate, Title) values ('Purselowe', 'Halley', 'Joycelin', '2015-07-10 23:03:38', 'Vet Tech');
insert into Employees (LastName, FirstName, MiddleName, HireDate, Title) values ('Wanklin', 'Thorny', 'Avis', '2016-01-04 03:42:33', 'Vet Assistant');
insert into Employees (LastName, FirstName, MiddleName, HireDate, Title) values ('Willcocks', 'Gwyneth', 'Ibrahim', '2016-10-15 13:24:31', 'Secretary');
insert into Employees (LastName, FirstName, MiddleName, HireDate, Title) values ('Oldford', 'Shayne', 'Claudia', '2017-03-13 20:33:46', 'Janitor');
insert into Employees (LastName, FirstName, MiddleName, HireDate, Title) values ('Gianasi', 'Ddene', 'Pincus', '2015-05-22 02:39:24', 'Veterinarian');
insert into Employees (LastName, FirstName, MiddleName, HireDate, Title) values ('Hayton', 'Tann', 'Glory', '2016-08-22 04:53:44', 'Vet Tech');


insert into EmployeeContactInfo ( AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EmployeeID) values ( '61 2nd Parkway', '06', 'Saint Louis', 'Missouri', '63110', '314-867-2970', '651-798-9699', 1);
insert into EmployeeContactInfo ( AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EmployeeID) values ( '11425 Knutson Place', '0', 'Greensboro', 'North Carolina', '27455', '910-742-7639', '312-300-7541', 2);
insert into EmployeeContactInfo ( AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EmployeeID) values ( '30603 Melrose Junction', null, 'Metairie', 'Louisiana', '70005', '504-100-6278', null, 3);
insert into EmployeeContactInfo ( AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EmployeeID) values ( '41029 Shopko Street', '35', 'Denver', 'Colorado', '80209', '303-570-6092', '267-623-1209', 4);
insert into EmployeeContactInfo ( AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EmployeeID) values ( '2230 Elka Road', null, 'Baltimore', 'Maryland', '21265', '410-157-4527', null, 5);
insert into EmployeeContactInfo ( AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EmployeeID) values ( '0024 Mendota Street', '65895', 'Colorado Springs', 'Colorado', '80951', '719-698-7895', '706-729-3987', 6);
insert into EmployeeContactInfo ( AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EmployeeID) values ( '02 Clemons Lane', '52149', 'Aurora', 'Colorado', '80045', '303-193-1475', '817-863-0528', 7);

insert into Visits (StartTime, EndTime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values ('2017-03-24 00:17:06', '2017-03-26 22:20:06', 1, '51655-125', '55289-236', 'ut erat curabitur', 5, 1);
insert into Visits (StartTime, EndTime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values ('2017-12-30 08:06:08', '2017-12-30 12:39:28', 1, '52380-3191', '0904-6107', 'imperdiet et commodo vulputate justo in blandit ultrices enim', 1, 2);
insert into Visits (StartTime, EndTime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values ('2017-12-25 09:01:16', '2017-12-25 14:06:22', 1, '75870-001', '64159-6349', 'orci eget orci vehicula condimentum curabitur in libero', 6, 3);
insert into Visits (StartTime, EndTime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values ('2017-08-13 06:44:30', '2017-11-12 15:43:28', 0, '0378-9040', '60760-061', 'nisl nunc rhoncus dui vel sem sed sagittis', 1, 7);
insert into Visits (StartTime, EndTime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values ('2017-02-14 06:42:18', '2017-12-21 10:21:02', 1, '16571-600', '47682-300', 'in faucibus orci luctus', 3, 7);

insert into Billing (BillDate, ClientID, VisitID, Amount) values ('2018-01-11 07:41:12', 3, 1, 14.36);
insert into Billing (BillDate, ClientID, VisitID, Amount) values ('2017-06-28 08:39:54', 2, 2, 78.42);
insert into Billing (BillDate, ClientID, VisitID, Amount) values ('2017-12-13 20:54:27', 4, 3, 95.79);
insert into Billing (BillDate, ClientID, VisitID, Amount) values ('2017-11-18 06:06:22', 2, 4, 75.97);
insert into Billing (BillDate, ClientID, VisitID, Amount) values ('2017-11-15 16:38:58', 2, 5, 2.56);

insert into Payments (PaymentDate, BillID, Notes, Amount)
values (GETDATE(), 1, 'N/A', 14.36)

--------------------------------------------------------------------PROCEDURES-----------------------------------------------------------------


--Species
GO
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
CREATE PROC sp_Breed	
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
CREATE PROC sp_BillingAndPayment

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


GO
CREATE PROCEDURE sp_NewClient

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
	@ClientID int OUTPUT
	AS
	BEGIN
		
	INSERT INTO Clients
		(FirstName, LastName, MiddleName)
		VALUES
		(@FirstName, @LastName, @MiddleName)
		
		SET @ClientID = (select top 1 SCOPE_IDENTITY() from Clients)
		
	INSERT INTO ClientContacts
		(ClientID ,AddressType, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, Email)
		VALUES
		(@ClientID ,@AddressType, @AddressLine1, @AddressLine2, @City, @StateProvince, @PostalCode, @Phone, @AltPhone, @Email)

	SELECT @ClientID
	FROM Clients
END
GO

exec sp_NewClient 'Bob', 'John', 'Taylor', 1, '111 Yolo Street', '11', 'Ocala', 'Florida', '33333', '352-111-1111', '352-222-2222', 'test@gmail.com', ''

GO
CREATE PROCEDURE sp_NewEmployee

	@LastName varchar(25),
	@FirstName varchar(25),
	@MiddleName varchar(25),
	@HireDate date,
	@Title varchar(50),
	@AddressLine1 varchar(50),
	@AddressLine2 varchar(50),
	@City varchar(35),
	@StateProvince varchar(25),
	@PostalCode varchar(15),
	@Phone varchar(15),
	@AltPhone varchar(15),
	@EmployeeID int OUTPUT
	AS
	BEGIN
		
	INSERT INTO Employees
		(LastName, FirstName, MiddleName, HireDate, Title)
		VALUES
		(@LastName, @FirstName, @MiddleName, @HireDate, @Title)
		
		SET @EmployeeID = (select top 1 SCOPE_IDENTITY() from Employees)
		
	INSERT INTO EmployeeContactInfo
		(AddressLine1, AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EmployeeID)
		VALUES
		(@AddressLine1, @AddressLine2, @City, @StateProvince, @PostalCode, @Phone, @AltPhone, @EmployeeID)

	SELECT @EmployeeID
	FROM Employees
END
GO

exec sp_NewEmployee 'Pearl','Goodwind','Natasha','01-29-2018','Vet Tech','901 32nd Avenue', null, 'Ocala','Florida','34470','352-213-3134', '352-555-5555', ' '

------------------------------------------------ROLES-------------------------------------------------------------------------------------------


GO
if (select count(*)
	from sys.syslogins where name = 'VetManager') > 0

	DROP LOGIN [VetManager]
	Print 'VetManager Login Dropped'

if (select count(*)
	from sys.syslogins where name = 'VetClerk') > 0

	DROP LOGIN [VetClerk]
	Print 'VetClerk Login Dropped'

GO
if (select count(*)
	from sys.sysusers where name = 'VetManager') > 0
	DROP USER [VetManager]
	PRINT 'VetManager User Dropped'

GO
	if (select count(*)
	from sys.sysusers where name = 'VetClerk') > 0
	DROP USER [VetClerk]
	PRINT 'VetClerk User Dropped'


CREATE LOGIN VetManager   
    WITH PASSWORD = 'VetManager1234';  
GO  

-- Creates a database user for the login created above.  
CREATE USER VetManager FOR LOGIN VetManager;  
GO

-- Creates the login ComeauUser with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN VetClerk   
    WITH PASSWORD = 'VetClerk1234';  
GO  

-- Creates a database user for the login created above.  
CREATE USER VetClerk FOR LOGIN VetClerk;  
GO

ALTER ROLE db_datareader ADD MEMBER VetManager ;  
GO

ALTER ROLE db_datawriter ADD MEMBER VetManager ;  
GO

ALTER ROLE db_datareader ADD MEMBER VetClerk ;  
GO

DENY ALTER ON OBJECT::
     clientcontacts
        TO VetClerk  
DENY SELECT ON OBJECT::
     clientcontacts
        TO VetClerk  
DENY UPDATE ON OBJECT::
     clientcontacts
        TO VetClerk
DENY INSERT ON OBJECT::
     clientcontacts
        TO VetClerk  		  
DENY DELETE ON OBJECT::
     clientcontacts
        TO VetClerk  	

DENY ALTER ON OBJECT::
     employeecontactinfo
        TO VetClerk  
DENY SELECT ON OBJECT::
     employeecontactinfo
        TO VetClerk  
DENY UPDATE ON OBJECT::
     employeecontactinfo
        TO VetClerk
DENY INSERT ON OBJECT::
     employeecontactinfo
        TO VetClerk  		  
DENY DELETE ON OBJECT::
     employeecontactinfo
        TO VetClerk  	

GRANT EXEC ON
	sp_Breed
		TO VetClerk

GRANT EXEC ON
	sp_Species
		TO VetClerk

GRANT EXEC ON
	sp_BillingAndPayment
		TO VetClerk

GRANT EXEC ON
	sp_MailingList
		TO VetClerk

GRANT EXEC ON
	sp_Breed
		TO VetManager

GRANT EXEC ON
	sp_Species
		TO VetManager

GRANT EXEC ON
	sp_BillingAndPayment
		TO VetManager

GRANT EXEC ON
	sp_MailingList
		TO VetManager

GRANT EXEC ON
	sp_NewClient
		TO VetManager

GRANT EXEC ON
	sp_NewEmployee
		TO VetManager

GRANT EXEC ON
	sp_NewClient
		TO VetClerk

GRANT EXEC ON
	sp_NewEmployee
		TO VetClerk
