using WebDungCuLamBanh.DTOs.Banner;
using WebDungCuLamBanh.DTOs.Cart;
using WebDungCuLamBanh.DTOs.CheckTab;
using WebDungCuLamBanh.DTOs.Customer;
using WebDungCuLamBanh.DTOs.GoodsReceipt;
using WebDungCuLamBanh.DTOs.Manufacturer;
using WebDungCuLamBanh.DTOs.Order;
using WebDungCuLamBanh.DTOs.Product;
using WebDungCuLamBanh.DTOs.Staff;
using WebDungCuLamBanh.DTOs.Supplier;
using WebDungCuLamBanh.DTOs.Voucher;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.DTOs.Mappings;

public static class MappingExtensions
{
    // Product
    public static ProductDto ToDto(this DungCuModel entity) => new()
    {
        Id_DungCu = entity.Id_DungCu,
        TenDungCu = entity.TenDungCu ?? string.Empty,
        HinhAnh = entity.HinhAnh,
        Gia = entity.Gia,
        GiaKhuyenMai = entity.GiaKhuyenMai,
        GiaNhap = entity.GiaNhap,
        SoLuong = entity.SoLuong,
        MoTa = entity.MoTa,
        Id_LoaiDungCu = entity.Id_LoaiDungCu,
        TenLoaiDungCu = entity.LoaiDungCu?.TenLoaiDungCu,
        Id_NhaCungCap = entity.Id_NhaCungCap,
        TenNhaCungCap = entity.NhaCungCap?.TenNhaCungCap,
        Id_NhaSanXuat = entity.Id_NhaSanXuat,
        TenNhaSanXuat = entity.NhaSanXuat?.TenNSX,
        DaXoa = entity.DaXoa
    };

    public static DungCuModel ToEntity(this CreateProductDto dto) => new()
    {
        TenDungCu = dto.TenDungCu,
        Gia = dto.Gia,
        GiaKhuyenMai = dto.GiaKhuyenMai,
        GiaNhap = dto.GiaNhap,
        SoLuong = dto.SoLuong,
        MoTa = dto.MoTa,
        Id_LoaiDungCu = dto.Id_LoaiDungCu,
        Id_NhaCungCap = dto.Id_NhaCungCap,
        Id_NhaSanXuat = dto.Id_NhaSanXuat,
        DaXoa = 0
    };

    // Category
    public static CategoryDto ToDto(this LoaiDungCuModel entity) => new()
    {
        Id_LoaiDungCu = entity.Id_LoaiDungCu,
        TenLoaiDungCu = entity.TenLoaiDungCu ?? string.Empty
    };

    // Customer
    public static CustomerDto ToDto(this KhachHangModel entity) => new()
    {
        Id_KhachHang = entity.Id_KhachHang ?? string.Empty,
        TenKhachHang = entity.TenKhachHang,
        Email = entity.Email,
        DiaChi = entity.DiaChi,
        SoDienThoai = entity.SoDienThoai,
        DiemThuong = entity.DiemThuong
    };

    public static KhachHangModel ToEntity(this CreateCustomerDto dto) => new()
    {
        Id_KhachHang = dto.Id_KhachHang,
        TenKhachHang = dto.TenKhachHang,
        Email = dto.Email,
        DiaChi = dto.DiaChi,
        SoDienThoai = dto.SoDienThoai
    };

    // Supplier
    public static SupplierDto ToDto(this NhaCungCapModel entity) => new()
    {
        Id_NhaCungCap = entity.Id_NhaCungCap,
        TenNhaCungCap = entity.TenNhaCungCap ?? string.Empty,
        DiaChi = entity.DiaChi,
        SoDienThoai = entity.SoDienThoai,
        Email = entity.Email
    };

    public static NhaCungCapModel ToEntity(this CreateSupplierDto dto) => new()
    {
        TenNhaCungCap = dto.TenNhaCungCap,
        DiaChi = dto.DiaChi,
        SoDienThoai = dto.SoDienThoai,
        Email = dto.Email
    };

    // Manufacturer
    public static ManufacturerDto ToDto(this NhaSanXuatModel entity) => new()
    {
        Id_NhaSanXuat = entity.Id_NhaSanXuat,
        TenNSX = entity.TenNSX ?? string.Empty,
        DiaChi = entity.DiaChi,
        Email = entity.Email
    };

    public static NhaSanXuatModel ToEntity(this CreateManufacturerDto dto) => new()
    {
        TenNSX = dto.TenNSX,
        DiaChi = dto.DiaChi,
        Email = dto.Email
    };

