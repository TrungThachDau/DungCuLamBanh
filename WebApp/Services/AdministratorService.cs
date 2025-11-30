using Firebase.Storage;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Formats.Jpeg;
using System.IO;
using System.Linq;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Models.admin;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services
{
    public class AdministratorService(IAdministratorRepository repository) : IAdministratorService
    {
        public Task<AdminModel?> AuthenticateAsync(AdminModel adminModel)
        {
            return repository.Admins
                .FirstOrDefaultAsync(a => a.TenNguoiDung == adminModel.TenNguoiDung && a.MatKhau == adminModel.MatKhau);
        }

                public async Task<DashboardData> GetDashboardAsync(DateTime fromDate, DateTime toDate)
        {
            var now = DateTime.Now;
            if (fromDate == default)
            {
                fromDate = now.Date;
            }
            if (toDate == default)
            {
                toDate = now.Date;
            }

            var doanhThuThangNay = await repository.Orders
                .Where(d => d.TrangThai != "Chua thanh to?n"
                            && d.NgayDat.HasValue
                            && d.NgayDat.Value.Month == now.Month
                            && d.NgayDat.Value.Year == now.Year)
                .SumAsync(d => d.TongTien ?? 0);

            var tienVatThangNay = await repository.Orders
                .Where(d => d.TrangThai != "Chua thanh to?n"
                            && d.NgayDat.HasValue
                            && d.NgayDat.Value.Month == now.Month
                            && d.NgayDat.Value.Year == now.Year)
                .SumAsync(d => d.VAT ?? 0);

            var tienShipThangNay = await repository.ShippingOrders
                .Where(d => d.TrangThaiVanChuyen.Id_TrangThai != 1
                            && d.DonHang.NgayDat.HasValue
                            && d.DonHang.NgayDat.Value.Month == now.Month
                            && d.DonHang.NgayDat.Value.Year == now.Year)
                .SumAsync(d => d.PhiVanChuyen ?? 0);

            var doanhThuSauThuevaChiPhiThangNay = Math.Round(doanhThuThangNay * 92 / 100, 0) - tienShipThangNay - tienVatThangNay;

            var tienNhapHangThangNay = await repository.ImportInvoices
                .Where(d => d.NgayNhapHang.HasValue
                            && d.NgayNhapHang.Value.Month == now.Month
                            && d.NgayNhapHang.Value.Year == now.Year)
                .SumAsync(d => d.TongTien ?? 0);

            var loiNhuanThangNay = doanhThuSauThuevaChiPhiThangNay - tienNhapHangThangNay;

            var vatThangNay = await repository.Orders
                .Where(d => d.TrangThai != "Chua thanh to?n"
                            && d.NgayDat.HasValue
                            && d.NgayDat.Value.Month == now.Month
                            && d.NgayDat.Value.Year == now.Year)
                .SumAsync(d => d.VAT ?? 0);

            var donHangChoXuLy = await repository.Orders
                .Where(d => d.TrangThai == "Chua thanh to?n")
                .CountAsync();

            var doanhThuLoc = await repository.Orders
                .Where(d => d.TrangThai != "Chua thanh to?n"
                            && d.NgayDat >= fromDate && d.NgayDat <= toDate)
                .SumAsync(d => d.TongTien ?? 0);

            var tienShipLoc = await repository.ShippingOrders
                .Where(d => d.TrangThaiVanChuyen.Id_TrangThai != 1
                            && d.DonHang.NgayDat >= fromDate && d.DonHang.NgayDat <= toDate)
                .SumAsync(d => d.PhiVanChuyen ?? 0);

            var doanhThuSauThuevaChiPhiLoc = Math.Round(doanhThuLoc * 92 / 100, 0) - tienShipLoc;

            var tienNhapHangLoc = await repository.ImportInvoices
                .Where(d => d.NgayNhapHang >= fromDate && d.NgayNhapHang <= toDate)
                .SumAsync(d => d.TongTien ?? 0);

            var tienLoiLoc = doanhThuSauThuevaChiPhiLoc - tienNhapHangLoc;

            var vatLoc = await repository.Orders
                .Where(d => d.TrangThai != "Chua thanh to?n"
                            && d.NgayDat >= fromDate && d.NgayDat <= toDate)
                .SumAsync(d => d.VAT ?? 0);

            var doanhThuHomNay = await repository.Orders
                .Where(d => d.TrangThai != "Chua thanh to?n"
                            && d.NgayDat.HasValue
                            && d.NgayDat.Value.Date == now.Date)
                .SumAsync(d => d.TongTien ?? 0);

            var tienShipHomNay = await repository.ShippingOrders
                .Where(d => d.TrangThaiVanChuyen.Id_TrangThai != 1
                            && d.DonHang.NgayDat.HasValue
                            && d.DonHang.NgayDat.Value.Date == now.Date)
                .SumAsync(d => d.PhiVanChuyen ?? 0);

            var doanhThuSauThuevaChiPhiHomNay = Math.Round(doanhThuHomNay * 92 / 100, 0) - tienShipHomNay;

            var tienNhapHangHomNay = await repository.ImportInvoices
                .Where(d => d.NgayNhapHang.HasValue && d.NgayNhapHang.Value.Date == now.Date)
                .SumAsync(d => d.TongTien ?? 0);

            var tienLoiHomNay = doanhThuSauThuevaChiPhiHomNay - tienNhapHangHomNay;

            var vatHomNay = await repository.Orders
                .Where(d => d.TrangThai != "Chua thanh to?n"
                            && d.NgayDat.HasValue
                            && d.NgayDat.Value.Date == now.Date)
                .SumAsync(d => d.VAT ?? 0);

            var products = await repository.Products
                .Where(d => d.DaXoa == 0)
                .ToListAsync();

            var orderDetails = await repository.OrderDetails
                .Where(d => d.DonHang.TrangThai != "Chua thanh to?n"
                            && d.DonHang.NgayDat.HasValue
                            && d.DonHang.NgayDat.Value.Month == now.Month
                            && d.DonHang.NgayDat.Value.Year == now.Year)
                .GroupBy(p => p.Id_DungCu)
                .Select(p => new
                {
                    Id_DungCu = p.Key,
                    SoLuong = p.Sum(x => x.SoLuong ?? 0)
                })
                .OrderByDescending(x => x.SoLuong)
                .ToListAsync();

            var productRank = orderDetails
                .Select((item, index) => new { item.Id_DungCu, Rank = index + 1 })
                .ToDictionary(x => x.Id_DungCu, x => x.Rank);

            var sortedProducts = products
                .OrderBy(p => productRank.ContainsKey(p.Id_DungCu) ? productRank[p.Id_DungCu] : int.MaxValue)
                .Take(10)
                .ToList();

            var productInfo = sortedProducts.Select(p => new ProductSaleInfo
            {
                Id_DungCu = p.Id_DungCu,
                TenSanPham = p.TenDungCu ?? string.Empty,
                SoLuongBanDuoc = orderDetails.FirstOrDefault(d => d.Id_DungCu == p.Id_DungCu)?.SoLuong ?? 0
            }).ToList();

            return new DashboardData
            {
                DoanhThuThangNay = doanhThuThangNay,
                TienVatThangNay = tienVatThangNay,
                TienShipThangNay = tienShipThangNay,
                DoanhThuSauThuevaChiPhiThangNay = doanhThuSauThuevaChiPhiThangNay,
                TienNhapHangThangNay = tienNhapHangThangNay,
                LoiNhuanThangNay = loiNhuanThangNay,
                VatThangNay = vatThangNay,
                DonHangChoXuLy = donHangChoXuLy,
                DoanhThuLoc = doanhThuLoc,
                TienShipLoc = tienShipLoc,
                DoanhThuSauThuevaChiPhiLoc = doanhThuSauThuevaChiPhiLoc,
                TienNhapHangLoc = tienNhapHangLoc,
                TienLoiLoc = tienLoiLoc,
                VatLoc = vatLoc,
                FromDate = fromDate,
                ToDate = toDate,
                DoanhThuHomNay = doanhThuHomNay,
                TienShipHomNay = tienShipHomNay,
                DoanhThuSauThuevaChiPhiHomNay = doanhThuSauThuevaChiPhiHomNay,
                TienNhapHangHomNay = tienNhapHangHomNay,
                TienLoiHomNay = tienLoiHomNay,
                VatHomNay = vatHomNay,
                ThangNay = now.Month,
                TopProducts = productInfo
            };
        }public async Task<List<DungCuModel>> GetProductsAsync(string search)
        {
            var query = repository.Products.Include(d => d.LoaiDungCu).Where(d => d.DaXoa == 0);
            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(d => d.TenDungCu.Contains(search));
            }
            return await query.ToListAsync();
        }

        public async Task<ProductFormOptions> GetProductFormOptionsAsync()
        {
            return new ProductFormOptions
            {
                Categories = await repository.Categories.ToListAsync(),
                Suppliers = await repository.Suppliers.ToListAsync(),
                Manufacturers = await repository.Manufacturers.ToListAsync()
            };
        }

        public async Task<OperationResult<DungCuModel>> CreateProductAsync(DungCuModel dungCuModel, IFormFile? imageInput)
        {
            if (dungCuModel.SoLuong < 0)
            {
                return OperationResult<DungCuModel>.Fail("S? lu?ng ph?i l� m?t s? nguy�n duong.");
            }

            var isDuplicateName = await repository.Products
                .AnyAsync(dc => dc.TenDungCu == dungCuModel.TenDungCu);
            if (isDuplicateName)
            {
                return OperationResult<DungCuModel>.Fail("T�n s?n ph?m da t?n t?i. Vui l�ng ch?n t�n kh�c.");
            }

            dungCuModel.DaXoa = 0;
            dungCuModel.SoLuong = 0;
            dungCuModel.GiaKhuyenMai = 0;

            await repository.AddAsync(dungCuModel);
            await repository.SaveChangesAsync();

            if (imageInput != null)
            {
                var newUrl = await UploadImage(imageInput, dungCuModel.Id_DungCu.ToString());
                dungCuModel.HinhAnh = newUrl;
                await repository.UpdateAsync(dungCuModel);
                await repository.SaveChangesAsync();
            }

            return OperationResult<DungCuModel>.Ok(dungCuModel);
        }

        public Task<DungCuModel?> GetProductForEditAsync(int? id)
        {
            if (id == null)
            {
                return Task.FromResult<DungCuModel?>(null);
            }

            return repository.Products
                .Include(p => p.LoaiDungCu)
                .Include(p => p.NhaCungCap)
                .FirstOrDefaultAsync(m => m.Id_DungCu == id);
        }

        public async Task<OperationResult<DungCuModel>> UpdateProductAsync(DungCuModel dungCuModel, IFormFile? imageInput)
        {
            if (imageInput != null)
            {
                dungCuModel.DaXoa = 0;
                var newUrl = await UploadImage(imageInput, dungCuModel.Id_DungCu.ToString());
                dungCuModel.HinhAnh = newUrl;
                await repository.UpdateAsync(dungCuModel);
                await repository.SaveChangesAsync();
                return OperationResult<DungCuModel>.Ok(dungCuModel);
            }

            var existingImage = await repository.Products
                .Where(d => d.Id_DungCu == dungCuModel.Id_DungCu)
                .Select(d => d.HinhAnh)
                .FirstOrDefaultAsync();

            dungCuModel.HinhAnh = existingImage;
            await repository.UpdateAsync(dungCuModel);
            await repository.SaveChangesAsync();

            return OperationResult<DungCuModel>.Ok(dungCuModel);
        }

        public async Task<OperationResult<bool>> SoftDeleteProductAsync(int id)
        {
            var dungCuModel = await repository.FindAsync<DungCuModel>(id);
            if (dungCuModel == null)
            {
                return OperationResult<bool>.Fail("S?n ph?m kh�ng t?n t?i.");
            }

            dungCuModel.DaXoa = 1;
            dungCuModel.SoLuong = 0;
            await repository.UpdateAsync(dungCuModel);
            await repository.SaveChangesAsync();

            return OperationResult<bool>.Ok(true);
        }

        public async Task<CategoryViewModel> GetCategoriesAsync()
        {
            return new CategoryViewModel
            {
                Category = await repository.Categories.ToListAsync(),
                NewCategory = new LoaiDungCuModel()
            };
        }

        public async Task<OperationResult<bool>> CreateCategoryAsync(string tenLoaiDungCu)
        {
            var category = await repository.Categories.FirstOrDefaultAsync(c => c.TenLoaiDungCu == tenLoaiDungCu);
            if (category != null)
            {
                return OperationResult<bool>.Fail("Lo?i d?ng c? n�y da t?n t?i.");
            }

            var loaiDungCuModel = new LoaiDungCuModel
            {
                TenLoaiDungCu = tenLoaiDungCu,
            };
            await repository.AddAsync(loaiDungCuModel);
            await repository.SaveChangesAsync();

            return OperationResult<bool>.Ok(true);
        }

        public async Task<OperationResult<bool>> DeleteCategoryAsync(int? id)
        {
            if (id == null)
            {
                return OperationResult<bool>.Fail("Kh�ng t�m th?y lo?i d?ng c?.");
            }

            var loaiDungCu = await repository.FindAsync<LoaiDungCuModel>(id.Value);
            if (loaiDungCu == null)
            {
                return OperationResult<bool>.Fail("Kh�ng t�m th?y lo?i d?ng c?.");
            }

            var dungCu = await repository.Products.FirstOrDefaultAsync(d => d.Id_LoaiDungCu == id);
            if (dungCu != null)
            {
                return OperationResult<bool>.Fail("Lo?i d?ng c? n�y da c� s?n ph?m.");
            }

            await repository.RemoveAsync(loaiDungCu);
            await repository.SaveChangesAsync();
            return OperationResult<bool>.Ok(true);
        }

        public Task<List<KhuyenMaiModel>> GetSaleOffsAsync()
        {
            return repository.SaleOffs.ToListAsync();
        }

        public async Task<OperationResult<KhuyenMaiModel>> CreateSaleOffAsync(KhuyenMaiModel khuyenMai)
        {
            if (khuyenMai.NgayBatDau > khuyenMai.NgayKetThuc)
            {
                return OperationResult<KhuyenMaiModel>.Fail("Ng�y kh�ng h?p l?.");
            }

            await repository.AddAsync(khuyenMai);
            await repository.SaveChangesAsync();

            return OperationResult<KhuyenMaiModel>.Ok(khuyenMai);
        }

        public async Task<OperationResult<bool>> DeleteSaleOffAsync(int? id)
        {
            if (id == null)
            {
                return OperationResult<bool>.Fail("Kh�ng t�m th?y khuy?n m?.");
            }

            var ctkm = await repository.SaleOffDetails.Where(ct => ct.Id_KhuyenMai == id).ToListAsync();
            foreach (var ct in ctkm)
            {
                await repository.RemoveAsync(ct);
            }

            var khuyenMai = await repository.FindAsync<KhuyenMaiModel>(id.Value);
            if (khuyenMai != null)
            {
                await repository.RemoveAsync(khuyenMai);
            }

            await repository.SaveChangesAsync();
            return OperationResult<bool>.Ok(true);
        }

        public async Task<SaleOffViewData> GetSaleOffDetailAsync(int id)
        {
            var khuyenMai = await repository.SaleOffs.FirstOrDefaultAsync(k => k.Id_KhuyenMai == id);
            var products = await repository.Products.Where(p => p.DaXoa == 0).ToListAsync();
            var details = await repository.SaleOffDetails
                .Include(ct => ct.SanPham)
                .Include(ct => ct.KhuyenMai)
                .Where(ct => ct.Id_KhuyenMai == id)
                .ToListAsync();

            return new SaleOffViewData
            {
                KhuyenMai = khuyenMai,
                Products = products,
                Details = details
            };
        }

        public async Task<OperationResult<bool>> AddProductToSaleOffAsync(ChiTietKhuyenMaiModel chiTietKhuyenMai)
        {
            if (chiTietKhuyenMai.GiaTriGiam > 99 || chiTietKhuyenMai.GiaTriGiam < 1)
            {
                return OperationResult<bool>.Fail("Gi� tr? gi?m ph?i t? 1 d?n 99.");
            }

            var existing = await repository.SaleOffDetails.FirstOrDefaultAsync(k => k.Id_SanPham == chiTietKhuyenMai.Id_SanPham);
            if (existing != null)
            {
                return OperationResult<bool>.Fail("S?n ph?m da t?n t?i.");
            }

            await repository.AddAsync(chiTietKhuyenMai);
            await repository.SaveChangesAsync();

            return OperationResult<bool>.Ok(true);
        }

        public async Task<OperationResult<bool>> DeleteProductSaleOffAsync(int idKhuyenMai, int idCtkm)
        {
            var ct = await repository.SaleOffDetails.FirstOrDefaultAsync(ct => ct.Id_CTKM == idCtkm);
            if (ct != null)
            {
                await repository.RemoveAsync(ct);
                await repository.SaveChangesAsync();
            }

            return OperationResult<bool>.Ok(true);
        }

        public async Task<OperationResult<bool>> ApplySaleOffAsync()
        {
            try
            {
                var kmcu = await repository.Products.ToListAsync();
                foreach (var dc in kmcu)
                {
                    dc.GiaKhuyenMai = 0;
                    await repository.UpdateAsync(dc);
                }
                await repository.SaveChangesAsync();

                var khuyenMai = await repository.SaleOffs.ToListAsync();
                foreach (var km in khuyenMai)
                {
                    var ctkm = await repository.SaleOffDetails.Where(ct => ct.Id_KhuyenMai == km.Id_KhuyenMai).ToListAsync();
                    foreach (var ct in ctkm)
                    {
                        var dungCu = await repository.Products.FirstOrDefaultAsync(d => d.Id_DungCu == ct.Id_SanPham);
                        if (dungCu != null)
                        {
                            if (km.NgayBatDau <= DateTime.Now && km.NgayKetThuc >= DateTime.Now)
                            {
                                var giaGoc = dungCu.Gia ?? 0;
                                dungCu.GiaKhuyenMai = (giaGoc * (100 - ct.GiaTriGiam)) / 100;
                                await repository.UpdateAsync(dungCu);
                            }
                            else
                            {
                                dungCu.GiaKhuyenMai = 0;
                                await repository.UpdateAsync(dungCu);
                            }
                        }
                    }
                }

                await repository.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return OperationResult<bool>.Fail(ex.Message);
            }

            return OperationResult<bool>.Ok(true);
        }

        public Task<List<MaGiamGiaModel>> GetVouchersAsync()
        {
            return repository.Vouchers.ToListAsync();
        }

        public async Task<OperationResult<bool>> CreateVoucherAsync(MaGiamGiaModel maGiamGia)
        {
            var existing = await repository.Vouchers.FirstOrDefaultAsync(k => k.Id_MaGiamGia == maGiamGia.Id_MaGiamGia);
            if (existing != null)
            {
                return OperationResult<bool>.Fail("Ma gi?m gi� n�y da t?n t?i.");
            }

            await repository.AddAsync(maGiamGia);
            await repository.SaveChangesAsync();
            return OperationResult<bool>.Ok(true);
        }

        public async Task<OperationResult<bool>> DeleteVoucherAsync(string? id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return OperationResult<bool>.Fail("Kh�ng t�m th?y ma gi?m gi�.");
            }

            var voucher = await repository.FindAsync<MaGiamGiaModel>(id);
            if (voucher != null)
            {
                await repository.RemoveAsync(voucher);
                await repository.SaveChangesAsync();
            }

            return OperationResult<bool>.Ok(true);
        }

        public async Task<OrderListData> GetAllOrdersAsync()
        {
            var data = new OrderListData
            {
                DonHangChuaGiao = await repository.ShippingOrders.Where(d => d.TinhTrang == 0).CountAsync(),
                DonHangDaGiao = await repository.ShippingOrders.Where(d => d.TinhTrang == 2).CountAsync(),
                DonHangDangGiao = await repository.ShippingOrders.Where(d => d.TinhTrang == 1).CountAsync(),
                DonHangDaHuy = await repository.ShippingOrders.Where(d => d.TinhTrang == 3).CountAsync()
            };

            data.Orders = await repository.ShippingOrders
                .Include(d => d.DonHang)
                .Include(d => d.PhuongThucThanhToan)
                .Include(d => d.TrangThaiVanChuyen)
                .OrderByDescending(p => p.Id_DHVC)
                .ToListAsync();

            data.ShippingStatusOptions = await repository.ShippingStatuses
                .Select(pttt => new SelectListItem
                {
                    Value = pttt.Id_TrangThai.ToString(),
                    Text = $"{pttt.TenTrangThai}"
                })
                .ToListAsync();

            return data;
        }

        public async Task<OrderListData> GetOrdersNotDeliveredAsync()
        {
            var data = await GetAllOrdersAsync();
            data.Orders = await repository.ShippingOrders
                .Include(d => d.DonHang)
                .Include(d => d.PhuongThucThanhToan)
                .Include(d => d.TrangThaiVanChuyen)
                .Where(d => d.TrangThaiVanChuyen.Id_TrangThai != 2)
                .OrderByDescending(d => d.DonHang.NgayDat)
                .OrderByDescending(p => p.Id_DHVC)
                .ToListAsync();
            return data;
        }

        public async Task<OrderListData> GetOrdersDeliveredAsync()
        {
            var data = await GetAllOrdersAsync();
            data.Orders = await repository.ShippingOrders
                .Include(d => d.DonHang)
                .Include(d => d.PhuongThucThanhToan)
                .Include(d => d.TrangThaiVanChuyen)
                .Where(d => d.TrangThaiVanChuyen.Id_TrangThai == 2)
                .OrderByDescending(d => d.DonHang.NgayDat)
                .OrderByDescending(p => p.Id_DHVC)
                .ToListAsync();
            return data;
        }

        public async Task<OperationResult<OrderDetailData>> GetOrderDetailAsync(string id)
        {
            var donHang = await repository.FindAsync<DonHangModel>(id);
            if (donHang == null)
            {
                return OperationResult<OrderDetailData>.Fail("Kh�ng t�m th?y h�a don.");
            }

            var chiTietDonHang = await repository.OrderDetails
                .Where(ct => ct.Id_DonHang == id)
                .Include(p => p.DungCu)
                .ToListAsync();

            var donHangVanChuyen = await repository.ShippingOrders
                .Where(ct => ct.Id_DonHang == id)
                .Include(p => p.TrangThaiVanChuyen)
                .Include(p => p.PhuongThucThanhToan)
                .FirstOrDefaultAsync();

            if (donHangVanChuyen == null || chiTietDonHang.Count == 0)
            {
                return OperationResult<OrderDetailData>.Fail("Kh�ng t�m th?y chi ti?t h�a don.");
            }

            var result = new OrderDetailViewModel
            {
                donHangModel = donHang,
                chiTietDonHangModel = chiTietDonHang,
                donHangVanChuyenModel = donHangVanChuyen
            };

            decimal? tongTien = donHang.TongTien;
            decimal? tamTinh = await repository.OrderDetails.Where(ct => ct.Id_DonHang == id).SumAsync(ct => ct.DonGia ?? 0);
            decimal? vat = Math.Round((tongTien ?? 0) * 8 / 108, 0);

            var magiamgia = donHang.Id_MaGiamGia;
            decimal giaTriGiam = 0;
            if (magiamgia != null)
            {
                giaTriGiam = (decimal)await repository.Vouchers.Where(gg => gg.Id_MaGiamGia == magiamgia)
                    .Select(gg => gg.GiaTriGiam)
                    .FirstOrDefaultAsync();
            }

            return OperationResult<OrderDetailData>.Ok(new OrderDetailData
            {
                ViewModel = result,
                TamTinh = tamTinh,
                Vat = vat,
                GiaTriGiam = giaTriGiam,
                TongTien = tongTien,
                PhiVanChuyen = donHangVanChuyen.PhiVanChuyen
            });
        }

        public Task<List<BannerModel>> GetBannersAsync()
        {
            return repository.Banners.ToListAsync();
        }

        public async Task<OperationResult<BannerModel>> CreateBannerAsync(BannerModel banner, IFormFile? imageInput)
        {
            if (imageInput != null)
            {
                banner.DuongDan = await UploadImage(imageInput, banner.TenBanner ?? string.Empty);
            }
            else
            {
                banner.DuongDan = "null";
            }

            await repository.AddAsync(banner);
            await repository.SaveChangesAsync();
            return OperationResult<BannerModel>.Ok(banner);
        }

        public async Task<OperationResult<BannerModel>> GetBannerAsync(int? id)
        {
            if (id == null)
            {
                return OperationResult<BannerModel>.Fail("Kh�ng t�m th?y banner.");
            }

            var banner = await repository.FindAsync<BannerModel>(id.Value);
            if (banner == null)
            {
                return OperationResult<BannerModel>.Fail("Kh�ng t�m th?y banner.");
            }

            return OperationResult<BannerModel>.Ok(banner);
        }

        public async Task<OperationResult<BannerModel>> UpdateBannerAsync(BannerModel banner, IFormFile? imageInput)
        {
            if (imageInput != null)
            {
                var newUrl = await UpdateImage(banner.DuongDan ?? string.Empty, imageInput);
                banner.DuongDan = newUrl;
            }

            await repository.UpdateAsync(banner);
            await repository.SaveChangesAsync();
            return OperationResult<BannerModel>.Ok(banner);
        }

        public async Task<OperationResult<bool>> DeleteBannerAsync(int? id)
        {
            if (id == null)
            {
                return OperationResult<bool>.Fail("Kh�ng t�m th?y banner.");
            }

            var banner = await repository.FindAsync<BannerModel>(id.Value);
            if (banner != null)
            {
                if (!string.IsNullOrEmpty(banner.TenBanner))
                {
                    await DeleteImageAsync(banner.TenBanner);
                }

                await repository.RemoveAsync(banner);
                await repository.SaveChangesAsync();
            }

            return OperationResult<bool>.Ok(true);
        }

        public async Task<OperationResult<bool>> ChangeStatusAsync(int dhvc, int value)
        {
            var donHangVanChuyen = await repository.ShippingOrders
                .Where(p => p.Id_DHVC == dhvc)
                .FirstOrDefaultAsync();

            if (donHangVanChuyen == null)
            {
                return OperationResult<bool>.Fail($"Order with ID {dhvc} not found.");
            }

            donHangVanChuyen.TinhTrang = value;
            await repository.UpdateAsync(donHangVanChuyen);
            await repository.SaveChangesAsync();
            return OperationResult<bool>.Ok(true);
        }

                public async Task<List<decimal>> GetEarningThisMonthAsync()
        {
            var earnings = new List<decimal>();
            var currentDate = DateTime.Now;

            for (int i = 0; i < 6; i++)
            {
                var targetDate = currentDate.AddMonths(-i);
                var earning = await repository.Orders
                    .Where(d => d.TrangThai != "Chua thanh to?n"
                                && d.NgayDat.HasValue
                                && d.NgayDat.Value.Month == targetDate.Month
                                && d.NgayDat.Value.Year == targetDate.Year)
                    .SumAsync(d => d.TongTien ?? 0);
                earnings.Add(earning);
            }

            return earnings;
        }
