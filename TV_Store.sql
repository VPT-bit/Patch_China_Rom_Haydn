-- Tao CSDL
CREATE DATABASE TV_Store;
GO
USE TV_Store;
GO

-- Bang 1: Khach hang
CREATE TABLE KhachHang (
    MaKH CHAR(10) CONSTRAINT PK_KhachHang PRIMARY KEY,
    HoTen NVARCHAR(50),
    SoDienThoai CHAR(10),
    DiaChi NVARCHAR(100),
    Email VARCHAR(50)
);
-- Bang 2: Nhan vien
CREATE TABLE NhanVien (
    MaNV CHAR(10) CONSTRAINT PK_NhanVien PRIMARY KEY,
    HoTen NVARCHAR(50),
    SoDienThoai CHAR(10),
    DiaChi NVARCHAR(100),
    NgayVaoLam DATE,
    Luong DECIMAL(10, 2)
);
-- Bang 3: Nha cung cap
CREATE TABLE NhaCungCap (
    MaNCC CHAR(10) CONSTRAINT PK_NhaCungCap PRIMARY KEY,
    TenNCC NVARCHAR(100),
    DiaChi NVARCHAR(100),
    SoDienThoai CHAR(10),
    Email VARCHAR(50)
);
-- Bang 4: San pham
CREATE TABLE SanPham (
    MaSP CHAR(10) CONSTRAINT PK_SanPham PRIMARY KEY,
    TenSP NVARCHAR(100),
    HangSanXuat NVARCHAR(50),
    KichThuocManHinh INT,
    GiaBan DECIMAL(15, 2),
    MoTa NVARCHAR(200),
    MaNCC CHAR(10),
    MaKM CHAR(10)
);
-- Bang 5: Kho hang
CREATE TABLE KhoHang (
    MaSP CHAR(10) CONSTRAINT PK_KhoHang PRIMARY KEY,
    SoLuongTon INT,
    NgayCapNhat DATE
);
-- Bang 6: Hoa don
CREATE TABLE HoaDon (
    MaHD CHAR(10) CONSTRAINT PK_HoaDon PRIMARY KEY,
    MaKH CHAR(10) NOT NULL,
    MaNV CHAR(10) NOT NULL,
    NgayBan DATE,
);
-- Bang 7: Chi tiet hoa don
CREATE TABLE ChiTietHoaDon (
    MaHD CHAR(10),
    MaSP CHAR(10),
    SoLuong INT,
    DonGia DECIMAL(15, 2),
    MucGiamGia DECIMAL(5, 2),
    CONSTRAINT PK_ChiTietHoaDon PRIMARY KEY (MaHD, MaSP)
);

-- Bang 8: Khuyen mai
CREATE TABLE KhuyenMai (
    MaKM CHAR(10) CONSTRAINT PK_KhuyenMai PRIMARY KEY,
    TenKM NVARCHAR(100),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    MucGiamGia DECIMAL(5, 2)
);

-- Bang 9: Bao hanh
CREATE TABLE BaoHanh (
    MaBH CHAR(10) CONSTRAINT PK_BaoHanh PRIMARY KEY,
    MaHD CHAR(10),
    MaSP CHAR(10),
    NgayMua DATE,
    ThoiHanBaoHanh INT,
    TinhTrang NVARCHAR(50)
);

-- Them rang buoc 
-- Bang KhachHang
ALTER TABLE KhachHang ADD CONSTRAINT CHK_Email CHECK (Email LIKE '%@%.%');
ALTER TABLE KhachHang ADD CONSTRAINT UQ_KH_SDT UNIQUE (SoDienThoai);
ALTER TABLE KhachHang ADD CONSTRAINT UQ_KH_Email UNIQUE (Email);
ALTER TABLE KhachHang ALTER COLUMN HoTen NVARCHAR(50) NOT NULL;

-- Bang NhanVien
ALTER TABLE NhanVien ADD CONSTRAINT UQ_NV_SDT UNIQUE (SoDienThoai);
ALTER TABLE NhanVien ADD CONSTRAINT CHK_Luong CHECK (Luong >= 0);
ALTER TABLE NhanVien ALTER COLUMN HoTen NVARCHAR(50) NOT NULL;
ALTER TABLE NhanVien ALTER COLUMN NgayVaoLam DATE NOT NULL;

-- Bang NhaCungCap
ALTER TABLE NhaCungCap ADD CONSTRAINT CHK_NCC_Email CHECK (Email LIKE '%@%.%');
ALTER TABLE NhaCungCap ADD CONSTRAINT UQ_NCC_SDT UNIQUE (SoDienThoai);
ALTER TABLE NhaCungCap ADD CONSTRAINT UQ_NCC_Email UNIQUE (Email);
ALTER TABLE NhaCungCap ALTER COLUMN TenNCC NVARCHAR(100) NOT NULL;

-- Bang SanPham
ALTER TABLE SanPham ADD CONSTRAINT CHK_KichThuoc CHECK (KichThuocManHinh > 0);
ALTER TABLE SanPham ADD CONSTRAINT CHK_GiaBan CHECK (GiaBan >= 0);
ALTER TABLE SanPham ALTER COLUMN TenSP NVARCHAR(100) NOT NULL;
ALTER TABLE SanPham ALTER COLUMN HangSanXuat NVARCHAR(50) NOT NULL;
ALTER TABLE SanPham ADD CONSTRAINT FK_SanPham_KhuyenMai FOREIGN KEY (MaKM) REFERENCES KhuyenMai(MaKM) ON DELETE SET NULL;
ALTER TABLE SanPham ADD CONSTRAINT FK_SanPham_NhaCungCap FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC) ON DELETE NO ACTION;
ALTER TABLE SanPham ADD CONSTRAINT UQ_SanPham_TenSP UNIQUE (TenSP);

