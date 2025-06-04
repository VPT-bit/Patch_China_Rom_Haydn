CREATE DATABASE QLCHDienTuGiaDung;
GO
USE QLCHDienTuGiaDung;
GO

-- Tạo bảng
CREATE TABLE KhachHang (
    MaKH VARCHAR(10) CONSTRAINT PK_KhachHang PRIMARY KEY,
    HoTen NVARCHAR(50) NOT NULL,
    SoDienThoai CHAR(10) NOT NULL,
    NgaySinh DATE,
    DiaChi NVARCHAR(100),
    Email VARCHAR(50)
);

CREATE TABLE NhanVien (
    MaNV VARCHAR(10) CONSTRAINT PK_NhanVien PRIMARY KEY,
    HoTen NVARCHAR(50) NOT NULL,
    SoDienThoai CHAR(10) NOT NULL,
    NgaySinh DATE,
    DiaChi NVARCHAR(100),
    Email VARCHAR(50),
    NgayVaoLam DATE NOT NULL,
    LuongCB MONEY,
    PhuCap MONEY
);

CREATE TABLE NhaCungCap (
    MaNCC VARCHAR(10) CONSTRAINT PK_NhaCungCap PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(100),
    SoDienThoai CHAR(10),
    Email VARCHAR(50)
);

CREATE TABLE KhuyenMai (
    MaKM VARCHAR(10) CONSTRAINT PK_KhuyenMai PRIMARY KEY,
    TenKM NVARCHAR(50) NOT NULL,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    MucGiamGia DECIMAL(5, 2)
);

CREATE TABLE DanhMucSanPham (
    MaDM VARCHAR(10) CONSTRAINT PK_DanhMucSanPham PRIMARY KEY,
    TenDM NVARCHAR(50) NOT NULL
);

CREATE TABLE SanPham (
    MaSP VARCHAR(10) CONSTRAINT PK_SanPham PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    HangSanXuat NVARCHAR(50) NOT NULL,
    CongSuat INT NOT NULL,
    GiaBan MONEY,
    DonViTinh NVARCHAR(20),
    MoTa NVARCHAR(200),
    MaNCC VARCHAR(10),
    MaKM VARCHAR(10),
    MaDM VARCHAR(10)
);

CREATE TABLE KhoHang (
    MaSP VARCHAR(10) CONSTRAINT PK_KhoHang PRIMARY KEY,
    SoLuongTon INT,
    NgayCapNhat DATE NOT NULL
);

CREATE TABLE HoaDon (
    MaHD VARCHAR(10) CONSTRAINT PK_HoaDon PRIMARY KEY,
    MaKH VARCHAR(10) NOT NULL,
    MaNV VARCHAR(10) NOT NULL,
    NgayBan DATETIME NOT NULL
);

CREATE TABLE ChiTietHoaDon (
    MaHD VARCHAR(10),
    MaSP VARCHAR(10),
    DonGia MONEY,
    SoLuong INT,
    MucGiamGia DECIMAL(5, 2),
    CONSTRAINT PK_ChiTietHoaDon PRIMARY KEY (MaHD, MaSP)
);

CREATE TABLE BaoHanh (
    MaBH VARCHAR(10) CONSTRAINT PK_BaoHanh PRIMARY KEY,
    MaHD VARCHAR(10),
    MaSP VARCHAR(10),
    NgayMua DATE NOT NULL,
    ThoiHanBaoHanh INT,
);

CREATE TABLE NhapKho (
    MaNhap VARCHAR(10) CONSTRAINT PK_NhapKho PRIMARY KEY,
    MaNCC VARCHAR(10) NOT NULL,
    MaSP VARCHAR(10) NOT NULL,
    SoLuong INT NOT NULL,
    GiaNhap MONEY,
    NgayNhap DATE NOT NULL
);

CREATE TABLE LichSuBaoHanh (
    MaLichSu VARCHAR(10) CONSTRAINT PK_LichSuBaoHanh PRIMARY KEY,
    MaBH VARCHAR(10) NOT NULL,
    LoiSanPham NVARCHAR(200),
    ChiPhi MONEY,
    NgayXuLy DATE
);

-- Thêm ràng buộc
-- Bảng KhachHang
ALTER TABLE KhachHang ADD CONSTRAINT CHK_KH_Email CHECK (Email LIKE '%@%.%');
ALTER TABLE KhachHang ADD CONSTRAINT UQ_KH_SDT UNIQUE (SoDienThoai);
ALTER TABLE KhachHang ADD CONSTRAINT UQ_KH_Email UNIQUE (Email);

-- Bảng NhanVien
ALTER TABLE NhanVien ADD CONSTRAINT UQ_NV_SDT UNIQUE (SoDienThoai);
ALTER TABLE NhanVien ADD CONSTRAINT UQ_NV_Email UNIQUE (Email);
ALTER TABLE NhanVien ADD CONSTRAINT CHK_NV_Email CHECK (Email IS NULL OR Email LIKE '%@%.%');
ALTER TABLE NhanVien ADD CONSTRAINT CHK_LuongCB CHECK (LuongCB >= 0);
ALTER TABLE NhanVien ADD CONSTRAINT CHK_PhuCap CHECK (PhuCap >= 0);

-- Bảng NhaCungCap
ALTER TABLE NhaCungCap ADD CONSTRAINT CHK_NCC_Email CHECK (Email IS NULL OR Email LIKE '%@%.%');
ALTER TABLE NhaCungCap ADD CONSTRAINT UQ_NCC_SDT UNIQUE (SoDienThoai);
ALTER TABLE NhaCungCap ADD CONSTRAINT UQ_NCC_Email UNIQUE (Email);

-- Bảng KhuyenMai
ALTER TABLE KhuyenMai ADD CONSTRAINT CHK_MucGiamGia CHECK (MucGiamGia >= 0 AND MucGiamGia <= 100);
ALTER TABLE KhuyenMai ADD CONSTRAINT CHK_NgayKM CHECK (NgayBatDau <= NgayKetThuc);

-- Bảng DanhMucSanPham
ALTER TABLE DanhMucSanPham ADD CONSTRAINT UQ_TenDM UNIQUE (TenDM);

-- Bảng SanPham
ALTER TABLE SanPham ADD CONSTRAINT CHK_GiaBan CHECK (GiaBan >= 0);
ALTER TABLE SanPham ADD CONSTRAINT FK_SanPham_KhuyenMai FOREIGN KEY (MaKM) REFERENCES KhuyenMai(MaKM) ON DELETE SET NULL;
ALTER TABLE SanPham ADD CONSTRAINT FK_SanPham_NhaCungCap FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC) ON DELETE NO ACTION;
ALTER TABLE SanPham ADD CONSTRAINT FK_SanPham_DanhMucSanPham FOREIGN KEY (MaDM) REFERENCES DanhMucSanPham(MaDM) ON DELETE SET NULL;
ALTER TABLE SanPham ADD CONSTRAINT UQ_SanPham_TenSP UNIQUE (TenSP);
ALTER TABLE SanPham ADD CONSTRAINT CHK_SanPham_CongSuat CHECK (CongSuat > 0);
ALTER TABLE SanPham ADD CONSTRAINT CHK_DonViTinh CHECK (DonViTinh IN (N'Cái', N'Bộ', N'Hộp', N'Chiếc') OR DonViTinh IS NULL);

