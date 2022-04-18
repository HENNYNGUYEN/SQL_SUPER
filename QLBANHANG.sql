/*CO SO DU LIEU QUAN LI BAN HANG*/
--Tao Database
Create Database QLBANHANG
--Tao Table
Create table KHACHHANG
( MAKH varchar(5) primary key,
  TENKH nvarchar(30) NOT NULL,
  DIACHI nvarchar(50),
  DT varchar(30),
  EMAIL varchar(30)
)
Create table VATTU
(
  MAVT varchar(5) primary key,
  TENVT nvarchar(30) NOT NULL,
  DVT nvarchar(20),
  GIAMUA Money,
  SLTON int
)
Create table HOADON
(
  MAHD varchar(10) primary key ,
  NGAY date,
  MAKH varchar(5) ,
  TONGTG float,
)
Create table CTHD 
(
  MAHD varchar(10),
  MAVT varchar(5), 
  SL int,
  KHUYENMAI float,
  GIABAN float,
  CONSTRAINT KhoaChinh1 primary key (MAHD,MAVT)
)
--KHOA NGOAI
Alter Table HOADON add Constraint KN_MAKH foreign key (MAKH)  references KHACHHANG (MAKH)
Alter Table CTHD add Constraint KN_MAVT foreign key (MAVT)  references VATTU (MAVT)
Alter Table CTHD add Constraint KN_MAHD foreign key (MAHD) references HOADON (MAHD)

