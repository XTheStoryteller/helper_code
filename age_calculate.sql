CREATE FUNCTION calculate_age(@birthdate DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @birthdate, GETDATE()) - 
           CASE 
               WHEN DATEADD(YEAR, DATEDIFF(YEAR, @birthdate, GETDATE()), @birthdate) > GETDATE() 
               THEN 1 
               ELSE 0 
           END
END;