-- Bảng KhoHang
ALTER TABLE KhoHang ADD CONSTRAINT FK_KhoHang_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE;
ALTER TABLE KhoHang ADD CONSTRAINT CHK_SoLuongTon CHECK (SoLuongTon >= 0);

-- Bảng HoaDon
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH) ON DELETE NO ACTION;
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_NhanVien FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV) ON DELETE NO ACTION;
ALTER TABLE HoaDon ADD CONSTRAINT CHK_NgayBan CHECK (NgayBan <= GETDATE());

-- Bảng ChiTietHoaDon
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT FK_ChiTietHoaDon_HoaDon FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD) ON DELETE CASCADE;
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT FK_ChiTietHoaDon_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE NO ACTION;
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT CHK_SoLuong CHECK (SoLuong > 0);
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT CHK_DonGia CHECK (DonGia >= 0);
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT CHK_MucGiamGia_ChiTiet CHECK (MucGiamGia >= 0 AND MucGiamGia <= 100);

-- Bảng BaoHanh
ALTER TABLE BaoHanh ADD CONSTRAINT FK_BaoHanh_ChiTietHoaDon FOREIGN KEY (MaHD, MaSP) REFERENCES ChiTietHoaDon(MaHD, MaSP) ON DELETE CASCADE;
ALTER TABLE BaoHanh ADD CONSTRAINT CHK_ThoiHanBaoHanh CHECK (ThoiHanBaoHanh >= 0);
ALTER TABLE BaoHanh ADD CONSTRAINT CHK_NgayMua CHECK (NgayMua <= GETDATE());

-- Bảng NhapKho
ALTER TABLE NhapKho ADD CONSTRAINT FK_NhapKho_NhaCungCap FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC) ON DELETE NO ACTION;
ALTER TABLE NhapKho ADD CONSTRAINT FK_NhapKho_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE NO ACTION;
ALTER TABLE NhapKho ADD CONSTRAINT CHK_SoLuongNhap CHECK (SoLuong > 0);
ALTER TABLE NhapKho ADD CONSTRAINT CHK_GiaNhap_NhapKho CHECK (GiaNhap >= 0);
ALTER TABLE NhapKho ADD CONSTRAINT CHK_NgayNhap CHECK (NgayNhap <= GETDATE());

-- Bảng LichSuBaoHanh
ALTER TABLE LichSuBaoHanh ADD CONSTRAINT FK_LichSuBaoHanh_BaoHanh FOREIGN KEY (MaBH) REFERENCES BaoHanh(MaBH) ON DELETE CASCADE;
ALTER TABLE LichSuBaoHanh ADD CONSTRAINT CHK_ChiPhi CHECK (ChiPhi >= 0);
ALTER TABLE LichSuBaoHanh ADD CONSTRAINT CHK_NgayXuLy CHECK (NgayXuLy IS NULL OR NgayXuLy <= GETDATE());

-- Them du lieu vao bang

INSERT INTO KhachHang (MaKH, HoTen, SoDienThoai, NgaySinh, DiaChi, Email) VALUES
('KH001', N'Nguyễn Văn An', '0901234561', '1990-05-15', N'123 Lê Lợi, Nha Trang', 'nguyenvanan@gmail.com'),
('KH002', N'Trần Thị Bình', '0901234562', '1985-08-22', N'45 Nguyễn Huệ, Đà Nẵng', 'tranbinh@gmail.com'),
('KH003', N'Phạm Minh Châu', '0901234563', '1995-03-10', N'67 Trần Phú, TP.HCM', 'phamchau@gmail.com'),
('KH004', N'Lê Hoàng Dũng', '0901234564', '1988-11-30', N'89 Võ Thị Sáu, Hà Nội', 'lehoangdung@gmail.com'),
('KH005', N'Huỳnh Thị Hồng', '0901234565', '1992-07-25', N'12 Nguyễn Trãi, Huế', 'huynhhong@gmail.com'),
('KH006', N'Võ Văn Hùng', '0901234566', '1993-09-12', N'34 Bùi Thị Xuân, Nha Trang', 'vohung@gmail.com'),
('KH007', N'Đỗ Thị Lan', '0901234567', '1987-04-18', N'56 Phạm Văn Đồng, Đà Lạt', 'dolan@gmail.com'),
('KH008', N'Ngô Minh Khoa', '0901234568', '1996-01-05', N'78 Hùng Vương, Cần Thơ', 'ngokhoa@gmail.com'),
('KH009', N'Bùi Văn Long', '0901234569', '1991-06-20', N'90 Lý Tự Trọng, Nha Trang', 'builong@gmail.com'),
('KH010', N'Trương Thị Mai', '0901234570', '1989-12-15', N'23 Hoàng Diệu, Vũng Tàu', 'truongmai@gmail.com'),
('KH011', N'Hoàng Văn Nam', '0901234571', '1994-02-28', N'45 Lê Đại Hành, TP.HCM', 'hoangnam@gmail.com'),
('KH012', N'Nguyễn Thị Ngọc', '0901234572', '1990-10-10', N'67 Nguyễn Văn Cừ, Hà Nội', 'nguyenngoc@gmail.com'),
('KH013', N'Trần Văn Phong', '0901234573', '1986-03-22', N'89 Trần Hưng Đạo, Đà Nẵng', 'tranphong@gmail.com'),
('KH014', N'Phạm Thị Quyên', '0901234574', '1997-05-30', N'12 Pasteur, Nha Trang', 'phamquyen@gmail.com'),
('KH015', N'Lê Minh Sơn', '0901234575', '1988-08-15', N'34 Nguyễn Đình Chiểu, Huế', 'leminhson@gmail.com'),
('KH016', N'Huỳnh Văn Tài', '0901234576', '1993-11-12', N'56 Võ Nguyên Giáp, Đà Lạt', 'huynhtai@gmail.com'),
('KH017', N'Võ Thị Thanh', '0901234577', '1995-04-25', N'78 Lê Hồng Phong, Cần Thơ', 'vothanh@gmail.com'),
('KH018', N'Đỗ Văn Thắng', '0901234578', '1990-07-18', N'90 Nguyễn Huệ, Vũng Tàu', 'dothang@gmail.com'),
('KH019', N'Ngô Thị Uyên', '0901234579', '1987-09-05', N'23 Lý Thường Kiệt, TP.HCM', 'ngouyen@gmail.com'),
('KH020', N'Bùi Minh Vũ', '0901234580', '1992-01-20', N'45 Trần Phú, Hà Nội', 'buivuminh@gmail.com');