-- RBTV
Alter Table KHACHHANG add Constraint RB_DT check (DT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
Alter Table VATTU add Constraint RB_GIAMUA check (GIAMUA>0 AND SLTON>=10)
Alter Table HOADON add Constraint RB_NGAY check(NGAY>GETDATE()) 
Alter Table CTHD add Constraint RB_SL check (SL>0)
-- INSERT DATA
INSERT INTO VATTU values
('VT01',N'Xi măng',N'Bao',50000,5000),
('VT02',N'Cát',N'Khối',45000,50000),
('VT03',N'Gạch ống',N'Viên',120,800000),
('VT04',N'Gạch thẻ',N'Viên',110,800000),
('VT05',N'Đá lớn',N'Khối',25000,100000),
('VT06',N'Đá nhỏ',N'Khối',33000,100000),
('VT07',N'Lam gió',N'Cái',15000,50000)
GO
INSERT INTO KHACHHANG values
('KH01',N'Nguyễn Thị Bé',N'Tân Bình','0138457895','bnt@yahoo.com'),
('KH02',N'Lê Hoàng Nam',N'Bình Chánh','0139878987','namlehoang@gmail.com'),
('KH03',N'Trần Thị Chiêu',N'Tân Bình','0138457895',NULL),
('KH04',N'Mai Thị Quế Anh',N'Bình Chánh',NULL,NULL),
('KH05',N'Lê Văn Sáng',N'Quận 10',NULL,'sanglv@hcm.vnn.vn'),
('KH06',N'Trần Hoàng',N'Tân Bình','0138457897',NULL)
GO
SET DATEFORMAT dmy;
INSERT INTO HOADON values
('HD001',N'12/05/2023','KH01',NULL),
('HD002',N'25/05/2023','KH02',NULL),
('HD003',N'25/05/2023','KH01',NULL),
('HD004',N'25/05/2023','KH04',NULL),
('HD005',N'26/05/2023','KH04',NULL),
('HD006',N'02/06/2023','KH03',NULL),
('HD007',N'22/06/2023','KH04',NULL),
('HD008',N'25/06/2023','KH03',NULL),
('HD009',N'15/08/2023','KH04',NULL),
('HD010',N'30/09/2023','KH01',NULL)
GO
INSERT INTO CTHD values
('HD001','VT01',5,NULL,52000),
('HD001','VT05',10,NULL,30000),
('HD002','VT03',10000,NULL,150),
('HD003','VT02',20,NULL,55000),
('HD004','VT03',50000,NULL,150),
('HD004','VT04',20000,NULL,120),
('HD005','VT05',10,NULL,30000),
('HD005','VT06',15,NULL,35000),
('HD005','VT07',20,NULL,17000),
('HD006','VT04',10000,NULL,120),
('HD007','VT04',20000,NULL,125),
('HD008','VT01',100,NULL,55000),
('HD008','VT02',20,NULL,47000),
('HD009','VT02',25,NULL,48000),
('HD010','VT01',25,NULL,57000)
-- PHAN VIEW
--1. Hiển thị danh sách các khách hàng có địa chỉ là “Tân Bình” gồm mã khách
--hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
	
	CREATE VIEW V1
	AS
	SELECT * 
	FROM KHACHHANG
	WHERE DIACHI='Tân Bình'
	-- XEM DU LIEU
	SELECT * FROM V1

--2. Hiển thị danh sách các khách hàng gồm các thông tin mã khách hàng, tên
--khách hàng, địa chỉ và địa chỉ E-mail của những khách hàng chưa có số điện thoại.

	CREATE VIEW V2 AS
	SELECT * FROM KHACHHANG WHERE DT IS NULL 
	--XEM DU LIEU 
	SELECT * FROM V2

--3. Hiển thị danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa
--chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ.
	CREATE VIEW V3 AS
	SELECT MAKH,TENKH,DIACHI FROM KHACHHANG WHERE DT IS NULL AND EMAIL IS NULL 
	--XEM DU LIEU 
	SELECT * FROM V3
--4. Hiển thị danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm
--mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
	CREATE VIEW V4 AS
	SELECT MAKH,TENKH,DIACHI,DT,EMAIL FROM KHACHHANG WHERE DT IS NOT NULL AND EMAIL IS NOT NULL
	--XEM DU LIEU 
	SELECT * FROM V4
--5. Hiển thị danh sách các vật tư có đơn vị tính là “Cái” gồm mã vật tư, tên vật tư
--và giá mua.
	CREATE VIEW V5 AS
	SELECT MAVT,TENVT,GIAMUA FROM VATTU WHERE DVT='Cái'
	--XEM DU LIEU 
	SELECT * FROM V5
--6. Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá
--mua mà có giá mua trên 25000.
	CREATE VIEW V6 AS
	SELECT MAVT,TENVT,DVT,GIAMUA FROM VATTU WHERE GIAMUA>25000
	--XEM DU LIEU 
	SELECT * FROM V6
--7. Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật
--tư, tên vật tư, đơn vị tính và giá mua.
	CREATE VIEW V7 AS
	SELECT MAVT,TENVT,DVT,GIAMUA FROM VATTU WHERE TENVT LIKE N'Gạch%'
	--XEM DU LIEU 
	SELECT * FROM V7
--8. Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá
--mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
	CREATE VIEW V8 AS
	SELECT MAVT,TENVT,DVT,GIAMUA FROM VATTU WHERE GIAMUA BETWEEN 20000 AND 40000
	--XEM DU LIEU 
	SELECT * FROM V8
--9. Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa
--chỉ khách hàng và số điện thoại.
	CREATE VIEW V9 AS
	SELECT MAHD,NGAY AS NGAYLAPHOADON,TENKH,DIACHI,DT AS SODIENTHOAI FROM KHACHHANG, HOADON 
	WHERE HOADON.MAKH=KHACHHANG.MAKH
	--XEM DU LIEU 
	SELECT * FROM V9
--10. Lấy ra các thông tin gồm Mã hóa đơn, tên khách hàng, địa chỉ khách hàng và
--số điện thoại của ngày 25/5/2010.
	CREATE VIEW V10 AS
	SELECT MAHD,TENKH,DIACHI,DT FROM HOADON,KHACHHANG WHERE NGAY=N'25/5/2023' 
	AND HOADON.MAKH=KHACHHANG.MAKH
	--XEM DU LIEU 
	SELECT * FROM V10
--11.Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và
-- số điện thoại của những hóa đơn trong tháng 6/2010.
	CREATE VIEW V11 AS
	SELECT MAHD,TENKH,DIACHI,DT FROM KHACHHANG,HOADON WHERE MONTH(NGAY)=6 AND HOADON.MAKH=KHACHHANG.MAKH
	--XEM DU LIEU 
	SELECT * FROM V11
--12.Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2010.
	CREATE VIEW V12 AS 
	SELECT TENKH,DIACHI,DT FROM KHACHHANG,HOADON WHERE MONTH(NGAY)=6 AND HOADON.MAKH=KHACHHANG.MAKH
	--XEM DU LIEU 
	SELECT * FROM V12
--13.Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2010 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
	CREATE VIEW V13 AS
	SELECT DISTINCT TENKH,DIACHI,DT FROM KHACHHANG,HOADON WHERE MONTH(NGAY)<>6 AND KHACHHANG.MAKH=HOADON.MAKH
	--XEM DU LIEU 
	SELECT * FROM V13
--14.Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính,
-- giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng).
	CREATE VIEW V14 AS
	SELECT  MAHD,VATTU.MAVT,TENVT,DVT, GIAMUA,GIABAN,SL,GIAMUA*SL AS TRIGIAMUA, GIABAN*SL AS TRIGIABAN
	FROM VATTU,CTHD WHERE VATTU.MAVT=CTHD.MAVT
	--XEM DU LIEU 
	SELECT * FROM V14
