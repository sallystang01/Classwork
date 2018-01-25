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