INSERT INTO NhanVien (MaNV, HoTen, SoDienThoai, NgaySinh, DiaChi, Email, NgayVaoLam, LuongCB, PhuCap) VALUES
('NV001', N'Nguyễn Thị Ái', '0912345601', '1990-06-10', N'123 Lê Lợi, Nha Trang', 'nguyenai@gmail.com', '2020-01-15', 8000000, 1000000),
('NV002', N'Trần Văn Bảo', '0912345602', '1988-09-20', N'45 Nguyễn Huệ, Đà Nẵng', 'tranbao@gmail.com', '2019-03-10', 9000000, 1200000),
('NV003', N'Phạm Minh Cường', '0912345603', '1992-02-15', N'67 Trần Phú, TP.HCM', 'phamcuong@gmail.com', '2021-05-20', 8500000, 1100000),
('NV004', N'Lê Thị Duyên', '0912345604', '1995-07-30', N'89 Võ Thị Sáu, Hà Nội', 'leduyen@gmail.com', '2020-08-12', 8200000, 1000000),
('NV005', N'Huỳnh Văn Em', '0912345605', '1990-11-25', N'12 Nguyễn Trãi, Huế', 'huynhem@gmail.com', '2018-04-18', 9500000, 1300000),
('NV006', N'Võ Minh Giang', '0912345606', '1993-03-12', N'34 Bùi Thị Xuân, Nha Trang', 'vogiang@gmail.com', '2021-02-10', 8700000, 1100000),
('NV007', N'Đỗ Thị Hà', '0912345607', '1987-05-28', N'56 Phạm Văn Đồng, Đà Lạt', 'doha@gmail.com', '2019-09-15', 9200000, 1200000),
('NV008', N'Ngô Văn Hùng', '0912345608', '1996-01-05', N'78 Hùng Vương, Cần Thơ', 'ngohung@gmail.com', '2020-11-20', 8300000, 1000000),
('NV009', N'Bùi Thị Inh', '0912345609', '1991-08-20', N'90 Lý Tự Trọng, Nha Trang', 'buiinh@gmail.com', '2018-07-10', 8800000, 1100000),
('NV010', N'Trương Văn Khôi', '0912345610', '1989-12-15', N'23 Hoàng Diệu, Vũng Tàu', 'truongkhoi@gmail.com', '2021-04-05', 9100000, 1200000),
('NV011', N'Hoàng Thị Lan', '0912345611', '1994-04-28', N'45 Lê Đại Hành, TP.HCM', 'hoanglan@gmail.com', '2020-06-15', 8600000, 1100000),
('NV012', N'Nguyễn Minh Mẫn', '0912345612', '1990-10-10', N'67 Nguyễn Văn Cừ, Hà Nội', 'nguyenman@gmail.com', '2019-02-20', 9400000, 1300000),
('NV013', N'Trần Thị Nga', '0912345613', '1986-03-22', N'89 Trần Hưng Đạo, Đà Nẵng', 'trannga@gmail.com', '2021-08-12', 8900000, 1100000),
('NV014', N'Phạm Văn Nhật', '0912345614', '1997-05-30', N'12 Pasteur, Nha Trang', 'phamnhat@gmail.com', '2020-01-25', 8700000, 1000000),
('NV015', N'Lê Thị Oanh', '0912345615', '1988-08-15', N'34 Nguyễn Đình Chiểu, Huế', 'leoanh@gmail.com', '2019-11-10', 9000000, 1200000),
('NV016', N'Huỳnh Minh Phú', '0912345616', '1993-11-12', N'56 Võ Nguyên Giáp, Đà Lạt', 'huynhphu@gmail.com', '2021-03-18', 8800000, 1100000),
('NV017', N'Võ Thị Quyên', '0912345617', '1995-04-25', N'78 Lê Hồng Phong, Cần Thơ', 'voquyen@gmail.com', '2020-09-20', 8500000, 1000000),
('NV018', N'Đỗ Văn Sơn', '0912345618', '1990-07-18', N'90 Nguyễn Huệ, Vũng Tàu', 'doson@gmail.com', '2018-05-15', 9200000, 1200000),
('NV019', N'Ngô Thị Thảo', '0912345619', '1987-09-05', N'23 Lý Thường Kiệt, TP.HCM', 'ngothao@gmail.com', '2021-07-10', 8700000, 1100000),
('NV020', N'Bùi Văn Tín', '0912345620', '1992-01-20', N'45 Trần Phú, Hà Nội', 'buitin@gmail.com', '2019-12-05', 9100000, 1200000);

INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChi, SoDienThoai, Email) VALUES
('NCC01', N' Samsung', N'123 Trần Phú, TP.HCM', '0923456701', 'samsungvn@gmail.com'),
('NCC02', N' LG Electronics', N'45 Nguyễn Huệ, Hà Nội', '0923456702', 'lgvn@gmail.com'),
('NCC03', N' Panasonic', N'67 Lê Lợi, Đà Nẵng', '0923456703', 'panasonicvn@gmail.com'),
('NCC04', N' Toshiba', N'89 Võ Thị Sáu, Nha Trang', '0923456704', 'toshibavn@gmail.com'),
('NCC05', N' Sony', N'12 Nguyễn Trãi, Huế', '0923456705', 'sonyvn@gmail.com'),
('NCC06', N' Philips', N'34 Bùi Thị Xuân, Đà Lạt', '0923456706', 'philipsvn@gmail.com'),
('NCC07', N' Electrolux', N'56 Phạm Văn Đồng, Cần Thơ', '0923456707', 'electroluxvn@gmail.com'),
('NCC08', N' Sharp', N'78 Hùng Vương, Vũng Tàu', '0923456708', 'sharpvn@gmail.com'),
('NCC09', N' Hitachi', N'90 Lý Tự Trọng, TP.HCM', '0923456709', 'hitachivn@gmail.com'),
('NCC10', N' Daikin', N'23 Hoàng Diệu, Hà Nội', '0923456710', 'daikinvn@gmail.com');

INSERT INTO KhuyenMai (MaKM, TenKM, NgayBatDau, NgayKetThuc, MucGiamGia) VALUES
('KM001', N'Khuyến mãi Tết 2025', '2025-01-01', '2025-02-15', 20.00),
('KM002', N'Black Friday 2025', '2025-11-20', '2025-11-30', 30.00),
('KM003', N'Khuyến mãi hè 2025', '2025-06-01', '2025-08-31', 15.00),
('KM004', N'Khuyến mãi khai trương', '2025-03-01', '2025-03-15', 25.00),
('KM005', N'Khuyến mãi cuối năm', '2025-12-01', '2025-12-31', 10.00);

INSERT INTO DanhMucSanPham (MaDM, TenDM) VALUES
('DM001', N'Tivi'),
('DM002', N'Tủ lạnh'),
('DM003', N'Máy giặt'),
('DM004', N'Điều hòa'),
('DM005', N'Máy lọc không khí'),
('DM006', N'Bếp điện'),
('DM007', N'Lò vi sóng'),
('DM008', N'Máy xay sinh tố'),
('DM009', N'Nồi chiên không dầu'),
('DM010', N'Quạt điện'),
('DM011', N'Máy hút bụi'),
('DM012', N'Bàn là'),
('DM013', N'Máy sấy tóc'),
('DM014', N'Loa Bluetooth'),
('DM015', N'Đèn LED'),
('DM016', N'Máy lọc nước'),
('DM017', N'Nồi áp suất'),
('DM018', N'Máy pha cà phê'),
('DM019', N'Máy ép chậm'),
('DM020', N'Bình đun siêu tốc');