-- Bang KhoHang
ALTER TABLE KhoHang ADD CONSTRAINT FK_KhoHang_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE;
ALTER TABLE KhoHang ADD CONSTRAINT CHK_SoLuongTon CHECK (SoLuongTon >= 0);
ALTER TABLE KhoHang ALTER COLUMN NgayCapNhat DATE NOT NULL;

-- Bang HoaDon
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH) ON DELETE NO ACTION;
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_NhanVien FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV) ON DELETE NO ACTION;
ALTER TABLE HoaDon ALTER COLUMN NgayBan DATE NOT NULL;
ALTER TABLE HoaDon ADD CONSTRAINT CHK_NgayBan CHECK (NgayBan <= GETDATE());

-- Bang ChiTietHoaDon
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT FK_ChiTietHoaDon_HoaDon FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD) ON DELETE CASCADE;
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT FK_ChiTietHoaDon_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP);
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT CHK_SoLuong CHECK (SoLuong > 0);
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT CHK_DonGia CHECK (DonGia >= 0);
ALTER TABLE ChiTietHoaDon ALTER COLUMN DonGia DECIMAL(15, 2) NOT NULL;
ALTER TABLE ChiTietHoaDon ALTER COLUMN SoLuong INT NOT NULL;
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT CHK_MucGiamGia_ChiTiet CHECK (MucGiamGia >= 0 AND MucGiamGia < 100);

-- Bang KhuyenMai
ALTER TABLE KhuyenMai ADD CONSTRAINT CHK_MucGiamGia CHECK (MucGiamGia >= 0 AND MucGiamGia <= 100);
ALTER TABLE KhuyenMai ADD CONSTRAINT CHK_NgayKM CHECK (NgayBatDau < NgayKetThuc);
ALTER TABLE KhuyenMai ALTER COLUMN TenKM NVARCHAR(100) NOT NULL;
ALTER TABLE KhuyenMai ALTER COLUMN NgayBatDau DATE NOT NULL;
ALTER TABLE KhuyenMai ALTER COLUMN NgayKetThuc DATE NOT NULL;

-- Bang BaoHanh
ALTER TABLE BaoHanh ADD CONSTRAINT FK_BaoHanh_ChiTietHoaDon FOREIGN KEY (MaHD, MaSP) REFERENCES ChiTietHoaDon(MaHD, MaSP);
ALTER TABLE BaoHanh ALTER COLUMN NgayMua DATE NOT NULL;
ALTER TABLE BaoHanh ALTER COLUMN ThoiHanBaoHanh INT NOT NULL;
ALTER TABLE BaoHanh ALTER COLUMN TinhTrang NVARCHAR(50) NOT NULL;
ALTER TABLE BaoHanh ADD CONSTRAINT CHK_ThoiHanBaoHanh CHECK (ThoiHanBaoHanh >= 0);
ALTER TABLE BaoHanh ADD CONSTRAINT CHK_NgayMua CHECK (NgayMua <= GETDATE());

--THEM DU LIEU VAO CAC BANG
-- NhaCungCap
INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChi, SoDienThoai, Email) VALUES 
('NCC001', N'Công ty Samsung Việt Nam', N'789 Đường Samsung, Quận 7', '0967890123', 'samsungvn@example.com'),
('NCC002', N'Công ty LG Electronics', N'456 Đường LG, Quận 8', '0978901234', 'lgelectronics@example.com'),
('NCC003', N'Công ty Sony Việt Nam', N'123 Đường Sony, Quận 9', '0989012345', 'sonyvn@example.com'),
('NCC004', N'Công ty TCL Việt Nam', N'1515 Đường ABC, Quận 8', '0936789012', 'tclvn@example.com'),
('NCC005', N'Công ty Panasonic Việt Nam', N'1616 Đường DEF, Quận 9', '0947890123', 'panasonicvn@example.com'),
('NCC006', N'Công ty Sharp Việt Nam', N'1717 Đường GHI, Quận 10', '0958901234', 'sharpvn@example.com'),
('NCC007', N'Công ty Xiaomi Việt Nam', N'1818 Đường JKL, Quận 11', '0969012345', 'xiaomivn@example.com'),
('NCC008', N'Công ty Toshiba Việt Nam', N'1919 Đường MNO, Quận 12', '0970123456', 'toshibavn@example.com'),
('NCC009', N'Công ty Philips Việt Nam', N'2020 Đường PQR, Thủ Đức', '0981234567', 'philipsvn@example.com'),
('NCC010', N'Công ty Vizio Việt Nam', N'2121 Đường STU, Quận 1', '0992345678', 'viziovn@example.com');

-- KhuyenMai
INSERT INTO KhuyenMai (MaKM, TenKM, NgayBatDau, NgayKetThuc, MucGiamGia) VALUES 
('KM001', N'Khuyến mãi mùa hè', '2023-06-01', '2023-06-30', 10.00),
('KM002', N'Khuyến mãi quốc khánh', '2023-09-01', '2023-09-03', 15.00),
('KM003', N'Khuyến mãi cuối năm', '2023-12-01', '2023-12-31', 20.00),
('KM004', N'Khuyến mãi Tết 2024', '2024-01-15', '2024-02-15', 25.00),
('KM005', N'Khuyến mãi mùa xuân', '2024-03-01', '2024-03-31', 12.00),
('KM006', N'Khuyến mãi 30/4', '2024-04-25', '2024-05-01', 18.00),
('KM007', N'Khuyến mãi hè 2024', '2024-06-01', '2024-06-30', 15.00),
('KM008', N'Khuyến mãi back-to-school', '2024-08-01', '2024-08-31', 10.00),
('KM009', N'Khuyến mãi 2/9', '2024-09-01', '2024-09-03',35.00),
('KM010', N'Khuyến mãi Black Friday', '2024-11-20', '2024-11-30', 30.00);

