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
--Câu 2a: Cho biết lượng nước tưới cần thiết của mỗi loại đất.
select MAMUCDICH,YNGHIAMD,VITRI.MakeValid().STArea()*MDNUOC/10000 as N'Lượng nước tưới cần thiết(m3)'
from land
--câu 2b: Cho biết loại đất có diện tích bé nhất
select MAMUCDICH,YNGHIAMD
from land
where VITRI.MakeValid().STArea()=(select MIN(VITRI.MakeValid().STArea())
from land)
/*Câu 2c: Giả sử ta cần đào 1 kênh nước để dẫn nước tưới tiêu. 
Kênh nước này được giới hạn bởi 2 đường thẳng song song với Oy và lần lượt qua điểm A(2, 4) và B(4,-2).
Hãy cho biết diện tích bị mất sau ứng với mỗi loại sau khi xây dựng kênh nước này*/
declare @canal Geometry
set @canal=Geometry::STPolyFromText('POLYGON((2 -2,4 -2,4 4,2 4,2 -2))',4326)
select MAMUCDICH,YNGHIAMD,@canal.MakeValid().STIntersection(VITRI.MakeValid()).STArea() as N'Diện tích bị mất()'
from land