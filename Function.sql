


ALTER FUNCTION dbo.fnInventory
(
@product INT
) 
RETURNS int   
AS   

BEGIN  
    DECLARE @avail int;  
    SELECT  i.available
    FROM inventory i   
    WHERE i.available = @Avail  
     IF (@avail = 0)   
        SET @avail = 0;
	ELSE
		SET @avail = 1;  
    RETURN @avail;  
END; 