-- SanPham
INSERT INTO SanPham (MaSP, TenSP, HangSanXuat, KichThuocManHinh, GiaBan, MoTa, MaNCC, MaKM) VALUES 
('SP001', N'TV Samsung 55 inch', N'Samsung', 55, 15000000.00, N'TV 4K, HDR', 'NCC001', 'KM001'),
('SP002', N'TV LG 65 inch', N'LG', 65, 25000000.00, N'TV OLED, Smart TV', 'NCC002', 'KM002'),
('SP003', N'TV Sony 50 inch beyond', N'Sony', 50, 18000000.00, N'TV Full HD, Android TV', 'NCC003', 'KM003'),
('SP004', N'TV TCL 43 inch', N'TCL', 43, 9000000.00, N'TV 4K, Smart TV', 'NCC004', 'KM004'),
('SP005', N'TV Panasonic 55 inch', N'Panasonic', 55, 16000000.00, N'TV LED, HDR', 'NCC005', 'KM005'),
('SP006', N'TV Sharp 50 inch', N'Sharp', 50, 12000000.00, N'TV Full HD', 'NCC006', 'KM006'),
('SP007', N'TV Xiaomi 65 inch', N'Xiaomi', 65, 20000000.00, N'TV OLED, Android TV', 'NCC007', 'KM007'),
('SP008', N'TV Toshiba 32 inch', N'Toshiba', 32, 6000000.00, N'TV HD, Smart TV', 'NCC008', 'KM008'),
('SP009', N'TV Philips 75 inch', N'Philips', 75, 30000000.00, N'TV 4K, Ambilight', 'NCC009', 'KM009'),
('SP010', N'TV Vizio 60 inch', N'Vizio', 60, 18000000.00, N'TV QLED, Smart TV', 'NCC010', 'KM010');

-- NhanVien
INSERT INTO NhanVien (MaNV, HoTen, SoDienThoai, DiaChi, NgayVaoLam, Luong) VALUES 
('NV001', N'Nguyễn Thị D', '0934567890', N'321 Đường XYZ, Quận 4', '2020-01-15', 10000000.00),
('NV002', N'Trần Văn E', '0945678901', N'654 Đường UVW, Quận 5', '2019-05-20', 12000000.00),
('NV003', N'Lê Thị F', '0956789012', N'987 Đường RST, Quận 6', '2021-03-10', 9000000.00),
('NV004', N'Phan Văn O', '0961234567', N'808 Đường FGH, Quận 1', '2022-01-10', 11000000.00),
('NV005', N'Lý Thị P', '0972345678', N'909 Đường IJK, Quận 2', '2022-03-15', 9500000.00),
('NV006', N'Huỳnh Văn Q', '0983456789', N'1010 Đường LMN, Quận 3', '2022-05-20', 13000000.00),
('NV007', N'Đinh Thị R', '0994567890', N'1111 Đường OPQ, Quận 4', '2022-07-25', 10000000.00),
('NV008', N'Tạ Văn S', '0935678901', N'1212 Đường RST, Quận 5', '2022-09-30', 20000000.00),
('NV009', N'Bành Thị T', '0946789012', N'1313 Đường UVW, Quận 6', '2022-11-05', 10500000.00),
('NV010', N'Lương Văn U', '0957890123', N'1414 Đường XYZ, Quận 7', '2023-01-10', 11500000.00);

-- KhachHang
INSERT INTO KhachHang (MaKH, HoTen, SoDienThoai, DiaChi, Email) VALUES 
('KH001', N'Nguyễn Văn A', '0901234567', N'123 Đường ABC, Quận 1', 'nguyenvana@example.com'),
('KH002', N'Trần Thị B', '0912345678', N'456 Đường DEF, Quận 2', 'tranthib@example.com'),
('KH003', N'Lê Văn C', '0923456789', N'789 Đường GHI, Quận 3', 'levanc@example.com'),
('KH004', N'Phạm Thị G', '0931234567', N'101 Đường KLM, Quận 7', 'phamthig@example.com'),
('KH005', N'Hoàng Văn H', '0942345678', N'202 Đường NOP, Quận 8', 'hoangvanh@example.com'),
('KH006', N'Đỗ Thị I', '0953456789', N'303 Đường QRS, Quận 9', 'dothi@example.com'),
('KH007', N'Vũ Văn K', '0964567890', N'404 Đường TUV, Quận 10', 'vuvank@example.com'),
('KH008', N'Ngô Thị L', '0975678901', N'505 Đường WXY, Quận 11', 'ngothil@example.com'),
('KH009', N'Trương Văn M', '0986789012', N'606 Đường ZAB, Quận 12', 'truongvanm@example.com'),
('KH010', N'Bùi Thị N', '0997890123', N'707 Đường CDE, Thủ Đức', 'buithin@example.com');

-- KhoHang
INSERT INTO KhoHang (MaSP, SoLuongTon, NgayCapNhat) VALUES 
('SP001', 50, '2023-10-01'),
('SP002', 30, '2023-12-01'),
('SP003', 40, '2024-8-01'),
('SP004', 60, '2024-01-01'),
('SP005', 45, '2024-02-01'),
('SP006', 50, '2024-03-01'),
('SP007', 35, '2024-04-01'),
('SP008', 70, '2024-05-01'),
('SP009', 25, '2024-06-01'),
('SP010', 40, '2024-07-01');