--15.Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư,
-- đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), 
-- trị giá bán (giá bán * số lượng) mà có giá bán lớn hơn hoặc bằng giá mua.
	CREATE VIEW V15 AS 
	SELECT  MAHD,VATTU.MAVT,TENVT,DVT, GIAMUA,GIABAN,SL,GIAMUA*SL AS TRIGIAMUA, GIABAN*SL AS TRIGIABAN
	FROM VATTU,CTHD WHERE VATTU.MAVT=CTHD.MAVT AND GIABAN>=GIAMUA
	--XEM DU LIEU 
	SELECT * FROM V15
--16.Lấy ra các thông tin gồm mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá
--bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán* số lượng) 
--và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lớn hơn 100.
	CREATE VIEW V16 AS
	SELECT  MAHD,VATTU.MAVT,TENVT,DVT, GIAMUA,GIABAN,SL,GIAMUA*SL AS TRIGIAMUA, GIABAN*SL AS TRIGIABAN,KHUYENMAI=0.1
	FROM VATTU,CTHD WHERE VATTU.MAVT=CTHD.MAVT AND SL>100
	--XEM DU LIEU 
	SELECT * FROM V16
--17. Tìm ra những mặt hàng chưa bán được.
	CREATE VIEW V17 as
	SELECT * FROM VATTU 
	WHERE MAVT NOT IN (SELECT MAVT FROM CTHD)
	--XEM DU LIEU 
	SELECT * FROM V17
