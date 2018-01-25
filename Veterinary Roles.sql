use Veterinary

-- Creates the login ComeauUser with password '340$Uuxwp7Mcxo7Khy'.  
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

GRANT EXEC ON OBJECT::
	sp_Breed
		TO VetClerk

GRANT EXEC ON OBJECT::
	sp_Species
		TO VetClerk

GRANT EXEC ON OBJECT::
	sp_BillingAndPayment
		TO VetClerk

GRANT EXEC ON OBJECT::
	sp_MailingList
		TO VetClerk