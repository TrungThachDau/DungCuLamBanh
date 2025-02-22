USE [qlbandungcu]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 07/07/2024 5:01:44 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[TenNguoiDung] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
	[Quyen] [int] NULL,
	[Ten] [nvarchar](255) NULL,
	[Email] [nchar](50) NULL,
	[DiaChi] [nvarchar](255) NULL,
	[SDT] [nchar](10) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[TenNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banner]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[TenBanner] [nvarchar](50) NULL,
	[DuongDan] [nvarchar](255) NULL,
	[LienKet] [nchar](255) NULL,
	[Id_Banner] [int] NOT NULL,
 CONSTRAINT [Banner_pk] PRIMARY KEY CLUSTERED 
(
	[Id_Banner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[checkTab]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[checkTab](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Command] [nvarchar](255) NULL,
 CONSTRAINT [checkTab_pk] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[Id_ChiTietDonHang] [int] IDENTITY(1,1) NOT NULL,
	[Id_DonHang] [nvarchar](255) NULL,
	[Id_DungCu] [int] NULL,
	[SoLuong] [int] NULL,
	[Gia] [decimal](18, 0) NULL,
 CONSTRAINT [PK_ChiTietDonHang] PRIMARY KEY CLUSTERED 
(
	[Id_ChiTietDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietKhuyenMai]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietKhuyenMai](
	[Id_CTKM] [int] IDENTITY(1,1) NOT NULL,
	[Id_KhuyenMai] [int] NULL,
	[Id_SanPham] [int] NULL,
	[GiaTriGiam] [int] NULL,
 CONSTRAINT [ChiTietKhuyenMai_pk] PRIMARY KEY CLUSTERED 
(
	[Id_CTKM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTHDNhapHang]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTHDNhapHang](
	[Id_CTHDNhapHang] [int] IDENTITY(1,1) NOT NULL,
	[Id_SanPham] [int] NULL,
	[SoLuong] [int] NULL,
	[GiaTien] [decimal](18, 0) NULL,
	[DonGia] [decimal](18, 0) NULL,
	[Id_HoaDonNhap] [nchar](20) NULL,
 CONSTRAINT [CTHDNhapHang_pk] PRIMARY KEY CLUSTERED 
(
	[Id_CTHDNhapHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuocVanChuyen]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuocVanChuyen](
	[Id_CuocVanChuyen] [int] IDENTITY(1,1) NOT NULL,
	[KhuVuc] [nvarchar](50) NULL,
	[CuocVanChuyen] [decimal](18, 0) NULL,
 CONSTRAINT [PK_CuocVanChuyen] PRIMARY KEY CLUSTERED 
(
	[Id_CuocVanChuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[Id_DonHang] [nvarchar](255) NOT NULL,
	[Id_KhachHang] [nvarchar](255) NULL,
	[NgayDat] [datetime2](7) NULL,
	[NgayGiao] [datetime2](7) NULL,
	[TongTien] [decimal](18, 0) NULL,
	[TrangThai] [nvarchar](25) NULL,
	[PhuongThucThanhToan] [int] NULL,
	[PhiVanChuyen] [numeric](18, 0) NULL,
	[Id_MaGiamGia] [nchar](10) NULL,
	[TienGiamGia] [decimal](18, 0) NULL,
	[VAT] [decimal](18, 0) NULL,
	[TienDiemThuong] [decimal](18, 0) NULL,
 CONSTRAINT [PK_DonHang] PRIMARY KEY CLUSTERED 
(
	[Id_DonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHangVanChuyen]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHangVanChuyen](
	[Id_DHVC] [int] IDENTITY(1,1) NOT NULL,
	[Id_DonHang] [nvarchar](255) NULL,
	[PhuongThucThanhToan] [int] NULL,
	[PhiVanChuyen] [numeric](18, 0) NULL,
	[DiaChiVanChuyen] [nvarchar](255) NULL,
	[TenKhachHang] [nvarchar](255) NULL,
	[SoDienThoai] [nchar](10) NULL,
	[Email] [nchar](50) NULL,
	[TinhTrang] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDonNhapHang]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonNhapHang](
	[Id_HoaDonNhap] [nchar](20) NOT NULL,
	[Id_NhaCungCap] [int] NULL,
	[NgayLapHoaDon] [datetime2](7) NULL,
	[TongTien] [decimal](18, 0) NULL,
	[TrangThai] [int] NULL,
	[NgayNhapHang] [datetime2](7) NULL,
	[NguoiLapHoaDon] [nvarchar](50) NULL,
	[NhanVienLap] [nchar](50) NULL,
 CONSTRAINT [HoaDonNhapHang_pk] PRIMARY KEY CLUSTERED 
(
	[Id_HoaDonNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[Id_KhachHang] [nvarchar](255) NOT NULL,
	[TenKhachHang] [nvarchar](255) NULL,
	[Email] [nvarchar](50) NULL,
	[SoDienThoai] [nchar](10) NULL,
	[DiaChi] [nvarchar](max) NULL,
	[DiemThuong] [decimal](18, 0) NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[Id_KhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[Id_KhuyenMai] [int] IDENTITY(1,1) NOT NULL,
	[TenKhuyenMai] [nvarchar](50) NULL,
	[NgayBatDau] [datetime2](7) NULL,
	[NgayKetThuc] [datetime] NULL,
	[TrangThai] [int] NULL,
 CONSTRAINT [PK_KhuyenMai2] PRIMARY KEY CLUSTERED 
(
	[Id_KhuyenMai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSanPham](
	[Id_LoaiDungCu] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiDungCu] [nvarchar](255) NULL,
 CONSTRAINT [PK_LoaiDungCu] PRIMARY KEY CLUSTERED 
(
	[Id_LoaiDungCu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaGiamGia]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaGiamGia](
	[Id_MaGiamGia] [nchar](10) NOT NULL,
	[TenMaGiamGia] [nvarchar](50) NULL,
	[GiaTriGiam] [numeric](18, 0) NULL,
	[LuotSuDung] [int] NULL,
 CONSTRAINT [PK_MaGiamGia] PRIMARY KEY CLUSTERED 
(
	[Id_MaGiamGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[Id_NhaCungCap] [int] IDENTITY(1,1) NOT NULL,
	[TenNhaCungCap] [nvarchar](255) NULL,
	[DiaChi] [nvarchar](255) NULL,
	[SoDienThoai] [nchar](10) NULL,
	[Email] [nchar](50) NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[Id_NhaCungCap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaSanXuat]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaSanXuat](
	[Id_NhaSanXuat] [int] IDENTITY(1,1) NOT NULL,
	[TenNSX] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](255) NULL,
 CONSTRAINT [NhaSanXuat_pk] PRIMARY KEY CLUSTERED 
(
	[Id_NhaSanXuat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhuongThucThanhToan]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhuongThucThanhToan](
	[Id_PTTT] [int] IDENTITY(1,1) NOT NULL,
	[TenPTTT] [nvarchar](50) NULL,
	[TinhTrang] [int] NULL,
 CONSTRAINT [PK_PhuongThucThanhToan] PRIMARY KEY CLUSTERED 
(
	[Id_PTTT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[Id_DungCu] [int] IDENTITY(1,1) NOT NULL,
	[TenDungCu] [nvarchar](255) NULL,
	[MoTa] [nvarchar](max) NULL,
	[Gia] [decimal](18, 0) NULL,
	[SoLuong] [int] NULL,
	[HinhAnh] [nvarchar](255) NULL,
	[Id_LoaiDungCu] [int] NULL,
	[Id_NhaCungCap] [int] NULL,
	[GiaKhuyenMai] [decimal](18, 0) NULL,
	[GiaNhap] [decimal](18, 0) NULL,
	[ThongTin] [nvarchar](max) NULL,
	[DaXoa] [int] NULL,
	[Id_NhaSanXuat] [int] NULL,
 CONSTRAINT [PK_DungCu] PRIMARY KEY CLUSTERED 
(
	[Id_DungCu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPhamYeuThich]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPhamYeuThich](
	[Id_SPYT] [int] IDENTITY(1,1) NOT NULL,
	[Id_KhachHang] [nvarchar](255) NULL,
	[Id_SanPham] [int] NULL,
 CONSTRAINT [SanPhamYeuThich_pk] PRIMARY KEY CLUSTERED 
(
	[Id_SPYT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrangThaiVanChuyen]    Script Date: 07/07/2024 5:01:45 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThaiVanChuyen](
	[Id_TrangThai] [int] NOT NULL,
	[TenTrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TrangThaiVanChuyen] PRIMARY KEY CLUSTERED 
(
	[Id_TrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Admin] ([TenNguoiDung], [MatKhau], [Quyen], [Ten], [Email], [DiaChi], [SDT]) VALUES (N'admin', N'1', 1, N'Giám đốc', N'admin@email.com                                   ', N'VN', N'0493213213')
INSERT [dbo].[Admin] ([TenNguoiDung], [MatKhau], [Quyen], [Ten], [Email], [DiaChi], [SDT]) VALUES (N'admin2', N'1', 1, N'Quản lý', N'Vi123@gmail.com                                   ', N'22 Trần Hưng Đạo', N'0789632541')
GO
INSERT [dbo].[Banner] ([TenBanner], [DuongDan], [LienKet], [Id_Banner]) VALUES (N'13', N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/Pink%20and%20Brown%20Cute%20Opening%20Soon%20Banner.gif?alt=media&token=67a067f5-7ba9-4240-a4bc-8049db56ab5a', NULL, 2)
INSERT [dbo].[Banner] ([TenBanner], [DuongDan], [LienKet], [Id_Banner]) VALUES (N'12', N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2FPurple%20and%20Pink%20Pastel%20Cute%20Fashion%20Collection%20Coming%20Soon%20Banner%20%281%29.png?alt=media&token=44991b8c-ac00-4096-8179-1292557ed665', NULL, 3)
GO
SET IDENTITY_INSERT [dbo].[checkTab] ON 

INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (6, N'a', N'Tab đang mở')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (7, N'a', N'Tab đang mở')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (8, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (9, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (10, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (11, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (12, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (13, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (14, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (15, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (16, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (17, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (18, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (19, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (20, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (21, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (22, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (23, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (24, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (25, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (26, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (27, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (28, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (29, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (30, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (31, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (32, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (33, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (34, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (35, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (36, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (37, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (38, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (39, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (40, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (41, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (42, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (43, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (44, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (45, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (46, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (47, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (48, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (49, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (50, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (51, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (52, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (53, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (54, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (55, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (56, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (57, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (58, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (59, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (60, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (61, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (62, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (63, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (64, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (65, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (66, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (67, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (68, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (69, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (70, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (71, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (72, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (73, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (74, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (75, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (76, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (77, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (78, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (79, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (80, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (81, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (82, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (83, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (84, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (85, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (86, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (87, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (88, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (89, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (90, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (91, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (92, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (93, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (94, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (95, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (96, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (97, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (98, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (99, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (100, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (101, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (102, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (103, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (104, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (105, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (106, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (107, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (108, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (109, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (110, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (111, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (112, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (113, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (114, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (115, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (116, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (117, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (118, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (119, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (120, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (121, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (122, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (123, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (124, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (125, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (126, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (127, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (128, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (129, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (130, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (131, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (132, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (133, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (134, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (135, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (136, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (137, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (138, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (139, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (140, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (141, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (142, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (143, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (144, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (145, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (146, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (147, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (148, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (149, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (150, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (151, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (152, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (153, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (154, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (155, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (156, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (157, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (158, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (159, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (160, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (161, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (162, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (163, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (164, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (165, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (166, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (167, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (168, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (169, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (170, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (171, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (172, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (173, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (174, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (175, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (176, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (177, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (178, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (179, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (180, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (181, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (182, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (183, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (184, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (185, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (186, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (187, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (188, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (189, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (190, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (191, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (192, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (193, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (194, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (195, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (196, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (197, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (198, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (199, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (200, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (201, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (202, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (203, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (204, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (205, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (206, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (207, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (208, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (209, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (210, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (211, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (212, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (213, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (214, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (215, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (216, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (217, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (218, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (219, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (220, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (221, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (222, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (223, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (224, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (225, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (226, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (227, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (228, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (229, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (230, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (231, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (232, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (233, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (234, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (235, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (236, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (237, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (238, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (239, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (240, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (241, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (242, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (243, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (244, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (245, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (246, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (247, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (248, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (249, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (250, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (251, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (252, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (253, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (254, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (255, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (256, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (257, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (258, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (259, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (260, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (261, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (262, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (263, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (264, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (265, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (266, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (267, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (268, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (269, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (270, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (271, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (272, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (273, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (274, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (275, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (276, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (277, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (278, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (279, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (280, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (281, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (282, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (283, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (284, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (285, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (286, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (287, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (288, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (289, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (290, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (291, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (292, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (293, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (294, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (295, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (296, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (297, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (298, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (299, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (300, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (301, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (302, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (303, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (304, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (305, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (306, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (307, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (308, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (309, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (310, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (311, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (312, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (313, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (314, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (315, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (316, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (317, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (318, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (319, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (320, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (321, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (322, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (323, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (324, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (325, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (326, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (327, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (328, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (329, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (330, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (331, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (332, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (333, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (334, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (335, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (336, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (337, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (338, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (339, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (340, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (341, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (342, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (343, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (344, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (345, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (346, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (347, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (348, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (349, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (350, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (351, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (352, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (353, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (354, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (355, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (356, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (357, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (358, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (359, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (360, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (361, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (362, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (363, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (364, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (365, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (366, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (367, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (368, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (369, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (370, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (371, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (372, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (373, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (374, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (375, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (376, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (377, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (378, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (379, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (380, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (381, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (382, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (383, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (384, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (385, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (386, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (387, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (388, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (389, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (390, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (391, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (392, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (393, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (394, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (395, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (396, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (397, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (398, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (399, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (400, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (401, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (402, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (403, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (404, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (405, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (406, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (407, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (408, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (409, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (410, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (411, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (412, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (413, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (414, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (415, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (416, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (417, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (418, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (419, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (420, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (421, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (422, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (423, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (424, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (425, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (426, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (427, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (428, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (429, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (430, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (431, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (432, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (433, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (434, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (435, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (436, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (437, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (438, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (439, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (440, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (441, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (442, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (443, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (444, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (445, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (446, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (447, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (448, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (449, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (450, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (451, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (452, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (453, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (454, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (455, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (456, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (457, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (458, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (459, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (460, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (461, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (462, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (463, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (464, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (465, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (466, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (467, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (468, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (469, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (470, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (471, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (472, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (473, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (474, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (475, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (476, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (477, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (478, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (479, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (480, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (481, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (482, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (483, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (484, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (485, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (486, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (487, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (488, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (489, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (490, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (491, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (492, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (493, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (494, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (495, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (496, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (497, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (498, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (499, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (500, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (501, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (502, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (503, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (504, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (505, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (506, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (507, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (508, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (509, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (510, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (511, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (512, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (513, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (514, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (515, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (516, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (517, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (518, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (519, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (520, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (521, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (522, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (523, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (524, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (525, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (526, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (527, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (528, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (529, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (530, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (531, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (532, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (533, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (534, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (535, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (536, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (537, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (538, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (539, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (540, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (541, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (542, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (543, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (544, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (545, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (546, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (547, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (548, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (549, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (550, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (551, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (552, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (553, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (554, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (555, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (556, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (557, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (558, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (559, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (560, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (561, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (562, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (563, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (564, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (565, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (566, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (567, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (568, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (569, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (570, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (571, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (572, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (573, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (574, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (575, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (576, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (577, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (578, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (579, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (580, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (581, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (582, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (583, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (584, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (585, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (586, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (587, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (588, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (589, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (590, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (591, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (592, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (593, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (594, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (595, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (596, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (597, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (598, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (599, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (600, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (601, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (602, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (603, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (604, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (605, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (606, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (607, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (608, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (609, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (610, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (611, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (612, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (613, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (614, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (615, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (616, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (617, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (618, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (619, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (620, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (621, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (622, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (623, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (624, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (625, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (626, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (627, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (628, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (629, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (630, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (631, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (632, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (633, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (634, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (635, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (636, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (637, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (638, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (639, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (640, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (641, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (642, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (643, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (644, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (645, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (646, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (647, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (648, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (649, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (650, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (651, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (652, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (653, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (654, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (655, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (656, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (657, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (658, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (659, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (660, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (661, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (662, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (663, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (664, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (665, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (666, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (667, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (668, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (669, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (670, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (671, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (672, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (673, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (674, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (675, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (676, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (677, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (678, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (679, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (680, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (681, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (682, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (683, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (684, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (685, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (686, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (687, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (688, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (689, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (690, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (691, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (692, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (693, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (694, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (695, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (696, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (697, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (698, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (699, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (700, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (701, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (702, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (703, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (704, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (705, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (706, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (707, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (708, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (709, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (710, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (711, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (712, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (713, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (714, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (715, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (716, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (717, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (718, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (719, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (720, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (721, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (722, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (723, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (724, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (725, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (726, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (727, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (728, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (729, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (730, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (731, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (732, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (733, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (734, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (735, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (736, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (737, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (738, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (739, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (740, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (741, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (742, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (743, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (744, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (745, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (746, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (747, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (748, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (749, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (750, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (751, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (752, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (753, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (754, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (755, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (756, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (757, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (758, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (759, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (760, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (761, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (762, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (763, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (764, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (765, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (766, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (767, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (768, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (769, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (770, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (771, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (772, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (773, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (774, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (775, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (776, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (777, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (778, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (779, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (780, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (781, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (782, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (783, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (784, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (785, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (786, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (787, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (788, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (789, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (790, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (791, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (792, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (793, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (794, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (795, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (796, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (797, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (798, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (799, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (800, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (801, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (802, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (803, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (804, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (805, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (806, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (807, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (808, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (809, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (810, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (811, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (812, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (813, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (814, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (815, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (816, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (817, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (818, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (819, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (820, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (821, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (822, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (823, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (824, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (825, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (826, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (827, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (828, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (829, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (830, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (831, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (832, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (833, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (834, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (835, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (836, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (837, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (838, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (839, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (840, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (841, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (842, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (843, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (844, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (845, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (846, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (847, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (848, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (849, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (850, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (851, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (852, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (853, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (854, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (855, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (856, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (857, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (858, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (859, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (860, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (861, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (862, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (863, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (864, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (865, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (866, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (867, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (868, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (869, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (870, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (871, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (872, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (873, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (874, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (875, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (876, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (877, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (878, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (879, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (880, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (881, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (882, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (883, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (884, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (885, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (886, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (887, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (888, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (889, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (890, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (891, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (892, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (893, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (894, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (895, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (896, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (897, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (898, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (899, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (900, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (901, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (902, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (903, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (904, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (905, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (906, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (907, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (908, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (909, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (910, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (911, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (912, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (913, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (914, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (915, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (916, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (917, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (918, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (919, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (920, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (921, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (922, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (923, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (924, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (925, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (926, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (927, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (928, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (929, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (930, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (931, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (932, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (933, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (934, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (935, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (936, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (937, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (938, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (939, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (940, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (941, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (942, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (943, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (944, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (945, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (946, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (947, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (948, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (949, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (950, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (951, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (952, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (953, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (954, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (955, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (956, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (957, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (958, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (959, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (960, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (961, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (962, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (963, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (964, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (965, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (966, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (967, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (968, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (969, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (970, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (971, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (972, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (973, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (974, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (975, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (976, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (977, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (978, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (979, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (980, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (981, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (982, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (983, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (984, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (985, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (986, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (987, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (988, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (989, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (990, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (991, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (992, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (993, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (994, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (995, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (996, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (997, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (998, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (999, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1000, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1001, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1002, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1003, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1004, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1005, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1006, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1007, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1008, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1009, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1010, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1011, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1012, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1013, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1014, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1015, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1016, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1017, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1018, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1019, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1020, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1021, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1022, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1023, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1024, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1025, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1026, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1027, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1028, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1029, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1030, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1031, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1032, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1033, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1034, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1035, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1036, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1037, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1038, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1039, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1040, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1041, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1042, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1043, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1044, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1045, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1046, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1047, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1048, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1049, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1050, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1051, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1052, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1053, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1054, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1055, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1056, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1057, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1058, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1059, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1060, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1061, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1062, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1063, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1064, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1065, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1066, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1067, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1068, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1069, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1070, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1071, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1072, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1073, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1074, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1075, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1076, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1077, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1078, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1079, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1080, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1081, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1082, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1083, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1084, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1085, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1086, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1087, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1088, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1089, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1090, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1091, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1092, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1093, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1094, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1095, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1096, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1097, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1098, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1099, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1100, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1101, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1102, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1103, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1104, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1105, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1106, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1107, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1108, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1109, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1110, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1111, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1112, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1113, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1114, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1115, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1116, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1117, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1118, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1119, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1120, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1121, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1122, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1123, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1124, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1125, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1126, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1127, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1128, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1129, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1130, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1131, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1132, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1133, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1134, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1135, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1136, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1137, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1138, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1139, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1140, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1141, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1142, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1143, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1144, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1145, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1146, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1147, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1148, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1149, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1150, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1151, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1152, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1153, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1154, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1155, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1156, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1157, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1158, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1159, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1160, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1161, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1162, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1163, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1164, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1165, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1166, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1167, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1168, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1169, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1170, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1171, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1172, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1173, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1174, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1175, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1176, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1177, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1178, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1179, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1180, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1181, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1182, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1183, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1184, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1185, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1186, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1187, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1188, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1189, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1190, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1191, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1192, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1193, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1194, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1195, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1196, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1197, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1198, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1199, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1200, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1201, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1202, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1203, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1204, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1205, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1206, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1207, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1208, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1209, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1210, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1211, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1212, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1213, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1214, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1215, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1216, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1217, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1218, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1219, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1220, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1221, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1222, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1223, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1224, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1225, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1226, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1227, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1228, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1229, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1230, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1231, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1232, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1233, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1234, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1235, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1236, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1237, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1238, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1239, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1240, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1241, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1242, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1243, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1244, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1245, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1246, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1247, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1248, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1249, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1250, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1251, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1252, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1253, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1254, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1255, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1256, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1257, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1258, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1259, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1260, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1261, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1262, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1263, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1264, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1265, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1266, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1267, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1268, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1269, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1270, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1271, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1272, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1273, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1274, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1275, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1276, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1277, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1278, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1279, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1280, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1281, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1282, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1283, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1284, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1285, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1286, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1287, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1288, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1289, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1290, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1291, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1292, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1293, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1294, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1295, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1296, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1297, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1298, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1299, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1300, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1301, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1302, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1303, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1304, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1305, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1306, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1307, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1308, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1309, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1310, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1311, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1312, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1313, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1314, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1315, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1316, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1317, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1318, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1319, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1320, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1321, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1322, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1323, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1324, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1325, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1326, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1327, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1328, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1329, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1330, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1331, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1332, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1333, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1334, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1335, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1336, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1337, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1338, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1339, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1340, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1341, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1342, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1343, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1344, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1345, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1346, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1347, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1348, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1349, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1350, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1351, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1352, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1353, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1354, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1355, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1356, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1357, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1358, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1359, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1360, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1361, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1362, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1363, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1364, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1365, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1366, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1367, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1368, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1369, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1370, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1371, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1372, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1373, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1374, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1375, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1376, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1377, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1378, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1379, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1380, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1381, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1382, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1383, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1384, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1385, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1386, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1387, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1388, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1389, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1390, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1391, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1392, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1393, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1394, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1395, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1396, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1397, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1398, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1399, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1400, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1401, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1402, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1403, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1404, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1405, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1406, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1407, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1408, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1409, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1410, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1411, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1412, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1413, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1414, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1415, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1416, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1417, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1418, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1419, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1420, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1421, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1422, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1423, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1424, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1425, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1426, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1427, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1428, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1429, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1430, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1431, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1432, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1433, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1434, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1435, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1436, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1437, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1438, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1439, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1440, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1441, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1442, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1443, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1444, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1445, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1446, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1447, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1448, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1449, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1450, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1451, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1452, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1453, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1454, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1455, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1456, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1457, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1458, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1459, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1460, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1461, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1462, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1463, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1464, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1465, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1466, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1467, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1468, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1469, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1470, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1471, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1472, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1473, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1474, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1475, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1476, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1477, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1478, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1479, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1480, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1481, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1482, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1483, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1484, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1485, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1486, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1487, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1488, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1489, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1490, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1491, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1492, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1493, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1494, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1495, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1496, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1497, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1498, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1499, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1500, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1501, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1502, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1503, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1504, N'a', N'Closed tab')
GO
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1505, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1506, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1507, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1508, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1509, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1510, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1511, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1512, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1513, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1514, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1515, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1516, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1517, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1518, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1519, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1520, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1521, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1522, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1523, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1524, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1525, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1526, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1527, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1528, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1529, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1530, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1531, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1532, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1533, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1534, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1535, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1536, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1537, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1538, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1539, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1540, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1541, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1542, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1543, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1544, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1545, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1546, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1547, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1548, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1549, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1550, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1551, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1552, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1553, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1554, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1555, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1556, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1557, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1558, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1559, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1560, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1561, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1562, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1563, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1564, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1565, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1566, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1567, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1568, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1569, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1570, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1571, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1572, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1573, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1574, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1575, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1576, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1577, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1578, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1579, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1580, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1581, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1582, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1583, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1584, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1585, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1586, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1587, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1588, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1589, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1590, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1591, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1592, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1593, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1594, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1595, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1596, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1597, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1598, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1599, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1600, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1601, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1602, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1603, N'a', N'Closed tab')
INSERT [dbo].[checkTab] ([Id], [Username], [Command]) VALUES (1604, N'a', N'Closed tab')
GO
SET IDENTITY_INSERT [dbo].[checkTab] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] ON 

INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1080, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024213539', 35, 1, CAST(673000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1081, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024213649', 35, 1, CAST(673000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1082, N'IPHieu2mTMSiiIRHXPkzcuR85q3331052024214241', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1083, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024214255', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1084, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024215428', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1085, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024215536', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1086, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024220345', 51, 2, CAST(120000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1087, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024220912', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1088, N'oN0w2HgAiUfCe4ReU062vaYj8Jv201062024100645', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1089, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024220025', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1090, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024220546', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1091, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024222037', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1092, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v204062024104739', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1093, N'NmPMtCxAuKdK6hF16uvCbq8LmPq204062024104933', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1094, N'st9QW9JdR6PDu6BO92JhYTnJoPu204062024154459', 36, 5, CAST(600000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1095, N'st9QW9JdR6PDu6BO92JhYTnJoPu204062024154459', 51, 2, CAST(120000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1096, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v204062024155843', 36, 2, CAST(240000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1097, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v204062024155843', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1098, N'ZbyF9wQs9MeTlns5zuvkM8iq4CK205062024154659', 58, -12, CAST(-1500000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1099, N'3BH4Yv3afiOHoBEWedc3pgkDf05305062024155430', 58, 2, CAST(250000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1100, N'KEjojQNKaqhOIFlCVwhtbLvrCGs205062024155709', 58, 5, CAST(625000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1101, N'uuJtSkmHTHWJdRd7JsMnYYROZjg105062024163757', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1102, N'uuJtSkmHTHWJdRd7JsMnYYROZjg105062024163757', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1103, N'zZZafZw6xeQ6FAZn5LjSKfszLij105062024164411', 36, 2, CAST(240000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1104, N'4nuYwMCZbBcn8fsYdcFazgg4b7j105062024165709', 58, 1, CAST(125000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1105, N'3o8YrM44sCZRcaNDujiMekuEmBq208062024103323', 36, 1, CAST(120000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1106, N'3o8YrM44sCZRcaNDujiMekuEmBq208062024103323', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1107, N'2dy5VnF6x8PYsx4umsKG8FIpQi1209062024110500', 58, 1, CAST(125000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1108, N'vCdfkK3zqRQKIphzf1iekc50rhv109062024142759', 51, 1, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1109, N'VUIUPOUvfXTvnz8yEqe8xCkZqnA210062024112808', 92, 3, CAST(108000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1110, N'VUIUPOUvfXTvnz8yEqe8xCkZqnA210062024112808', 93, 2, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1111, N'VUIUPOUvfXTvnz8yEqe8xCkZqnA210062024112808', 85, 9, CAST(585000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1112, N'Sc0z69Fxf0UcKAwYWOqfy9qWdiZ212062024133623', 94, 3, CAST(87000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1113, N'iqS90KymxdPGL6tjf7bBowrbyFN212062024133936', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1114, N'tyDutpwXXYOKSf1RlE9ETUICvRw212062024225127', 40, 1, CAST(19500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1115, N'1oG8rU2MxpgEPLOKCF5k8cQ038r213062024100343', 64, 1, CAST(20000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1116, N'C34CbZK5xLfFp1aSk9quqpQTr5g213062024102928', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1117, N'TjJ2VJCNnlOc7JhGNjQ5S6CSbJq213062024103128', 41, 1, CAST(49500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1118, N'TjJ2VJCNnlOc7JhGNjQ5S6CSbJq213062024103128', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1119, N'ZLvVK8F8nqgE4lxdOAfJLxTAmK6313062024103410', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1120, N'OpVDEdrw42c4OqQHKQAAiHGQLaA313062024104757', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1121, N'jgRYVXL9ZCVQBKqbwGTQ4hbsGa0213062024131256', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1122, N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024132353', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1123, N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024132353', 98, 1, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1124, N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024133206', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1125, N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024133206', 98, 2, CAST(400000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1126, N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024135650', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1127, N'HDLpwGnqokafNHdCu4MbCrgVzqL213062024140245', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1128, N'sGQfyBMU90ScZ1maFOubZ6Hqv1K313062024140902', 96, 3, CAST(300000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1129, N'sGQfyBMU90ScZ1maFOubZ6Hqv1K313062024141506', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1130, N'sGQfyBMU90ScZ1maFOubZ6Hqv1K313062024142114', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1131, N'IAkZeCqdoFhpKQlFGQGq7Tve9Rd213062024142342', 96, 3, CAST(300000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1132, N'OpVDEdrw42c4OqQHKQAAiHGQLaA313062024144505', 40, 1, CAST(19500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1133, N'Skq5WVkKsMY7VubinaZQY7ZPYyf113062024152242', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1134, N'A4pF6tmAFdX0HjtZD50OYJXhs3d213062024152556', 96, 2, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1135, N'VUAp201PzScrRTIUxgJry7hW4Bn113062024153033', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1137, N'VUAp201PzScrRTIUxgJry7hW4Bn113062024153646', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1138, N'vbDsoCJgcDgMxqtAnUbmEK9WJF2213062024154139', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1139, N'RhF8UQ8WIMeqqOGsYiUatomWI5e213062024154757', 98, 2, CAST(400000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1140, N'afFIHGQ9yoWT0GOEh4S59TwIBKp213062024155228', 98, 1, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1141, N'4dAubIPZaqbBP3aA2ZeGddjsxax113062024155522', 98, 1, CAST(200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1142, N'bCX6uIiBqtYaKTlbwoijc6ZRl9R213062024220035', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1143, N'TZm3YCbA18RK5JW3RGFyyQhe0bz113062024232755', 93, 1, CAST(30000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1144, N'ZTKYFSYnIlen9JqN9ZAv0mMmVZJ314062024120251', 91, 1, CAST(250000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1145, N'Gulv2V3VtLeSdLbtt0ElieH8HZh214062024131555', 40, 1, CAST(19500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1146, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v204062024155843', 83, 1, CAST(125000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1147, N'4NK7rEFR3xSoxRcGnPagYSpmLm3214062024150123', 40, 9, CAST(175500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1148, N'4NK7rEFR3xSoxRcGnPagYSpmLm3214062024150123', 94, 1, CAST(29000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1149, N'p18N2axNryTpwogADXYFD4BADCv115062024094200', 41, 1, CAST(49500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1150, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024205310', 81, 1, CAST(34000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1151, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024205310', 97, 4, CAST(1600000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1152, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024211308', 40, 8, CAST(156000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1153, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024211308', 91, 4, CAST(1000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1154, N'084ug84iPJhDv9CrTCwrDQWZdi5316062024121128', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1155, N'WvR6AFKGCEXLi6kLbgLu3zK7Wse225062024225722', 41, 1, CAST(49500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1156, N'NMcWwharUjQEPOtvN8nVx4vDDBy225062024231113', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1157, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024211308', 94, 7, CAST(203000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1158, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024211308', 90, 12, CAST(38400 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1159, N'T3ZAvV3yhIYwahM6LvSAjIgcnOl101072024211454', 96, 1, CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1160, N'ssvaiofbY4ZMOIVZOK2xPPIKuUb201072024144836', 98, 4, CAST(800000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1162, N'vH3ZYO8SIMYzizeuK1zT0oqIIpp102072024054647', 93, 1, CAST(30000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1163, N'mxtKSAGkutM0fxayQjTvqvXQ1Po202072024060234', 94, 1, CAST(29000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1164, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v202072024060446', 41, 1, CAST(49500 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1165, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v202072024060446', 97, 2, CAST(800000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1166, N'tyDutpwXXYOKSf1RlE9ETUICvRw202072024050959', 94, 1, CAST(29000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonHang] ([Id_ChiTietDonHang], [Id_DonHang], [Id_DungCu], [SoLuong], [Gia]) VALUES (1167, N'tyDutpwXXYOKSf1RlE9ETUICvRw202072024061940', 97, 1, CAST(400000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietKhuyenMai] ON 

INSERT [dbo].[ChiTietKhuyenMai] ([Id_CTKM], [Id_KhuyenMai], [Id_SanPham], [GiaTriGiam]) VALUES (33, 35, 90, 99)
INSERT [dbo].[ChiTietKhuyenMai] ([Id_CTKM], [Id_KhuyenMai], [Id_SanPham], [GiaTriGiam]) VALUES (34, 35, 64, 20)
INSERT [dbo].[ChiTietKhuyenMai] ([Id_CTKM], [Id_KhuyenMai], [Id_SanPham], [GiaTriGiam]) VALUES (35, 35, 40, 70)
INSERT [dbo].[ChiTietKhuyenMai] ([Id_CTKM], [Id_KhuyenMai], [Id_SanPham], [GiaTriGiam]) VALUES (36, 35, 41, 10)
SET IDENTITY_INSERT [dbo].[ChiTietKhuyenMai] OFF
GO
SET IDENTITY_INSERT [dbo].[CTHDNhapHang] ON 

INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (7, 62, 1, CAST(10000 AS Decimal(18, 0)), CAST(10000 AS Decimal(18, 0)), N'HD1                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (10, 55, 12, CAST(14544 AS Decimal(18, 0)), CAST(1212 AS Decimal(18, 0)), N'HD1                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (11, 35, 23, CAST(230000 AS Decimal(18, 0)), CAST(10000 AS Decimal(18, 0)), N'HD2                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (12, 35, 2, CAST(400000 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), N'HD5                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (13, 47, 2, CAST(30000 AS Decimal(18, 0)), CAST(15000 AS Decimal(18, 0)), N'HD3                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (14, 35, 23, CAST(529 AS Decimal(18, 0)), CAST(23 AS Decimal(18, 0)), N'HD5                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (15, 35, 5, CAST(3000000 AS Decimal(18, 0)), CAST(600000 AS Decimal(18, 0)), N'HD6                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (16, 51, 20, CAST(400000 AS Decimal(18, 0)), CAST(20000 AS Decimal(18, 0)), N'HD7                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (17, 36, 50, CAST(2500000 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), N'HD8                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (18, 58, 50, CAST(2500000 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), N'HD8                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (19, 46, 50, CAST(2000000 AS Decimal(18, 0)), CAST(40000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (20, 47, 100, CAST(3000000 AS Decimal(18, 0)), CAST(30000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (21, 48, 30, CAST(6300000 AS Decimal(18, 0)), CAST(210000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (22, 49, 40, CAST(440000 AS Decimal(18, 0)), CAST(11000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (23, 57, 56, CAST(4480000 AS Decimal(18, 0)), CAST(80000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (24, 66, 100, CAST(2300000 AS Decimal(18, 0)), CAST(23000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (25, 67, 60, CAST(7200000 AS Decimal(18, 0)), CAST(120000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (26, 69, 200, CAST(8400000 AS Decimal(18, 0)), CAST(42000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (27, 70, 30, CAST(1500000 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (28, 75, 110, CAST(12100000 AS Decimal(18, 0)), CAST(110000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (29, 79, 50, CAST(2300000 AS Decimal(18, 0)), CAST(46000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (30, 82, 70, CAST(4410000 AS Decimal(18, 0)), CAST(63000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (31, 94, 60, CAST(1260000 AS Decimal(18, 0)), CAST(21000 AS Decimal(18, 0)), N'HD9                 ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (32, 59, 120, CAST(23400000 AS Decimal(18, 0)), CAST(195000 AS Decimal(18, 0)), N'HD11                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (33, 60, 40, CAST(2120000 AS Decimal(18, 0)), CAST(53000 AS Decimal(18, 0)), N'HD11                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (34, 61, 50, CAST(5000000 AS Decimal(18, 0)), CAST(100000 AS Decimal(18, 0)), N'HD11                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (35, 84, 70, CAST(4200000 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'HD11                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (36, 85, 56, CAST(3360000 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'HD11                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (37, 86, 80, CAST(4800000 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'HD11                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (38, 87, 100, CAST(6000000 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'HD11                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (39, 63, 100, CAST(2300000 AS Decimal(18, 0)), CAST(23000 AS Decimal(18, 0)), N'HD12                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (40, 64, 100, CAST(2200000 AS Decimal(18, 0)), CAST(22000 AS Decimal(18, 0)), N'HD12                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (41, 65, 100, CAST(1800000 AS Decimal(18, 0)), CAST(18000 AS Decimal(18, 0)), N'HD12                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (42, 68, 100, CAST(4000000 AS Decimal(18, 0)), CAST(40000 AS Decimal(18, 0)), N'HD12                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (43, 70, 3, CAST(150000 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), N'HD13                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (44, 45, 40, CAST(2400000 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'HD14                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (45, 51, 50, CAST(2650000 AS Decimal(18, 0)), CAST(53000 AS Decimal(18, 0)), N'HD14                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (46, 52, 20, CAST(520000 AS Decimal(18, 0)), CAST(26000 AS Decimal(18, 0)), N'HD14                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (47, 56, 60, CAST(3300000 AS Decimal(18, 0)), CAST(55000 AS Decimal(18, 0)), N'HD14                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (48, 62, 70, CAST(18200000 AS Decimal(18, 0)), CAST(260000 AS Decimal(18, 0)), N'HD14                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (49, 80, 30, CAST(900000 AS Decimal(18, 0)), CAST(30000 AS Decimal(18, 0)), N'HD14                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (50, 81, 60, CAST(1620000 AS Decimal(18, 0)), CAST(27000 AS Decimal(18, 0)), N'HD14                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (51, 83, 59, CAST(7021000 AS Decimal(18, 0)), CAST(119000 AS Decimal(18, 0)), N'HD14                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (52, 39, 50, CAST(550000 AS Decimal(18, 0)), CAST(11000 AS Decimal(18, 0)), N'HD15                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (53, 78, 80, CAST(3040000 AS Decimal(18, 0)), CAST(38000 AS Decimal(18, 0)), N'HD15                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (54, 90, 15, CAST(4500000 AS Decimal(18, 0)), CAST(300000 AS Decimal(18, 0)), N'HD15                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (55, 96, 20, CAST(1700000 AS Decimal(18, 0)), CAST(85000 AS Decimal(18, 0)), N'HD15                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (56, 40, 30, CAST(1710000 AS Decimal(18, 0)), CAST(57000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (57, 53, 40, CAST(480000 AS Decimal(18, 0)), CAST(12000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (58, 54, 20, CAST(80000 AS Decimal(18, 0)), CAST(4000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (59, 71, 40, CAST(2240000 AS Decimal(18, 0)), CAST(56000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (60, 73, 26, CAST(7800000 AS Decimal(18, 0)), CAST(300000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (61, 74, 30, CAST(5790000 AS Decimal(18, 0)), CAST(193000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (62, 88, 50, CAST(2400000 AS Decimal(18, 0)), CAST(48000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (63, 89, 40, CAST(1280000 AS Decimal(18, 0)), CAST(32000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (65, 91, 10, CAST(2300000 AS Decimal(18, 0)), CAST(230000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (66, 92, 40, CAST(1200000 AS Decimal(18, 0)), CAST(30000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (67, 97, 10, CAST(3700000 AS Decimal(18, 0)), CAST(370000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (68, 98, 10, CAST(1800000 AS Decimal(18, 0)), CAST(180000 AS Decimal(18, 0)), N'HD16                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (69, 41, 36, CAST(1800000 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), N'HD17                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (70, 50, 20, CAST(580000 AS Decimal(18, 0)), CAST(29000 AS Decimal(18, 0)), N'HD17                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (71, 72, 50, CAST(6400000 AS Decimal(18, 0)), CAST(128000 AS Decimal(18, 0)), N'HD17                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (72, 77, 100, CAST(3200000 AS Decimal(18, 0)), CAST(32000 AS Decimal(18, 0)), N'HD17                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (73, 93, 50, CAST(1200000 AS Decimal(18, 0)), CAST(24000 AS Decimal(18, 0)), N'HD17                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (74, 42, 100, CAST(1400000 AS Decimal(18, 0)), CAST(14000 AS Decimal(18, 0)), N'HD18                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (75, 44, 100, CAST(1200000 AS Decimal(18, 0)), CAST(12000 AS Decimal(18, 0)), N'HD18                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (76, 76, 60, CAST(2760000 AS Decimal(18, 0)), CAST(46000 AS Decimal(18, 0)), N'HD18                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (77, 95, 90, CAST(3690000 AS Decimal(18, 0)), CAST(41000 AS Decimal(18, 0)), N'HD18                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (79, 35, 20, CAST(13000000 AS Decimal(18, 0)), CAST(650000 AS Decimal(18, 0)), N'HD19                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (80, 37, 20, CAST(4520000 AS Decimal(18, 0)), CAST(226000 AS Decimal(18, 0)), N'HD19                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (81, 38, 30, CAST(2100000 AS Decimal(18, 0)), CAST(70000 AS Decimal(18, 0)), N'HD19                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (82, 43, 40, CAST(600000 AS Decimal(18, 0)), CAST(15000 AS Decimal(18, 0)), N'HD19                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (83, 55, 40, CAST(1640000 AS Decimal(18, 0)), CAST(41000 AS Decimal(18, 0)), N'HD19                ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (84, 46, 9, CAST(225000 AS Decimal(18, 0)), CAST(25000 AS Decimal(18, 0)), N'HD031332            ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (85, 94, 99, CAST(1485000 AS Decimal(18, 0)), CAST(15000 AS Decimal(18, 0)), N'HD031332            ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (86, 62, 99, CAST(7920000 AS Decimal(18, 0)), CAST(80000 AS Decimal(18, 0)), N'HD0321321           ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (87, 52, 12, CAST(1200000 AS Decimal(18, 0)), CAST(100000 AS Decimal(18, 0)), N'HD0321321           ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (88, 66, 2, CAST(40000 AS Decimal(18, 0)), CAST(20000 AS Decimal(18, 0)), N'HD320130213         ')
INSERT [dbo].[CTHDNhapHang] ([Id_CTHDNhapHang], [Id_SanPham], [SoLuong], [GiaTien], [DonGia], [Id_HoaDonNhap]) VALUES (89, 48, 10, CAST(1400000 AS Decimal(18, 0)), CAST(140000 AS Decimal(18, 0)), N'HD144               ')
SET IDENTITY_INSERT [dbo].[CTHDNhapHang] OFF
GO
SET IDENTITY_INSERT [dbo].[CuocVanChuyen] ON 

INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (1, N'Quận 1', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (2, N'Khác', CAST(35000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (3, N'Quận 2', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (4, N'Quận 3', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (5, N'Quận 4', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (6, N'Quận 5', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (7, N'Quận 6 ', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (8, N'Quận 7', CAST(12000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (9, N'Quận 8', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (10, N'Quận 9', CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (11, N'Quận 10', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (12, N'Quận 11', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (13, N'Quận 12', CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (14, N'Tân Bình', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (15, N'Tân Phú', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (16, N'Phú Nhuận', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (17, N'Bình Tân', CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (18, N'Bình Chánh', CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (19, N'Gò Vấp', CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (20, N'Nhà Bè', CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (21, N'Củ Chi', CAST(21000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (22, N'Hóc Môn', CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (23, N'Cần Giờ', CAST(21000 AS Decimal(18, 0)))
INSERT [dbo].[CuocVanChuyen] ([Id_CuocVanChuyen], [KhuVuc], [CuocVanChuyen]) VALUES (24, N'Thủ Đức', CAST(12000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[CuocVanChuyen] OFF
GO
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'084ug84iPJhDv9CrTCwrDQWZdi5316062024121128', N'084ug84iPJhDv9CrTCwrDQWZdi53', CAST(N'2024-06-16T12:11:28.6565289' AS DateTime2), CAST(N'2024-06-19T12:11:28.6570718' AS DateTime2), CAST(70200 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), N'FREESHIP  ', CAST(35000 AS Decimal(18, 0)), CAST(5200 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'1oG8rU2MxpgEPLOKCF5k8cQ038r213062024100343', N'1oG8rU2MxpgEPLOKCF5k8cQ038r2', CAST(N'2024-06-13T10:03:43.8196409' AS DateTime2), CAST(N'2024-06-16T10:03:43.8201735' AS DateTime2), CAST(20000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'2dy5VnF6x8PYsx4umsKG8FIpQi1209062024110500', N'2dy5VnF6x8PYsx4umsKG8FIpQi12', CAST(N'2024-06-09T11:05:00.1687853' AS DateTime2), CAST(N'2024-06-12T11:05:00.1688207' AS DateTime2), CAST(125000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'3BH4Yv3afiOHoBEWedc3pgkDf05305062024155430', N'3BH4Yv3afiOHoBEWedc3pgkDf053', CAST(N'2024-06-05T15:54:30.1437479' AS DateTime2), CAST(N'2024-06-08T15:54:30.1438051' AS DateTime2), CAST(250000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'3o8YrM44sCZRcaNDujiMekuEmBq208062024103323', N'3o8YrM44sCZRcaNDujiMekuEmBq2', CAST(N'2024-06-08T10:33:23.9004414' AS DateTime2), CAST(N'2024-06-11T10:33:23.9010358' AS DateTime2), CAST(180000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'4dAubIPZaqbBP3aA2ZeGddjsxax113062024155522', N'4dAubIPZaqbBP3aA2ZeGddjsxax1', CAST(N'2024-06-13T15:55:22.8688911' AS DateTime2), CAST(N'2024-06-16T15:55:22.8689461' AS DateTime2), CAST(216000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(16000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'4NK7rEFR3xSoxRcGnPagYSpmLm3214062024150123', N'4NK7rEFR3xSoxRcGnPagYSpmLm32', CAST(N'2024-06-14T15:03:23.9893629' AS DateTime2), CAST(N'2024-06-17T15:03:23.9893690' AS DateTime2), CAST(201860 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'kaka      ', CAST(50000 AS Decimal(18, 0)), CAST(12360 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'4nuYwMCZbBcn8fsYdcFazgg4b7j105062024165709', N'4nuYwMCZbBcn8fsYdcFazgg4b7j1', CAST(N'2024-06-05T16:58:13.8671857' AS DateTime2), CAST(N'2024-06-08T16:58:13.8671906' AS DateTime2), CAST(147960 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(12000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(10960 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'A4pF6tmAFdX0HjtZD50OYJXhs3d213062024152556', N'A4pF6tmAFdX0HjtZD50OYJXhs3d2', CAST(N'2024-06-13T15:25:56.1800418' AS DateTime2), CAST(N'2024-06-16T15:25:56.1801722' AS DateTime2), CAST(216000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), N'kaka      ', CAST(50000 AS Decimal(18, 0)), CAST(17280 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'afFIHGQ9yoWT0GOEh4S59TwIBKp213062024155228', N'afFIHGQ9yoWT0GOEh4S59TwIBKp2', CAST(N'2024-06-13T15:52:28.5019760' AS DateTime2), CAST(N'2024-06-16T15:52:28.5020691' AS DateTime2), CAST(216000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(16000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'bCX6uIiBqtYaKTlbwoijc6ZRl9R213062024220035', N'bCX6uIiBqtYaKTlbwoijc6ZRl9R2', CAST(N'2024-06-13T22:00:35.9473722' AS DateTime2), CAST(N'2024-06-16T22:00:35.9474172' AS DateTime2), CAST(108000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(8000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'C34CbZK5xLfFp1aSk9quqpQTr5g213062024102928', N'C34CbZK5xLfFp1aSk9quqpQTr5g2', CAST(N'2024-06-13T10:29:28.2987386' AS DateTime2), CAST(N'2024-06-16T10:29:28.2987798' AS DateTime2), CAST(200000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Gulv2V3VtLeSdLbtt0ElieH8HZh214062024131555', N'Gulv2V3VtLeSdLbtt0ElieH8HZh2', CAST(N'2024-06-14T13:15:55.4485515' AS DateTime2), CAST(N'2024-06-17T13:15:55.4493860' AS DateTime2), CAST(21060 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(1560 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'HDLpwGnqokafNHdCu4MbCrgVzqL213062024140245', N'HDLpwGnqokafNHdCu4MbCrgVzqL2', CAST(N'2024-06-13T14:02:45.2421328' AS DateTime2), CAST(N'2024-06-16T14:02:45.2421345' AS DateTime2), CAST(150000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(11111 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'IAkZeCqdoFhpKQlFGQGq7Tve9Rd213062024142342', N'IAkZeCqdoFhpKQlFGQGq7Tve9Rd2', CAST(N'2024-06-13T14:25:11.2977857' AS DateTime2), CAST(N'2024-06-16T14:25:11.2977902' AS DateTime2), CAST(285000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(18519 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'IPHieu2mTMSiiIRHXPkzcuR85q3331052024214241', N'IPHieu2mTMSiiIRHXPkzcuR85q33', CAST(N'2024-05-31T21:42:41.6399776' AS DateTime2), CAST(N'2024-06-03T21:42:41.6400332' AS DateTime2), CAST(60000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'iqS90KymxdPGL6tjf7bBowrbyFN212062024133936', N'iqS90KymxdPGL6tjf7bBowrbyFN2', CAST(N'2024-06-12T13:41:04.9944098' AS DateTime2), CAST(N'2024-06-15T13:41:04.9944175' AS DateTime2), CAST(199800 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(14800 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'jgRYVXL9ZCVQBKqbwGTQ4hbsGa0213062024131256', N'jgRYVXL9ZCVQBKqbwGTQ4hbsGa02', CAST(N'2024-06-13T13:12:56.9122083' AS DateTime2), CAST(N'2024-06-16T13:12:56.9135557' AS DateTime2), CAST(100000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'KEjojQNKaqhOIFlCVwhtbLvrCGs205062024155709', N'KEjojQNKaqhOIFlCVwhtbLvrCGs2', CAST(N'2024-06-05T15:57:09.0285861' AS DateTime2), CAST(N'2024-06-08T15:57:09.0291624' AS DateTime2), CAST(625000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'mxtKSAGkutM0fxayQjTvqvXQ1Po202072024060234', N'mxtKSAGkutM0fxayQjTvqvXQ1Po2', CAST(N'2024-07-02T06:03:43.5367027' AS DateTime2), CAST(N'2024-07-05T06:03:43.5367069' AS DateTime2), CAST(66320 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(2320 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024132353', N'Nba9TYNsR0XjGGO7LUrVkaMD9z63', CAST(N'2024-06-13T13:26:26.5133840' AS DateTime2), CAST(N'2024-06-16T13:26:26.5133896' AS DateTime2), CAST(361800 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(26800 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024133206', N'Nba9TYNsR0XjGGO7LUrVkaMD9z63', CAST(N'2024-06-13T13:55:33.4630725' AS DateTime2), CAST(N'2024-06-16T13:55:33.4630756' AS DateTime2), CAST(585000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(48148 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024135650', N'Nba9TYNsR0XjGGO7LUrVkaMD9z63', CAST(N'2024-06-13T13:59:41.7044357' AS DateTime2), CAST(N'2024-06-16T13:59:41.7044388' AS DateTime2), CAST(85000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(3704 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'NMcWwharUjQEPOtvN8nVx4vDDBy225062024231113', N'NMcWwharUjQEPOtvN8nVx4vDDBy2', CAST(N'2024-06-25T23:11:13.6333689' AS DateTime2), CAST(N'2024-06-28T23:11:13.6344697' AS DateTime2), CAST(108000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(8000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'NmPMtCxAuKdK6hF16uvCbq8LmPq204062024104933', N'NmPMtCxAuKdK6hF16uvCbq8LmPq2', CAST(N'2024-06-04T10:50:14.1493589' AS DateTime2), CAST(N'2024-06-07T10:50:14.1493663' AS DateTime2), CAST(102600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(7600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'oN0w2HgAiUfCe4ReU062vaYj8Jv201062024100645', N'oN0w2HgAiUfCe4ReU062vaYj8Jv2', CAST(N'2024-06-01T10:07:54.7108817' AS DateTime2), CAST(N'2024-06-04T10:07:54.7108908' AS DateTime2), CAST(102600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(7600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'OpVDEdrw42c4OqQHKQAAiHGQLaA313062024104757', N'OpVDEdrw42c4OqQHKQAAiHGQLaA3', CAST(N'2024-06-13T10:49:16.1621905' AS DateTime2), CAST(N'2024-06-16T10:49:16.1621957' AS DateTime2), CAST(253800 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(18800 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'OpVDEdrw42c4OqQHKQAAiHGQLaA313062024144505', N'OpVDEdrw42c4OqQHKQAAiHGQLaA3', CAST(N'2024-06-13T14:46:03.2121169' AS DateTime2), CAST(N'2024-06-16T14:46:03.2121221' AS DateTime2), CAST(58860 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(4360 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'p18N2axNryTpwogADXYFD4BADCv115062024094200', N'p18N2axNryTpwogADXYFD4BADCv1', CAST(N'2024-06-15T09:42:00.0067471' AS DateTime2), CAST(N'2024-06-18T09:42:00.0067490' AS DateTime2), CAST(53460 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(3960 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'RhF8UQ8WIMeqqOGsYiUatomWI5e213062024154757', N'RhF8UQ8WIMeqqOGsYiUatomWI5e2', CAST(N'2024-06-13T15:47:57.8627653' AS DateTime2), CAST(N'2024-06-16T15:47:57.8632791' AS DateTime2), CAST(432000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(32000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Sc0z69Fxf0UcKAwYWOqfy9qWdiZ212062024133623', N'Sc0z69Fxf0UcKAwYWOqfy9qWdiZ2', CAST(N'2024-06-12T13:38:51.6811400' AS DateTime2), CAST(N'2024-06-15T13:38:51.6811478' AS DateTime2), CAST(131760 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(9760 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'sGQfyBMU90ScZ1maFOubZ6Hqv1K313062024140902', N'sGQfyBMU90ScZ1maFOubZ6Hqv1K3', CAST(N'2024-06-13T14:12:41.7212529' AS DateTime2), CAST(N'2024-06-16T14:12:41.7212553' AS DateTime2), CAST(235000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(11111 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'sGQfyBMU90ScZ1maFOubZ6Hqv1K313062024141506', N'sGQfyBMU90ScZ1maFOubZ6Hqv1K3', CAST(N'2024-06-13T14:16:14.1814142' AS DateTime2), CAST(N'2024-06-16T14:16:14.1814160' AS DateTime2), CAST(185000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'kaka      ', CAST(50000 AS Decimal(18, 0)), CAST(3704 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'sGQfyBMU90ScZ1maFOubZ6Hqv1K313062024142114', N'sGQfyBMU90ScZ1maFOubZ6Hqv1K3', CAST(N'2024-06-13T14:21:14.2062479' AS DateTime2), CAST(N'2024-06-16T14:21:14.2062490' AS DateTime2), CAST(150000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), N'kaka      ', CAST(50000 AS Decimal(18, 0)), CAST(3704 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Skq5WVkKsMY7VubinaZQY7ZPYyf113062024152242', N'Skq5WVkKsMY7VubinaZQY7ZPYyf1', CAST(N'2024-06-13T15:22:42.5371415' AS DateTime2), CAST(N'2024-06-16T15:22:42.5372201' AS DateTime2), CAST(200000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(14815 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'ssvaiofbY4ZMOIVZOK2xPPIKuUb201072024144836', N'ssvaiofbY4ZMOIVZOK2xPPIKuUb2', CAST(N'2024-07-01T14:48:36.3301167' AS DateTime2), CAST(N'2024-07-04T14:48:36.3301964' AS DateTime2), CAST(864000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(64000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'st9QW9JdR6PDu6BO92JhYTnJoPu204062024154459', N'st9QW9JdR6PDu6BO92JhYTnJoPu2', CAST(N'2024-06-04T15:53:35.3713534' AS DateTime2), CAST(N'2024-06-07T15:53:35.3713792' AS DateTime2), CAST(734400 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(10000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(54400 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'T3ZAvV3yhIYwahM6LvSAjIgcnOl101072024211454', N'T3ZAvV3yhIYwahM6LvSAjIgcnOl1', CAST(N'2024-07-01T21:15:33.6575461' AS DateTime2), CAST(N'2024-07-04T21:15:33.6575604' AS DateTime2), CAST(143000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(8000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'TjJ2VJCNnlOc7JhGNjQ5S6CSbJq213062024103128', N'TjJ2VJCNnlOc7JhGNjQ5S6CSbJq2', CAST(N'2024-06-13T10:31:28.6128657' AS DateTime2), CAST(N'2024-06-16T10:31:28.6129505' AS DateTime2), CAST(149500 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'tyDutpwXXYOKSf1RlE9ETUICvRw202072024050959', N'tyDutpwXXYOKSf1RlE9ETUICvRw2', CAST(N'2024-07-02T06:18:31.7161170' AS DateTime2), CAST(N'2024-07-05T06:18:31.7161193' AS DateTime2), CAST(52583 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(2320 AS Decimal(18, 0)), CAST(13737 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'tyDutpwXXYOKSf1RlE9ETUICvRw202072024061940', N'tyDutpwXXYOKSf1RlE9ETUICvRw2', CAST(N'2024-07-02T06:19:40.9717433' AS DateTime2), CAST(N'2024-07-05T06:19:40.9717440' AS DateTime2), CAST(432000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(32000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'tyDutpwXXYOKSf1RlE9ETUICvRw212062024225127', N'tyDutpwXXYOKSf1RlE9ETUICvRw2', CAST(N'2024-06-12T22:57:02.5277090' AS DateTime2), CAST(N'2024-06-15T22:57:02.5277145' AS DateTime2), CAST(49354 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(3656 AS Decimal(18, 0)), CAST(8802 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'TZm3YCbA18RK5JW3RGFyyQhe0bz113062024232755', N'TZm3YCbA18RK5JW3RGFyyQhe0bz1', CAST(N'2024-06-13T23:27:55.8624149' AS DateTime2), CAST(N'2024-06-16T23:27:55.8633640' AS DateTime2), CAST(32400 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(2400 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v202072024060446', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-07-02T06:04:46.6937280' AS DateTime2), CAST(N'2024-07-05T06:04:46.6937285' AS DateTime2), CAST(917460 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(67960 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024220025', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-06-03T22:00:42.0653427' AS DateTime2), CAST(N'2024-06-06T22:00:42.0653473' AS DateTime2), CAST(102600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(7600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024220546', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-06-03T22:06:03.3016163' AS DateTime2), CAST(N'2024-06-06T22:06:03.3016201' AS DateTime2), CAST(102600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(7600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024222037', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-06-03T22:21:00.2982538' AS DateTime2), CAST(N'2024-06-06T22:21:00.2982608' AS DateTime2), CAST(102600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(7600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v204062024104739', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-06-04T10:47:57.4765882' AS DateTime2), CAST(N'2024-06-07T10:47:57.4766039' AS DateTime2), CAST(102600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(7600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v204062024155843', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-06-14T13:18:10.4647122' AS DateTime2), CAST(N'2024-06-17T13:18:10.4647231' AS DateTime2), CAST(474000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(15000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(34000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024205310', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-06-15T20:56:29.0746469' AS DateTime2), CAST(N'2024-06-18T20:56:29.0746645' AS DateTime2), CAST(1745720 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'kaka      ', CAST(50000 AS Decimal(18, 0)), CAST(126720 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024211308', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-06-26T08:49:54.3835645' AS DateTime2), CAST(N'2024-06-29T08:49:54.3837165' AS DateTime2), CAST(920732 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(111792 AS Decimal(18, 0)), CAST(623460 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024213539', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-05-31T21:36:11.5760738' AS DateTime2), CAST(N'2024-06-03T21:36:11.5760770' AS DateTime2), CAST(708000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024213649', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-05-31T21:37:34.1043092' AS DateTime2), CAST(N'2024-06-03T21:37:34.1043132' AS DateTime2), CAST(708000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024214255', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-05-31T21:43:22.3562485' AS DateTime2), CAST(N'2024-06-03T21:43:22.3562522' AS DateTime2), CAST(102600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(7600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024215428', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-05-31T21:54:48.0647802' AS DateTime2), CAST(N'2024-06-03T21:54:48.0647887' AS DateTime2), CAST(0 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(362924 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024215536', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-05-31T21:59:58.7261885' AS DateTime2), CAST(N'2024-06-03T21:59:58.7263890' AS DateTime2), CAST(48600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(3600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024220345', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-05-31T22:04:11.4254772' AS DateTime2), CAST(N'2024-06-03T22:04:11.4254809' AS DateTime2), CAST(113400 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(8400 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024220912', N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', CAST(N'2024-06-03T20:52:47.6277595' AS DateTime2), CAST(N'2024-06-06T20:52:47.6279617' AS DateTime2), CAST(102600 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(7600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'uuJtSkmHTHWJdRd7JsMnYYROZjg105062024163757', N'uuJtSkmHTHWJdRd7JsMnYYROZjg1', CAST(N'2024-06-05T16:38:37.7382964' AS DateTime2), CAST(N'2024-06-08T16:38:37.7383027' AS DateTime2), CAST(167400 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(12400 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'vbDsoCJgcDgMxqtAnUbmEK9WJF2213062024154139', N'vbDsoCJgcDgMxqtAnUbmEK9WJF22', CAST(N'2024-06-13T15:43:45.5915851' AS DateTime2), CAST(N'2024-06-16T15:43:45.5915898' AS DateTime2), CAST(89000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(4000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'vCdfkK3zqRQKIphzf1iekc50rhv109062024142759', N'vCdfkK3zqRQKIphzf1iekc50rhv1', CAST(N'2024-06-09T14:27:59.5207303' AS DateTime2), CAST(N'2024-06-12T14:27:59.5207313' AS DateTime2), CAST(60000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'vH3ZYO8SIMYzizeuK1zT0oqIIpp102072024054647', N'vH3ZYO8SIMYzizeuK1zT0oqIIpp1', CAST(N'2024-07-02T05:46:47.6496923' AS DateTime2), CAST(N'2024-07-05T05:46:47.6496932' AS DateTime2), CAST(32400 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(2400 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'VUAp201PzScrRTIUxgJry7hW4Bn113062024153033', N'VUAp201PzScrRTIUxgJry7hW4Bn1', CAST(N'2024-06-13T15:32:03.4990297' AS DateTime2), CAST(N'2024-06-16T15:32:03.4990340' AS DateTime2), CAST(89000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'kaka      ', CAST(50000 AS Decimal(18, 0)), CAST(4320 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'VUAp201PzScrRTIUxgJry7hW4Bn113062024153646', N'VUAp201PzScrRTIUxgJry7hW4Bn1', CAST(N'2024-06-13T15:36:46.8115515' AS DateTime2), CAST(N'2024-06-16T15:36:46.8115526' AS DateTime2), CAST(54000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), N'kaka      ', CAST(50000 AS Decimal(18, 0)), CAST(8000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'VUIUPOUvfXTvnz8yEqe8xCkZqnA210062024112808', N'VUIUPOUvfXTvnz8yEqe8xCkZqnA2', CAST(N'2024-06-10T11:29:15.4960004' AS DateTime2), CAST(N'2024-06-13T11:29:15.4960061' AS DateTime2), CAST(797040 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), N'kaka      ', CAST(50000 AS Decimal(18, 0)), CAST(59040 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'WvR6AFKGCEXLi6kLbgLu3zK7Wse225062024225722', N'WvR6AFKGCEXLi6kLbgLu3zK7Wse2', CAST(N'2024-06-25T22:57:22.7833354' AS DateTime2), CAST(N'2024-06-28T22:57:22.7851314' AS DateTime2), CAST(53460 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(3960 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'ZbyF9wQs9MeTlns5zuvkM8iq4CK205062024154659', N'ZbyF9wQs9MeTlns5zuvkM8iq4CK2', CAST(N'2024-06-05T15:46:59.7596551' AS DateTime2), CAST(N'2024-06-08T15:46:59.7597157' AS DateTime2), CAST(-1500000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'ZLvVK8F8nqgE4lxdOAfJLxTAmK6313062024103410', N'ZLvVK8F8nqgE4lxdOAfJLxTAmK63', CAST(N'2024-06-13T10:34:33.6283840' AS DateTime2), CAST(N'2024-06-16T10:34:33.6283875' AS DateTime2), CAST(145800 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(10800 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'ZTKYFSYnIlen9JqN9ZAv0mMmVZJ314062024120251', N'ZTKYFSYnIlen9JqN9ZAv0mMmVZJ3', CAST(N'2024-06-14T12:02:51.5063956' AS DateTime2), CAST(N'2024-06-17T12:02:51.5064513' AS DateTime2), CAST(216000 AS Decimal(18, 0)), N'Chưa thanh toán', NULL, CAST(0 AS Numeric(18, 0)), N'KAKA      ', CAST(50000 AS Decimal(18, 0)), CAST(16000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonHang] ([Id_DonHang], [Id_KhachHang], [NgayDat], [NgayGiao], [TongTien], [TrangThai], [PhuongThucThanhToan], [PhiVanChuyen], [Id_MaGiamGia], [TienGiamGia], [VAT], [TienDiemThuong]) VALUES (N'zZZafZw6xeQ6FAZn5LjSKfszLij105062024164411', N'zZZafZw6xeQ6FAZn5LjSKfszLij1', CAST(N'2024-06-05T16:44:38.0729431' AS DateTime2), CAST(N'2024-06-08T16:44:38.0729487' AS DateTime2), CAST(297000 AS Decimal(18, 0)), N'Thanh toán khi nhận hàng', 1, CAST(35000 AS Numeric(18, 0)), NULL, CAST(0 AS Decimal(18, 0)), CAST(22000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[DonHangVanChuyen] ON 

INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1040, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024213539', 1, CAST(35000 AS Numeric(18, 0)), N'HIHI, Long Phước, Bà Rịa, Bà Rịa - Vũng Tàu', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1042, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024214255', 1, CAST(35000 AS Numeric(18, 0)), N'HIHI, Hòa Phước, Hòa Vang, Đà Nẵng', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1045, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024220345', 1, CAST(35000 AS Numeric(18, 0)), N'HIHI, An Phú, An Phú, An Giang', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1047, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024220912', 1, CAST(35000 AS Numeric(18, 0)), N'140 Lê Trọng Tấn, Yên Lạc, Nguyên Bình, Cao Bằng', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1060, N'Sc0z69Fxf0UcKAwYWOqfy9qWdiZ212062024133623', 1, CAST(35000 AS Numeric(18, 0)), N'70, Phường Bình Thủy, Quận Bình Thuỷ, Cần Thơ', N'j', N'7232321313', N'k,                                                ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1061, N'iqS90KymxdPGL6tjf7bBowrbyFN212062024133936', 1, CAST(35000 AS Numeric(18, 0)), N'Xuân Tam, Xuân Tâm, Xuân Lộc, Đồng Nai', N'Duyên', N'332032302 ', N'duyen@gmail.com                                   ', 3)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1063, N'ZLvVK8F8nqgE4lxdOAfJLxTAmK6313062024103410', 1, CAST(35000 AS Numeric(18, 0)), N'2132, Liêm Thuỷ, Na Rì, Bắc Kạn', N'trung', N'213213    ', N'2132132@gmai.com                                  ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1064, N'OpVDEdrw42c4OqQHKQAAiHGQLaA313062024104757', 1, CAST(35000 AS Numeric(18, 0)), N'No street specified, Phường Gia Lộc, Trảng Bàng, Tây Ninh', N'Tuyền', N'0388684332', N'vuongthanhtuyenvtt@gmail.com                      ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1065, N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024132353', 1, CAST(35000 AS Numeric(18, 0)), N'No street specified, Hòa Bắc, Hòa Vang, Đà Nẵng', N'21321', N'32132     ', N'3213                                              ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1066, N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024133206', 1, CAST(35000 AS Numeric(18, 0)), N'232132, Phường Tân Thiện, La Gi, Bình Thuận', N'TRUNG', N'0369033543', N'3213231@EMAIL.COM                                 ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1069, N'sGQfyBMU90ScZ1maFOubZ6Hqv1K313062024141506', 1, CAST(35000 AS Numeric(18, 0)), N'No street specified, Phường Châu Phú B, Châu Đốc, An Giang', N'2132', N'3213      ', N'2321@dsd.c                                        ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1071, N'OpVDEdrw42c4OqQHKQAAiHGQLaA313062024144505', 1, CAST(35000 AS Numeric(18, 0)), N'No street specified, Phường Tân An, Quận Ninh Kiều, Cần Thơ', N'Tuyền', N'0388584632', N'vuongthanhtuyenvtt@gmail.com                      ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1072, N'VUAp201PzScrRTIUxgJry7hW4Bn113062024153033', 1, CAST(35000 AS Numeric(18, 0)), N'No street specified, Phường Hòa Hiệp Nam, Quận Liên Chiểu, Đà Nẵng', N'trung', N'2321      ', N'dasdsa@dead.cv                                    ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1076, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024205310', 1, CAST(35000 AS Numeric(18, 0)), N'123, đường 22/12, khu phố Lộc Du, Phường Trảng Bàng, Trảng Bàng, Tây Ninh', N'Nguyễn Quang Trung', N'0332313233', N'trungthachdau@outlook.com                         ', 1)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1044, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024215536', 1, CAST(35000 AS Numeric(18, 0)), N'HIHI, Phường Núi Sam, Châu Đốc, An Giang', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1041, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024213649', 1, CAST(35000 AS Numeric(18, 0)), N'HIHI, Hòa Thành, Krông Bông, Đắk Lắk', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1043, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v231052024215428', 1, CAST(35000 AS Numeric(18, 0)), N'HIHI, Phường Long Tâm, Bà Rịa, Bà Rịa - Vũng Tàu', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1062, N'tyDutpwXXYOKSf1RlE9ETUICvRw212062024225127', 1, CAST(35000 AS Numeric(18, 0)), N'122 Khu B Tân Thành, Cẩm Lý, Lục Nam, Bắc Giang', N'Ri', N'0777892289', N'nahri090901@gmail.com                             ', 1)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1067, N'Nba9TYNsR0XjGGO7LUrVkaMD9z6313062024135650', 1, CAST(35000 AS Numeric(18, 0)), N'No street specified, Hòa Tân, Krông Bông, Đắk Lắk', N'2132132', N'32132     ', N'321321@email.com                                  ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1068, N'sGQfyBMU90ScZ1maFOubZ6Hqv1K313062024140902', 1, CAST(35000 AS Numeric(18, 0)), N'No street specified, Phường Núi Sam, Châu Đốc, An Giang', N'32132', N'3213213   ', N'321321@edmsada                                    ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1070, N'IAkZeCqdoFhpKQlFGQGq7Tve9Rd213062024142342', 1, CAST(35000 AS Numeric(18, 0)), N'No street specified, Đa Phước, An Phú, An Giang', N'3232', N'32132     ', N'32131@GMAIL.COM                                   ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1073, N'vbDsoCJgcDgMxqtAnUbmEK9WJF2213062024154139', 1, CAST(35000 AS Numeric(18, 0)), N'3213213, Phong Thạnh A, Giá Rai, Bạc Liêu', N'TRUNG', N'2002      ', N'2132132@GMAIL.COM                                 ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1075, N'4NK7rEFR3xSoxRcGnPagYSpmLm3214062024150123', 1, CAST(35000 AS Numeric(18, 0)), N'Long Hưng, Long Hưng, Gò Công, Tiền Giang', N'Sương', N'0392183292', N'suong@email.com                                   ', 3)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1046, N'oN0w2HgAiUfCe4ReU062vaYj8Jv201062024100645', 1, CAST(35000 AS Numeric(18, 0)), N'Long Hưng, Long Hưng, Gò Công, Tiền Giang', N'Suong', N'0369033213', N'suong@email.com                                   ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1048, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024220025', 1, CAST(35000 AS Numeric(18, 0)), N'12321321, Đắk Wil, Cư Jút, Đắk Nông', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1049, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024220546', 1, CAST(35000 AS Numeric(18, 0)), N'12321321, Đông Hiệp, Cờ Đỏ, Cần Thơ', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1050, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v203062024222037', 1, CAST(35000 AS Numeric(18, 0)), N'2132131, Bình Ba, Châu Đức, Bà Rịa - Vũng Tàu', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1051, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v204062024104739', 1, CAST(35000 AS Numeric(18, 0)), N'21321313, Điện Quan, Bảo Yên, Lào Cai', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1052, N'NmPMtCxAuKdK6hF16uvCbq8LmPq204062024104933', 1, CAST(35000 AS Numeric(18, 0)), N'213213, Long Mỹ, Giồng Trôm, Bến Tre', N'Han', N'0369033543', N'quangtrung.nguyen.2016@gmail.com                  ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1053, N'st9QW9JdR6PDu6BO92JhYTnJoPu204062024154459', 1, CAST(10000 AS Numeric(18, 0)), N'3B, Phường Bến Nghé, Quận 1, Sài Gòn', N'Ly', N'0369303434', N'nahri090901@gmail.com                             ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1054, N'uuJtSkmHTHWJdRd7JsMnYYROZjg105062024163757', 1, CAST(35000 AS Numeric(18, 0)), N'123213, Triệu Thượng, Triệu Phong, Quảng Trị', N'Sương', N'23        ', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1055, N'zZZafZw6xeQ6FAZn5LjSKfszLij105062024164411', 1, CAST(35000 AS Numeric(18, 0)), N'123231, Thới Bình, Thới Bình, Cà Mau', N'Sương', N'3213132   ', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1057, N'4nuYwMCZbBcn8fsYdcFazgg4b7j105062024165709', 1, CAST(12000 AS Numeric(18, 0)), N'3213213132, Phường Tân Thuận Tây, Quận 7, Sài Gòn', N'keke', N'32322321  ', N'trungthachdau@outlook.com                         ', 2)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1058, N'VUIUPOUvfXTvnz8yEqe8xCkZqnA210062024112808', 1, CAST(35000 AS Numeric(18, 0)), N'An Đôn, Phường An Đôn, Quảng Trị, Quảng Trị', N'Tuấn', N'0393283282', N'tuan@gmail.com                                    ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1074, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v204062024155843', 1, CAST(15000 AS Numeric(18, 0)), N'HIHI, Phường Hiệp Phú, Quận 9, Sài Gòn', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1077, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v215062024211308', 1, CAST(35000 AS Numeric(18, 0)), N'HIHI, Sơn Lộ, Bảo Lạc, Cao Bằng', N'trung', N'0369033543', N'trungthachdau@outlook.com                         ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1078, N'T3ZAvV3yhIYwahM6LvSAjIgcnOl101072024211454', 1, CAST(35000 AS Numeric(18, 0)), N'Ngô Mây, Ngô Mây, Phù Cát, Bình Định', N'Trang', N'0320321313', N'trang@email.com                                   ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1079, N'mxtKSAGkutM0fxayQjTvqvXQ1Po202072024060234', 1, CAST(35000 AS Numeric(18, 0)), N'Không có thông tin, Tân Phước, Gò Công Đông, Tiền Giang', N'suong', N'0828372425', N'nguyenthingocsuong2425@gmail.com                  ', 0)
INSERT [dbo].[DonHangVanChuyen] ([Id_DHVC], [Id_DonHang], [PhuongThucThanhToan], [PhiVanChuyen], [DiaChiVanChuyen], [TenKhachHang], [SoDienThoai], [Email], [TinhTrang]) VALUES (1080, N'tyDutpwXXYOKSf1RlE9ETUICvRw202072024050959', 1, CAST(35000 AS Numeric(18, 0)), N'4, Phù Lương, Quế Võ, Bắc Ninh', N'Ri', N'0777892289', N'nahri090901@gmail.com                             ', 0)
SET IDENTITY_INSERT [dbo].[DonHangVanChuyen] OFF
GO
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'123                 ', 1, CAST(N'2024-05-30T20:43:19.4919113' AS DateTime2), CAST(0 AS Decimal(18, 0)), 0, NULL, NULL, NULL)
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'2321323             ', 2, CAST(N'2024-06-09T10:59:46.9587529' AS DateTime2), CAST(0 AS Decimal(18, 0)), 0, NULL, NULL, N'Chưa lập                                          ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD031332            ', 1, CAST(N'2024-06-14T14:53:36.9717109' AS DateTime2), CAST(1710000 AS Decimal(18, 0)), 1, CAST(N'2024-06-14T14:55:04.2663434' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD0321321           ', 4, CAST(N'2024-06-26T08:43:34.0897619' AS DateTime2), CAST(9120000 AS Decimal(18, 0)), 1, CAST(N'2024-06-26T08:45:35.4022592' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD1                 ', 1, CAST(N'2021-11-11T08:43:00.0000000' AS DateTime2), CAST(0 AS Decimal(18, 0)), 1, CAST(N'2021-11-11T08:43:00.0000000' AS DateTime2), NULL, NULL)
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD10                ', 1, CAST(N'2024-06-04T15:34:16.5009995' AS DateTime2), CAST(0 AS Decimal(18, 0)), 1, CAST(N'2024-06-04T15:34:36.4023264' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD11                ', 2, CAST(N'2024-06-09T14:30:28.2624998' AS DateTime2), CAST(48880000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:34:05.3645194' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD12                ', 3, CAST(N'2024-06-09T14:34:15.3786091' AS DateTime2), CAST(10300000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:35:39.1899142' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD12312             ', 8, CAST(N'2024-06-16T12:03:58.0516581' AS DateTime2), CAST(0 AS Decimal(18, 0)), 0, NULL, NULL, N'Chưa lập                                          ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD13                ', 1, CAST(N'2024-06-09T14:35:44.6177022' AS DateTime2), CAST(150000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:37:03.0758477' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD14                ', 4, CAST(N'2024-06-09T14:37:21.2965618' AS DateTime2), CAST(36611000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:40:49.0835571' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD144               ', 1, CAST(N'2024-07-02T06:00:32.6863257' AS DateTime2), CAST(1400000 AS Decimal(18, 0)), 1, CAST(N'2024-07-02T06:01:41.0174681' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD15                ', 5, CAST(N'2024-06-09T14:41:13.7916344' AS DateTime2), CAST(9790000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:43:04.0932417' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD16                ', 6, CAST(N'2024-06-09T14:43:28.3496541' AS DateTime2), CAST(30780000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:47:55.1868967' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD17                ', 7, CAST(N'2024-06-09T14:48:16.1464941' AS DateTime2), CAST(13180000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:50:13.1866341' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD18                ', 8, CAST(N'2024-06-09T14:50:35.5675446' AS DateTime2), CAST(9050000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:51:56.8868676' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD19                ', 9, CAST(N'2024-06-09T14:52:20.4698998' AS DateTime2), CAST(21860000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:54:12.7089145' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD2                 ', 9, CAST(N'2024-05-29T09:53:07.2959901' AS DateTime2), CAST(230000 AS Decimal(18, 0)), 1, CAST(N'2024-05-29T09:53:23.7709809' AS DateTime2), N'admin', NULL)
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD3                 ', 1, CAST(N'2024-05-29T10:05:19.4682814' AS DateTime2), CAST(0 AS Decimal(18, 0)), 1, CAST(N'2024-05-29T10:05:26.5872522' AS DateTime2), NULL, NULL)
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD320130213         ', 1, CAST(N'2024-06-28T22:06:18.9761552' AS DateTime2), CAST(40000 AS Decimal(18, 0)), 1, CAST(N'2024-06-28T22:13:28.6628258' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD5                 ', 1, CAST(N'2024-05-29T12:40:40.4943830' AS DateTime2), CAST(400000 AS Decimal(18, 0)), 1, CAST(N'2024-05-29T12:41:33.6931631' AS DateTime2), N'admin', NULL)
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD6                 ', 1, CAST(N'2024-05-30T10:43:37.0618250' AS DateTime2), CAST(3000000 AS Decimal(18, 0)), 1, CAST(N'2024-05-30T10:43:54.3603254' AS DateTime2), N'admin', NULL)
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD7                 ', 9, CAST(N'2024-05-31T20:12:05.5159194' AS DateTime2), CAST(400000 AS Decimal(18, 0)), 1, CAST(N'2024-05-31T20:12:54.4735180' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD8                 ', 1, CAST(N'2024-06-04T15:30:48.6305905' AS DateTime2), CAST(5000000 AS Decimal(18, 0)), 1, CAST(N'2024-06-04T15:31:56.0336345' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HD9                 ', 1, CAST(N'2024-06-07T17:01:18.8932944' AS DateTime2), CAST(55690000 AS Decimal(18, 0)), 1, CAST(N'2024-06-09T14:29:58.3932843' AS DateTime2), NULL, N'admin                                             ')
INSERT [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap], [Id_NhaCungCap], [NgayLapHoaDon], [TongTien], [TrangThai], [NgayNhapHang], [NguoiLapHoaDon], [NhanVienLap]) VALUES (N'HDHP                ', 1, CAST(N'2024-06-14T14:53:15.7492619' AS DateTime2), CAST(0 AS Decimal(18, 0)), 0, NULL, NULL, N'Chưa lập                                          ')
GO
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'3GU1dd4nWMgTZyqC7iI6GEB1qJi2', N'Tran 2', N'tran2@email.com', N'          ', N'', CAST(782 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'7MF0H4p5JPf44DNtMEV11FQ4mqM2', N'trung', N'hihi@email.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'fOzizcz951gI0HfJg2cFrTBIoFH3', N'trunggg', N'trung@admin.com', N'0369033543', N'Tây Thạnh', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'IdYiQiWnxgZk3eiuVEpqrmslZgu1', N'Trang', N'tnhocanh139@gmail.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'LFmktzLUs2UfJRF89lpX7SCJ41I2', N'Ngọc Sương', N'nguyenthingocsuong2425@gmail.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'NmPMtCxAuKdK6hF16uvCbq8LmPq2', N'Hân', N'quangtrung.nguyen.2016@gmail.com', N'          ', N'', CAST(10260 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'p4L720AjmkcclsitD25QKc3yHUl2', N'Ranie', N'xuanlan22102003@gmail.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'rcRTufKY5zNmMgsLPPEsaktt4Wk2', N'Quyenn', N'phuongphuongquyen6@gmail.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'TUo8POh26kdsrZXPrzf9jQlmpL22', N'anh thống đẹp ', N'lasigla3008@gmail.com', N'          ', N'', CAST(458 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'tyDutpwXXYOKSf1RlE9ETUICvRw2', N'Ri', N'nahri090901@gmail.com', N'0777892289', N'', CAST(18995 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', N'trung', N'trungthachdau@outlook.com', N'0369033543', N'HIHI', CAST(715533 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'V0fQz3i0OGUdmIvF0OyeKQvRxLk2', N'Aa', N'Aa123@gmail.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'vk5dGwcTBYh7LOqrWfLE6j0OVLr1', N'Mi', N'mi123@gmail.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'w7CDb37QEASGIMMA09BF2JrpQwK2', N'trung', N'trung@email7.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'zm31KrLjk6MqgAQpPulyNxVA6qB2', N'Ri', N'trysrt2ne1@gmail.com', N'          ', N'', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[KhachHang] ([Id_KhachHang], [TenKhachHang], [Email], [SoDienThoai], [DiaChi], [DiemThuong]) VALUES (N'zvmU9uvF1BfsQUZcVL4O9ZydOqU2', N'Hi', N'hi2@email.com', N'          ', N'', CAST(3716 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[KhuyenMai] ON 

INSERT [dbo].[KhuyenMai] ([Id_KhuyenMai], [TenKhuyenMai], [NgayBatDau], [NgayKetThuc], [TrangThai]) VALUES (35, N'Khuyến mãi giữa năm', CAST(N'2024-06-09T00:00:00.0000000' AS DateTime2), CAST(N'2024-07-09T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[KhuyenMai] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiSanPham] ON 

INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (3, N'Đồ dùng nhà bếp')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (7, N'Máy móc')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (8, N'Khuôn bánh')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (9, N'Cán bột')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (10, N'Cây vét ')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (11, N'Dụng cụ cắt')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (12, N'Dụng cụ bào tỉa')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (13, N'Chai nhựa')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (14, N'Dụng cụ làm bánh kem')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (15, N'Bột bánh')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (16, N'Nguyên liệu tổng hợp')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (17, N'Phô mai')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (18, N'Bột khô')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (19, N'Bột trộn sẵn')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (20, N'Hương lệu')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (21, N'Chocolate - Chip - Cốm - Kẹo dẻo - Bánh kẹo trang trí - Topping')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (22, N'Nhân bánh')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (23, N'Màu trang trí')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (24, N'Đo nhiệt độ - Bàn xoay')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (25, N'Kem trang trí bánh')
INSERT [dbo].[LoaiSanPham] ([Id_LoaiDungCu], [TenLoaiDungCu]) VALUES (26, N'Khay bánh')
SET IDENTITY_INSERT [dbo].[LoaiSanPham] OFF
GO
INSERT [dbo].[MaGiamGia] ([Id_MaGiamGia], [TenMaGiamGia], [GiaTriGiam], [LuotSuDung]) VALUES (N'FREESHIP  ', N'FREESHIP', CAST(35000 AS Numeric(18, 0)), 99)
INSERT [dbo].[MaGiamGia] ([Id_MaGiamGia], [TenMaGiamGia], [GiaTriGiam], [LuotSuDung]) VALUES (N'KAKA      ', NULL, CAST(50000 AS Numeric(18, 0)), 9999)
INSERT [dbo].[MaGiamGia] ([Id_MaGiamGia], [TenMaGiamGia], [GiaTriGiam], [LuotSuDung]) VALUES (N'SHIP15K   ', N'SHIP15K', CAST(15000 AS Numeric(18, 0)), 50)
GO
SET IDENTITY_INSERT [dbo].[NhaCungCap] ON 

INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (1, N'Công ty TNHH Hạnh Phúc', N'1 Ð.Thống Nhất, Quận 1, Sài Gòn', N'0339571912', N'hanhphuc@outlook.com                              ')
INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (2, N'Công ty TNHH Gia Vị', N'213 Ð. Công Lý, Quận 3, Sài Gòn', N'0339571912', N'giavi@gmail.com                                   ')
INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (3, N'Tập đoàn Thiên Đường Bột Mì', N'20 Tỉnh Lộ 50, Tx. Gò Công, Tiền Giang', N'0339571912', N'tdbm@tdbm.com                                     ')
INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (4, N'Công ty Nông sản Hoa Ngọt Ngào', N'56 Ð. Lữ Gia, Tp. Ðà Lạt, Lâm Ðồng', N'0339571912', N'contact@hoangotngao.com                           ')
INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (5, N'Double Cake Inc', N'23 Ð. Trần Hưng Ðạo, Tp. Westminster, CA 92683', N'0339571912', N'doublecake@doublecake.com                         ')
INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (6, N'Tập đoàn Vạn Thịnh Phúc', N'23 Argile, Quận Du Tiêm Vượng, Khu Cửu Long, Hồng Kông', N'0339571912', N'vanthinkphuc@vtp.hk                               ')
INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (7, N'Công ty Cổ phần Mơ Mộng', N'52 Triệu Ðà, Quận 10, Sài Gòn', N'0339571912', N'contact@momong.vn                                 ')
INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (8, N'Công ty TNHH Yêu Thương', N'95 Nguyễn Huệ, Quận 2, Sài Gòn', N'0339571912', N'yeu@yeuthuong.org.vn                              ')
INSERT [dbo].[NhaCungCap] ([Id_NhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai], [Email]) VALUES (9, N'Tập đoàn Sáng Tạo', N'258 Sáng Tạo, Quận 9, Sài Gòn', N'0339571912', N'sangtao@st.vn                                     ')
SET IDENTITY_INSERT [dbo].[NhaCungCap] OFF
GO
SET IDENTITY_INSERT [dbo].[NhaSanXuat] ON 

INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (1, N'Whisk & Flourish', N'contact@whiskflourish.vn', N'123 Đồng Khởi, Bến Nghé, Quận 1, TP. HCM')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (2, N'Delicious Fields', N'df@df.com', N'123 Green Valley Road, Suite 200, Saigon, Vietnam')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (3, N'SavorSpire Foods', N'info@savorspirefoods.com', N'456 Flavor Avenue, 5th Floor, New York, NY 10012, USA')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (4, N'NutriNook', N'support@nutrinook.com', N'789 Health Blvd, Building A, Toronto, ON M5V 3C6, Canada')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (5, N'FlavorWave Creations', N'sales@flavorwavecreations.com', N'101 Spice Street, Level 4, London, UK SE1 7PB')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (6, N'HarvestGlow Organics', N'hello@harvestgloworganics.com', N'202 Farm Lane, Suite 100, Melbourne, VIC 3000, Australia')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (7, N'CookWave Innovations', N'inquiries@cookwaveinnovations.com', N'512 Kitchen Lane, Suite B, Los Angeles, CA 90017, USA')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (8, N'EpiChef Tools', N'contact@epicheftools.com', N'623 Culinary Plaza, 3rd Floor, Paris, France 75002')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (9, N'KitchenEuphoria', N'info@kitcheneuphoria.com', N'734 HomeCook Boulevard, Suite 101, Singapore 238841')
INSERT [dbo].[NhaSanXuat] ([Id_NhaSanXuat], [TenNSX], [Email], [DiaChi]) VALUES (10, N'BlueStone', N'1800545494@tara.com.vn', N'36 Bùi Thị Xuân, Phường Bến Thành, Quận 1, TP.HCM')
SET IDENTITY_INSERT [dbo].[NhaSanXuat] OFF
GO
SET IDENTITY_INSERT [dbo].[PhuongThucThanhToan] ON 

INSERT [dbo].[PhuongThucThanhToan] ([Id_PTTT], [TenPTTT], [TinhTrang]) VALUES (1, N'Thanh toán khi nhận hàng', 1)
INSERT [dbo].[PhuongThucThanhToan] ([Id_PTTT], [TenPTTT], [TinhTrang]) VALUES (2, N'Chuyển khoản', 0)
INSERT [dbo].[PhuongThucThanhToan] ([Id_PTTT], [TenPTTT], [TinhTrang]) VALUES (3, N'Ví điện tử MoMo', 0)
SET IDENTITY_INSERT [dbo].[PhuongThucThanhToan] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (23, N'3232121', N'- Màu sắc: Đen
- Chất liệu: Vải', CAST(3 AS Decimal(18, 0)), 0, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2F162072038%20%281%29.jpg?alt=media&token=1502ee8d-75da-411d-b8d5-05fb07e6d052', 3, 7, CAST(0 AS Decimal(18, 0)), NULL, N'- Màu sắc: Đen
- Chất liệu: Vải', 1, 1)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (27, N'SP2', NULL, CAST(200 AS Decimal(18, 0)), 0, NULL, 3, 1, CAST(0 AS Decimal(18, 0)), CAST(100 AS Decimal(18, 0)), NULL, 1, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (28, N'232323', N'32131', CAST(213213 AS Decimal(18, 0)), 0, NULL, 3, 1, CAST(0 AS Decimal(18, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (29, N'ahahaha ahahah hahah hahahaha ', NULL, CAST(213213 AS Decimal(18, 0)), 0, NULL, 3, 1, CAST(0 AS Decimal(18, 0)), NULL, N'213213', NULL, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (30, N'3213', NULL, CAST(11 AS Decimal(18, 0)), 0, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2F162072038.jpg?alt=media&token=cf1d8974-1947-4e94-847b-67a7776355ff', 3, 1, CAST(0 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)), NULL, NULL, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (31, N'trungggg', NULL, CAST(21 AS Decimal(18, 0)), 0, NULL, 18, 1, CAST(0 AS Decimal(18, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (32, N'21321321', NULL, CAST(32132 AS Decimal(18, 0)), 0, NULL, 3, 1, CAST(0 AS Decimal(18, 0)), CAST(3213 AS Decimal(18, 0)), NULL, 1, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (33, N'123213', NULL, CAST(32132 AS Decimal(18, 0)), 0, NULL, 3, 1, CAST(0 AS Decimal(18, 0)), CAST(2132132 AS Decimal(18, 0)), NULL, 1, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (34, N'kaka', NULL, CAST(2 AS Decimal(18, 0)), 0, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Ficon.png?alt=media&token=c6322ce6-bf44-4e49-9d58-e1f77faf5b20', 3, 1, CAST(0 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), NULL, 1, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (35, N'Máy đánh trứng', N'Máy Đánh Trứng Bluestone 300W HMB-6333 – Có Bảo Hành 2 Năm
– Máy đánh trứng, kem, trộn bột…dùng trong làm bánh và các công việc nhà bếp
– Đa dụng với nhiều tốc độ.
– Dung tích vừa và nhỏ.
– Dạng máy cầm tay, dễ di chuyển.
– Xuất xứ: Trung Quốc', CAST(673000 AS Decimal(18, 0)), 20, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2FMaydanhtrung.jpg?alt=media&token=a8575d76-9370-46b1-8228-eee033ec5c99', 7, 9, CAST(0 AS Decimal(18, 0)), CAST(40000 AS Decimal(18, 0)), N'- Màu sắc: Đen
-  300W HMB 6333S', 0, 10)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (36, N'Cân Điện Tử', N'Cân Điện Tử B-215 được dùng để cân đo trọng lượng nguyên liệu theo công thức cho sẵn giúp bánh có thể hoàn chỉnh và ngon nhất hay dùng trong nhà bếp cân các loại rau, củ quả, thịt cá và những loại thực phẩm khác….
Không chỉ dừng lại là một dụng cụ mà chiếc cân điện tử siêu xinh xắn này còn là một món đồ trang trí trong cắn bếp của bạn nhé.
', CAST(120000 AS Decimal(18, 0)), 41, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fcandientu.jpg?alt=media&token=c2011b32-35f3-4445-9f3c-69f10faf8ca1', 7, 9, CAST(0 AS Decimal(18, 0)), NULL, N'Tên sản phẩm: Cân Điện Tử B-215
Chất liệu: nhựa
Màu sắc : giao màu ngẫu nhiên
Xuất xứ: Trung Quốc', 0, 10)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (37, N'Máy Làm Bánh Waffle', N'Máy Làm Bánh Waffle Mini dùng điện( Không Bảo Hành- Không Đổi Trả) được dùng làm bánh waffle xinh xắn, tiện dụng.

', CAST(245000 AS Decimal(18, 0)), 20, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmaylamwaffle.jpg?alt=media&token=c6429888-c130-4c96-a0e3-18d6236a78bb', 7, 9, CAST(0 AS Decimal(18, 0)), CAST(226000 AS Decimal(18, 0)), N'– Tên sản phẩm : Máy Làm Bánh Waffle Mini
– Màu sắc: đỏ
– Công suất : 350w
– Xuất xứ: Trung Quốc', 0, 10)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (38, N'Máy Ép Miệng Túi', N'Thông tin sản phẩm:
Tên sản phẩm:Máy Ép Miệng Túi (Giao Kiểu Gợn Sóng Hoặc Bằng) – Giao Màu Ngẫu Nhiên- Không Đổi Trả – Không Bảo Hành
Chất liệu: nhựa
Màu sắc: nhiều màu tím, hồng, xanh …
Xuất xứ: Trung Quốc
', CAST(85000 AS Decimal(18, 0)), 30, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmayhangmiengtui.jpg?alt=media&token=016c4c39-7cc2-420e-a710-9be3ab9e18ad', 7, 9, CAST(0 AS Decimal(18, 0)), CAST(70000 AS Decimal(18, 0)), NULL, 0, 10)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (39, N'Chén Pudding Tròn Trắng', N'Khuôn Pudding Tròn Màu Trắng được làm bằng sứ cao cấp, khuôn dùng làm các loại bánh pudding, dễ dàng lấy bánh và vệ sinh sau khi sử dụng.

Thông tin sản phẩm:
Tên sản phẩm: Khuôn Pudding Tròn Màu Trắng
Chất liệu: sứ
Màu sắc: màu trắng
Xuất xứ: Việt Nam
Kích thước: Đường kính trên: 7.5cm, đường kính đáy: 6.5cm, chiều cao: 4cm', CAST(17000 AS Decimal(18, 0)), 50, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fchenpudding.jpg?alt=media&token=9929cdfa-0372-45d5-b003-9b14f68beacd', 8, 5, CAST(0 AS Decimal(18, 0)), CAST(11000 AS Decimal(18, 0)), N'- Kích thước: 7.5 cm', 0, 1)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (40, N'Khuôn tròn đế rời', N'Khuôn tròn đáy rời 18cm
Trên thị trường có rất nhiều loại khuôn dành cho làm bánh ngọt. Chúng có hình thù vô cùng đa dạng như hình tròn, hình vuông, hình trái tim, hình hoa, lá, đa giác với có nhiều kích cỡ khác nhau và khuôn tròn là khuôn cơ bản nhất được rất nhiều lựa chọn sử dụng. Khuôn tròn đáy rời 18cm - một loại khuôn được nhiều người lựa chọn. Khuôn được làm từ nhôm đúc xuất xứ tại Việt Nam vô cùng bền chắc với ưu điểm của khuôn là giá thành khuôn phù hợp mà chất liệu lại vô cùng an toàn. Khuôn có đáy và thân rời nhau giúp bạn dễ dàng hơn khi lấy bánh. Khuôn được dùng làm các loại bánh ngọt như: bánh kem, mousse, bông lan…

Để sử dụng khuôn tốt nhất tối đa sau bạn nên:
– Khi mua về trước khi sử dụng phải được rửa sạch, hơ trên lửa nhỏ để khô khuôn bánh 
– Bôi một lớp bơ, dầu mỡ lên mặt khuôn hoặc sử dụng giấy nến để chống dính khuôn.  ', CAST(65000 AS Decimal(18, 0)), 11, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2FKhuonnhomtron.jpg?alt=media&token=71ad9f3b-7aa8-499a-9c91-82bd0528bf2d', 8, 6, CAST(19500 AS Decimal(18, 0)), CAST(57000 AS Decimal(18, 0)), N'Kích thước: 18cm', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (41, N'Khuôn bánh trung thu', N'Thiết kế chắc chắn bền đẹp, dễ dàng vệ sinh và làm sạch.
Lò xo cứng cáp tạo đồ đàn hồi và sức nén tốt.
Mỗi phân loại khuôn sẽ 3-6 mảnh họa tiết hoa văn cho bạn thay đổi nhé.
Đường kính miệng tầm ~50mm (tùy kiểu sẽ có chênh lệch ít nhiều).
', CAST(55000 AS Decimal(18, 0)), 36, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fkhuontrungthu.jpg?alt=media&token=7e86b122-6b1c-4635-8b88-84b6bfe4ba73', 8, 7, CAST(49500 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), N'Sản phẩm: Khuôn nhấn bánh trung thu GBMO1585.
Chất liệu: Nhựa ABS an toàn khi sử dụng.
Phân loại khối lượng: 50g.', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (42, N'Giấy Thấm Dầu Thực Phẩm ', N'Giấy thấm dầu dùng thấm dầu mỡ từ các món chiên, rán. Có thể dùng gói Sandwich, Hamberger, lót các loại bánh bánh kẹo ngọt….

– Chất liệu: Giấy nến
– Màu sắc: Giao họa tiết ngẫu nhiên
– Kích thước: 18*18cm
– Số lượng: 100 tờ/gói', CAST(20000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fgiaythamdau.jpg?alt=media&token=b0baafa3-a49a-4554-82a3-d13a798f62e8', 3, 8, CAST(0 AS Decimal(18, 0)), CAST(14000 AS Decimal(18, 0)), N'– Giao Họa Tiết Ngẫu Nhiên', 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (43, N'Dây Thừng Dày 1MM', N'Dây Thừng dùng để trang trí đồ handmade, dây được làm bằng vải bố chắc chắn.

Thông tin sản phẩm:
Tên sản phẩm: Dây Thừng Dày 1MM – Dài 100M
Màu sắc: màu nâu
Xuất xứ: Việt Nam', CAST(20000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fdaythung.jpg?alt=media&token=40c3d2fe-acb8-416b-a50b-192635255687', 3, 9, CAST(0 AS Decimal(18, 0)), CAST(15000 AS Decimal(18, 0)), NULL, 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (44, N'Giấy Nến ', N'Giấy nến cắt sẵn dùng trong nhà bếp, với công dụng chống dính hiệu quả bởi chất liệu giấy tráng silicone, không sinh ra chất độc hại khi tiếp xúc nhiệt nóng.

Thông tin sản phẩm

– Tên sản phẩm: Giấy nến 8412

– Kích thước: 20cm

– Số lượng: 20 tờ/gói

– Chất liệu: giấy tráng silicone

– Xuất xứ: Trung Quốc

– Công dụng: Dùng để chống dính, lót khay, đế bánh', CAST(19000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fgiaynen.jpg?alt=media&token=c30c366f-64fd-419d-a20b-9d1aebf07a16', 3, 8, CAST(0 AS Decimal(18, 0)), CAST(12000 AS Decimal(18, 0)), N'8412 8inch – 20 Tờ', 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (45, N'Găng Tay Chịu Nhiệt Lớn', N'Găng tay vải là dụng cụ hữu ích dành cho chị em dùng trong nhà bếp. Chiếc găng tay vải dày, cực bền, chịu nhiệt tốt bảo vệ cho đôi tay khi lấy bánh ra khỏi lò nướng hay thức ăn từ trong lò nướng, lò vi sóng,bếp than…

? Găng tay vải được thiết kế các đường vân ở giữa giúp giữ và bám chắc đồ dùng, an toàn khi sử dụng. Với bộ đôi găng tay vải này, các chị em không cần phải lo sợ nóng bỏng từ những chiếc nồi, xoong, …khi làm bếp nhé .
', CAST(70000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fgangtayto.jpg?alt=media&token=9c62f2bb-c5cc-4da2-979c-b34b26d399dc', 3, 4, CAST(0 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'Găng tay được dùng trong chế biến bánh, các loại thực phẩm, giúp bảo vệ tay và an toàn vệ sinh thực phẩm.

Tên sản phẩm: Găng Tay Chịu Nhiệt Lớn Màu Xanh
Màu sắc: màu xanh
Chất liệu: vải

Giao 1 Cặp 2 Cái', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (46, N'Găng Tay Chịu Nhiệt Trung', N'Găng tay vải là dụng cụ hữu ích dành cho chị em dùng trong nhà bếp. Chiếc găng tay vải dày, cực bền, chịu nhiệt tốt bảo vệ cho đôi tay khi lấy bánh ra khỏi lò nướng hay thức ăn từ trong lò nướng, lò vi sóng,bếp than…

Găng tay vải được thiết kế các đường vân ở giữa giúp giữ và bám chắc đồ dùng, an toàn khi sử dụng. Với bộ đôi găng tay vải này, các chị em không cần phải lo sợ nóng bỏng từ những chiếc nồi, xoong, …khi làm bếp nhé .

', CAST(50000 AS Decimal(18, 0)), 59, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fgangtaytrung.jpg?alt=media&token=a30e72f0-09bd-4a1d-9ade-1897aa716609', 3, 1, CAST(0 AS Decimal(18, 0)), CAST(25000 AS Decimal(18, 0)), N'Găng tay được dùng trong chế biến bánh, các loại thực phẩm, giúp bảo vệ tay và an toàn vệ sinh thực phẩm.

Tên sản phẩm: Găng Tay Chịu Nhiệt Trung
Màu sắc: màu bạc
Chất liệu: vải, da', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (47, N'Kẹp Gắp Bánh Inox', N'Dụng cụ kẹp gắp bánh là dụng cụ hữu ích trong nhà bếp giúp bạn dễ dàng kẹp, chế biến đồ ăn, làm bánh. Làm từ inox có độ bền và chịu lực cao. Thiết kế tay cầm dài, giúp bạn gắp đồ ăn nóng, đồ nướng dễ dàng.', CAST(39000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fkepgapbanh.jpg?alt=media&token=e1c7ec80-9b7c-445d-8292-24ad1aa54f4c', 3, 1, CAST(0 AS Decimal(18, 0)), CAST(30000 AS Decimal(18, 0)), N'– Kẹp gắp bánh inox
– Chất liệu: inox
– Kích thước: dài 33cm x 4.5cm
– Xuất xứ: China', 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (48, N'Cây Cán Gỗ Họa Tiết', N'Cây cán bột gỗ in họa tiết được làm từ gỗ tự nhiên nên có độ bền rất cao, đảm bảo độ sắc nét và họa tiết đều đặn trên bánh sau khi lăn trên bột, tay cầm rắn chắc.
Với cây cán bột gỗ này, chị em có thể tự tay làm ra chiếc bánh vừa ngon miệng, vừa đẹp xinh mà không tốn nhiều công sức cho việc tạo hình. Có nhiều họa tiết dễ thương để lựa chọn : ong nhỏ , gấu, happy birthday, hoa …Nhanh tay rinh ngay về căn bếp thân iu nhé cả nhà .

', CAST(230000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fcaylanhoatiet.jpg?alt=media&token=417e0f8e-fbdd-4bb1-bb89-76f3e877967e', 9, 1, CAST(0 AS Decimal(18, 0)), CAST(140000 AS Decimal(18, 0)), N'Tên sản phẩm: Cây Cán Gỗ Nhập Họa Tiết Con Vật Dễ Thương 
Chiều Dài Toàn Cây 46cm
Chất liệu: gỗ
Xuất xứ: Trung Quốc', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (49, N'Cây Đánh Trứng Inox', N'Cây Đánh Trứng Inox 10inch 23808 là dụng cụ cơ bản không thể thiếu đối với những người đam mê bếp bánh. Với cây đánh trứng cầm tay được làm bằng chất liệu inox an toàn sẽ giúp bạn đánh xốp trứng và bột bánh một cách dễ dàng và tiện lợi nhất.

', CAST(15000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fcaydanhtrung.jpg?alt=media&token=79efa17b-7773-451b-a0e7-1cb1245cf237', 9, 1, CAST(0 AS Decimal(18, 0)), CAST(11000 AS Decimal(18, 0)), N'Tên sản phẩm: Cây Đánh Trứng Inox 10inch 23808
Chất liệu: inox
Chiều dài toàn cây: 25cm
Xuất xứ: Trung Quốc', 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (50, N'Muỗng Xúc Kem Inox', N'Muỗng Xúc Kem Inox Lớn 8071 được làm bằng chất liệu inox rắn chắc, được dùng để múc kem tạo hình hoặc múc trái cây,rất tiện lợi và dễ dàng vệ sinh.', CAST(45000 AS Decimal(18, 0)), 20, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmuongkem.jpg?alt=media&token=f7eb8fbe-f15c-487a-b8cc-48460621a2e7', 9, 7, CAST(0 AS Decimal(18, 0)), CAST(29000 AS Decimal(18, 0)), N'Tên sản phẩm: Muỗng Xúc Kem Inox Lớn 8071
Chất liệu: inox
Xuất xứ: Trung Quốc
Đường kính viên kem lớn : 6cm, chiều cao viên 3cm', 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (51, N'Muôi lật-trộn bột bánh', N'Công dụng: dùng để lật đồ ăn khi nấu nướng, trộn bộ, đánh bột...
Hạn chế tối đa khả năng gây trầy xước và hư hỏng nồi chảo chống dính và các dụng cụ làm bếp khác
Sử dụng tiện lợi khi trở thức ăn , khấy bột, trộn bột
Chất liệu silicon an toàn, dễ dàng vệ sinh sau khi sử dụng.
An toàn khi dùng , sử dụng được cho nhiều mục đích nấu ăn khác nhau.', CAST(60000 AS Decimal(18, 0)), 49, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2FMuoitronbot.jpg?alt=media&token=ee7296a2-9a27-452c-b7fd-7252c24c4683', 9, 4, CAST(0 AS Decimal(18, 0)), CAST(53000 AS Decimal(18, 0)), N'Kích thước : 57x264mm
Màu sắc: Màu vàng, xanh biển, xanh ngọc, hồng
Chất liệu : thép không gỉ ,silicone , PS + PRT
Thiết kế gọn gàng, đẹp mắt, tạo sự sinh động cho bếp nhà bạn', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (52, N'Bộ Cọ Vẽ Vuốt Bánh', N'Bộ Cọ Vẽ 10 Cái được dùng để vẽ trang trí bánh kem .

', CAST(30000 AS Decimal(18, 0)), 32, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fcovebanh.jpg?alt=media&token=c89a46c4-1dc1-4fdf-90c9-5a7ab1719647', 10, 4, CAST(0 AS Decimal(18, 0)), CAST(100000 AS Decimal(18, 0)), N'Tên sản phẩm: Bộ Cọ Vẽ 10 Cái
Chất liệu: gỗ
Màu sắc: Hồng, xanh
Xuất xứ: China', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (53, N'Miếng Vét Bầu Vàng', N'Miếng Vét Bầu Vàng dùng để vét bột, chất liệu bằng nhựa nên dễ dàng vệ sinh sau khi sử dụng.
Thông tin sản phẩm:
Tên sản phẩm: Miếng Vét Bầu Vàng 
Chất liệu: nhựa
Màu sắc: màu vàng
Xuất xứ: Trung Quốc', CAST(15000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmiengvetbau.jpg?alt=media&token=9da39488-f9af-43e3-b36a-b5a51295d675', 10, 6, CAST(0 AS Decimal(18, 0)), CAST(12000 AS Decimal(18, 0)), NULL, 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (54, N'Miếng Vét Tam Giác', N'Miếng Vét Tam Giác được làm bằng nhựa tốt, dùng cắt bột trong làm bánh.
Thông tin sản phẩm:
Tên sản phẩm: Miếng Vét Tam Giác
Chất liệu: nhựa
Màu sắc: màu trắng
Xuất xứ: Trung Quốc', CAST(7000 AS Decimal(18, 0)), 20, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fvettamgiac.jpg?alt=media&token=206e278f-cef5-4782-8e46-ce9d87ac412f', 10, 6, CAST(0 AS Decimal(18, 0)), CAST(4000 AS Decimal(18, 0)), NULL, 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (55, N'Dao Cắt Bánh Răng Cưa', N'Chiều dài : 30cm
Xuất xứ: Trung Quốc', CAST(55000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fdaorangcua.jpg?alt=media&token=e6f4723e-1d60-436d-a06d-595dd28ed048', 11, 9, CAST(0 AS Decimal(18, 0)), CAST(41000 AS Decimal(18, 0)), NULL, 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (56, N'Dao Cắt Bánh Pizza', N'Dao Cắt Bánh Pizza 9011 được dùng cắt bánh pizza. Dao có lưỡi inox sắc rất dễ cắt bánh, phần cán bằng nhựa.
Xuất xứ: Trung Quốc', CAST(70000 AS Decimal(18, 0)), 60, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fdaopizza.jpg?alt=media&token=ff8d1400-468e-445b-9cde-efb290e70c18', 11, 4, CAST(0 AS Decimal(18, 0)), CAST(55000 AS Decimal(18, 0)), N'HSD: 31-12-2023
Màu: Bạc', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (57, N'Xẻng xúc bánh cán nhựa', N'Xẻng Xúc Bánh Cán Nhựa hàng nhập khẩu chất lượng tốt.

Xuất xứ: Trung Quốc', CAST(90000 AS Decimal(18, 0)), 56, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fxengxucbanh.jpg?alt=media&token=e6f58c42-127a-4449-a6bd-19cd4eb0dc44', 11, 1, CAST(0 AS Decimal(18, 0)), CAST(80000 AS Decimal(18, 0)), N'Màu sắc: đen
Dài: 19cm
Rộng 7cm
Chất liệu: Inox, cán bọc nhựa', 0, 9)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (58, N'Bộ dao tỉa bánh mini', N'Bộ Dao Tỉa dùng để tỉa tạo hình nghệ thuật cho hoa, quả.

Xuất xứ: Nhật Bản', CAST(125000 AS Decimal(18, 0)), 49, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fdaotiabanh.jpg?alt=media&token=62278389-dafe-4127-b5a2-36e473b571b0', 11, 5, CAST(0 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), N'Chất liệu: Thép Nhật bọc cán gỗ
Chiều dài: 15cm
Chiều dài lưỡi dao 8cm', 0, 8)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (59, N'Phô Mai Mozzarella Bào Sợi', N'Phô Mai Mozzarella Bào Sợi 1kg- Giao Còn Hạn- Không Đổi Trả Hàng là nguyên liệu phô mai tươi, mềm , có vị thơm ngon, là nguyên liệu dùng làm các loại bánh, món ăn …', CAST(210000 AS Decimal(18, 0)), 120, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmozza_soi.jpg?alt=media&token=23529f7a-7015-4e19-939e-8ad36a168e19', 3, 2, CAST(0 AS Decimal(18, 0)), CAST(195000 AS Decimal(18, 0)), N'Tên sản phẩm: Phô Mai Mozzarella Bào Sợi 1kg
Trọng lượng: 1kg
Bảo quản trong ngăn đông tủ lạnh.', 0, 6)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (60, N'Cream Cheese Elle Vire', N'Cream Cheese Elle Vire 150gr- Giao Còn Hạn- Không Đổi Trả Hàng
Cream Cheese Elle Vire 150gr là nguyên liệu được dùng làm các món bánh, giúp tạo thêm độ béo và thơm ngon hơn cho món bánh, Sản phẩm đảm bảo chất lượng và an toàn thực phẩm.', CAST(68000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fcream-cheese-elle-vire-1-570x570.jpeg?alt=media&token=be139c70-283b-457f-b196-93671523f34b', 17, 2, CAST(0 AS Decimal(18, 0)), CAST(53000 AS Decimal(18, 0)), N'Tên sản phẩm: Cream Cheese Elle Vire 150gr
Khối lượng tịnh: 150gr
Bảo quản ở ngăn mát tủ lạnh', 0, 6)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (61, N'Hạt Chia Đen Absolute Organic', N'Hạt Chia Úc Absolute Organic gồm những hạt màu đen có kích thước nhỏ giống như hạt mè, với khả năng ứng dụng rộng rãi được nhiều người yêu thích sử dụng.', CAST(120000 AS Decimal(18, 0)), 50, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fhatchia.jpg?alt=media&token=55660fc8-f950-4ee0-b6a6-8ae764eb9459', 16, 2, CAST(0 AS Decimal(18, 0)), CAST(100000 AS Decimal(18, 0)), N'Khối lượng tịnh: 1kg
Cách sử dụng: Pha với nước, nước trái cây, rắc lên món salad, ngũ cốc,…
Bảo quản: Nơi khô ráo, thoáng mát
Xuất xứ: Úc', 0, 6)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (62, N'Bột Khoai Lang Tím', N'Bột Khoai Lang Tím là nguyên liệu dùng để chế biến chè, cháo, bánh, kem, sinh tố,… được phổ biến rộng rãi.', CAST(275000 AS Decimal(18, 0)), 169, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbotkhoailang.jpg?alt=media&token=c62a5638-45da-4c8c-bb64-60c314b99ab1', 16, 4, CAST(0 AS Decimal(18, 0)), CAST(80000 AS Decimal(18, 0)), N'Khối lượng tịnh: 1kg
Cáhc sử dụng: Dùng trong chế biến thực phẩm
Bảo quản: Nơi khô ráo, thoáng mát
Xuất xứ: Việt Nam
Thành phần: 100% khoai lang tím', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (63, N'Bột mì đa dụng', N'Hướng dẫn sử dụng: Dùng để chế biến các loại bánh mì bánh bông lan bánh ngọt bánh rán bánh pizza mì sợi bánh bao...
Hướng dẫn bảo quản: Bảo quản nơi sạch sẽ thoáng mát hợp vệ sinh.', CAST(25000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbotmidadung.jpg?alt=media&token=c9f0cb81-f86b-4d7e-8c02-abc6fd3affbb', 18, 3, CAST(0 AS Decimal(18, 0)), CAST(23000 AS Decimal(18, 0)), N'Bột mì đa dụng Meizan được đóng gói kín đáo tiện lợi khi sử dụng và bảo quản.
Ngày sản xuất: Xem trên bao bì sản phẩm.
Hạn sử dụng: 6 tháng.', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (64, N'Bột Bánh Bao Tài Ký', N'Bột Bánh Bao Tài Ký là một dòng bột trộn sẵn kèm theo sản phẩm là một gói men nở bên trong vô cùng tiện lợi. Giúp bạn có thể tạo ra lớp vỏ bột bên ngoài mềm mịn, căng nở, xốp và thơm ngon.

Cách sử dụng:
– Bước 1: Ủ BỘT: Gói men khô + 200 ml nước, khuấy tan đều. Đổ hỗn hợp trên từ từ vào bột bánh bao, nhồi đều đến khi thấy bột mịn (khoảng 10 phút). Đậy kín khối bột, ủ với nhiệt độ ấm (khoảng 30 – 330C) đến khi thấy khối bột nở gấp đôi (khoảng 1 giờ).

– Bước 2: NHÂN BÁNH: Thịt bằm; nấm mèo, củ sắn (củ đậu) thái sợi; hành tây, hành tím cắt hạt lựu; nêm vừa khẩu vị, trộn đều.

– Bước 3: TẠO HÌNH VÀ HẤP BÁNH: Chia bột thành từng khối bột nhỏ khoảng 50 g, cán mỏng, đặt nhân và trứng cút luộc vào giữa và tạo hình. Hấp bánh trong khoảng 10 – 20 phút (tùy kích thước bánh).

Bảo quản: Nơi khô thoáng, tránh ẩm và ánh sáng trực tiếp', CAST(25000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbot-banh-bao-taky-595x595.png?alt=media&token=c5aa25e1-ee27-4201-91a6-c06566395ff0', 18, 3, CAST(20000 AS Decimal(18, 0)), CAST(22000 AS Decimal(18, 0)), N'Khối lượng tịnh: 400g
Công dụng: Dùng bột làm vỏ cho món bánh bao
Sản phẩm của Công ty cổ phần bột – thực phẩm Tài Ký.
Thành phần: Bột mì, đường cát, chất tạo xốp (450(i)),…', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (65, N'Bột Gạo Tài Ký', N'Bột Gạo Tài Ký là một loại bột được ứng dụng rộng rãi trong nhiều công thức bánh, đặc biệt là các món bánh Việt. Sản phẩm góp phần mang đến vị ngon tuyệt hảo cho món bánh thành phẩm nên được nhiều người yêu thích sử dụng.

Cách sử dụng: Dùng chế biến các loại bánh bò, bánh giò, bánh đúc,…
Bảo quản: Nơi khô ráo, thoáng mát', CAST(20000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbot-gao-tai-ky-goi-400-595x595.jpg?alt=media&token=2a1a7732-2953-48e0-905f-447a1c5c4321', 18, 3, CAST(0 AS Decimal(18, 0)), CAST(18000 AS Decimal(18, 0)), N'Khối lượng tịnh: 400g
Thành phần: 100% bột gạo', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (66, N'Bột Bắp Thái Lan', N'Bột Bắp Thái Lan là loại bột được sản xuất trên dây chuyền công nghệ hiện đại. Sản phẩm là một loại bột mịn được làm từ các nội nhũ (phần lõi của hạt) của hạt bắp/ngô khô. Bột bắp Thái Lan ở dạng bột rất mịn, màu trắng, vị đắng, do đó khi sử dụng phải pha loãng trước trong nước ấm/nóng và nấu thì sẽ làm mất được vị đắng này.

Cách sử dụng: Dùng làm bánh hoặc chế biến món ăn
Bảo quản: Nơi khô ráo, thoáng mát, tránh ẩm và ánh sáng mặt trời trực tiếp', CAST(27000 AS Decimal(18, 0)), 102, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Ftinh-bot-bap-thai-400-595x595.jpg?alt=media&token=e7a71681-197a-4a12-9644-43b0fd8a0315', 18, 1, CAST(0 AS Decimal(18, 0)), CAST(20000 AS Decimal(18, 0)), N'Khối lượng tịnh: 400g
Xuất xứ: Thái Lan
Thành phần: 100% bột bắp', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (67, N'Bột Bánh Bông Lan Chay', N'Sản phẩm Bột Bánh Bông Lan Chay Fancy’s được chế biến theo công nghệ Hà Lan và được kiểm soát nghiêm ngặt trong quá trình sản xuất. Ngoài ra, công thức bột bánh vẫn giữ nguyên sự thơm ngon, bông xốp sẵn có của chiếc bánh bông lan thông thường, nhưng đặc biệt bột bánh không chứa thành phần của trứng mà thay vào đó là các nguyên liệu tự nhiên như: Bột mì, đường, tinh bột bắp, bột nổi,… nên rất thích hợp cho người ăn chay sử dụng.

Cách sử dụng Bột Bánh Bông Lan Chay Fancy’s

Thoa dầu vào 7 khuôn tròn 20cm để chống dính, sau đó làm nóng lò ở nhiệt độ 180ºC.
Cho bột bánh bông lan chay, nước (hoặc sữa) vào thố đánh. Đánh hỗn hợp bằng máy chuyên dùng khoảng 5 phút với tốc độ cao (hoặc dùng máy đánh trứng gia đình khoảng 7 phút) cho đến khi bột nổi, mịn, dẻo. Dừng máy.
Cho dầu ăn vào hỗn hợp, trộn thật đều bằng tay hoặc cây vét (Không sử dụng máy đánh trong quá trình trộn dầu ăn vào).
Chia đều hỗn hợp vào các khuôn nướng (khoảng 300g).
Nướng bánh ở nhiệt độ 180ºC trong 25 phút.
Dùng bánh khi nguội.

Lưu ý

Chỉ nên dùng ¼ lượng công thức khi đánh bằng máy đánh trứng gia đình.
Để bánh được chất lượng hơn có thể thay thế 50% lượng dầu ăn bằng bơ phe hoặc các loại bơ ngon khác.', CAST(125000 AS Decimal(18, 0)), 60, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbot-banh-bong-lan-chay.png?alt=media&token=04656525-1f51-4a49-96f9-2d062ac6477e', 19, 1, CAST(0 AS Decimal(18, 0)), CAST(120000 AS Decimal(18, 0)), N'Khối lượng tịnh: 1kg
Cách sử dụng: Làm bánh bông lan chay
Bảo quản : Bảo quản nơi khô ráo, thoáng mát tránh ánh nắng trực tiếp
Sản xuất: Công ty TNHH TM Tân Nhất Hương
Thành phần: Bột mì, đường, tinh bột bắp,…', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (68, N'Bột Bánh Pancake', N'Sản phẩm Bột Trộn Sẵn Bánh Pancake là một giải pháp nếu bạn không có quá nhiều thời gian nấu nướng những vấn muốn thưởng thức bữa sáng với những chiếc bánh pancake thơm ngon, mềm mại. Với tỉ lệ bột được trộn sẵn, bạn chỉ cần thao tác vài bước đơn giản là có thể cho ra đời ngay những chiếc bánh thơm ngon, mềm mịn tại nhà.

Cách thực hiện

Khấy đều dầu, nước và trứng (1).
Cho bột vào thố đánh bằng chổi đánh dẹt (mái chèo) cùng 2/3 hỗn hợp (1) ở tốc độ chậm
Vét bột trên thành xuống thố và đánh ở tốc độ trung bình khoảng từ 1 đến 2 phút.
Cho hết 1/3 hỗn hợp (1) còn lại vào đánh ở tốc độ chậm trong 1 phút, vét bột ở thành xuống thố
Cho hỗn hợp vừa đánh ra chảo với đường kính bánh khoảng 7 – 10cm, chiên áp chảo bánh.
Lật mặt bánh khi mặt kia đã khô.', CAST(48000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbot-lam-banh-pancake.jpg?alt=media&token=338b4f5d-1d10-46b6-952e-658055d704fc', 19, 3, CAST(0 AS Decimal(18, 0)), CAST(40000 AS Decimal(18, 0)), N'Khối lượng tịnh: 1kg
Cách dùng: Sử dụng chế biến pancake,…
Bảo quản: Bảo quản nơi khô ráo, thoáng mát tránh ánh nắng trực tiếp
Sản xuất: Công ty TNHH TM Tân Nhất Hương
Thành phần: Bột mì, đường, muối,…', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (69, N'Bột Custard Nguyên Chất', N'Sản phẩm Bột Custard Nguyên Chất Fancy’s hay còn gọi là bột trứng là sản phẩm được tạo ra bởi sự pha trộn của tinh bột ngô, bột vani, chút kem béo và trứng. Đây là một nguyên liệu phụ trợ làm bánh khá phổ biến, được sử dụng cho nhiều công thức làm bánh khác nhau. Bột custard nguyên chất thường được làm nhân bên trong các loại bánh vì có cấu trúc dẻo, có thể nướng được. Khi nướng, các thành phần trong bột hòa quyện với nhau, tạo ra một hương vị đặc biệt với mùi thơm thoang thoảng của trứng, vị béo của kem. Đặc tính dẻo của bột custard được các thợ làm bánh yêu thích, đặc tính này không chỉ tạo nên vị ngon cho món ăn mà còn khiến cho hình thức món ăn trở nên bắt mắt, hấp dẫn hơn.

Cách sử dụng: Làm nhân bánh, làm các loại bánh,…
Bảo quản: Nơi khô thoáng, tránh ánh nắng trực tiếp', CAST(50000 AS Decimal(18, 0)), 200, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbot-custard-nguyen-chat.jpg?alt=media&token=0d2aad1a-e75a-4e6d-a917-55e5171b6354', 19, 1, CAST(0 AS Decimal(18, 0)), CAST(42000 AS Decimal(18, 0)), N'Khối lượng tịnh: 500g
Sản xuất: Công ty TNHH TM Tân Nhất Hương
Thành phần: Bột bắp, muối, hương sữa tự nhiên, màu tổng hợp (160ai),…', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (70, N'Hương Bơ', N'Hương Bơ dùng để tạo hương trong thực phẩm, làm bánh… Sản phẩm được nhiều người yêu thích sử dụng.
Cách sử dụng: Tạo hương trong thực phẩm, làm bánh
Bảo quản: Bảo quản nơi khô ráo, thoáng mát', CAST(58000 AS Decimal(18, 0)), 33, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fhuong-bo-2-595x595.jpg?alt=media&token=96d6510c-59b3-4808-9b97-74ea22005c84', 20, 1, CAST(0 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), N'Khối lượng tịnh: 200g
', 0, 4)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (71, N'Hương Chuối', N'Hương Chuối dùng tạo hương thơm ngon trong thực phẩm, làm bánh… Sản phẩm được nhiều người yêu thích sử dụng.
Cách sử dụng: Dùng tạo hương trong thực phẩm, làm bánh
Bảo quản: Bảo quản nơi khô ráo, thoáng mát
Sản phẩm của Công ty TNHH TM Tân Nhất Hương', CAST(70000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fhuong-chuoi-2-595x595.jpg?alt=media&token=e54a1686-83d6-4a13-9374-c89fbd2354f7', 20, 6, CAST(0 AS Decimal(18, 0)), CAST(56000 AS Decimal(18, 0)), N'Khối lượng tịnh: 250g
', 0, 4)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (72, N'Hương Cam Pháp Vahine', N'Hương Cam Pháp là sản phẩm dùng tạo hương cho các loại bánh, đặc biệt là bánh mì hoa cúc. Sản phẩm đóng chai tiện lợi cho việc sử dụng và bảo quản.
Cách sử dụng: Dùng tạo hương trong chế biến thực phẩm
Bảo quản: Nơi khô mát, tránh nắng', CAST(140000 AS Decimal(18, 0)), 50, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fhuong-cam-phap-595x595.jpg?alt=media&token=2b4be3f1-19a2-402d-ac4c-69106bb8d6eb', 20, 7, CAST(0 AS Decimal(18, 0)), CAST(128000 AS Decimal(18, 0)), N'Dung tích: 200ml
Thành phần: Tinh cam pháp 100%', 0, 4)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (73, N'Rượu Bacardi', N'Rượu Bacardi được dùng để pha chế thức uống theo sở thích hoặc dùng trong làm bánh.

Cách sử dụng: Làm bánh hoặc pha chế thức uống
Bảo quản: Nơi khô ráo, thoáng mát', CAST(328000 AS Decimal(18, 0)), 26, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fruou-barcadi-595x595.jpg?alt=media&token=e552f95b-8017-45e6-a7aa-65a68b4449b8', 20, 6, CAST(0 AS Decimal(18, 0)), CAST(300000 AS Decimal(18, 0)), N'Dung tíchl: 750ml
', 0, 4)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (74, N'Rượu Rum Chauvet', N'Rượu Rum Chauvet được dùng để pha chế thức uống theo sở thích hoặc dùng trong làm bánh.
Cách sử dụng: Dùng làm bánh, pha chế,…
Bảo quản: Nơi khô ráo, thoáng mát và tránh nhiệt độ cao,…', CAST(205000 AS Decimal(18, 0)), 30, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Frum-chauvet-595x595.jpg?alt=media&token=11ddbcb7-50b8-45d0-8ae6-b137ab2986e2', 20, 6, CAST(0 AS Decimal(18, 0)), CAST(193000 AS Decimal(18, 0)), N'Dung tích: 1 lít
', 0, 4)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (75, N'Rượu Rum Chauvet Trắng', N'Rượu Rum Chauvet Trắng được dùng để pha chế thức uống theo sở thích hoặc dùng trong làm bánh.
Cách sử dụng: Làm nhân bánh, nhân socola, pha chế cocktail,…
Bảo quản: Bảo quản nơi khô ráo, thoáng mát, đậy kỹ nắp sau khi sử dụng', CAST(125000 AS Decimal(18, 0)), 110, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fruou-barcadi-595x595.jpg?alt=media&token=93db934d-2ddc-467b-b12a-354818c8d065', 20, 1, CAST(0 AS Decimal(18, 0)), CAST(110000 AS Decimal(18, 0)), N'Dung tích: 700ml
', 0, 4)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (76, N'Kẹo Xốp Marshmallow Trắng', N'Kẹo Xốp Marshmallow Trắng No Addition là một loại kẹo dẻo xốp, mềm như bông gòn, rất được ưa chuộng để làm các món ăn vặt, đồ uống, món nướng, nhân bánh chocopie, …. Không chỉ có hình dáng bắt mắt, kẹo Marshmallow còn có hương vị thơm ngon, an toàn với sức khỏe người dùng.

Cách sử dụng: Dùng ăn trực tiếp, làm nguyên liệu trong công thức làm bánh, làm kẹo,…
Bảo quản: Nơi khô thoáng, tránh ẩm và ánh sáng mặt trời trực tiếp', CAST(52000 AS Decimal(18, 0)), 60, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fkeo-mash-xanh-595x595.jpg?alt=media&token=9ba40ca5-7531-428d-8819-2596001808cf', 21, 8, CAST(0 AS Decimal(18, 0)), CAST(46000 AS Decimal(18, 0)), N'Khối lượng tịnh: 500g
', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (77, N'Kẹo Xốp Trắng Hồng', N'Kẹo xốp trắng hồng marshmallow được nhập khẩu trực tiếp tại Philippines, được sản xuất trên dây chuyền công nghiệp hiện đại, đảm bảo an toàn cho sức khỏe người sử dụng. Sản phẩm làm bằng nguyên liệu sạch, với tỉ lệ chính xác, tạo nên những viên kẹo mềm, mịn, bông xốp. Khi ăn có vị ngọt dịu và hơi dai, vô cùng độc đáo. Keo marshmallow mini trắng có thể sử dụng ăn trực tiếp, làm nguyên liệu chính cho món kẹo nougat và có thể sử dụng trong làm bánh và trang trí thức uống,…

Cách dùng: Sử dụng ăn trực tiếp, làm bánh, kẹo, hoặc trang trí,…
Bảo quản: Nơi thoáng mát, tránh ẩm và ánh sáng mặt trời trực tiếp.', CAST(43000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fkeo-marshmallows-mini-hong-570x570.jpeg?alt=media&token=68d91ed5-c518-4730-8fc4-7cf924f4887a', 21, 7, CAST(0 AS Decimal(18, 0)), CAST(32000 AS Decimal(18, 0)), N'Trọng lượng: 200g
Thành phần: Glucose syrup, đường, nước, gelatine, tinh bột ngô,.', 0, 2)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (78, N'Bột Decor Bánh Vị Nho', N'Bột rắc NGŨ CỐC nguyên chất giúp trang trí bánh nhanh thật nhanh, rẻ thật rẻ. Mà ăn kèm với kem còn ngon tuyệt vời.

Bảo quản: tránh ánh nắng mặt trời trực tiếp.', CAST(45000 AS Decimal(18, 0)), 80, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fdecor-nho-768x768.jpg?alt=media&token=62af4e5d-43ba-4e8a-9c8a-383d47b5e61a', 21, 5, CAST(0 AS Decimal(18, 0)), CAST(38000 AS Decimal(18, 0)), N'Trọng lượng : 100gr/ hộp
Bột rắc mịn, hương vị trái cây tươi mát, chiết xuất từ tự nhiên
Màu sắc bắt mắt, không chói, sến, an toàn tuyệt đối
Không sợ lem, không sợ thấm, thỏa sức trang trí.', 0, 3)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (79, N'Kẹo Bi Đường Xanh Dương', N'Kẹo Bi Đường Mix Màu Xanh Dương là dòng kẹo dùng để trang trí bánh với nhiều màu sắc và kích thước viên to nhỏ khác nhau rất thích hợp để trang trí các món bánh ngọt, bánh lạnh, cupcake , và thức uống, món kem.

Cách sử dụng: Dùng để trang trí lên các dòng bánh ngọt, trang trí lên một số món thức uống…
Bảo quản: Nơi khô thoáng, tránh ẩm và ánh sáng mặt trời trực tiếp', CAST(54000 AS Decimal(18, 0)), 50, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fkeo-bi-mix-768x768.jpg?alt=media&token=c39ef9f6-06f5-4fd9-9ced-2627fd044873', 21, 1, CAST(0 AS Decimal(18, 0)), CAST(46000 AS Decimal(18, 0)), N'Khối lượng tịnh: 130g
', 0, 3)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (80, N'Mứt Mật Ong Đào Unifresh', N'Với khả năng ứng dụng cực cao, hàm lượng trái cây cao lên tới 55%, mứt trái cây UNIFRESH đang mang lại cơn sốt trong giới ngành bánh. Mứt Mật Ong Đào Unifresh dùng làm nhân bánh, trang trí bánh, kem lạnh, ăn kèm với bánh mì, sandwich…

Cách sử dụng: Dùng làm nhân bánh, kem lạnh, ăn kèm với bánh mì, sandwich,…
Bảo quản: Để ở nơi thoáng mát, tránh ánh nắng trực tiếp. Sau khi mở nắp, giữ lạnh và sử dụng trong thời gian ngắn
Xuất xứ: Việt Nam', CAST(35000 AS Decimal(18, 0)), 30, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmut-mat-ong-dao-595x595.jpg?alt=media&token=029ef5dc-a6e8-4b46-9371-dfa0c12a95d3', 22, 4, CAST(0 AS Decimal(18, 0)), CAST(30000 AS Decimal(18, 0)), N'Khối lượng tịnh: 350g
Thành phần: Đào, đường mạch nha, đường mía,…', 0, 3)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (81, N'Mứt  Dâu Tây Unifresh', N'Mứt  Dâu Tây Unifresh được ứng dụng rộng rãi, dùng nhân bánh, trang trí bánh, kem lạnh, ăn kèm với bánh mì, sandwich… Với khả năng ứng dụng cực cao, các loại mứt trái cây Unifresh đang mang lại cơn sốt trong giới ngành bánh.

Cách sử dụng: Dùng làm nhân bánh, kem lạnh, ăn kèm với bánh mì, sandwich,…
Bảo quản: Để ở nơi thoáng mát, tránh ánh nắng trực tiếp. Sau khi mở nắp, giữ lạnh và sử dụng trong thời gian ngắn
Xuất xứ: Việt Nam
', CAST(34000 AS Decimal(18, 0)), 59, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmut-dau-tay-595x595.jpg?alt=media&token=39503a43-a38c-4c6f-8b4c-ccc6fe8c901d', 22, 4, CAST(0 AS Decimal(18, 0)), CAST(27000 AS Decimal(18, 0)), N'Khối lượng tịnh: 350g
Thành phần: Dâu tây, đường mạch nha, đường mía, nước cốt dâu tây,…', 0, 3)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (82, N'Mứt Dứa Cao Cấp Unifresh', N'Với khả năng ứng dụng cực cao, hàm lượng trái cây cao lên tới 55%, mứt trái cây UNIFRESH đang mang lại cơn sốt trong giới ngành bánh. Mứt Dứa Cao Cấp Unifresh dùng làm nhân bánh, trang trí bánh, kem lạnh, ăn kèm với bánh mì, sandwich…

Cách sử dụng: Dùng làm nhân bánh, kem lạnh, ăn kèm với bánh mì, sandwich,…
Bảo quản: Để ở nơi thoáng mát, tránh ánh nắng trực tiếp. Sau khi mở nắp, giữ lạnh và sử dụng trong thời gian ngắn
Xuất xứ: Việt Nam', CAST(75000 AS Decimal(18, 0)), 70, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmuat-dua-cao-cap-570x570.jpg?alt=media&token=75410132-a22e-441a-8f3d-90f4006a6174', 22, 1, CAST(0 AS Decimal(18, 0)), CAST(63000 AS Decimal(18, 0)), N'Khối lượng tịnh: 950g
Thành phần: Dứa 45 – 55%, đường mạch nha, đường mía,…', 0, 3)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (83, N'Mứt Filling Táo Andros', N'Mứt Filling Táo Andros là sản phẩm mới thuộc dòng Andros Professional, được thiết kế riêng cho ngành làm bánh. Được đóng gói túi tiện lợi trong túi nhôm, tiết kiệm được thời gian chuẩn bị và mang đến hương vị ngon nhất.

Bảo quản: Nơi khô ráo, thoáng mát. Sau khi mở nắp, giữ lạnh và sử dụng trong thời gian ngắn
Sản phẩm của ANDROS
Cách sử dụng: Làm mứt nhân bánh hoặc topping cho bánh nướng, bánh lạnh', CAST(125000 AS Decimal(18, 0)), 58, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fmut-filling-andros-1.jpg?alt=media&token=e929b0a2-c374-47a5-a9e7-4312e7e11535', 22, 4, CAST(0 AS Decimal(18, 0)), CAST(119000 AS Decimal(18, 0)), N'Khối lượng tịnh: 1kg
Thành phần: Táo (40%), siro bắp có hàm lượng fructose cao, nước, đường, chất ổn định (1442, 415), chất điều chỉnh độ acid (330,331), chất chống oxi hóa (300), hương liệu táo giống tự nhiên, chất bảo quản (202), màu thực phẩm tự nhiên', 0, 3)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (84, N'Màu Wilton Lemon Yellow', N'Màu Wilton Lemon Yellow là sản phẩm màu dùng trong làm bánh, pha chế,… được nhiều người yêu thích sử dụng.

Cách sử dụng: Tạo màu trong làm bánh và pha chế,…
Bảo quản: Nơi khô thoáng, để nhiệt độ phòng và tránh tiếp xúc trực tiếp với ánh nắng mặt trời', CAST(65000 AS Decimal(18, 0)), 70, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Flemon-yellow-2-595x595.png?alt=media&token=da4a02c8-49b3-4c9a-8815-c12c6c3bf05e', 23, 2, CAST(0 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'Khối lượng tịnh: 28g
Màu sắc: Lemon Yellow
Thành phần: Nước, siro ngô hàm lượng fructose cao, siro ngô,…', 0, 5)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (85, N'Màu Wilton Sky Blue', N'Màu Wilton Sky Blue là sản phẩm màu dùng trong làm bánh, pha chế,… được nhiều người yêu thích sử dụng.

Cách sử dụng: Tạo màu trong làm bánh và pha chế,…
Bảo quản: Nơi khô thoáng, để nhiệt độ phòng và tránh tiếp xúc trực tiếp với ánh nắng mặt trời', CAST(65000 AS Decimal(18, 0)), 47, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fsky-blue-595x595.jpg?alt=media&token=2dc9ea42-73a5-44c1-b6a4-82d9afc90360', 23, 2, CAST(0 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'Khối lượng tịnh: 28g
Màu sắc: Sky Blue', 0, 5)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (86, N'Màu Wilton Red', N'Màu Wilton Red là sản phẩm màu dùng trong làm bánh, pha chế,… được nhiều người yêu thích sử dụng.

Cách sử dụng: Tạo màu trong làm bánh và pha chế,…
Bảo quản: Nơi khô thoáng, để nhiệt độ phòng và tránh tiếp xúc trực tiếp với ánh nắng mặt trời', CAST(65000 AS Decimal(18, 0)), 80, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fred-red-1-595x595.jpg?alt=media&token=9352747a-0839-42d3-868b-56d021c97680', 23, 2, CAST(0 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'Khối lượng tịnh: 28g
Màu sắc: Red Red
', 0, 5)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (87, N'Màu Wilton Black', N'Màu Wilton Black là sản phẩm màu dùng trong làm bánh, pha chế,… được nhiều người yêu thích sử dụng.

Cách sử dụng: Tạo màu trong làm bánh và pha chế,…
Bảo quản: Nơi khô thoáng, để nhiệt độ phòng và tránh tiếp xúc trực tiếp với ánh nắng mặt trời', CAST(65000 AS Decimal(18, 0)), 100, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fblack-595x595.jpg?alt=media&token=a67ea507-686a-4187-8820-fd2809cf742d', 23, 2, CAST(0 AS Decimal(18, 0)), CAST(60000 AS Decimal(18, 0)), N'Khối lượng tịnh: 28g
Màu sắc: Black
', 0, 5)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (88, N'Bột Hoa Đậu Biếc', N'Bột Hoa Đậu Biếc dùng tạo màu thành phần hoàn toàn từ tự nhiên, dùng tạo màu cho các món ăn, món bánh,…

Cách sử dụng: Dùng chế biến các món xôi, chè, bánh, kem, thạch, đồ uống,…
Sản xuất: Công ty Cổ phần Chợ Quê Việt Nam', CAST(55000 AS Decimal(18, 0)), 50, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbot-hoa-dau-biec-1-595x595.jpg?alt=media&token=e96e4d50-ec49-4eb0-b8fb-61f367dc4c14', 23, 6, CAST(0 AS Decimal(18, 0)), CAST(48000 AS Decimal(18, 0)), N'Khối lượng tịnh: 50g
Thành phần: Hoa đậu biếc khô', 0, 1)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (89, N'Bột Lá Nếp – Lá Dứa', N'Bột Lá Nếp – Lá Dứa sử dụng để tạo màu xanh cốm tự nhiên cho các món ăn: xôi, mứt dừa, bánh chưng, bánh trung thu, bánh trôi, bánh kẹo, thạch, pha chế trà sữa,….

Cách sử dụng: Tạo màu cho xôi, mứt dừa, bánh chưng, bánh trung thu, bánh trôi, bánh kẹo, thạch, pha chế trà sữa,….
Bảo quản: Nơi khô ráo, thoáng mát
Sản xuất: Công ty Cổ phần Chợ Quê Việt Nam', CAST(35000 AS Decimal(18, 0)), 40, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fbot-la-nep-la-dua-595x595.png?alt=media&token=470d8221-f8fb-42c1-947a-b4dbe0ec62ff', 3, 6, CAST(0 AS Decimal(18, 0)), CAST(32000 AS Decimal(18, 0)), N'Khối lượng tịnh: 50g
Thành phần: Lá nếp nguyên chất 100%', 0, 1)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (90, N'Bàn Xoay Inox', N'Bàn Xoay Inox dùng làm bàn xoay làm bánh kem, chất liệu tốt và dễ dàng vệ sinh.
Sau khi làm xong bánh gato, bạn đặt cốt bánh lên bàn xoay sau đó dùng các đồ làm bánh khác như đui bắt bông kem…để trang trí.', CAST(320000 AS Decimal(18, 0)), 3, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fban-xoay-inox-595x595.jpg?alt=media&token=d3c521f2-f368-40e9-be57-b9ea423bd693', 24, 5, CAST(3200 AS Decimal(18, 0)), CAST(300000 AS Decimal(18, 0)), N'Chất liệu: Inox
Màu sắc: Bạc', 0, 7)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (91, N'Bàn Xoay Thủy Tinh', N'Bàn Xoay Thủy Tinh được dùng làm bàn xoay để trang trí bánh kem, bàn xoay bằng chất liệu thủy tinh nên dễ vệ sinh sau khi sử dụng.

Xuất xứ: Trung Quốc
', CAST(250000 AS Decimal(18, 0)), 6, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fban-xoay-thuy-tinh-8181-570x432.jpg?alt=media&token=ac82493a-c9a0-471a-ad6d-3c34faf1da17', 24, 6, CAST(0 AS Decimal(18, 0)), CAST(230000 AS Decimal(18, 0)), N'Tên sản phẩm: Bàn Xoay Thủy Tinh
Chất liệu: thủy tinh+ chân nhựa
Đường kính: 30cm , chiều cao : 10cm
', 0, 7)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (92, N'Cây Đo Nhiệt Độ PVC', N'Cây Đo Nhiệt Độ PVC dùng để đo nhiệt độ chất lỏng.
Xuất xứ: Trung Quốc

Chức năng phím:
Bật/Tắt: Chức năng chuyển đổi
℃/: Ở trạng thái nhiệt độ hiển thị, nhấn nút này để thực hiện chức năng chuyển đổi ℃/.
Phím giữ: ở trạng thái nhiệt độ hiển thị, nhấn nút này để giữ giá trị hiển thị của LCD ở trạng thái giữ và nhấn lại.
Khi phát hiện nhiệt độ được khôi phục. Khi chức năng giữ được thực hiện, giữ phù hợp với màn hình LCD.

Sạch sẽ và an toàn, một mặt hàng hoàn hảo để kiểm tra nhiệt độ của thực phẩm, đặc biệt là BBQ.

 
Di động, rất nhẹ, dễ dàng mang đi mọi nơi, đi dã ngoại, đến BBQ, sử dụng đơn giản.

 
Cấu trúc loại bút, tất cả các đầu dò bằng thép không gỉ, độ chính xác cao, đo nhiệt độ nhanh.

Nó có nhiều chức năng, chẳng hạn như chuyển đổi ℃/℉, điện lạnh, sưởi ấm và sử dụng trong nhà bếp gia đình.
LCD cho thấy Phạm vi đo tăng lên rất nhiều và độ ổn định cao.
Sử dụng: Được sử dụng cho các tình huống khác nhau cần đo nhiệt độ, v. v.', CAST(36000 AS Decimal(18, 0)), 37, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fnhiet-ke-768x768.jpg?alt=media&token=1f654bbf-ef44-4f02-baba-fa2736d19c83', 24, 6, CAST(0 AS Decimal(18, 0)), CAST(30000 AS Decimal(18, 0)), N'Màu đen
Mẫu: pt101
Loại: Nhiệt kế thực phẩm (điện tử)
Kích thước: 22.6*2 cm/8.9*0.79"
Khối lượng: 0.04 kg
Phạm vi Độ ẩm: không ẩm kế
Phạm vi nhiệt độ:-50 ~ + 300 ℃ (-58''f ~ + 572''f)
Lớp chính xác: ± 1,5 ℃
Phạm vi áp dụng: Đo nhiệt độ chất lỏng và thực phẩm', 0, 10)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (93, N'Kem Béo Pha Chế', N'Sản phẩm Kem Béo Pha Chế là dòng kem đa năng dành riêng cho ngành pha chế. Với tính ổn định cao, hương vị kem nguyên bản được ưu tiên hàng đầu và hơn hết, kem pha chế có độ béo, mịn cao nên rất thích hợp với các công thức pha chế thức uống như: Trà sữa, thức uống đá xay hay làm milk foam,… Đặc biệt hơn, sản phẩm còn có những ưu điểm nổi bật:

Ưu điểm của Kem Béo Pha Chế 
Vị kem béo ngậy, lôi cuốn, tan nhanh trong miệng.
Độ ổn định cao.
Nâng cao vị nguyên bản của kem béo, nên dễ kết hợp cùng nhiều nguyên liệu khác nhau.

Cách sử dụng Kem Béo Pha Chế
Xả đông trong tủ mát ở nhiệt độ 2 độ C. – 7 độ C trước khi sử dụng.
Lắc đều trước khi mở.
Sản phẩm sau khi đã xả đông phải bảo quản trong tủ lạnh.
Sử dụng sản phẩm làm nguyên liệu trong các công thức pha chế thức uống, trà, cafe, thức uống đá xay,…

Bảo quản:
Cấp đông, bảo quản 18 tháng theo dữ liệu sản xuất.
Ngăn mát: 15 ngày chưa mở nắp hộp và 5 ngày nếu đã mở nắp hộp.', CAST(30000 AS Decimal(18, 0)), 48, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fkem-beo-pha-che-1-570x570.jpg?alt=media&token=9f2a501b-63a3-43f5-9e31-e38814e6e76a', 25, 7, CAST(0 AS Decimal(18, 0)), CAST(24000 AS Decimal(18, 0)), N'Khối lượng tịnh: 500g
Thành phần: Nước, dầu cọ hydro hoá, đường maltodextrin, si rô bắp, đường dextrose, chất dẫn xuất từ sữa sodium caseinate, chất nhũ hoá (INS 471, INS 435, INS 491, INS 481 (i)), muối, chất ổn định (INS 339, INS 340 (ii)), hưỡng sữa tổng hợp, chất làm dày (INS 415), màu thực phẩm carotene tự nhiên (INS 160a(ii)).', 0, 6)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (94, N'Kem Béo Thực Vật', N'Sản phẩm Kem Béo Thực Vật (hay còn gọi là Kem Béo Lùn) là dòng nguyên liệu có thể sử dụng thay thế sữa, dùng trong pha chế cà phê, trà, các món tráng miệng, đặc biệt thích hợp để làm món súp kem chuẩn vị thơm ngon. Kem béo thực vật được ưa chuộng bởi kem có vị béo đặc biệt và tan nhanh trong miệng sau khi thưởng thức. Về tính năng, sản phẩm còn có thể đánh bông như kem topping giúp thỏa sức chế biến các công thức nấu ăn, pha chế hay làm bánh,…

Bạn có thể sử dụng Kem Béo Thực Vật để:

– Tăng hương vị cho công thức pha chế các loại cà phê hoặc trà sữa.
– Tăng thêm chất béo thực vật trong sinh tố hoặc các loại thức uống không cồn.
– Sử dụng trong nấu trà sữa, các loại sữa ngũ cốc, sữa trái cây hoặc các loại chè ngọt
– Là nguyên liệu để làm lớp phủ ganache trở nên bóng đẹp hơn, phù hợp trong nhiều công thức làm bánh.

Cách sử dụng Kem Béo Thực Vật
Xả đông trong tủ mát ở nhiệt độ 2 độ C. – 7 độ C trước khi sử dụng.
Lắc đều trước khi mở.
Sản phẩm sau khi đã xả đông phải bảo quản trong tủ lạnh.

Cách bảo quản: Lưu giữ ở nhiệt độ -18 độ C.
', CAST(29000 AS Decimal(18, 0)), 146, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fkem-beo-thuc-vat-500g.png?alt=media&token=50987e34-3beb-4078-b799-b8eb99377ab2', 25, 1, CAST(0 AS Decimal(18, 0)), CAST(15000 AS Decimal(18, 0)), N'Khối lượng tịnh: 500g
Thành phần: Nước, dầu cọ hydro hóa, syrô bắp, sodium caseinate (chất dẫn xuất từ sữa), chất nhũ hóa (Mono và Diglycerides(471), sodium Stearolyl Lactylate(481), polysorbate 60(435), chất làm đặc, muối và hương thực phẩm.', 0, 6)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (95, N'Kem Trang Trí Bánh Tulip', N'Sản phẩm Kem Trang Trí Bánh Tulip chuyên dùng cho trang trí bánh kem, làm nhân các loại bánh, kem ly, chè, các món tráng miệng, đồ uống…với những ưu điểm sau:
Hương vị đậm đà.
Độ bền vượt trội.
Độ nở cao.
Độ ẩm tốt.

Được phép sử dụng cho người ăn kiêng.

Cách sử dụng Kem Trang Trí Bánh Tulip
Xả đông trong tủ mát ở nhiệt độ 2 độ C. – 7 độ C trong khoảng thời gian từ 12-24 giờ trước khi sử dụng.
Lắc đều trước khi mở.
Cho nguyên liệu vào thố để lạnh (không quá 20% sức chứa của thố).
Đánh kem ở tốc độ trung bình cho đến khi kem nổi lên đạt độ cứng, độ bóng vừa ý. Cách đánh khác nhau tùy thuộc vào mục đích sử dụng kem.( Không đánh kem ở tốc độ cao khi kem còn đá).

Sản phẩm sau khi đã đánh phải bảo quản lạnh hoặc trữ đông.

Cách bảo quản: Lưu giữ ở nhiệt độ -18 độ C.
', CAST(50000 AS Decimal(18, 0)), 90, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2FKem-Tulip.jpeg?alt=media&token=b56d8d7c-7aef-4d65-b1b3-68b560ac2be7', 25, 8, CAST(0 AS Decimal(18, 0)), CAST(41000 AS Decimal(18, 0)), N'Khối lượng tịnh: 1kg
Thành phần: Nước, dầu cọ đã một phần hydro hóa, đường dextrose, đạm đậu nành, đường, sodium caseinate ( chất dẫn xuất từ sữa), chất nhũ hóa( Polysorbate 60, Sodium Stearoyl Lactylate (481)), chất làm đặc ( methylcellulose (461)), xanthan gum(415), muối, hương tổng hợp.', 0, 6)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (96, N'Khay Gỗ Tròn', N' –  Khay gỗ tròn pizza thiết kế dáng tròn, tay cầm hiện đại, tiện lợi trong quá trình sử dụng.
 – Sản phẩm sử dụng chất liệu sơn gỗ cao cấp, không độc hại khi sử dụng
 – Dùng để trưng bày, decor, đế bánh pizza, bánh mì, bánh ngọt…..', CAST(100000 AS Decimal(18, 0)), 0, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fkhay-go-tron-570x570.jpg?alt=media&token=e8ea5495-b1e8-4124-9602-2fbff85d085b', 26, 5, CAST(0 AS Decimal(18, 0)), CAST(85000 AS Decimal(18, 0)), N'Màu sắc: Màu gỗ
Chất liệu: Gỗ
Kích thước: Đường kính khay 26cm', 0, 7)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (97, N'Kệ Bánh 4005MD', N'Để giúp không gian bữa tiệc của bạn trở nên sang trọng, lung linh, sinh động hơn… Whisk and Flourish sẽ mang đến cho bạn những mẫu khay – kệ đựng bánh từ đáng yêu đến sang trọng, độc đáo. Khay bánh không chỉ giúp bảo quản bánh ngọt, bánh gato tươi ngon mỗi ngày mà còn decor rất là đẹp nữa.

Khay – Kệ đựng bánh được thiết kế với tông màu sang trọng, nắp đậy trong suốt thấy rõ những chiếc bánh xinh xinh bên trong, sáng tạo nhiều kiểu dáng từ chất liệu gỗ, nhựa cao cấp… cho bạn nhiều sự lựa chọn theo sở thích ưng ý của mình.

Xuất xứ: Trung Quốc', CAST(400000 AS Decimal(18, 0)), 6, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fke-banh-4005MD-420K-01-570x597.jpg?alt=media&token=0b136246-4d95-4b67-b93a-d3279b7b99eb', 26, 6, CAST(0 AS Decimal(18, 0)), CAST(370000 AS Decimal(18, 0)), N'Chất liệu: nhựa mica + gỗ', 0, 7)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (98, N'Kệ Bánh Nhựa Đế Vàng', N'Khay – Kệ đựng bánh được thiết kế với tông màu sang trọng, nắp đậy trong suốt thấy rõ những chiếc bánh xinh xinh bên trong, sáng tạo nhiều kiểu dáng từ chất liệu gỗ, nhựa cao cấp… cho bạn nhiều sự lựa chọn theo sở thích ưng ý của mình.

Xuất xứ: Trung Quốc', CAST(200000 AS Decimal(18, 0)), 7, N'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2Fke-banh-nhua-de-vang-4175p-420k-570x533.jpg?alt=media&token=11712b6a-d3d7-48dd-aa83-e1709dfb8d30', 26, 6, CAST(0 AS Decimal(18, 0)), CAST(180000 AS Decimal(18, 0)), N'Chất liệu: nhựa mica', 0, 7)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (99, N'Máy đánh trứng', NULL, CAST(19 AS Decimal(18, 0)), 0, NULL, 3, 1, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, 1, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (100, N'Máy đánh trứng', NULL, CAST(123 AS Decimal(18, 0)), 0, NULL, 3, 1, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, 1, NULL)
INSERT [dbo].[SanPham] ([Id_DungCu], [TenDungCu], [MoTa], [Gia], [SoLuong], [HinhAnh], [Id_LoaiDungCu], [Id_NhaCungCap], [GiaKhuyenMai], [GiaNhap], [ThongTin], [DaXoa], [Id_NhaSanXuat]) VALUES (101, N'Bot banh', NULL, CAST(20000 AS Decimal(18, 0)), 0, NULL, 19, 3, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, 1, 2)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPhamYeuThich] ON 

INSERT [dbo].[SanPhamYeuThich] ([Id_SPYT], [Id_KhachHang], [Id_SanPham]) VALUES (2, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', 94)
INSERT [dbo].[SanPhamYeuThich] ([Id_SPYT], [Id_KhachHang], [Id_SanPham]) VALUES (3, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', 64)
INSERT [dbo].[SanPhamYeuThich] ([Id_SPYT], [Id_KhachHang], [Id_SanPham]) VALUES (8, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', 96)
INSERT [dbo].[SanPhamYeuThich] ([Id_SPYT], [Id_KhachHang], [Id_SanPham]) VALUES (16, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', 91)
INSERT [dbo].[SanPhamYeuThich] ([Id_SPYT], [Id_KhachHang], [Id_SanPham]) VALUES (17, N'Ui3jqdolDjgRDOTZdVA3E7S9O0v2', 40)
INSERT [dbo].[SanPhamYeuThich] ([Id_SPYT], [Id_KhachHang], [Id_SanPham]) VALUES (18, N'tyDutpwXXYOKSf1RlE9ETUICvRw2', 96)
SET IDENTITY_INSERT [dbo].[SanPhamYeuThich] OFF
GO
INSERT [dbo].[TrangThaiVanChuyen] ([Id_TrangThai], [TenTrangThai]) VALUES (0, N'Đang chuẩn bị hàng')
INSERT [dbo].[TrangThaiVanChuyen] ([Id_TrangThai], [TenTrangThai]) VALUES (1, N'Đang giao hàng')
INSERT [dbo].[TrangThaiVanChuyen] ([Id_TrangThai], [TenTrangThai]) VALUES (2, N'Đã giao hàng')
INSERT [dbo].[TrangThaiVanChuyen] ([Id_TrangThai], [TenTrangThai]) VALUES (3, N'Đã huỷ')
GO
/****** Object:  Index [UQ_Id_Banner]    Script Date: 07/07/2024 5:01:46 CH ******/
ALTER TABLE [dbo].[Banner] ADD  CONSTRAINT [UQ_Id_Banner] UNIQUE NONCLUSTERED 
(
	[Id_Banner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_CTDH_DH] FOREIGN KEY([Id_DonHang])
REFERENCES [dbo].[DonHang] ([Id_DonHang])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_CTDH_DH]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_CTDH_SP] FOREIGN KEY([Id_DungCu])
REFERENCES [dbo].[SanPham] ([Id_DungCu])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_CTDH_SP]
GO
ALTER TABLE [dbo].[ChiTietKhuyenMai]  WITH CHECK ADD  CONSTRAINT [ChiTietKhuyenMai_KhuyenMai_Id_KhuyenMai_fk] FOREIGN KEY([Id_KhuyenMai])
REFERENCES [dbo].[KhuyenMai] ([Id_KhuyenMai])
GO
ALTER TABLE [dbo].[ChiTietKhuyenMai] CHECK CONSTRAINT [ChiTietKhuyenMai_KhuyenMai_Id_KhuyenMai_fk]
GO
ALTER TABLE [dbo].[ChiTietKhuyenMai]  WITH CHECK ADD  CONSTRAINT [ChiTietKhuyenMai_SanPham_Id_DungCu_fk] FOREIGN KEY([Id_SanPham])
REFERENCES [dbo].[SanPham] ([Id_DungCu])
GO
ALTER TABLE [dbo].[ChiTietKhuyenMai] CHECK CONSTRAINT [ChiTietKhuyenMai_SanPham_Id_DungCu_fk]
GO
ALTER TABLE [dbo].[CTHDNhapHang]  WITH CHECK ADD  CONSTRAINT [CTHDNhapHang_HoaDonNhapHang_Id_HoaDonNhap_fk] FOREIGN KEY([Id_HoaDonNhap])
REFERENCES [dbo].[HoaDonNhapHang] ([Id_HoaDonNhap])
GO
ALTER TABLE [dbo].[CTHDNhapHang] CHECK CONSTRAINT [CTHDNhapHang_HoaDonNhapHang_Id_HoaDonNhap_fk]
GO
ALTER TABLE [dbo].[CTHDNhapHang]  WITH CHECK ADD  CONSTRAINT [CTHDNhapHang_SanPham_Id_DungCu_fk] FOREIGN KEY([Id_SanPham])
REFERENCES [dbo].[SanPham] ([Id_DungCu])
GO
ALTER TABLE [dbo].[CTHDNhapHang] CHECK CONSTRAINT [CTHDNhapHang_SanPham_Id_DungCu_fk]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [DonHang_MaGiamGia_Id_MaGiamGia_fk] FOREIGN KEY([Id_MaGiamGia])
REFERENCES [dbo].[MaGiamGia] ([Id_MaGiamGia])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [DonHang_MaGiamGia_Id_MaGiamGia_fk]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_PhuongThucThanhToan] FOREIGN KEY([PhuongThucThanhToan])
REFERENCES [dbo].[PhuongThucThanhToan] ([Id_PTTT])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_PhuongThucThanhToan]
GO
ALTER TABLE [dbo].[DonHangVanChuyen]  WITH CHECK ADD  CONSTRAINT [FK_DHVC_DH] FOREIGN KEY([Id_DonHang])
REFERENCES [dbo].[DonHang] ([Id_DonHang])
GO
ALTER TABLE [dbo].[DonHangVanChuyen] CHECK CONSTRAINT [FK_DHVC_DH]
GO
ALTER TABLE [dbo].[DonHangVanChuyen]  WITH CHECK ADD  CONSTRAINT [FK_DonHangVanChuyen_PhuongThucThanhToan] FOREIGN KEY([PhuongThucThanhToan])
REFERENCES [dbo].[PhuongThucThanhToan] ([Id_PTTT])
GO
ALTER TABLE [dbo].[DonHangVanChuyen] CHECK CONSTRAINT [FK_DonHangVanChuyen_PhuongThucThanhToan]
GO
ALTER TABLE [dbo].[DonHangVanChuyen]  WITH CHECK ADD  CONSTRAINT [FK_DonHangVanChuyen_TrangThai] FOREIGN KEY([TinhTrang])
REFERENCES [dbo].[TrangThaiVanChuyen] ([Id_TrangThai])
GO
ALTER TABLE [dbo].[DonHangVanChuyen] CHECK CONSTRAINT [FK_DonHangVanChuyen_TrangThai]
GO
ALTER TABLE [dbo].[HoaDonNhapHang]  WITH CHECK ADD  CONSTRAINT [HoaDonNhapHang_NhaCungCap_Id_NhaCungCap_fk] FOREIGN KEY([Id_NhaCungCap])
REFERENCES [dbo].[NhaCungCap] ([Id_NhaCungCap])
GO
ALTER TABLE [dbo].[HoaDonNhapHang] CHECK CONSTRAINT [HoaDonNhapHang_NhaCungCap_Id_NhaCungCap_fk]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_DungCu_NhaCungCap] FOREIGN KEY([Id_NhaCungCap])
REFERENCES [dbo].[NhaCungCap] ([Id_NhaCungCap])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_DungCu_NhaCungCap]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_LoaiSanPham] FOREIGN KEY([Id_LoaiDungCu])
REFERENCES [dbo].[LoaiSanPham] ([Id_LoaiDungCu])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_LoaiSanPham]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [SanPham_NhaSanXuat_Id_NhaSanXuat_fk] FOREIGN KEY([Id_NhaSanXuat])
REFERENCES [dbo].[NhaSanXuat] ([Id_NhaSanXuat])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [SanPham_NhaSanXuat_Id_NhaSanXuat_fk]
GO
ALTER TABLE [dbo].[SanPhamYeuThich]  WITH CHECK ADD  CONSTRAINT [SanPhamYeuThich_KhachHang_Id_KhachHang_fk] FOREIGN KEY([Id_KhachHang])
REFERENCES [dbo].[KhachHang] ([Id_KhachHang])
GO
ALTER TABLE [dbo].[SanPhamYeuThich] CHECK CONSTRAINT [SanPhamYeuThich_KhachHang_Id_KhachHang_fk]
GO
ALTER TABLE [dbo].[SanPhamYeuThich]  WITH CHECK ADD  CONSTRAINT [SanPhamYeuThich_SanPham_Id_DungCu_fk] FOREIGN KEY([Id_SanPham])
REFERENCES [dbo].[SanPham] ([Id_DungCu])
GO
ALTER TABLE [dbo].[SanPhamYeuThich] CHECK CONSTRAINT [SanPhamYeuThich_SanPham_Id_DungCu_fk]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Command' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'checkTab', @level2type=N'COLUMN',@level2name=N'Username'
GO