-- HoaDon
INSERT INTO HoaDon (MaHD, MaKH, MaNV, NgayBan) VALUES 
('HD001', 'KH001', 'NV001', '2023-10-15'),
('HD002', 'KH002', 'NV002', '2023-10-16'),
('HD003', 'KH003', 'NV003', '2023-10-17'),
('HD004', 'KH004', 'NV004', '2024-01-20'),
('HD005', 'KH005', 'NV005', '2024-02-25'),
('HD006', 'KH006', 'NV006', '2024-03-15'),
('HD007', 'KH007', 'NV007', '2024-04-10'),
('HD008', 'KH008', 'NV008', '2024-05-05'),
('HD009', 'KH009', 'NV009', '2024-06-12'),
('HD010', 'KH010', 'NV010', '2024-07-18');
-- ChiTietHoaDon
INSERT INTO ChiTietHoaDon (MaHD, MaSP, SoLuong, DonGia, MucGiamGia) VALUES 
('HD001', 'SP001', 1, 15000000.00, 10.00), 
('HD002', 'SP002', 1, 25000000.00, 15.00), 
('HD003', 'SP003', 1, 18000000.00, 20.00),
('HD004', 'SP004', 2, 9000000.00, 25.00),
('HD005', 'SP005', 1, 16000000.00, 12.00),
('HD006', 'SP006', 3, 12000000.00, 18.00),
('HD007', 'SP007', 1, 20000000.00, 15.00),
('HD008', 'SP008', 2, 6000000.00, 10.00),
('HD009', 'SP009', 1, 30000000.00, 35.00),
('HD010', 'SP010', 1, 18000000.00, 30.00);
-- BaoHanh
INSERT INTO BaoHanh (MaBH, MaHD, MaSP, NgayMua, ThoiHanBaoHanh, TinhTrang) VALUES 
('BH001', 'HD001', 'SP001', '2023-10-15', 12, N'Còn bảo hành'),
('BH002', 'HD002', 'SP002', '2023-10-16', 24, N'Còn bảo hành'),
('BH003', 'HD003', 'SP003', '2023-10-17', 18, N'Còn bảo hành'),
('BH004', 'HD004', 'SP004', '2024-01-20', 12, N'Còn bảo hành'),
('BH005', 'HD005', 'SP005', '2024-02-25', 24, N'Còn bảo hành'),
('BH006', 'HD006', 'SP006', '2024-03-15', 18, N'Còn bảo hành'),
('BH007', 'HD007', 'SP007', '2024-04-10', 36, N'Còn bảo hành'),
('BH008', 'HD008', 'SP008', '2024-05-05', 12, N'Còn bảo hành'),
('BH009', 'HD009', 'SP009', '2024-06-12', 24, N'Còn bảo hành'),
('BH010', 'HD010', 'SP010', '2024-07-18', 18, N'Còn bảo hành');