INSERT INTO SanPham (MaSP, TenSP, HangSanXuat, CongSuat, GiaBan, DonViTinh, MoTa, MaNCC, MaKM, MaDM) VALUES
('SP001', N'Tivi Samsung 55 inch 4K', N'Samsung', 120, 15000000, N'Cái', N'Tivi 4K chất lượng cao, màn hình LED', 'NCC01', 'KM001', 'DM001'),
('SP002', N'Tivi Sony 65 inch OLED', N'Sony', 150, 35000000, N'Cái', N'Tivi OLED cao cấp, màu sắc sống động', 'NCC05', 'KM002', 'DM001'),
('SP003', N'Tủ lạnh LG Inverter 300L', N'LG', 200, 12000000, N'Cái', N'Tủ lạnh Inverter tiết kiệm điện', 'NCC02', 'KM003', 'DM002'),
('SP004', N'Tủ lạnh Panasonic 400L', N'Panasonic', 250, 18000000, N'Cái', N'Tủ lạnh dung tích lớn, công nghệ Nanoe', 'NCC03', NULL, 'DM002'),
('SP005', N'Máy giặt Samsung 8kg', N'Samsung', 500, 9000000, N'Cái', N'Máy giặt cửa trước, tiết kiệm nước', 'NCC01', 'KM004', 'DM003'),
('SP006', N'Máy giặt Toshiba 10kg', N'Toshiba', 600, 11000000, N'Cái', N'Máy giặt cửa trên, giặt sạch sâu', 'NCC04', NULL, 'DM003'),
('SP007', N'Điều hòa Daikin 1HP', N'Daikin', 900, 10000000, N'Cái', N'Điều hòa Inverter, làm lạnh nhanh', 'NCC10', 'KM005', 'DM004'),
('SP008', N'Điều hòa LG 1.5HP', N'LG', 1200, 13000000, N'Cái', N'Điều hòa 2 chiều, tiết kiệm điện', 'NCC02', NULL, 'DM004'),
('SP009', N'Máy lọc không khí Philips', N'Philips', 50, 7000000, N'Cái', N'Lọc không khí, loại bỏ 99% vi khuẩn', 'NCC06', 'KM003', 'DM005'),
('SP010', N'Máy lọc không khí Sharp', N'Sharp', 60, 8000000, N'Cái', N'Công nghệ Plasmacluster', 'NCC08', NULL, 'DM005'),
('SP011', N'Bếp điện từ Panasonic', N'Panasonic', 2000, 5000000, N'Cái', N'Bếp điện từ an toàn, dễ sử dụng', 'NCC03', 'KM001', 'DM006'),
('SP012', N'Bếp điện từ Electrolux', N'Electrolux', 2200, 6000000, N'Cái', N'Bếp đôi, công suất cao', 'NCC07', NULL, 'DM006'),
('SP013', N'Lò vi sóng Samsung 23L', N'Samsung', 800, 3000000, N'Cái', N'Lò vi sóng đa chức năng', 'NCC01', 'KM002', 'DM007'),
('SP014', N'Lò vi sóng Toshiba 25L', N'Toshiba', 900, 3500000, N'Cái', N'Lò vi sóng có nướng', 'NCC04', NULL, 'DM007'),
('SP015', N'Máy xay sinh tố Philips', N'Philips', 600, 1500000, N'Cái', N'Máy xay đa năng, lưỡi thép không gỉ', 'NCC06', 'KM004', 'DM008'),
('SP016', N'Máy xay sinh tố Toshiba', N'Toshiba', 500, 1200000, N'Cái', N'Máy xay nhỏ gọn, dễ vệ sinh', 'NCC04', NULL, 'DM008'),
('SP017', N'Nồi chiên không dầu Philips 4L', N'Philips', 1400, 4000000, N'Cái', N'Nồi chiên không dầu, công nghệ Rapid Air', 'NCC06', 'KM005', 'DM009'),
('SP018', N'Nồi chiên không dầu Sharp 5L', N'Sharp', 1500, 4500000, N'Cái', N'Nồi chiên dung tích lớn', 'NCC08', NULL, 'DM009'),
('SP019', N'Quạt điện Panasonic', N'Panasonic', 50, 800000, N'Cái', N'Quạt đứng, 3 tốc độ gió', 'NCC03', 'KM003', 'DM010'),
('SP020', N'Quạt điện Toshiba', N'Toshiba', 60, 900000, N'Cái', N'Quạt bàn, thiết kế hiện đại', 'NCC04', NULL, 'DM010');

INSERT INTO KhoHang (MaSP, SoLuongTon, NgayCapNhat) VALUES
('SP001', 50, '2025-05-20'),
('SP002', 30, '2025-05-20'),
('SP003', 40, '2025-05-20'),
('SP004', 25, '2025-05-20'),
('SP005', 60, '2025-05-20'),
('SP006', 45, '2025-05-20'),
('SP007', 35, '2025-05-20'),
('SP008', 20, '2025-05-20'),
('SP009', 55, '2025-05-20'),
('SP010', 30, '2025-05-20'),
('SP011', 40, '2025-05-20'),
('SP012', 25, '2025-05-20'),
('SP013', 50, '2025-05-20'),
('SP014', 35, '2025-05-20'),
('SP015', 60, '2025-05-20'),
('SP016', 45, '2025-05-20'),
('SP017', 30, '2025-05-20'),
('SP018', 25, '2025-05-20'),
('SP019', 50, '2025-05-20'),
('SP020', 40, '2025-05-20');

INSERT INTO HoaDon (MaHD, MaKH, MaNV, NgayBan) VALUES
('HD001', 'KH001', 'NV001', '2025-01-10 10:00:00'),
('HD002', 'KH002', 'NV002', '2025-01-15 11:30:00'),
('HD003', 'KH003', 'NV003', '2025-02-01 14:20:00'),
('HD004', 'KH004', 'NV004', '2025-02-10 09:45:00'),
('HD005', 'KH005', 'NV005', '2025-03-05 15:10:00'),
('HD006', 'KH006', 'NV006', '2025-03-15 16:30:00'),
('HD007', 'KH007', 'NV007', '2025-04-01 10:50:00'),
('HD008', 'KH008', 'NV008', '2025-04-10 12:15:00'),
('HD009', 'KH009', 'NV009', '2025-05-01 13:40:00'),
('HD010', 'KH010', 'NV010', '2025-05-10 11:00:00'),
('HD011', 'KH011', 'NV011', '2025-05-15 14:30:00'),
('HD012', 'KH012', 'NV012', '2025-05-20 09:20:00'),
('HD013', 'KH013', 'NV013', '2025-05-25 10:45:00'),
('HD014', 'KH014', 'NV014', '2025-05-26 15:00:00'),
('HD015', 'KH015', 'NV015', '2025-05-27 16:20:00'),
('HD016', 'KH016', 'NV016', '2024-05-28 08:30:00'),
('HD017', 'KH017', 'NV017', '2024-05-28 10:00:00'),
('HD018', 'KH018', 'NV018', '2024-05-28 12:15:00'),
('HD019', 'KH019', 'NV019', '2024-05-28 14:40:00'),
('HD020', 'KH020', 'NV020', '2024-05-28 16:00:00');

INSERT INTO ChiTietHoaDon (MaHD, MaSP, DonGia, SoLuong, MucGiamGia) VALUES
('HD001', 'SP001', 15000000, 1, 20.00),
('HD001', 'SP015', 1500000, 2, 25.00),
('HD002', 'SP003', 12000000, 1, 15.00),
('HD002', 'SP019', 800000, 1, 15.00),
('HD003', 'SP005', 9000000, 1, 25.00),
('HD003', 'SP017', 4000000, 1, 20.00),
('HD004', 'SP007', 10000000, 1, 10.00),
('HD004', 'SP013', 3000000, 1, 30.00),
('HD005', 'SP009', 7000000, 1, 15.00),
('HD005', 'SP011', 5000000, 1, 20.00),
('HD006', 'SP002', 35000000, 1, 30.00),
('HD006', 'SP020', 900000, 2, 0.00),
('HD007', 'SP004', 18000000, 1, 0.00),
('HD007', 'SP014', 3500000, 1, 0.00),
('HD008', 'SP006', 11000000, 1, 0.00),
('HD008', 'SP016', 1200000, 2, 0.00),
('HD009', 'SP008', 13000000, 1, 0.00),
('HD009', 'SP018', 4500000, 1, 0.00),
('HD010', 'SP010', 8000000, 1, 0.00),
('HD010', 'SP012', 6000000, 1, 0.00);

