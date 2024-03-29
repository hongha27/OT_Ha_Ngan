﻿CREATE DATABASE SPARTIAL
GO
USE SPARTIAL
GO
CREATE TABLE LAND(
	ID int identity(1,1) primary key,
	CMND varchar(10),
	TEN nvarchar(50),
	VITRI geometry

)
GO
insert into LAND values('264534610','A',GEOMETRY::STPolyFromText('POLYGON((1 6,1 3,5 2,7 3,7 6,1 6),(-1 1,2 1,2 0,-1 1))',4326));
GO
INSERT INTO LAND VALUES('264521111','B',GEOMETRY::STPolyFromText('POLYGON((1 3,1 6,-4 6,-4 3,1 3))',4326));
GO
INSERT INTO LAND VALUES('264570000','C',GEOMETRY::STPolyFromText('POLYGON((2 0,2 -2,-4 -2,-4 1,-1 1,2 0))',4326));
GO
INSERT INTO LAND VALUES('264569292','D',GEOMETRY::STPolyFromText('POLYGON((2 1,9 0,9 -2,2 -2,2 1))',4326));
GO
INSERT INTO LAND VALUES('264569292','E',GEOMETRY::STPolyFromText('POLYGON((7 6,9 6,9 2,5 2,7 3,7 6))',4326));
GO
INSERT INTO LAND VALUES('264569292','F',GEOMETRY::STPolyFromText('POLYGON((9 6,9 2,10 2,10 5,15 5,15 6,9 6))',4326));
GO
INSERT INTO LAND VALUES('264569292','G',GEOMETRY::STPolyFromText('POLYGON((10 2,10 5,15 5,15 3,10 2))',4326));
GO
INSERT INTO LAND VALUES('264569292','H',GEOMETRY::STPolyFromText('POLYGON((9 0, 15 1,15 -2,9 -2,9 0))',4326));
GO

SELECT * FROM LAND
GO
--------LAB 7------------
--Cho biết các mảnh đất của ông/bà D tiếp giáp với những mảnh đất của ông/bà nào? --
ALTER PROC KTRA (@TEN VARCHAR(10))
AS
BEGIN
DECLARE @D GEOMETRY
SET @D=(
SELECT VITRI.MakeValid()
FROM LAND
WHERE TEN=@TEN)
--select @D
SELECT TEN	
FROM LAND
WHERE @D.MakeValid().STTouches(VITRI.MakeValid())=1	
END 
--Các mảnh đất tiếp giáp với mảnh đất của ông/bà A
declare @D Geometry
set @D=(select VITRI.MakeValid() from LAND where TEN='D')
select TEN, VITRI.MakeValid().STArea()
from LAND
--where 
--
declare @W geometry
set @W=GEOMETRY::STPolyFromText('POLYGON((-4 0,-4 3,15 3,15 0,-4 0))',4326)
--select @W
select TEN,@W.MakeValid().STIntersection(VITRI.MakeValid()).STArea() as DienTichBiMat,VITRI.MakeValid().STDifference(@W.MakeValid().STIntersection(VITRI.MakeValid())) as VITRI
from LAND

EXEC KTRA @TEN='A'

-----

DECLARE @M GEOMETRY
DECLARE @N GEOMETRY
set @M= GEOMETRY::STGeomFromText('LINESTRING (0 3,1 3)', 0)
set @N= GEOMETRY::STGeomFromText('LINESTRING (0 0,0 3)', 0)
SELECT @M
SELECT @N