-- 3a:Truy vấn đơn giản: 3 câu
-- 1:Hiển thị danh sách sản phẩm và số lượng tồn kho
SELECT sp.MaSP, sp.TenSP, sp.HangSanXuat, sp.KichThuocManHinh,sp.GiaBan, kh.SoLuongTon
FROM SanPham sp 
JOIN KhoHang kh ON sp.MaSP = kh.MaSP;
--2:Hiển thị sản phẩm bán chạy nhất năm 2024
SELECT TOP 1 sp.MaSP, sp.TenSP, sp.HangSanXuat, SUM(ct.SoLuong) AS TongSoLuongBan
FROM ChiTietHoaDon ct
JOIN SanPham sp ON ct.MaSP = sp.MaSP
JOIN HoaDon hd on hd.MaHD=ct.MaHD
WHERE YEAR(hd.NgayBan)='2024'
GROUP BY sp.MaSP, sp.TenSP, sp.HangSanXuat
ORDER BY TongSoLuongBan DESC;
-- 3:Hiển thị danh sách các sản phẩm có số lượng tồn kho dưới mức tối thiểu(vd: duoi 10)
SELECT sp.MaSP, sp.TenSP, kh.SoLuongTon
FROM SanPham sp
LEFT JOIN KhoHang kh ON sp.MaSP = kh.MaSP
WHERE kh.SoLuongTon < 10;
--===============================--
-- 3b:Truy vấn với Aggregate Functions: 7 câu
-- 1:Hiển thị danh sách sản phẩm đã bán trong 1 ngày(vd: ngày 2023-10-16)
SELECT ct.MaSP,sp.TenSP,ct.SoLuong,ct.DonGia,ct.MucGiamGia, (ct.SoLuong * ct.DonGia * (1 - ct.MucGiamGia / 100)) AS DoanhThu
FROM ChiTietHoaDon ct
JOIN HoaDon hd ON ct.MaHD = hd.MaHD
JOIN SanPham sp ON ct.MaSP = sp.MaSP
WHERE hd.NgayBan = '2023-10-16'  
-- 2:Hiển thị doanh thu theo từng tháng trong năm 2024
SELECT MONTH(hd.NgayBan) AS Thang, SUM(ct.SoLuong * ct.DonGia * (1 - ct.MucGiamGia / 100)) AS DoanhThu
FROM HoaDon hd JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
WHERE YEAR(hd.NgayBan) = 2024
GROUP BY MONTH(hd.NgayBan)
ORDER BY Thang;
-- 3:Nhân viên có doanh thu cao nhất năm 2024
SELECT TOP 1 nv.HoTen, SUM(ct.SoLuong * ct.DonGia * (1 - ct.MucGiamGia / 100)) AS TongDoanhThu
FROM HoaDon hd
JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
JOIN NhanVien nv ON hd.MaNV = nv.MaNV
WHERE YEAR(hd.NgayBan) = 2024
GROUP BY nv.HoTen
ORDER BY TongDoanhThu DESC
-- 4:Số lượng hoá đơn theo từng chương trình khuyến mãi
SELECT km.TenKM, COUNT(DISTINCT hd.MaHD) AS SoLuongHoaDon
FROM HoaDon hd
JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
JOIN SanPham sp ON ct.MaSP = sp.MaSP
JOIN KhuyenMai km ON sp.MaKM = km.MaKM
GROUP BY km.TenKM
ORDER BY SoLuongHoaDon DESC;
-- 5:Hiển thị thông tin khách hàng đã chi tiêu nhiều nhất năm 2024
SELECT TOP 1 kh.MaKH, kh.HoTen, kh.Email, SUM(ct.SoLuong * ct.DonGia * (1 - ct.MucGiamGia / 100)) AS TongChiTieu
FROM HoaDon hd
JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
JOIN KhachHang kh ON hd.MaKH = kh.MaKH
WHERE YEAR(hd.NgayBan)='2024'
GROUP BY kh.MaKH, kh.HoTen, kh.Email
ORDER BY TongChiTieu DESC;
-- 6:Số lượng khách hàng trung thành(mua hàng nhiều hơn 1 lần)
SELECT COUNT(DISTINCT MaKH) AS SoKhachHangQuayLai
FROM (
    SELECT MaKH, COUNT(MaHD) AS SoLanMua
    FROM HoaDon
    GROUP BY MaKH
    HAVING COUNT(MaHD) > 1
) AS KhachHang;
-- 7:Doanh thu trung bình trên mỗi hoá đơn là bao nhiêu?
SELECT AVG(TongTien) AS DoanhThuTrungBinh
FROM (
    SELECT MaHD, SUM(SoLuong * DonGia * (1 - MucGiamGia / 100)) AS TongTien
    FROM ChiTietHoaDon
    GROUP BY MaHD
) AS DoanhThuHoaDon;
--===============================--
-- 3c:Truy ván với mệnh đề Having: 5 câu
-- 1: Hiển thị các khách hàng đã mua hàng ít nhất 3 lần trong năm 2024
SELECT kh.MaKH, kh.HoTen, COUNT(hd.MaHD) AS SoLanMua
FROM HoaDon hd
JOIN KhachHang kh ON hd.MaKH = kh.MaKH
WHERE YEAR(HD.NgayBan)='2024'
GROUP BY kh.MaKH, kh.HoTen
HAVING COUNT(hd.MaHD) >= 3
ORDER BY SoLanMua DESC;
-- 2. Hiển thị các tháng trong năm 2024 có số lượng hóa đơn trên 5
SELECT MONTH(hd.NgayBan) AS Thang, COUNT(hd.MaHD) AS SoLuongHoaDon
FROM HoaDon hd
WHERE YEAR(hd.NgayBan) = 2024
GROUP BY MONTH(hd.NgayBan)
HAVING COUNT(hd.MaHD) > 5
ORDER BY Thang;
-- 3. Hiển thị các khách hàng có tổng chi tiêu trên 25 triệu
SELECT kh.MaKH, kh.HoTen, SUM(ct.SoLuong * ct.DonGia * (1 - ct.MucGiamGia / 100)) AS TongChiTieu
FROM HoaDon hd
JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
JOIN KhachHang kh ON hd.MaKH = kh.MaKH
GROUP BY kh.MaKH, kh.HoTen
HAVING SUM(ct.SoLuong * ct.DonGia * (1 - ct.MucGiamGia / 100)) > 25000000
ORDER BY TongChiTieu DESC;
-- 4. Hiển thị các nhân viên có tổng số lượng sản phẩm bán ra trên 5 chiếc trong 2024
SELECT nv.MaNV, nv.HoTen, SUM(ct.SoLuong) AS TongSoLuongBan
FROM HoaDon hd
JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
JOIN NhanVien nv ON hd.MaNV = nv.MaNV
WHERE YEAR(hd.NgayBan)='2024'
GROUP BY nv.MaNV, nv.HoTen
HAVING SUM(ct.SoLuong) > 5
ORDER BY TongSoLuongBan DESC;
-- 5. Hiển thị các sản phẩm có tổng số lượng bán ra trong quý 3/2024 trên 3 chiếc
SELECT sp.MaSP, sp.TenSP, sp.HangSanXuat, SUM(ct.SoLuong) AS TongSoLuongBan
FROM ChiTietHoaDon ct
JOIN HoaDon hd ON ct.MaHD = hd.MaHD
JOIN SanPham sp ON ct.MaSP = sp.MaSP
WHERE YEAR(hd.NgayBan) = 2024 AND MONTH(hd.NgayBan) BETWEEN 7 AND 9
GROUP BY sp.MaSP, sp.TenSP, sp.HangSanXuat
HAVING SUM(ct.SoLuong) > 3
ORDER BY TongSoLuongBan DESC;
--===============================--
-- 3d: Truy vấn lớn nhất, nhỏ nhất: 3 câu
-- 1. Hiển thị sản phẩm có số lượng tồn kho cao nhất
SELECT sp.MaSP, sp.TenSP, MAX(kh.SoLuongTon) AS SoLuongTonCaoNhat
FROM KhoHang kh
JOIN SanPham sp ON kh.MaSP = sp.MaSP
GROUP BY sp.MaSP, sp.TenSP
HAVING MAX(kh.SoLuongTon) = (SELECT MAX(SoLuongTon) FROM KhoHang);
-- 2. Hiển thị chương trình khuyến mãi có thời gian áp dụng dài nhất
SELECT km.MaKM, km.TenKM, MAX(DATEDIFF(DAY, km.NgayBatDau, km.NgayKetThuc)) AS ThoiGianApDungTinhTheoNgay
FROM KhuyenMai km
GROUP BY km.MaKM, km.TenKM
HAVING MAX(DATEDIFF(DAY, km.NgayBatDau, km.NgayKetThuc)) = (
    SELECT MAX(DATEDIFF(DAY, NgayBatDau, NgayKetThuc))
    FROM KhuyenMai
);
-- 3. Hiển thị sản phẩm có kích thước màn hình lớn nhất
SELECT sp.MaSP, sp.TenSP, MAX(sp.KichThuocManHinh) AS KichThuocLonNhat
FROM SanPham sp
GROUP BY sp.MaSP, sp.TenSP
HAVING MAX(sp.KichThuocManHinh) = (SELECT MAX(KichThuocManHinh) FROM SanPham);
--===============================--
-- 3e: Truy vấn Không/Chưa có(NOT IN và LEFT, RIGHT JOIN): 5 câu
-- 1. Sản phẩm không thuộc chương trình khuyến mãi nào 
SELECT sp.MaSP, sp.TenSP
FROM SanPham sp
WHERE sp.MaKM NOT IN (
    SELECT MaKM
    FROM KhuyenMai
);
-- 2. Sản phẩm chưa có thông tin bảo hành
SELECT sp.MaSP, sp.TenSP
FROM SanPham sp
WHERE sp.MaSP NOT IN (
    SELECT DISTINCT MaSP
    FROM BaoHanh
);
-- 3. Nhân viên chưa từng bán sản phẩm nào trong tháng 6/2024
SELECT nv.MaNV, nv.HoTen
FROM NhanVien nv
WHERE nv.MaNV NOT IN (
    SELECT DISTINCT MaNV
    FROM HoaDon
    WHERE YEAR(NgayBan) = 2024 AND MONTH(NgayBan) = 6
);
-- 4. Sản phẩm chưa được bảo hành nhưng đã được bán trong năm 2024 và có kích thước màn hình từ 50 inch
SELECT sp.MaSP, sp.TenSP, sp.KichThuocManHinh, SUM(ct.SoLuong) AS TongSoLuongBan
FROM SanPham sp
LEFT JOIN BaoHanh bh ON sp.MaSP = bh.MaSP
JOIN ChiTietHoaDon ct ON sp.MaSP = ct.MaSP
JOIN HoaDon hd ON ct.MaHD = hd.MaHD
WHERE bh.MaSP IS NULL AND YEAR(hd.NgayBan) = 2024 AND sp.KichThuocManHinh >= 50
GROUP BY sp.MaSP, sp.TenSP, sp.KichThuocManHinh
ORDER BY TongSoLuongBan DESC;
-- 5. Sản phẩm chưa được áp dụng chương trình khuyến mãi nhưng đã được nhập kho trong năm 2024 với số lượng trên 10 chiếc
SELECT sp.MaSP, sp.TenSP, kh.SoLuongTon, kh.NgayCapNhat
FROM KhuyenMai km
RIGHT JOIN SanPham sp ON km.MaKM = sp.MaKM
JOIN KhoHang kh ON sp.MaSP = kh.MaSP AND YEAR(kh.NgayCapNhat) = 2024
WHERE km.MaKM IS NULL AND kh.SoLuongTon > 10
ORDER BY kh.SoLuongTon DESC;
--===============================--
-- 3f: Truy vấn Hợp/Giao/Trừ: 3 câu
-- 1. Khách hàng mua hàng trong quý 1 hoặc quý 4 năm 2024
SELECT MaKH, HoTen
FROM KhachHang
WHERE MaKH IN (
    SELECT MaKH
    FROM HoaDon
    WHERE YEAR(NgayBan) = 2024 AND MONTH(NgayBan) IN (1, 2, 3)
)
UNION
SELECT MaKH, HoTen
FROM KhachHang
WHERE MaKH IN (
    SELECT MaKH
    FROM HoaDon
    WHERE YEAR(NgayBan) = 2024 AND MONTH(NgayBan) IN (10, 11, 12)
);
-- 2. Sản phẩm có giá trên 40 triệu nhưng chưa từng được bán
SELECT MaSP, TenSP
FROM SanPham
WHERE GiaBan > 40000000
EXCEPT
SELECT sp.MaSP, sp.TenSP
FROM SanPham sp
JOIN ChiTietHoaDon ct ON sp.MaSP = ct.MaSP;
-- 3. Sản phẩm thuộc chương trình khuyến mãi nhưng chưa được bán trong năm 2024
SELECT MaSP, TenSP
FROM SanPham
WHERE MaKM IS NOT NULL
EXCEPT
SELECT sp.MaSP, sp.TenSP
FROM SanPham sp
JOIN ChiTietHoaDon ct ON sp.MaSP = ct.MaSP
JOIN HoaDon hd ON ct.MaHD = hd.MaHD
WHERE YEAR(hd.NgayBan) = 2024;
--===============================--
-- 3g:Truy vấn UPDATE/DELETE: 7 câu
-- 1. Cập nhật mã khuyến mãi cho sản phẩm chưa có khuyến mãi và giá trên 20 triệu
UPDATE SanPham
SET MaKM = 'KM001'
WHERE MaKM IS NULL AND GiaBan > 20000000;
-- 2. Cập nhật đơn giá chi tiết hóa đơn giảm 10% cho sản phẩm có kích thước trên 55 inch
UPDATE ChiTietHoaDon
SET DonGia = DonGia * 0.9
WHERE MaSP IN (
    SELECT MaSP
    FROM SanPham
    WHERE KichThuocManHinh > 55
);
-- 3. Cập nhật mức giảm giá chi tiết hóa đơn tăng 5% cho hóa đơn trong tháng 12/2024
UPDATE ChiTietHoaDon
SET MucGiamGia = MucGiamGia + 5
WHERE MaHD IN (
    SELECT MaHD
    FROM HoaDon
    WHERE YEAR(NgayBan) = 2024 AND MONTH(NgayBan) = 12
);
-- 4. Cập nhật mức giảm giá khuyến mãi tăng 10% cho chương trình khuyến mãi bắt đầu trong năm 2024
UPDATE KhuyenMai
SET MucGiamGia = MucGiamGia + 10
WHERE YEAR(NgayBatDau) = 2024;
-- 5. Xóa khách hàng không có hóa đơn trong 2 năm gần nhất (2023-2024)
DELETE FROM KhachHang
WHERE MaKH NOT IN (
    SELECT MaKH
    FROM HoaDon
    WHERE YEAR(NgayBan) IN (2023, 2024)
);
-- 6. Xóa bảo hành của sản phẩm không còn trong kho
DELETE FROM BaoHanh
WHERE MaSP NOT IN (
    SELECT MaSP
    FROM KhoHang
);
-- 7. Xóa bản ghi kho của sản phẩm không được cập nhật trong 3 năm (trước 2022)
DELETE FROM KhoHang
WHERE YEAR(NgayCapNhat) < 2022;
--===============================--
-- 3h: Truy vấn sử dụng phép Chia: 2 câu
-- 1. Tìm nhà cung cấp có sản phẩm trong tất cả các chương trình khuyến mãi
SELECT ncc.MaNCC, ncc.TenNCC
FROM NhaCungCap ncc
JOIN SanPham sp ON ncc.MaNCC = sp.MaNCC
JOIN KhuyenMai km ON sp.MaKM = km.MaKM
GROUP BY ncc.MaNCC, ncc.TenNCC
HAVING COUNT(DISTINCT km.MaKM) = (SELECT COUNT(*) FROM KhuyenMai);

