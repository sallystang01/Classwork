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
CreateDate date
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
Email varchar(35)
PRIMARY KEY (AddressID)
CONSTRAINT FK_ClientID FOREIGN KEY (ClientID)
REFERENCES Clients(ClientID)
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
[Weight] decimal(2) not null,
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
REFERENCES Employees(EmployeeID)
)

CREATE TABLE EmployeeContactInfo
(
AddressID int not null identity(1, 1),
AddressType int not null,
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
Amount decimal not null
PRIMARY KEY (BillID)
CONSTRAINT FK_1ClientID FOREIGN KEY (ClientID)
REFERENCES Clients(ClientID),
CONSTRAINT FK_VisitID FOREIGN KEY (VisitID)
REFERENCES Visits(VisitID)
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
REFERENCES Billing(BillID)
)