INSERT INTO BaoHanh (MaBH, MaHD, MaSP, NgayMua, ThoiHanBaoHanh) VALUES
('BH001', 'HD001', 'SP001', '2025-01-10', 24),
('BH002', 'HD001', 'SP015', '2025-01-10', 12),
('BH003', 'HD002', 'SP003', '2025-01-15', 24),
('BH004', 'HD002', 'SP019', '2025-01-15', 12),
('BH005', 'HD003', 'SP005', '2025-02-01', 24),
('BH006', 'HD003', 'SP017', '2025-02-01', 12),
('BH007', 'HD004', 'SP007', '2025-02-10', 24),
('BH008', 'HD004', 'SP013', '2025-02-10', 12),
('BH009', 'HD005', 'SP009', '2025-03-05', 24),
('BH010', 'HD005', 'SP011', '2025-03-05', 12),
('BH011', 'HD006', 'SP002', '2025-03-15', 24),
('BH012', 'HD006', 'SP020', '2025-03-15', 12),
('BH013', 'HD007', 'SP004', '2025-04-01', 24),
('BH014', 'HD007', 'SP014', '2025-04-01', 12),
('BH015', 'HD008', 'SP006', '2025-04-10', 24),
('BH016', 'HD008', 'SP016', '2025-04-10', 12),
('BH017', 'HD009', 'SP008', '2025-05-01', 24),
('BH018', 'HD009', 'SP018', '2025-05-01', 12),
('BH019', 'HD010', 'SP010', '2025-05-10', 24),
('BH020', 'HD010', 'SP012', '2025-05-10', 12);

INSERT INTO NhapKho (MaNhap, MaNCC, MaSP, SoLuong, GiaNhap, NgayNhap) VALUES
('NK001', 'NCC01', 'SP001', 50, 12000000, '2025-01-01'),
('NK002', 'NCC05', 'SP002', 30, 30000000, '2025-01-02'),
('NK003', 'NCC02', 'SP003', 40, 10000000, '2025-01-03'),
('NK004', 'NCC03', 'SP004', 25, 15000000, '2025-01-04'),
('NK005', 'NCC01', 'SP005', 60, 7500000, '2025-01-05'),
('NK006', 'NCC04', 'SP006', 45, 9000000, '2025-01-06'),
('NK007', 'NCC10', 'SP007', 35, 8500000, '2025-01-07'),
('NK008', 'NCC02', 'SP008', 20, 11000000, '2025-01-08'),
('NK009', 'NCC06', 'SP009', 55, 6000000, '2025-01-09'),
('NK010', 'NCC08', 'SP010', 30, 6500000, '2025-01-10'),
('NK011', 'NCC03', 'SP011', 40, 4000000, '2025-01-11'),
('NK012', 'NCC07', 'SP012', 25, 5000000, '2025-01-12'),
('NK013', 'NCC01', 'SP013', 50, 2500000, '2025-01-13'),
('NK014', 'NCC04', 'SP014', 35, 3000000, '2025-01-14'),
('NK015', 'NCC06', 'SP015', 60, 1200000, '2025-01-15'),
('NK016', 'NCC04', 'SP016', 45, 1000000, '2025-01-16'),
('NK017', 'NCC06', 'SP017', 30, 3500000, '2025-01-17'),
('NK018', 'NCC08', 'SP018', 25, 4000000, '2025-01-18'),
('NK019', 'NCC03', 'SP019', 50, 700000, '2025-01-19'),
('NK020', 'NCC04', 'SP020', 40, 750000, '2025-01-20');

INSERT INTO LichSuBaoHanh (MaLichSu, MaBH, LoiSanPham, ChiPhi, NgayXuLy) VALUES
('LS001', 'BH001', N'Lỗi màn hình hiển thị', 500000, '2025-02-10'),
('LS002', 'BH002', N'Lỗi lưỡi dao xay', 200000, '2025-02-15'),
('LS003', 'BH003', N'Lỗi động cơ làm lạnh', 1000000, '2025-03-01'),
('LS004', 'BH004', N'Lỗi quạt không quay', 150000, '2025-03-05'),
('LS005', 'BH005', N'Lỗi động cơ máy giặt', 800000, '2025-03-10'),
('LS006', 'BH006', N'Lỗi cảm biến nhiệt', 300000, '2025-03-15'),
('LS007', 'BH007', N'Lỗi làm lạnh không đều', 600000, '2025-04-01'),
('LS008', 'BH008', N'Lỗi lò vi sóng không nóng', 250000, '2025-04-05'),
('LS009', 'BH009', N'Lỗi lọc bụi', 400000, '2025-04-10'),
('LS010', 'BH010', N'Lỗi bếp từ không nhận nồi', 350000, '2025-04-15'),
('LS011', 'BH011', N'Lỗi màn hình OLED', 1500000, '2025-04-20'),
('LS012', 'BH012', N'Lỗi quạt không quay', 150000, '2025-04-25'),
('LS013', 'BH013', N'Lỗi ngăn đông không lạnh', 900000, '2025-05-01'),
('LS014', 'BH014', N'Lỗi lò vi sóng không hoạt động', 300000, '2025-05-05'),
('LS015', 'BH015', N'Lỗi động cơ máy giặt', 700000, '2025-05-10'),
('LS016', 'BH016', N'Lỗi lưỡi dao xay', 200000, '2025-05-15'),
('LS017', 'BH017', N'Lỗi làm lạnh không đều', 600000, '2025-05-20'),
('LS018', 'BH018', N'Lỗi cảm biến nhiệt', 350000, '2025-05-25'),
('LS019', 'BH019', N'Lỗi lọc bụi', 400000, '2025-05-26'),
('LS020', 'BH020', N'Lỗi bếp từ không nhận nồi', 350000, '2025-05-27');
--3a. Truy vấn đơn giản (3 câu)(TUYEN)
--a1. Hiển thị thông tin sản phẩm có giá bán từ 10 triệu trở lên
SELECT MaSP, TenSP, GiaBan
FROM SanPham sp
WHERE GiaBan >= 10000000;

--a2. Liệt kê các sản phẩm có số lượng tồn kho còn đúng 30 cái
SELECT sp.MaSP, sp.TenSP, kh.SoLuongTon
FROM SanPham sp
JOIN KhoHang kh ON sp.MaSP = kh.MaSP
WHERE kh.SoLuongTon = 30;

--a3. Tính tổng tiền bán được của mỗi hóa đơn (sau khi trừ khuyến mãi)
SELECT MaHD, SUM(DonGia * SoLuong * (1 - MucGiamGia / 100)) AS TongTien
FROM ChiTietHoaDon
GROUP BY MaHD;

-- ========================================