-- 2. Tìm nhân viên đã xử lý hóa đơn cho tất cả khách hàng VIP (chi tiêu trên 20 triệu)
SELECT nv.MaNV, nv.HoTen
FROM NhanVien nv
WHERE NOT EXISTS (
    SELECT kh.MaKH
    FROM KhachHang kh
    JOIN HoaDon hd ON kh.MaKH = hd.MaKH
    JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
    GROUP BY kh.MaKH
    HAVING SUM(ct.SoLuong * ct.DonGia * (1 - ct.MucGiamGia / 100)) > 20000000
    AND NOT EXISTS (
        SELECT 1
        FROM HoaDon hd2
        WHERE hd2.MaNV = nv.MaNV
        AND hd2.MaKH = kh.MaKH
    )
);
GO
--===============================--
-- 4:
-- THỦ TỤC:3 câu
-- 1. Thủ tục: Lấy danh sách hóa đơn trong ngày
CREATE PROCEDURE LayHoaDonTrongNgay
    @Ngay DATE
AS
BEGIN
    SELECT MaHD, MaKH, NgayBan
    FROM HoaDon
    WHERE NgayBan = @Ngay;
END;
GO
-- Ví dụ: trả về các hóa đơn ngày 15/10/2023
EXEC LayHoaDonTrongNgay '2023-10-15';
GO
-- 2. Thủ tục: Cập nhật số lượng tồn kho
CREATE PROCEDURE CapNhatTonKho
    @MaSP CHAR(10),
    @SoLuong INT