--1.18 Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, 
--giá mua, giá bán, số lượng, trị giá mua, trị giá bán.
	CREATE VIEW V18 AS
	SELECT  HOADON.MAHD,NGAY,TENKH,DIACHI,DT,TENVT,DVT,GiABAN,GIAMUA,SL,GIAMUA*SL AS TRIGIAMUA,GiABAN*SL AS TRIGIABAN
	FROM KHACHHANG,HOADON,VATTU,CTHD
	WHERE HOADON.MAHD=CTHD.MAHD
	AND VATTU.MAVT=CTHD.MAVT AND KHACHHANG.MAKH=HOADON.MAKH
	--XEM DU LIEU 
	SELECT * FROM V18
	--1.19. Tạo bảng tổng hợp tháng 5/2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, 
	--số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán.
	CREATE VIEW V19 AS
	SELECT  HOADON.MAHD,NGAY,TENKH,DIACHI,DT,TENVT,DVT,GiABAN,GIAMUA,SL,GIAMUA*SL AS TRIGIAMUA,GiABAN*SL AS TRIGIABAN
	FROM KHACHHANG,HOADON,VATTU,CTHD
	WHERE HOADON.MAHD=CTHD.MAHD
	AND VATTU.MAVT=CTHD.MAVT AND KHACHHANG.MAKH=HOADON.MAKH AND MONTH(NGAY)=5
	--XEM DU LIEU 
	SELECT * FROM V19
	--20.Tạo bảng tổng hợp quý 1 – 2010 gồm các thông tin: mã hóa đơn, ngày hóa
	--đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua,
	--giá bán, số lượng, trị giá mua, trị giá bán.
	CREATE VIEW V20 AS
	SELECT  HOADON.MAHD,NGAY,TENKH,DIACHI,DT,TENVT,DVT,GiABAN,GIAMUA,SL,GIAMUA*SL AS TRIGIAMUA,GiABAN*SL AS TRIGIABAN
	FROM KHACHHANG,HOADON,VATTU,CTHD
	WHERE HOADON.MAHD=CTHD.MAHD
	AND VATTU.MAVT=CTHD.MAVT AND KHACHHANG.MAKH=HOADON.MAKH AND NGAY BETWEEN '1/1/2023' AND '31/3/2023'
	--XEM DU LIEU 
	SELECT * FROM V20
	--21.Lấy ra danh sách các hóa đơn gồm các thông tin: Số hóa đơn, ngày, tên khách
	--hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
	CREATE VIEW V21 AS
	SELECT HOADON.MAHD,NGAY,DIACHI,TONGTG=SL*GiABAN
	FROM HOADON,KHACHHANG,CTHD
	WHERE HOADON.MAKH=KHACHHANG.MAKH AND CTHD.MAHD=HOADON.MAHD
		--XEM DU LIEU 
	SELECT * FROM V21
	--22.Lấy ra hóa đơn có tổng trị giá lớn nhất gồm các thông tin: Số hóa đơn, ngày,
	--tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
	CREATE VIEW V22 AS
	SELECT HOADON.MAHD,NGAY,DIACHI,TONGTG=SL*GiABAN
	FROM HOADON,KHACHHANG,CTHD
	WHERE HOADON.MAKH=KHACHHANG.MAKH AND CTHD.MAHD=HOADON.MAHD
	--XEM DU LIEU
	SELECT  * FROM V22
	WHERE TONGTG=(select max(TONGTG) from V22)
	----23.Lấy ra hóa đơn có tổng trị giá lớn nhất trong tháng 5/2010 gồm các thông tin:
	--Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
	CREATE VIEW V23 AS
	SELECT HOADON.MAHD,NGAY,TENKH,DIACHI,TONGTG=SL*GIABAN FROM CTHD,HOADON,KHACHHANG
	WHERE MONTH(NGAY)=5 AND CTHD.MAHD=HOADON.MAHD AND HOADON.MAKH=KHACHHANG.MAKH 
	-- XEM DU LIEU 
	SELECT * FROM V23 
	WHERE TONGTG=(SELECT MAX(TONGTG) FROM V23)
	--24.	Đếm xem mỗi khách hàng có bao nhiêu hóa đơn.
	CREATE VIEW V24 AS
	SELECT MAKH,COUNT(MAHD) AS [TỔNG HÓA ĐƠN]  FROM HOADON  GROUP BY MAKH 
	-- XEM DU LIEU 
	SELECT * FROM V24                                                                                                                                                                 
	--25.	Đếm xem mỗi khách hàng, mỗi tháng có bao nhiêu hóa đơn.
	CREATE VIEW V25 AS
	SELECT  MONTH(NGAY) AS [THÁNG] ,MAKH, COUNT(MAHD) AS [TỔNG HÓA ĐƠN] FROM HOADON GROUP BY MAKH,NGAY
	-- XEM DU LIEU 
	SELECT * FROM V25
	--26.	Lấy ra các thông tin của khách hàng có số lượng hóa đơn mua hàng nhiều nhất.

	--27.	Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
	--28.	Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hóa đơn nhất.
	--29.	Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất.
	--30.	Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, địa chỉ, số lượng hóa đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hóa đơn để trống)