-- 3b: 7 câu truy vấn Aggerate Functions(KHANH)
-- b1. Doanh thu từ từng sản phẩm có khuyến mãi trong quý 1 năm 2025
SELECT sp.MaSP, sp.TenSP, km.MaKM, km.TenKM, 
        SUM(ct.DonGia * ct.SoLuong * (1 - ct.MucGiamGia / 100)) AS DoanhThu
FROM HoaDon hd
JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
JOIN SanPham sp ON ct.MaSP = sp.MaSP
JOIN KhuyenMai km ON sp.MaKM = km.MaKM
WHERE YEAR(hd.NgayBan) = 2025 
  AND MONTH(hd.NgayBan) IN (1, 2, 3)
  AND sp.MaKM IS NOT NULL
  AND hd.NgayBan BETWEEN km.NgayBatDau AND km.NgayKetThuc
GROUP BY sp.MaSP, sp.TenSP, km.MaKM, km.TenKM
ORDER BY DoanhThu DESC;

-- b2. Tổng doanh thu theo danh mục sản phẩm trong năm 2025
SELECT dm.MaDM, dm.TenDM, SUM(ct.DonGia * ct.SoLuong * (1 - ct.MucGiamGia / 100)) AS TongDoanhThu
FROM DanhMucSanPham dm
JOIN SanPham sp ON dm.MaDM = sp.MaDM
JOIN ChiTietHoaDon ct ON sp.MaSP = ct.MaSP
JOIN HoaDon hd ON ct.MaHD = ct.MaHD
WHERE YEAR(hd.NgayBan) = 2025
GROUP BY dm.MaDM, dm.TenDM
ORDER BY TongDoanhThu DESC;

-- b3. Số lượng hóa đơn và doanh thu trung bình nhân viên trong tháng 5/2025
SELECT nv.MaNV, nv.HoTen, COUNT(hd.MaHD) AS SoLuongHoaDon, 
        AVG(ct.DonGia * ct.SoLuong * (1 - ct.MucGiamGia / 100)) AS DoanhThuTrungBinh
FROM NhanVien nv
JOIN HoaDon hd ON nv.MaNV = hd.MaNV
JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
WHERE YEAR(hd.NgayBan) = 2025 AND MONTH(hd.NgayBan) = 5
GROUP BY nv.MaNV, nv.HoTen
ORDER BY SoLuongHoaDon DESC;

-- b4. Sản phẩm bán chạy nhất (theo số lượng bán) trong tháng 1/2025
SELECT TOP 1 sp.MaSP, sp.TenSP, SUM(ct.SoLuong) AS TongSoLuongBan
FROM SanPham sp
JOIN ChiTietHoaDon ct ON sp.MaSP = ct.MaSP
JOIN HoaDon hd ON ct.MaHD = hd.MaHD
WHERE YEAR(hd.NgayBan) = 2025 AND MONTH(hd.NgayBan) = 1
GROUP BY sp.MaSP, sp.TenSP
ORDER BY TongSoLuongBan DESC;

-- b5. Hiển thị các sản phẩm tồn kho theo danh mục, số lượng tồn kho, và giá trị tồn kho (dựa trên giá bán) trong tháng 5/2025
SELECT  dm.TenDM, sp.MaSP, sp.TenSP, SUM(kh.SoLuongTon) AS SoLuongTon,
         SUM(kh.SoLuongTon * sp.GiaBan) AS GiaTriTonKho
FROM DanhMucSanPham dm
JOIN SanPham sp ON dm.MaDM = sp.MaDM
JOIN KhoHang kh ON sp.MaSP = kh.MaSP
WHERE YEAR(kh.NgayCapNhat) = 2025 AND MONTH(kh.NgayCapNhat) = 5
GROUP BY dm.MaDM, dm.TenDM, sp.MaSP, sp.TenSP
ORDER BY dm.MaDM, GiaTriTonKho DESC;

-- b6. Tổng chi phí bảo hành theo nhà cung cấp
SELECT ncc.MaNCC, ncc.TenNCC, SUM(ls.ChiPhi) AS TongChiPhiBaoHanh
FROM NhaCungCap ncc
JOIN SanPham sp ON ncc.MaNCC = sp.MaNCC
JOIN BaoHanh bh ON sp.MaSP = bh.MaSP
JOIN LichSuBaoHanh ls ON bh.MaBH = ls.MaBH
GROUP BY ncc.MaNCC, ncc.TenNCC
ORDER BY TongChiPhiBaoHanh DESC;

-- b7. Hiển thị 3 khách hàng có tổng chi tiêu cao nhất trong năm 2024
SELECT TOP 3 kh.MaKH, kh.HoTen, 
        SUM(ct.DonGia * ct.SoLuong * (1 - ct.MucGiamGia / 100)) AS TongChiTieu
FROM KhachHang kh
JOIN HoaDon hd ON kh.MaKH = hd.MaKH
JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
WHERE YEAR(hd.NgayBan) = 2024
GROUP BY kh.MaKH, kh.HoTen
ORDER BY TongChiTieu DESC;
-- =================================================
--3c. Truy vấn having (5 câu)(TUYEN)

--c1. Tìm các danh mục sản phẩm nhiều hơn 5 sản phẩm
SELECT dm.TenDM, COUNT(sp.MaSP) AS TongSoSp
FROM DanhMucSanPham dm
JOIN SanPham sp ON dm.MaDM = sp.MaDM
GROUP BY dm.TenDM
HAVING COUNT(sp.MaSP) > 5;

--c2. Liệt kê các nhà cung cấp có tổng giá trị nhập kho ít nhất là 50 triệu
SELECT Ncc.TenNCC, SUM(Nkh.SoLuong * Nkh.GiaNhap) AS TongGTnhap
FROM NhaCungCap Ncc
JOIN NhapKho Nkh ON ncc.MaNCC = Nkh.MaNCC
GROUP BY ncc.TenNCC
HAVING SUM(Nkh.SoLuong * Nkh.GiaNhap) >= 50000000;

--c3. Liệt kê các danh mục sản phẩm đã có sản phẩm được bán ra
SELECT dm.MaDM as Madanhmuc, dm.TenDM as Tendanhmuc
FROM DanhMucSanPham dm 
JOIN SanPham sp ON dm.MaDM = sp.MaDM
JOIN ChiTietHoaDon AS cthd ON sp.MaSP = cthd.MaSP
GROUP BY dm.MaDM, dm.TenDM
HAVING COUNT(cthd.MaSP) > 0;

--c4. Tìm các nhà cung cấp chỉ cung cấp sản phẩm cho duy nhất một danh mục sản phẩm
SELECT Ncc.MaNCC AS MaNhaCungCap, Ncc.TenNCC AS Ten, COUNT(DISTINCT sp.MaDM) AS Soluong
FROM NhaCungCap Ncc
JOIN SanPham sp ON Ncc.MaNCC = sp.MaNCC
GROUP BY ncc.MaNCC, ncc.TenNCC
HAVING COUNT(DISTINCT sp.MaDM) = 1;

--c5. Hiển thị các khách hàng có tổng chi tiêu trên 50 triệu
SELECT kh.MaKH, kh.HoTen, SUM(cthd.DonGia * cthd.SoLuong * (1 - cthd.MucGiamGia / 100)) AS TongChiTieu
FROM KhachHang kh
JOIN HoaDon hd ON kh.MaKH = hd.MaKH
JOIN ChiTietHoaDon cthd ON hd.MaHD = cthd.MaHD
GROUP BY kh.MaKH, kh.HoTen
HAVING SUM(cthd.DonGia * cthd.SoLuong * (1 - cthd.MucGiamGia / 100)) > 50000000
ORDER BY TongChiTieu DESC;

