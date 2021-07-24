/**
        +--------------------------+
        |        DBI202_LAB        | 
        |          LAB02           |
        |       Ho Nhat Minh       |
        |         FX03283          |
        +--------------------------+
**/

-- Tạo Database
DROP DATABASE IF EXISTS DBI202_LAB
GO

CREATE DATABASE DBI202_LAB
GO

-- I. Tạo các bảng và ràng buộc
-- Bảng KHACHANG
CREATE TABLE KHACHHANG
(
    MAKH NVARCHAR(5) NOT NULL PRIMARY KEY,
    TENKH NVARCHAR(30) NOT NULL,
    DIACHI NVARCHAR(300),
    DT VARCHAR(10),
    EMAIL VARCHAR(30)
)
-- Ràng buộc cần có trong bảng: TENKH not null, 
-- DT có thể từ 7 đến 10 chữ số. 
ALTER TABLE KHACHHANG
ADD CONSTRAINT chk_khachhang_dt CHECK (LEN(DT) BETWEEN 7 AND 10)

-- Bảng VATTU
CREATE TABLE VATTU
(
    MAVT NVARCHAR(5) NOT NULL PRIMARY KEY,
    TENVT NVARCHAR(30) NOT NULL,
    DVT NVARCHAR(20),
    GIAMUA MONEY,
    SLTON INT
)
-- Ràng buộc cần có trong bảng:
-- TENVT not null, GIAMUA >0, SLTON >=0.
ALTER TABLE VATTU
ADD CONSTRAINT chk_vattu_giamua CHECK (GIAMUA > 0)

ALTER TABLE VATTU
ADD CONSTRAINT chk_vattu_slton CHECK (SLTON >= 0)

-- Bảng HOADON
CREATE TABLE HOADON
(
    MAHD NVARCHAR(10) NOT NULL PRIMARY KEY,
    NGAY DATETIME,
    MAKH NVARCHAR(5),
    TONGTG MONEY
)
-- Ràng buộc cần có trong bảng: MAKH là khóa ngoại tham chiếu tới MAKH trong bảng KHACHHANG.
ALTER TABLE HOADON
ADD FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)

-- Bảng CHITIETHOADON
CREATE TABLE CHITIETHOADON
(
    MAHD NVARCHAR(10) NOT NULL PRIMARY KEY,
    MAVT NVARCHAR(5),
    SL INT,
    KHUYENMAI DECIMAL,
    GIABAN MONEY
)
-- Ràng buộc cần có trong bảng MAHD là khóa ngoại tham chiếu tới MAHD trong bảng HOADON, MAVT là khóa ngoại tham chiếu tới MAVT trong bảng VATTU. Giá trị nhập vào cho trường SL phải lớn hơn 0
ALTER TABLE CHITIETHOADON
ADD FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD)

ALTER TABLE CHITIETHOADON
ADD FOREIGN KEY (MAVT) REFERENCES VATTU(MAVT)

ALTER TABLE CHITIETHOADON
ADD CONSTRAINT chk_chitiethoadon_sl CHECK (SL > 0)
