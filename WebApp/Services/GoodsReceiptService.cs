using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services;

public class GoodsReceiptService(IGoodsReceiptRepository repository) : IGoodsReceiptService
{
    public async Task<IEnumerable<HoaDonNhapHangModel>> GetAllAsync(string search = "")
    {
        var query = repository.ReceiptsWithSupplier;

        if (!string.IsNullOrEmpty(search))
        {
            query = query.Where(d => d.Id_HoaDonNhap.Contains(search) ||
                                     d.NhaCungCap.TenNhaCungCap.Contains(search));
        }

        return await query.OrderByDescending(p => p.NgayLapHoaDon).ToListAsync();
    }

    public async Task<HoaDonNhapHangModel?> GetByIdAsync(string id)
    {
        return await repository.ReceiptsWithSupplier
            .FirstOrDefaultAsync(m => m.Id_HoaDonNhap == id);
    }

    public async Task<OperationResult<HoaDonNhapHangModel>> CreateAsync(HoaDonNhapHangModel model)
    {
        try
        {
            model.NgayLapHoaDon = DateTime.Now;
            model.TrangThai = 0;
            model.NhanVienLap ??= "Chưa lập";

            await repository.AddAsync(model);
            await repository.SaveChangesAsync();

            return OperationResult<HoaDonNhapHangModel>.SuccessResult(model);
        }
        catch (Exception ex)
        {
            return OperationResult<HoaDonNhapHangModel>.FailureResult(ex.Message);
        }
    }

    public async Task<ReceiptDetailViewModelData?> GetReceiptDetailsAsync(string id)
    {
        var hoaDon = await repository.ReceiptsWithSupplier
            .FirstOrDefaultAsync(h => h.Id_HoaDonNhap == id);

        if (hoaDon == null) return null;

        var chiTiet = await repository.ReceiptDetails
            .Where(ct => ct.Id_HoaDonNhap == id)
            .ToListAsync();

        var sanPham = await repository.Products
            .Where(p => p.DaXoa == 0 && p.Id_NhaCungCap == hoaDon.Id_NhaCungCap)
            .ToListAsync();

        return new ReceiptDetailViewModelData
        {
            HoaDon = hoaDon,
            ChiTiet = chiTiet,
            SanPham = sanPham
        };
    }

    public async Task<OperationResult> AddProductToReceiptAsync(string maHD, int idSanPham, int soLuong, int donGia)
    {
        try
        {
            var ctdhnhaphang = new CTHDNhapHangModel
            {
                Id_HoaDonNhap = maHD,
                Id_SanPham = idSanPham,
                SoLuong = soLuong,
                DonGia = donGia,
                GiaTien = soLuong * donGia
            };

            await repository.AddReceiptDetailAsync(ctdhnhaphang);
            await repository.SaveChangesAsync();

            return OperationResult.SuccessResult();
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> ImportProductsAsync(string maHD, string? nhanVienLap = null)
    {
        try
        {
            var cthd = await repository.ReceiptDetails
                .Where(ct => ct.Id_HoaDonNhap == maHD)
                .ToListAsync();

            foreach (var item in cthd)
            {
                var dungCu = await repository.Products.FirstOrDefaultAsync(p => p.Id_DungCu == item.Id_SanPham);
                if (dungCu != null)
                {
                    dungCu.SoLuong += item.SoLuong;
                    dungCu.GiaNhap = item.DonGia;
                }
            }

            var hoaDon = await repository.GetByIdAsync(maHD);
            if (hoaDon == null)
            {
                return OperationResult.FailureResult("Không tìm thấy hóa đơn nhập hàng.");
            }

            hoaDon.TongTien = cthd.Sum(ct => ct.GiaTien);
            hoaDon.NgayNhapHang = DateTime.Now;
            hoaDon.NhanVienLap = nhanVienLap ?? "Hệ thống";
            hoaDon.TrangThai = 1;

            await repository.UpdateAsync(hoaDon);
            await repository.SaveChangesAsync();

            return OperationResult.SuccessResult();
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> DeleteProductFromReceiptAsync(string maHD, int detailId)
    {
        try
        {
            var detail = await repository.FindReceiptDetailAsync(maHD, detailId);
            if (detail == null)
            {
                return OperationResult.FailureResult("Không tìm thấy chi tiết hóa đơn.");
            }

            await repository.RemoveReceiptDetailAsync(detail);
            await repository.SaveChangesAsync();

            return OperationResult.SuccessResult();
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<bool> ExistsAsync(string id)
    {
        return await repository.ExistsAsync(e => e.Id_HoaDonNhap == id);
    }
}