-- =================================================
--3d: 3 Câu truy vấn tìm giá trị lớn nhất hoặc nhỏ nhất(DAT)
--d1.Tìm khách hàng có tổng tiền mua hàng cao nhất
SELECT TOP 1 KH.MaKH, KH.HoTen, SUM(CT.SoLuong * SP.GiaBan) AS TongTien 
FROM HoaDon HD
JOIN KhachHang KH ON HD.MaKH = KH.MaKH
JOIN ChiTietHoaDon CT ON HD.MaHD = CT.MaHD
JOIN SanPham SP ON CT.MaSP = SP.MaSP
GROUP BY KH.MaKH, KH.HoTen 
ORDER BY TongTien DESC;
--d2.Tìm sản phẩm có giá bán thấp nhất
SELECT TOP 1 MaSP, TenSP, GiaBan
FROM SanPham
ORDER BY GiaBan ASC;
--d3.Tìm nhân viên có lương cao nhất
SELECT TOP 1 MaNV, HoTen, LuongCB 
FROM NhanVien
ORDER BY LuongCB DESC; 
-- =================================================
--3e. Truy vấn Không/chưa có: (Not In và left/right join): 5 câu(HOAI)
--e1. Danh sách khách hàng chưa từng mua hàng
SELECT MaKH, HoTen, DiaChi, SoDienThoai, Email
FROM KhachHang
WHERE MaKH NOT IN (
    SELECT DISTINCT MaKH FROM HoaDon
);
--e2. Danh sách sản phẩm chưa từng được bán
SELECT sp.MaSP, sp.TenSP, sp.GiaBan, kh.SoLuongTon, sp.MaDM, sp.MaNCC
FROM SanPham sp
JOIN KhoHang kh ON sp.MaSP = kh.MaSP
WHERE sp.MaSP NOT IN (
    SELECT DISTINCT MaSP FROM ChiTietHoaDon
);
-- e3. Danh sách nhân viên chưa lập hóa đơn nào
SELECT MaNV, HoTen, NgaySinh, DiaChi, SoDienThoai
FROM NhanVien
WHERE MaNV NOT IN (
    SELECT DISTINCT MaNV FROM HoaDon
);
--e4. Danh sách nhà cung cấp không có sản phẩm nào
SELECT NCC.MaNCC, TenNCC, DiaChi, SoDienThoai, Email
FROM NhaCungCap NCC
LEFT JOIN SanPham SP ON NCC.MaNCC = SP.MaNCC
WHERE SP.MaSP IS NULL;
-- e5. Danh sách loại sản phẩm chưa có sản phẩm nào
SELECT DM.MaDM, TenDM
FROM DanhMucSanPham DM
LEFT JOIN SanPham SP ON DM.MaDM = SP.MaDM
WHERE SP.MaSP IS NULL;
-- =================================================
--3f:3 Câu truy vấn hợp / giao / trừ(DAT)
--f1. HỢP (UNION) – Danh sách tất cả khách hàng từng mua hàng hoặc từng bảo hành sản phẩm
SELECT MaKH FROM HoaDon
UNION
SELECT MaKH FROM BaoHanh bh JOIN HoaDon hd on bh.MaHD=hd.MaHD;
--f2. GIAO (INTERSECT) –Tìm khách hàng vừa từng mua hàng và vừa từng bảo hành sản phẩm  
SELECT MaKH FROM HoaDon
INTERSECT
SELECT HD.MaKH
FROM BaoHanh BH
JOIN HoaDon HD ON BH.MaHD = HD.MaHD
JOIN LichSuBaoHanh LS ON BH.MaBH = LS.MaBH;
--f3. TRỪ (EXCEPT) – Sản phẩm đã từng được nhập kho nhưng chưa từng được bán
SELECT MaSP FROM KhoHang
EXCEPT
SELECT MaSP FROM ChiTietHoaDon;
-- =================================================
--3g. Truy vấn Update, Delete: 7 câu(HOAI)
--g1. Cập nhật địa chỉ mới cho một khách hàng
UPDATE KhachHang
SET DiaChi = '123 Đường Lý Thường Kiệt, Quận 10, TP.HCM'
WHERE MaKH = 'KH001';
--g2. Tăng giá 10% cho tất cả sản phẩm thuộc loại “Tủ lạnh”
UPDATE SanPham
SET GiaBan = GiaBan * 1.10
WHERE MaDM = (
    SELECT MaDM FROM DanhMucSanPham WHERE TenDM = N'Tủ lạnh'
);
--g3. Cập nhật số điện thoại cho nhân viên có mã NV005
UPDATE NhanVien
SET SoDienThoai = '0988123456'
WHERE MaNV = 'NV005';
--g4. Giảm 5% giá cho sản phẩm còn tồn kho trên 50
UPDATE SanPham
SET GiaBan = GiaBan * 0.95
FROM SanPham sp
JOIN KhoHang kh ON sp.MaSP = kh.MaSP
WHERE kh.SoLuongTon > 50;
--g5. Cập nhật email cho tất cả nhà cung cấp không có email
UPDATE NhaCungCap
SET Email = 'chua.capnhat@email.com'
WHERE Email IS NULL;
--Câu lệnh DELETE
--g6. Xóa khách hàng chưa từng mua hàng
DELETE FROM KhachHang
WHERE MaKH NOT IN (
    SELECT DISTINCT MaKH FROM HoaDon
);
--g7. Xóa sản phẩm chưa từng xuất hiện trong chi tiết hóa đơn
DELETE FROM SanPham
WHERE MaSP NOT IN (
    SELECT DISTINCT MaSP FROM ChiTietHoaDon
);
-- =================================================

-- 3h: 2 câu truy vấn với phép chia(KHANH)
-- h1: Tìm khách hàng đã mua tất cả sản phẩm đang khuyến mãi
SELECT DISTINCT kh.MaKH, kh.HoTen
FROM KhachHang kh
WHERE NOT EXISTS (
    SELECT sp.MaSP
    FROM SanPham sp
    WHERE sp.MaKM IS NOT NULL
    AND NOT EXISTS (
        SELECT cthd.MaSP
        FROM ChiTietHoaDon cthd
        JOIN HoaDon hd ON cthd.MaHD = hd.MaHD
        WHERE hd.MaKH = kh.MaKH
        AND cthd.MaSP = sp.MaSP
    )
);
-- h2: Tìm sản phẩm đã được tất cả khách hàng mua
SELECT DISTINCT sp.MaSP, sp.TenSP
FROM SanPham sp
WHERE NOT EXISTS (
    SELECT kh.MaKH
    FROM KhachHang kh
    WHERE NOT EXISTS (
        SELECT cthd.MaSP
        FROM ChiTietHoaDon cthd
        JOIN HoaDon hd ON cthd.MaHD = hd.MaHD
        WHERE hd.MaKH = kh.MaKH
        AND cthd.MaSP = sp.MaSP
    )
);

-- 4 Thủ tục / Hàm / Trigger
-- Thủ tục
-- Thủ tục thêm khách hàng
GO
CREATE PROCEDURE sp_ThemKhachHang
    @MaKH VARCHAR(10),
    @HoTen NVARCHAR(50),
    @SoDienThoai CHAR(10),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(100),
    @Email VARCHAR(50)
