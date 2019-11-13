create database ADBTeamHaNganSpatialDB
go

use ADBTeamHaNganSpatialDB
go

create table land 
(
	MAMUCDICH NVARCHAR(10),
	YNGHIAMD NVARCHAR(50),
	MDNUOC int,
	MATDODTHU float,
	VITRI geometry
)

INSERT INTO land VALUES(N'M7',N'Trồng lúa',75000,250.6,GEOMETRY::STPolyFromText('POLYGON((1 0, 1 -4,-2 -5, -2 -1, -1 0, 1 0),(5 0,7 0, 7 -5, 5 -5, 3 -3, 6 -2,5 0))',4326))
go
INSERT INTO land VALUES(N'M8',N'Trồng cây ăn quả',45000,350.4,GEOMETRY::STPolyFromText('POLYGON((1 -3, 3 -3,3 -5, -2 -5,1 -4,1 -3))',4326))
go
INSERT INTO land VALUES(N'M9',N'Trồng rau',35000,450.5,GEOMETRY::STPolyFromText('POLYGON((1 0, 2 1,5 0, 5 -2,3 -3,1 -3, 1 0))',4326))
go
select * from land