private async Task<string?> UploadImage(IFormFile fileInput, string filename)
        {
            try
            {
                using var inputStream = fileInput.OpenReadStream();
                using var image = await Image.LoadAsync(inputStream);

                var encoder = new JpegEncoder
                {
                    Quality = 30
                };
                using var outputStream = new MemoryStream();
                await image.SaveAsync(outputStream, encoder);
                outputStream.Seek(0, SeekOrigin.Begin);

                var storage = new FirebaseStorage("qldclb-770f5.appspot.com");
                var imageUrl = await storage.Child("images")
                    .Child(fileInput.FileName)
                    .PutAsync(outputStream);

                return imageUrl;
            }
            catch (Exception)
            {
                return null;
            }
        }

        private async Task<string?> UpdateImage(string url, IFormFile fileInput)
        {
            if (string.IsNullOrEmpty(url))
            {
                return await UploadImage(fileInput, fileInput.FileName);
            }

            var uri = new Uri(url);
            try
            {
                var storage = new FirebaseStorage("qldclb-770f5.appspot.com");
                var existingImage = await storage.Child("images")
                    .Child(Path.GetFileName(uri.LocalPath))
                    .GetDownloadUrlAsync();

                if (existingImage != null)
                {
                    await storage.Child("images")
                        .Child(Path.GetFileName(uri.LocalPath))
                        .DeleteAsync();
                }

                using var inputStream = fileInput.OpenReadStream();
                using var image = await Image.LoadAsync(inputStream);
                var encoder = new JpegEncoder
                {
                    Quality = 50
                };
                using var outputStream = new MemoryStream();
                await image.SaveAsync(outputStream, encoder);
                outputStream.Seek(0, SeekOrigin.Begin);
                var imageUrl = await storage.Child("images")
                    .Child(fileInput.FileName)
                    .PutAsync(outputStream);
                return imageUrl;
            }
            catch (Exception)
            {
                return null;
            }
        }

        private async Task DeleteImageAsync(string filename)
        {
            var storage = new FirebaseStorage("qldclb-770f5.appspot.com");
            var existingImage = await storage.Child("images")
                .Child(Path.GetFileName(filename))
                .GetDownloadUrlAsync();
            if (existingImage != null)
            {
                await storage.Child("images")
                    .Child(Path.GetFileName(filename))
                    .DeleteAsync();
            }
        }
    }
}