AS
BEGIN
    INSERT INTO KhachHang (MaKH, HoTen, SoDienThoai, NgaySinh, DiaChi, Email)
    VALUES (@MaKH, @HoTen, @SoDienThoai, @NgaySinh, @DiaChi, @Email);
END;
GO

-- Ví dụ
EXEC sp_ThemKhachHang 
    @MaKH = 'KH021', 
    @HoTen = N'Nguyễn Văn Bình', 
    @SoDienThoai = '0901234581', 
    @NgaySinh = '1990-01-01', 
    @DiaChi = N'123 Nguyễn Huệ, TP.HCM', 
    @Email = 'nguyenbinh@gmail.com';
GO


-- Thủ tục cập nhật số lượng tồn
CREATE PROCEDURE sp_CapNhatSoLuongTon
    @MaSP VARCHAR(10),
    @SoLuong INT
AS
BEGIN
    UPDATE KhoHang
    SET SoLuongTon = @SoLuong,
        NgayCapNhat = GETDATE()
    WHERE MaSP = @MaSP;
END;
GO

-- Ví dụ
EXEC sp_CapNhatSoLuongTon 
    @MaSP = 'SP001', 
    @SoLuong = 100;
GO


-- Thủ tục thêm hóa đơn
CREATE PROCEDURE sp_ThemHoaDon
    @MaHD VARCHAR(10),
    @MaKH VARCHAR(10),
    @MaNV VARCHAR(10)
AS
BEGIN
    INSERT INTO HoaDon (MaHD, MaKH, MaNV, NgayBan)
    VALUES (@MaHD, @MaKH, @MaNV, GETDATE());
END;
GO

-- Ví dụ
EXEC sp_ThemHoaDon 
    @MaHD = 'HD021', 
    @MaKH = 'KH001', 
    @MaNV = 'NV001';
GO

-- Hàm

-- Hàm tính tổng tiền hóa đơn
CREATE FUNCTION fn_TinhTongTienHoaDon (@MaHD VARCHAR(10))
RETURNS MONEY
AS
BEGIN
    DECLARE @TongTien MONEY;
    SELECT @TongTien = SUM(DonGia * SoLuong * (1 - MucGiamGia / 100))
    FROM ChiTietHoaDon
    WHERE MaHD = @MaHD;
    RETURN ISNULL(@TongTien, 0);
END;
GO

-- Ví dụ
SELECT dbo.fn_TinhTongTienHoaDon('HD001') AS TongTienHoaDon;
GO



-- Hàm kiểm tra số lượng tồn
CREATE FUNCTION fn_KiemTraSoLuongTon (@MaSP VARCHAR(10))
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

-- Ví dụ
SELECT dbo.fn_KiemTraSoLuongTon('SP001') AS SoLuongTon;
GO

-- Trigger
-- Trigger cập nhật số lượng tồn kho khi xuất hóa đơn
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'tr_CapNhatKhoHang')
    DROP TRIGGER tr_CapNhatKhoHang;
GO
CREATE TRIGGER tr_CapNhatKhoHang
ON ChiTietHoaDon
AFTER INSERT
AS
BEGIN
    UPDATE KhoHang
    SET SoLuongTon = KhoHang.SoLuongTon - inserted.SoLuong,
        NgayCapNhat = GETDATE()
    FROM KhoHang
    JOIN inserted ON KhoHang.MaSP = inserted.MaSP
    WHERE KhoHang.SoLuongTon >= inserted.SoLuong;
END;
GO

-- Ví dụ: Thêm chi tiết hóa đơn để kích hoạt trigger
INSERT INTO ChiTietHoaDon (MaHD, MaSP, DonGia, SoLuong, MucGiamGia)
VALUES ('HD021', 'SP001', 15000000, 2, 20.00);
GO


-- Trigger cập nhật số lượng tồn kho khi nhập kho
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'tr_KiemTraSoLuongNhapKho')
    DROP TRIGGER tr_KiemTraSoLuongNhapKho;
GO
CREATE TRIGGER tr_KiemTraSoLuongNhapKho
ON NhapKho
AFTER INSERT
AS
BEGIN
    UPDATE KhoHang
    SET SoLuongTon = KhoHang.SoLuongTon + inserted.SoLuong,
        NgayCapNhat = GETDATE()
    FROM KhoHang
    JOIN inserted ON KhoHang.MaSP = inserted.MaSP;
END;
GO

-- Ví dụ: Thêm bản ghi nhập kho để kích hoạt trigger
INSERT INTO NhapKho (MaNhap, MaNCC, MaSP, SoLuong, GiaNhap, NgayNhap)
VALUES ('NK021', 'NCC01', 'SP001', 10, 12000000, '2025-06-03');
GO


-- Trigger kiểm tra số lượng bán với số lượng tồn kho
CREATE TRIGGER tr_KiemTraSoLuongBan
ON ChiTietHoaDon
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT * 
        FROM inserted i
        JOIN KhoHang kh ON i.MaSP = kh.MaSP
        WHERE i.SoLuong > kh.SoLuongTon
    )
    BEGIN
        RAISERROR (N'Số lượng bán vượt quá số lượng tồn kho.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Ví dụ: Cố gắng thêm chi tiết hóa đơn với số lượng vượt quá tồn kho
INSERT INTO ChiTietHoaDon (MaHD, MaSP, DonGia, SoLuong, MucGiamGia)
VALUES ('HD021', 'SP002', 35000000, 5, 30.00);
GO

-- 5: Tạo 3 người dùng và cấp quyền cho mỗi người dùng với các quyền khác nhau
CREATE LOGIN ChuCuaHang WITH PASSWORD = 'MatKhauChu123', DEFAULT_DATABASE = QLCHDienTuGiaDung;
CREATE LOGIN NhanVienBanHang WITH PASSWORD = 'MatKhauNVBH123', DEFAULT_DATABASE = QLCHDienTuGiaDung;
CREATE LOGIN NhanVienKho WITH PASSWORD = 'MatKhauNVK123', DEFAULT_DATABASE = QLCHDienTuGiaDung;
GO

CREATE USER ChuCuaHang FOR LOGIN ChuCuaHang;
CREATE USER NhanVienBanHang FOR LOGIN NhanVienBanHang;
CREATE USER NhanVienKho FOR LOGIN NhanVienKho;
GO

-- Phân quyền
GRANT CONTROL ON DATABASE::QLCHDienTuGiaDung TO ChuCuaHang;
GO

GRANT SELECT, INSERT ON HoaDon TO NhanVienBanHang;
GRANT SELECT, INSERT ON ChiTietHoaDon TO NhanVienBanHang;
GRANT SELECT, INSERT, UPDATE ON KhachHang TO NhanVienBanHang;
GRANT SELECT ON SanPham TO NhanVienBanHang;
GRANT SELECT ON KhuyenMai TO NhanVienBanHang;
GRANT SELECT ON DanhMucSanPham TO NhanVienBanHang;
GO

GRANT SELECT, UPDATE ON KhoHang TO NhanVienKho;
GRANT SELECT, INSERT ON NhapKho TO NhanVienKho;
GRANT SELECT ON SanPham TO NhanVienKho;
GRANT SELECT ON NhaCungCap TO NhanVienKho;
GO

