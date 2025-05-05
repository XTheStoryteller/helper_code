CREATE FUNCTION [dbo].[fnDistanceBetweenLatitudeAndLongitudes] (
    @dLatitude1 FLOAT, 
    @dLongitude1 FLOAT, 
    @dLatitude2 FLOAT, 
    @dLongitude2 FLOAT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @earthRadius FLOAT = 6371; -- Radius of Earth in kilometers
    
    -- Convert degrees to radians
    DECLARE @lat1Rad FLOAT = @dLatitude1 * PI() / 180;
    DECLARE @lon1Rad FLOAT = @dLongitude1 * PI() / 180;
    DECLARE @lat2Rad FLOAT = @dLatitude2 * PI() / 180;
    DECLARE @lon2Rad FLOAT = @dLongitude2 * PI() / 180;
    
    -- Haversine formula
    DECLARE @dLat FLOAT = @lat2Rad - @lat1Rad;
    DECLARE @dLon FLOAT = @lon2Rad - @lon1Rad;
    
    DECLARE @a FLOAT = SIN(@dLat/2) * SIN(@dLat/2) + 
                        COS(@lat1Rad) * COS(@lat2Rad) * 
                        SIN(@dLon/2) * SIN(@dLon/2);
    DECLARE @c FLOAT = 2 * ATN2(SQRT(@a), SQRT(1-@a));
    DECLARE @distance FLOAT = @earthRadius * @c;
    
    RETURN @distance; -- Returns distance in kilometers
END
