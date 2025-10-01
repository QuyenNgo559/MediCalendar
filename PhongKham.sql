CREATE DATABASE PhongKham;

GO

USE PhongKham;
GO

-- Bảng chuyên khoa
CREATE TABLE dbo.ChuyenKhoa (
    MaCK INT IDENTITY(1,1) PRIMARY KEY,
    TenCK NVARCHAR(100) NOT NULL
);
GO

-- Bảng bệnh nhân
CREATE TABLE dbo.BenhNhan (
    MaBN INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(200) NOT NULL,
    NgaySinh DATE NULL,
    SDT NVARCHAR(20) NULL,
    Email NVARCHAR(150) NULL,
    CCCD NVARCHAR(20) NULL,
    MatKhau NVARCHAR(255) NULL,
    DiaChi NVARCHAR(255) NULL
);
GO

-- Bảng bác sĩ
CREATE TABLE dbo.BacSi (
    MaBS INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(200) NOT NULL,
    MaCK INT NULL,
    MatKhau NVARCHAR(255) NULL,
    CONSTRAINT FK_BacSi_ChuyenKhoa FOREIGN KEY (MaCK)
        REFERENCES dbo.ChuyenKhoa(MaCK)
);
GO

-- Lịch khám
CREATE TABLE dbo.LichKham (
    MaLich INT IDENTITY(1,1) PRIMARY KEY,
    MaBN INT NOT NULL,
    MaBS INT NOT NULL,
    NgayGio DATETIME2 NULL,
    STT INT NULL,
    TrangThai NVARCHAR(50) NULL,
    GhiChu NVARCHAR(MAX) NULL,
    CONSTRAINT FK_LichKham_BenhNhan FOREIGN KEY (MaBN)
        REFERENCES dbo.BenhNhan(MaBN),
    CONSTRAINT FK_LichKham_BacSi FOREIGN KEY (MaBS)
        REFERENCES dbo.BacSi(MaBS)
);
GO

-- Đơn thuốc
CREATE TABLE dbo.DonThuoc (
    MaDon INT IDENTITY(1,1) PRIMARY KEY,
    MaLich INT NOT NULL,
    NgayLap DATE NULL,
    TenThuoc NVARCHAR(255) NULL,
    SoLuong INT NULL,
    HuongDan NVARCHAR(MAX) NULL,
    CONSTRAINT FK_DonThuoc_LichKham FOREIGN KEY (MaLich)
        REFERENCES dbo.LichKham(MaLich)
);
GO

-- Kết quả khám
CREATE TABLE dbo.KetQuaKham (
    MaKQ INT IDENTITY(1,1) PRIMARY KEY,
    MaLich INT NOT NULL,
    ChanDoan NVARCHAR(MAX) NULL,
    GhiChu NVARCHAR(MAX) NULL,
    NgayKham DATE NULL,
    CONSTRAINT FK_KetQuaKham_LichKham FOREIGN KEY (MaLich)
        REFERENCES dbo.LichKham(MaLich)
);
GO

-- Thanh toán
CREATE TABLE dbo.ThanhToan (
    MaTT INT IDENTITY(1,1) PRIMARY KEY,
    MaLich INT NOT NULL,
    SoTien DECIMAL(12,2) NULL,
    PhuongThuc NVARCHAR(50) NULL,
    TrangThai NVARCHAR(50) NULL,
    NgayTT DATE NULL,
    CONSTRAINT FK_ThanhToan_LichKham FOREIGN KEY (MaLich)
        REFERENCES dbo.LichKham(MaLich)
);
GO

-- Thông báo
CREATE TABLE dbo.ThongBao (
    MaTB INT IDENTITY(1,1) PRIMARY KEY,
    MaBN INT NULL,
    MaBS INT NULL,
    MaLich INT NULL,
    TieuDe NVARCHAR(200) NULL,
    NoiDung NVARCHAR(MAX) NULL,
    LoaiThongBao NVARCHAR(50) NULL,
    NgayGui DATETIME2 NULL,
    TrangThai NVARCHAR(50) NULL,
    CONSTRAINT FK_ThongBao_BenhNhan FOREIGN KEY (MaBN) REFERENCES dbo.BenhNhan(MaBN),
    CONSTRAINT FK_ThongBao_BacSi FOREIGN KEY (MaBS) REFERENCES dbo.BacSi(MaBS),
    CONSTRAINT FK_ThongBao_LichKham FOREIGN KEY (MaLich) REFERENCES dbo.LichKham(MaLich)
);
GO