AS
BEGIN
    UPDATE KhoHang
    SET SoLuongTon = @SoLuong,
        NgayCapNhat = GETDATE()
    WHERE MaSP = @MaSP;
END;
GO
-- Ví dụ: cập nhật tồn kho của TV Samsung 55 inch thành 70)
EXEC CapNhatTonKho 'SP001', 70;
GO
-- 3. Thủ tục: Lấy danh sách khuyến mãi đang hoạt động
CREATE PROCEDURE LayKhuyenMaiHienTai
AS
BEGIN
    SELECT MaKM, TenKM, MucGiamGia
    FROM KhuyenMai
    WHERE GETDATE() BETWEEN NgayBatDau AND NgayKetThuc;
END;
GO
--Ví dụ: trả về các khuyến mãi đang diễn ra vào ngày hiện tại, ví dụ: không có khuyến mãi nào nếu ngày là 26/04/2025)
EXEC LayKhuyenMaiHienTai;
GO
-- HÀM: 2 câu
-- 1. Hàm: Lấy giá bán của sản phẩm
CREATE FUNCTION LayGiaBan (@MaSP CHAR(10))
RETURNS DECIMAL(15, 2)
AS
BEGIN
    DECLARE @GiaBan DECIMAL(15, 2);
    SELECT @GiaBan = GiaBan
    FROM SanPham
    WHERE MaSP = @MaSP;
    RETURN ISNULL(@GiaBan, 0);