    // Staff
    public static StaffDto ToDto(this AdminModel entity) => new()
    {
        TenNguoiDung = entity.TenNguoiDung,
        Quyen = entity.Quyen,
        Ten = entity.Ten,
        Email = entity.Email,
        DiaChi = entity.DiaChi,
        SoDienThoai = entity.SoDienThoai
    };

    public static AdminModel ToEntity(this CreateStaffDto dto) => new()
    {
        TenNguoiDung = dto.TenNguoiDung,
        MatKhau = dto.MatKhau,
        Quyen = dto.Quyen ?? 0,
        Ten = dto.Ten,
        Email = dto.Email,
        DiaChi = dto.DiaChi,
        SoDienThoai = dto.SoDienThoai
    };

    // Goods Receipt
    public static GoodsReceiptDto ToDto(this HoaDonNhapHangModel entity) => new()
    {
        Id_HoaDonNhap = entity.Id_HoaDonNhap,
        Id_NhaCungCap = entity.Id_NhaCungCap,
        TenNhaCungCap = entity.NhaCungCap?.TenNhaCungCap,
        NgayLapHoaDon = entity.NgayLapHoaDon,
        NgayNhapHang = entity.NgayNhapHang,
        NhanVienLap = entity.NhanVienLap,
        TongTien = entity.TongTien,
        TrangThai = entity.TrangThai
    };

    public static GoodsReceiptDetailDto ToDto(this CTHDNhapHangModel entity) => new()
    {
        Id_CTHDNhapHang = entity.Id_CTHDNhapHang,
        Id_HoaDonNhap = entity.Id_HoaDonNhap,
        Id_SanPham = entity.Id_SanPham,
        TenSanPham = entity.SanPham?.TenDungCu,
        SoLuong = entity.SoLuong,
        DonGia = entity.DonGia,
        GiaTien = entity.GiaTien
    };

    // Banner
    public static BannerDto ToDto(this BannerModel entity) => new()
    {
        Id_Banner = entity.Id_Banner,
        TenBanner = entity.TenBanner,
        DuongDan = entity.DuongDan,
        LienKet = entity.LienKet
    };

    // Voucher
    public static VoucherDto ToDto(this MaGiamGiaModel entity) => new()
    {
        Id_MaGiamGia = entity.Id_MaGiamGia,
        TenMaGiamGia = entity.TenMaGiamGia,
        GiaTriGiam = entity.GiaTriGiam,
        LuotSuDung = entity.LuotSuDung
    };

    // CheckTab
    public static CheckTabDto ToDto(this WebDungCuLamBanh.Models.CheckTab entity) => new()
    {
        Id = entity.Id ?? 0,
        Username = entity.Username,
        Command = entity.Command
    };

    public static WebDungCuLamBanh.Models.CheckTab ToEntity(this CreateCheckTabDto dto) => new()
    {
        Username = dto.Username,
        Command = dto.Command
    };

    // Cart / Order
    public static CartItemDto ToCartItemDto(this ChiTietDonHangModel entity) => new()
    {
        Id_ChiTietDonHang = entity.Id_ChiTietDonHang,
        Id_DonHang = entity.Id_DonHang,
        Id_DungCu = entity.Id_DungCu,
        TenDungCu = entity.DungCu?.TenDungCu,
        HinhAnh = entity.DungCu?.HinhAnh,
        SoLuong = entity.SoLuong,
        DonGia = entity.DonGia
    };

    public static OrderDetailDto ToOrderDetailDto(this ChiTietDonHangModel entity) => new()
    {
        Id_ChiTietDonHang = entity.Id_ChiTietDonHang,
        Id_DonHang = entity.Id_DonHang,
        Id_DungCu = entity.Id_DungCu,
        TenDungCu = entity.DungCu?.TenDungCu,
        HinhAnh = entity.DungCu?.HinhAnh,
        SoLuong = entity.SoLuong,
        DonGia = entity.DonGia
    };

    public static OrderDto ToDto(this DonHangModel entity) => new()
    {
        Id_DonHang = entity.Id_DonHang ?? string.Empty,
        Id_KhachHang = entity.Id_KhachHang,
        TenKhachHang = entity.KhachHang?.TenKhachHang,
        EmailKhachHang = entity.KhachHang?.Email,
        SoDienThoai = entity.KhachHang?.SoDienThoai,
        DiaChiNhanHang = entity.KhachHang?.DiaChi,
        NgayDat = entity.NgayDat,
        TongTien = entity.TongTien,
        TienGiamGia = entity.TienGiamGia,
        PhiVanChuyen = entity.PhiVanChuyen,
        TrangThai = entity.TrangThai,
        Id_PhuongThucThanhToan = entity.Id_PhuongThucThanhToan,
        TenPTTT = entity.PhuongThucThanhToan?.TenPTTT
    };
}
