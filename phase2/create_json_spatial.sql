Use SKS_National_Bank;

GO

ALTER TABLE Address ADD AddressJSON NVARCHAR (MAX);

GO
UPDATE Address
SET
    AddressJSON = (
        SELECT
            Address_ID,
            City_Name,
            Province_Name L,
            Street_Number,
            Street_Name,
            Appt_Number
        FROM Address AS a
        WHERE
            a.Address_ID = Address.Address_ID FOR JSON PATH,
            INCLUDE_NULL_VALUES,
            WITHOUT_ARRAY_WRAPPER
    );
GO

SELECT * FROM Address
SELECT * FROM Facilities

--Add Spatial data
ALTER TABLE Facilities ADD Geom GEOMETRY
ALTER TABLE Facilities ADD Geog GEOGRAPHY
--Add the latitude and longtitude of each facility
ALTER TABLE Facilities ADD Latitude FLOAT
ALTER TABLE Facilities ADD Longitude FLOAT

--Declare the coordinates
--Longitude and Latitude coordinates on where the bank is located
DECLARE @geog GEOGRAPHY = GEOGRAPHY::STPointFromText('POINT(-114.06933 51.04639)', 4326)
--Polygon that represents the building of the bank 
DECLARE @geom GEOMETRY = GEOMETRY::STPolyFromText('POLYGON((566119 5659318, 566121 5659318, 566122 5659320, 566120 5659321, 566119 5659319, 566119 5659318))', 0)
--Update and put it in the table using PK and FK
UPDATE 
	Facilities 
		SET 
			Geom = @geom, Geog = @geog
		WHERE
			Facility_ID = 1 AND Address_ID = 1
--Update Lat and Long columns to have their respective coordinates
UPDATE 
	Facilities
	SET 
		Latitude = Geog.Lat, Longitude = Geog.Long
	WHERE 
		Facility_ID = 1 AND Address_ID = 1
GO
	
--Bank 2
DECLARE @geog GEOGRAPHY = GEOGRAPHY::STPointFromText('POINT(-114.07323 51.00125)', 4326)
DECLARE @geom GEOMETRY = GEOMETRY::STPolyFromText('POLYGON((566100 5659300, 566105 5659305, 566110 5659310, 566115 5659305, 566110 5659300, 566100 5659300))', 0)

UPDATE 
	Facilities 
		SET 
			Geom = @geom, Geog = @geog
		WHERE
			Facility_ID = 2 AND Address_ID = 2

UPDATE 
	Facilities
	SET 
		Latitude = Geog.Lat, Longitude = Geog.Long
	WHERE 
		Facility_ID = 2 AND Address_ID = 2
GO
	
--Bank 3
DECLARE @geog GEOGRAPHY = GEOGRAPHY::STPointFromText('POINT(-114.07044 51.04642)', 4326)
DECLARE @geom GEOMETRY = GEOMETRY::STPolyFromText('POLYGON((566120 5659315, 566125 5659318, 566128 5659322, 566122 5659325, 566120 5659320, 566120 5659315))', 0)

UPDATE 
	Facilities 
		SET	
			Geom = @geom, Geog = @geog
		WHERE 
			Facility_ID = 3 AND Address_ID = 3

UPDATE 
	Facilities
		SET 
			Latitude = Geog.Lat, Longitude = Geog.Long
		WHERE 
			Facility_ID = 3 AND Address_ID = 3
GO
	
--Bank 4
DECLARE @geog GEOGRAPHY = GEOGRAPHY::STPointFromText('POINT(-114.05482 51.04769)', 4326)
DECLARE @geom GEOMETRY = GEOMETRY::STPolyFromText('POLYGON((566110 5659320, 566112 5659325, 566115 5659330, 566111 5659335, 566109 5659329, 566110 5659320))', 0)

UPDATE 
	Facilities 
		SET 
			Geom = @geom, Geog = @geog
		WHERE
			Facility_ID = 4 AND Address_ID = 4

UPDATE
	Facilities
		SET 
			Latitude = Geog.Lat, Longitude = Geog.Long
		WHERE
			Facility_ID = 4 AND Address_ID = 4
GO
	
--Bank 5
DECLARE @geog GEOGRAPHY = GEOGRAPHY::STPointFromText('POINT(-114.06139 51.05047)', 4326)
DECLARE @geom GEOMETRY = GEOMETRY::STPolyFromText('POLYGON((566130 5659340, 566135 5659345, 566138 5659350, 566132 5659352, 566129 5659346, 566130 5659340))', 0)

UPDATE 
	Facilities 
		SET 
			Geom = @geom, Geog = @geog
		WHERE 
			Facility_ID = 5 AND Address_ID = 5

UPDATE 
	Facilities
		SET
			Latitude = Geog.Lat, Longitude = Geog.Long
		WHERE 
			Facility_ID = 5 AND Address_ID = 5
GO
	
--Bank 6
DECLARE @geog GEOGRAPHY = GEOGRAPHY::STPointFromText('POINT(-114.08151 51.04587)', 4326)
DECLARE @geom GEOMETRY = GEOMETRY::STPolyFromText('POLYGON((566140 5659360, 566145 5659365, 566148 5659370, 566142 5659375, 566139 5659369, 566140 5659360))', 0)

UPDATE 
	Facilities 
		SET
			Geom = @geom, Geog = @geog
		WHERE 
			Facility_ID = 6 AND Address_ID = 6

UPDATE 
	Facilities
		SET 
			Latitude = Geog.Lat, Longitude = Geog.Long
		WHERE
			Facility_ID = 6 AND Address_ID = 6
GO