END;
GO
-- Ví dụ sử dụng:
SELECT dbo.LayGiaBan('SP001') AS GiaBan;
-- (Trả về 15000000.00, giá bán của TV Samsung 55 inch)
GO
-- 2. Hàm: Lấy số lượng tồn kho
CREATE FUNCTION LayTonKho (@MaSP CHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @SoLuong INT;
    SELECT @SoLuong = SoLuongTon
    FROM KhoHang
    WHERE MaSP = @MaSP;
    RETURN ISNULL(@SoLuong, 0);
END;
GO
-- Ví dụ sử dụng:
SELECT dbo.LayTonKho('SP002') AS SoLuongTon;
-- (Trả về 30, số lượng tồn kho của TV LG 65 inch)
GO
-- 3. Hàm: Lấy tên nhân viên theo mã
CREATE FUNCTION LayTenNhanVien (@MaNV CHAR(10))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @TenNV NVARCHAR(50);
    SELECT @TenNV = HoTen
    FROM NhanVien
    WHERE MaNV = @MaNV;
    RETURN ISNULL(@TenNV, N'Không tìm thấy');
END;
GO
-- Ví dụ sử dụng:
SELECT dbo.LayTenNhanVien('NV001') AS TenNhanVien;
-- (Trả về Nguyễn Thị D, tên nhân viên NV001)
GO
-- 4. Hàm: Kiểm tra sản phẩm có khuyến mãi
CREATE FUNCTION CoKhuyenMai (@MaSP CHAR(10))
RETURNS BIT
AS
BEGIN
    DECLARE @CoKM BIT;
    IF EXISTS (
        SELECT 1
        FROM SanPham sp
        JOIN KhuyenMai km ON sp.MaKM = km.MaKM
        WHERE sp.MaSP = @MaSP
            AND GETDATE() BETWEEN km.NgayBatDau AND km.NgayKetThuc
    )
        SET @CoKM = 1;
    ELSE
        SET @CoKM = 0;
    RETURN @CoKM;
END;
GO
-- Ví dụ sử dụng:
SELECT dbo.CoKhuyenMai('SP003') AS CoKhuyenMai;
-- (Trả về 0, vì khuyến mãi KM003 đã hết hạn vào 31/12/2023)
GO
-- 5. Hàm: Lấy số lượng hóa đơn của khách hàng
CREATE FUNCTION DemHoaDonKhachHang (@MaKH CHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @SoHoaDon INT;
    SELECT @SoHoaDon = COUNT(*)
    FROM HoaDon
    WHERE MaKH = @MaKH;
    RETURN ISNULL(@SoHoaDon, 0);
END;
GO
-- Ví dụ sử dụng:
SELECT dbo.DemHoaDonKhachHang('KH002') AS SoHoaDon;
-- (Trả về 1, số hóa đơn của khách hàng Trần Thị B)
GO
-- TRIGGER:
-- 1. Trigger: Tự động cập nhật tình trạng bảo hành khi thêm bản ghi bảo hành
CREATE TRIGGER CapNhatTinhTrangBaoHanh
ON BaoHanh
AFTER INSERT
AS
BEGIN
    UPDATE BaoHanh
    SET TinhTrang = N'Còn bảo hành'
    FROM BaoHanh
    JOIN inserted ON BaoHanh.MaBH = inserted.MaBH
    WHERE inserted.TinhTrang IS NULL;
END;
GO
-- Ví dụ sử dụng:
INSERT INTO BaoHanh (MaBH, MaHD, MaSP, NgayMua, ThoiHanBaoHanh)
VALUES ('BH011', 'HD001', 'SP001', '2024-08-01', 12);
-- (Tự động đặt TinhTrang thành 'Còn bảo hành' cho bản ghi BH011)
GO
-- 2. Trigger: Tự động cập nhật ngày bán hóa đơn thành ngày hiện tại
CREATE TRIGGER CapNhatNgayBanHoaDon
ON HoaDon
AFTER INSERT
AS
BEGIN
    UPDATE HoaDon
    SET NgayBan = GETDATE()
    FROM HoaDon
    JOIN inserted ON HoaDon.MaHD = inserted.MaHD;
END;
GO
-- Ví dụ sử dụng:
INSERT INTO HoaDon (MaHD, MaKH, MaNV, NgayBan)
VALUES ('HD011', 'KH001', 'NV001', '2023-01-01');
-- (Tự động cập nhật NgayBan của HD011 thành ngày hiện tại, ví dụ: 26/04/2025)
GO
-- 3. Trigger: Kiểm tra tồn kho trước khi thêm chi tiết hóa đơn
CREATE TRIGGER KiemTraTonKhoBan
ON ChiTietHoaDon
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN KhoHang kh ON i.MaSP = kh.MaSP
        WHERE kh.SoLuongTon < i.SoLuong
    )
    BEGIN
        RAISERROR ('Số lượng tồn kho không đủ để bán!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
-- Ví dụ sử dụng:
INSERT INTO ChiTietHoaDon (MaHD, MaSP, SoLuong, DonGia, MucGiamGia)
VALUES ('HD011', 'SP001', 100, 15000000.00, 10.00);
-- (Lỗi: 'Số lượng tồn kho không đủ để bán!', vì SP001 chỉ có 50 trong kho)
INSERT INTO ChiTietHoaDon (MaHD, MaSP, SoLuong, DonGia, MucGiamGia)
VALUES ('HD011', 'SP001', 10, 15000000.00, 10.00);
-- (Thành công, vì 10 <= 50, bản ghi được thêm)

-- 5: Tạo 3 người dùng và cấp quyền cho mỗi người dùng với các quyền khác nhau
-- ChuCH, NVBanHang, NVKho
CREATE LOGIN ChuCH WITH PASSWORD = 'ManagerPass@123';
CREATE LOGIN NVBanHang WITH PASSWORD = 'SalePass@123';
CREATE LOGIN NVKho WITH PASSWORD = 'InventoryPass@123';
GO
CREATE USER ChuCH FOR LOGIN ChuCH;
CREATE USER NVBanHang FOR LOGIN NVBanHang;
CREATE USER NVKho FOR LOGIN NVKho;
GO

-- ChuCH: Toàn quyền trên cơ sở dữ liệu (đọc, ghi, cập nhật, xóa, thực thi thủ tục)
GRANT CONTROL ON DATABASE::TV_Store TO ChuCH;
GO
-- Ví dụ
EXECUTE AS USER = 'ChuCH';
SELECT * from KhachHang
REVERT;

-- NVBanHang: Xem thông tin khách hàng, sản phẩm, hóa đơn; thêm/cập nhật hóa đơn
GRANT SELECT ON KhachHang TO NVBanHang;
GRANT SELECT ON SanPham TO NVBanHang;
GRANT SELECT ON HoaDon TO NVBanHang;
GRANT SELECT ON ChiTietHoaDon TO NVBanHang;
GRANT INSERT, UPDATE ON HoaDon TO NVBanHang;
GRANT INSERT, UPDATE ON ChiTietHoaDon TO NVBanHang;

-- NVKho: Xem và cập nhật dữ liệu kho; thực thi thủ tục liên quan đến kho
GRANT SELECT, UPDATE ON KhoHang TO NVKho;
GRANT SELECT ON SanPham TO NVKho;
GRANT EXECUTE ON CapNhatTonKho TO NVKho;
GRANT EXECUTE ON LayKhuyenMaiHienTai TO NVKho;
-- Ví dụ 1
EXECUTE AS USER = 'NVKho';
EXEC CapNhatTonKho 'SP001', 70;
REVERT; -- Quay lại tài khoản gốc
GO
-- Ví dụ 2
EXECUTE AS USER = 'NVKho';
EXEC LayKhuyenMaiHienTai;
REVERT; -- Quay lại tài khoản gốc
