using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }
        public DbSet<KhachHangModel> KhachHangs { get; set; }
        public DbSet<DungCuModel> DungCus { get; set; }
        public DbSet<LoaiDungCuModel> LoaiDungCus { get; set; }
        public DbSet<DonHangModel> DonHangs { get; set; }
        public DbSet<ChiTietDonHangModel> ChiTietDonHangs { get; set; }

        public DbSet<AdminModel> Admins { get; set; }
        public DbSet<NhaCungCapModel> NhaCungCaps { get; set; }
        public DbSet<DonHangVanChuyenModel> DonHangVanChuyens { get; set; }
        public DbSet<PTTTModel> PTTTs { get; set; }
        public DbSet<MaGiamGiaModel> MaGiamGias { get; set; }

        public DbSet<KhuyenMaiModel> KhuyenMai2s { get; set; }
        public DbSet<ChiTietKhuyenMaiModel> ChiTietKhuyenMais { get; set; }

        public DbSet<CuocVanChuyenModel> CuocVanChuyens { get; set; }
        public DbSet<TrangThaiVanChuyenModel> TrangThaiVanChuyens { get; set; }
        public DbSet<PTTTModel> PhuongThucThanhToans { get; set; }
        public DbSet<BannerModel> Banners { get; set; }

        public DbSet<HoaDonNhapHangModel> HoaDonNhapHangs { get; set; }
        public DbSet<CTHDNhapHangModel> ChiTietHoaDonNhapHangs { get; set; }
        public DbSet<CheckTab> CheckTabs { get; set; }
        public DbSet<YeuThichModel> YeuThichs { get; set; }
        public DbSet<NhaSanXuatModel> NhaSanXuats { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            foreach (var property in modelBuilder.Model.GetEntityTypes()
                .SelectMany(t => t.GetProperties())
                .Where(p => p.ClrType == typeof(decimal)))
            {
                property.SetColumnType("decimal(18, 0)");
            };

            _ = modelBuilder.Entity<DungCuModel>()
                .HasOne(p => p.LoaiDungCu)
                .WithMany()
                .HasForeignKey(p => p.Id_LoaiDungCu);
            _ = modelBuilder.Entity<DungCuModel>()
                .HasOne(p => p.NhaCungCap)
                .WithMany()
                .HasForeignKey(p => p.Id_NhaCungCap);
            _ = modelBuilder.Entity<DungCuModel>()
                .HasOne(p => p.NhaSanXuat)
                .WithMany()
                .HasForeignKey(p => p.Id_NhaSanXuat);
            _ = modelBuilder.Entity<DungCuModel>(entity =>
            {
                entity.Property(e => e.Gia).HasPrecision(18, 0);
            });
            _ = modelBuilder.Entity<DungCuModel>(entity =>
            {
                entity.Property(e => e.GiaKhuyenMai).HasPrecision(18, 0);
            });
            _ = modelBuilder.Entity<DungCuModel>(entity =>
            {
                entity.Property(e => e.GiaNhap).HasPrecision(18, 0);
            });
            
            ///////////////////////////////////Đơn hàng/////////////////////////

            _ = modelBuilder.Entity<DonHangModel>()
                .HasOne(p => p.KhachHang)
                .WithMany()
                .HasForeignKey(p => p.Id_KhachHang);
            _ = modelBuilder.Entity<DonHangModel>()
                .HasOne(p => p.PhuongThucThanhToan)
                .WithMany()
                .HasForeignKey(p => p.Id_PhuongThucThanhToan);

            _ = modelBuilder.Entity<DonHangModel>()
                .HasOne(p => p.GiamGia)
                .WithMany()
                .HasForeignKey(p => p.Id_MaGiamGia);
            _ = modelBuilder.Entity<DonHangModel>(entity =>
            {
                entity.Property(e => e.PhiVanChuyen).HasPrecision(18, 2);
            });
            _ = modelBuilder.Entity<DonHangModel>(entity =>
            {
                entity.Property(e => e.TongTien).HasPrecision(18, 2);
            });
            _ = modelBuilder.Entity<DonHangModel>(entity =>
            {
                entity.Property(e => e.TienDiemThuong).HasPrecision(18, 2);
            });
            _ = modelBuilder.Entity<DonHangModel>(entity =>
            {
                entity.Property(e => e.TienGiamGia).HasPrecision(18, 2);
            });
            _ = modelBuilder.Entity<DonHangModel>(entity =>
            {
                entity.Property(e => e.VAT).HasPrecision(18, 2);
            });

            ////////////////////////////////////////////////////////////////////
            _ = modelBuilder.Entity<ChiTietDonHangModel>()
                .HasOne(p => p.DonHang)
                .WithMany()
                .HasForeignKey(p => p.Id_DonHang);
            _ = modelBuilder.Entity<ChiTietDonHangModel>()
                .HasOne(p => p.DungCu)
                .WithMany()
                .HasForeignKey(p => p.Id_DungCu);
            //_ = modelBuilder.Entity<NhaCungCapModel>()
            //    .Property(p => p.SoDienThoai)
            //    .HasPrecision(18, 0); // Đặt precision và scale theo yêu cầu của bạn
            /////////////////////////////////////////////////////////////////////
            _ = modelBuilder.Entity<DonHangVanChuyenModel>()
                .HasOne(p => p.DonHang)
                .WithMany()
                .HasForeignKey(p => p.Id_DonHang);
            _ = modelBuilder.Entity<DonHangVanChuyenModel>()
                .HasOne(p => p.PhuongThucThanhToan)
                .WithMany()
                .HasForeignKey(p => p.ID_PhuongThucThanhToan);
            _ = modelBuilder.Entity<DonHangVanChuyenModel>()
                .HasOne(p => p.TrangThaiVanChuyen)
                .WithMany()
                .HasForeignKey(p => p.TinhTrang);
            _ = modelBuilder.Entity<DonHangVanChuyenModel>(entity =>
            {
                entity.Property(e => e.PhiVanChuyen).HasPrecision(18, 2);
            });
            ////////////////////
            _ = modelBuilder.Entity<KhachHangModel>(entity =>
            {
                entity.Property(e => e.DiemThuong).HasPrecision(18, 2);
            });
            ////////////////////
            _ = modelBuilder.Entity<MaGiamGiaModel>(entity =>
            {
                entity.Property(e => e.GiaTriGiam).HasPrecision(18, 2);
            });
            //////////////---- -------------Hóa đơn nhập hàng-----------------/////////////////////
            _ = modelBuilder.Entity<HoaDonNhapHangModel>()
                .HasOne(p => p.NhaCungCap)
                .WithMany()
                .HasForeignKey(p => p.Id_NhaCungCap);
            _ = modelBuilder.Entity<HoaDonNhapHangModel>(entity =>
            {
                entity.Property(e => e.TongTien).HasPrecision(18, 2);
            });

            _ = modelBuilder.Entity<CTHDNhapHangModel>()
                .HasOne(p => p.HoaDonNhapHang)
                .WithMany()
                .HasForeignKey(p => p.Id_HoaDonNhap);
            _ = modelBuilder.Entity<CTHDNhapHangModel>()
                .HasOne(p => p.SanPham)
                .WithMany()
                .HasForeignKey(p => p.Id_SanPham);
            _ = modelBuilder.Entity<CTHDNhapHangModel>(entity =>
            {
                entity.Property(e => e.DonGia).HasPrecision(18, 0);
            });
            _ = modelBuilder.Entity<CTHDNhapHangModel>(entity =>
            {
                entity.Property(e => e.GiaTien).HasPrecision(18, 0);
            });
            /////////
            _ = modelBuilder.Entity<ChiTietKhuyenMaiModel>()
                .HasOne(p => p.SanPham)
                .WithMany()
                .HasForeignKey(p => p.Id_SanPham);
            _ = modelBuilder.Entity<ChiTietKhuyenMaiModel>()
                .HasOne(p => p.KhuyenMai)
                .WithMany()
                .HasForeignKey(p => p.Id_KhuyenMai);
            //////////
            _ = modelBuilder.Entity<YeuThichModel>()
                .HasOne(p => p.KhachHang)
                .WithMany()
                .HasForeignKey(p => p.Id_KhachHang);
            _ = modelBuilder.Entity<YeuThichModel>()
                .HasOne(p => p.SanPham)
                .WithMany()
                .HasForeignKey(p => p.Id_SanPham);
            _ = modelBuilder.Entity<CuocVanChuyenModel>(entity =>
            {
                entity.Property(e => e.CuocVanChuyen).HasPrecision(18, 0);
            });
        }
        public DbSet<WebDungCuLamBanh.Models.BannerModel> BannerModel { get; set; } = default!;
    }
}
