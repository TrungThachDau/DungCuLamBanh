using Firebase.Storage;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Formats.Jpeg;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Models.admin;

namespace WebDungCuLamBanh.AdminAPIController
{
    [ApiController]
    [Route("api/admin/[controller]")]
    public class AdministratorApiController(AppDbContext context) : ControllerBase
    {
        [HttpPost("login")]
        public async Task<IActionResult> Login(AdminModel adminModel)
        {
            var admin = await context.Admins.FirstOrDefaultAsync(a => a.TenNguoiDung == adminModel.TenNguoiDung && a.MatKhau == adminModel.MatKhau);
            if (admin != null && admin.Quyen == 1)
            {
                var username = admin.TenNguoiDung ?? string.Empty;
                HttpContext.Session.Set("admin", System.Text.Encoding.UTF8.GetBytes(username));
                return Ok(admin);
            }

            return Unauthorized("Đăng nhập không thành công");
        }

        [HttpPost("logout")]
        public IActionResult Logout()
        {
            HttpContext.Session.Remove("admin");
            return NoContent();
        }

        [HttpGet("dashboard")]
        public async Task<IActionResult> Dashboard([FromQuery] DateTime? fromDate, [FromQuery] DateTime? toDate)
        {
            var from = fromDate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            var to = toDate ?? DateTime.Now;

            var doanhThuThangNay = context.DonHangs
                .Where(d => d.TrangThai != "Chua thanh toán" && d.NgayDat.Value.Month == DateTime.Now.Month && d.NgayDat.Value.Year == DateTime.Now.Year)
                .Sum(d => d.TongTien);

            var tienVatThangNay = context.DonHangs
                .Where(d => d.TrangThai != "Chua thanh toán" && d.NgayDat.Value.Month == DateTime.Now.Month && d.NgayDat.Value.Year == DateTime.Now.Year)
                .Sum(d => d.VAT);

            var tienShipThangNay = context.DonHangVanChuyens
                .Where(d => d.TrangThaiVanChuyen.Id_TrangThai != 1 && d.DonHang.NgayDat.Value.Month == DateTime.Now.Month && d.DonHang.NgayDat.Value.Year == DateTime.Now.Year)
                .Sum(d => d.PhiVanChuyen);

            var doanhThuSauThuevaChiPhiThangNay = Math.Round((decimal)(doanhThuThangNay * 92 / 100), 0) - tienShipThangNay - tienVatThangNay;
            var tienNhapHangThangNay = context.HoaDonNhapHangs
                .Where(d => d.NgayNhapHang.Value.Month == DateTime.Now.Month && d.NgayNhapHang.Value.Year == DateTime.Now.Year)
                .Sum(d => d.TongTien);

            var loiNhuanThangNay = doanhThuSauThuevaChiPhiThangNay - tienNhapHangThangNay;
            var vatThangNay = tienVatThangNay;

            var doanhThuLoc = context.DonHangs
                .Where(d => d.TrangThai != "Chua thanh toán" && d.NgayDat >= from && d.NgayDat <= to)
                .Sum(d => d.TongTien);

            var tienShipLoc = context.DonHangVanChuyens
                .Where(d => d.TrangThaiVanChuyen.Id_TrangThai != 1 && d.DonHang.NgayDat >= from && d.DonHang.NgayDat <= to)
                .Sum(d => d.PhiVanChuyen);

            var doanhThuSauThuevaChiPhiLoc = Math.Round((decimal)(doanhThuLoc * 92 / 100), 0) - tienShipLoc;
            var tienNhapHangLoc = context.HoaDonNhapHangs
                .Where(d => d.NgayNhapHang >= from && d.NgayNhapHang <= to)
                .Sum(d => d.TongTien);

            var tienLoiLoc = doanhThuSauThuevaChiPhiLoc - tienNhapHangLoc;
            var vatLoc = context.DonHangs
                .Where(d => d.TrangThai != "Chua thanh toán" && d.NgayDat >= from && d.NgayDat <= to)
                .Sum(d => d.VAT);

            var doanhThuHomNay = context.DonHangs
                .Where(d => d.TrangThai != "Chua thanh toán" && d.NgayDat.Value.Date == DateTime.Now.Date)
                .Sum(d => d.TongTien);

            var tienShipHomNay = context.DonHangVanChuyens
                .Where(d => d.TrangThaiVanChuyen.Id_TrangThai != 1 && d.DonHang.NgayDat.Value.Date == DateTime.Now.Date)
                .Sum(d => d.PhiVanChuyen);

            var doanhThuSauThuevaChiPhiHomNay = Math.Round((decimal)(doanhThuHomNay * 92 / 100), 0) - tienShipHomNay;
            var tienNhapHangHomNay = context.HoaDonNhapHangs
                .Where(d => d.NgayNhapHang.Value.Date == DateTime.Now.Date)
                .Sum(d => d.TongTien);

            var tienLoiHomNay = doanhThuSauThuevaChiPhiHomNay - tienNhapHangHomNay;
            var vatHomNay = context.DonHangs
                .Where(d => d.TrangThai != "Chua thanh toán" && d.NgayDat.Value.Date == DateTime.Now.Date)
                .Sum(d => d.VAT);

            var products = await context.DungCus.Where(d => d.DaXoa == 0).ToListAsync();

            var orderDetails = await context.ChiTietDonHangs
                .Where(d => d.DonHang.TrangThai != "Chua thanh toán" && d.DonHang.NgayDat.Value.Month == DateTime.Now.Month && d.DonHang.NgayDat.Value.Year == DateTime.Now.Year)
                .GroupBy(p => p.Id_DungCu)
                .Select(p => new
                {
                    Id_DungCu = p.Key,
                    SoLuong = p.Sum(x => x.SoLuong)
                })
                .OrderByDescending(x => x.SoLuong)
                .ToListAsync();

            var productRank = orderDetails.Select((item, index) => new { item.Id_DungCu, Rank = index + 1 }).ToDictionary(x => x.Id_DungCu, x => x.Rank);
            var sortedProducts = products.OrderBy(p => productRank.ContainsKey(p.Id_DungCu) ? productRank[p.Id_DungCu] : int.MaxValue).Take(10).ToList();

            var productInfo = sortedProducts.Select(p => new
            {
                Id_DungCu = p.Id_DungCu,
                TenSanPham = p.TenDungCu,
                SoLuongBanDuoc = orderDetails.FirstOrDefault(d => d.Id_DungCu == p.Id_DungCu)?.SoLuong ?? 0
            }).ToList();

            return Ok(new
            {
                summary = new
                {
                    doanhThuThangNay,
                    tienVatThangNay,
                    tienShipThangNay,
                    doanhThuSauThuevaChiPhiThangNay,
                    tienNhapHangThangNay,
                    loiNhuanThangNay,
                    vatThangNay,
                    thangNay = DateTime.Now.Month
                },
                filter = new
                {
                    fromDate = from,
                    toDate = to,
                    doanhThuLoc,
                    tienShipLoc,
                    doanhThuSauThuevaChiPhiLoc,
                    tienNhapHangLoc,
                    tienLoiLoc,
                    vatLoc
                },
                today = new
                {
                    doanhThuHomNay,
                    tienShipHomNay,
                    doanhThuSauThuevaChiPhiHomNay,
                    tienNhapHangHomNay,
                    tienLoiHomNay,
                    vatHomNay
                },
                topProducts = productInfo
            });
        }

        [HttpGet("products")]
        public async Task<IActionResult> Products(string search = "")
        {
            var query = context.DungCus.Include(d => d.LoaiDungCu).Where(d => d.DaXoa == 0);
            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(d => d.TenDungCu.Contains(search));
            }

            var result = await query.ToListAsync();
            return Ok(result);
        }

        [HttpPost("products")]
        public async Task<IActionResult> CreateProduct([FromForm] DungCuModel dungCuModel, IFormFile? imageInput = null)
        {
            if (dungCuModel.SoLuong < 0)
            {
                return BadRequest("Số lượng phải là số nguyên dương.");
            }

            var duplicate = await context.DungCus.AnyAsync(dc => dc.TenDungCu == dungCuModel.TenDungCu);
            if (duplicate)
            {
                return Conflict("Tên sản phẩm đã tồn tại.");
            }

            dungCuModel.DaXoa = 0;
            dungCuModel.SoLuong = 0;
            dungCuModel.GiaKhuyenMai = 0;

            context.Add(dungCuModel);
            await context.SaveChangesAsync();

            if (imageInput != null)
            {
                var id = dungCuModel.Id_DungCu;
                var newUrl = await UploadImage(imageInput, id.ToString());
                dungCuModel.HinhAnh = newUrl;
                context.Update(dungCuModel);
                await context.SaveChangesAsync();
            }

            return CreatedAtAction(nameof(GetProductById), new { id = dungCuModel.Id_DungCu }, dungCuModel);
        }

        [HttpGet("products/{id:int}")]
        public async Task<IActionResult> GetProductById(int id)
        {
            var product = await context.DungCus.Include(p => p.LoaiDungCu).Include(p => p.NhaCungCap).FirstOrDefaultAsync(m => m.Id_DungCu == id);
            if (product == null)
            {
                return NotFound();
            }

            return Ok(product);
        }

        [HttpPut("products/{id:int}")]
        public async Task<IActionResult> EditProduct(int id, [FromForm] DungCuModel dungCuModel, IFormFile? imageInput = null)
        {
            if (id != dungCuModel.Id_DungCu)
            {
                return BadRequest("Id mismatch with payload");
            }

            if (imageInput != null)
            {
                dungCuModel.DaXoa = 0;
                var newUrl = await UploadImage(imageInput, dungCuModel.Id_DungCu.ToString());
                dungCuModel.HinhAnh = newUrl;
            }
            else
            {
                dungCuModel.HinhAnh = await context.DungCus.Where(d => d.Id_DungCu == dungCuModel.Id_DungCu).Select(d => d.HinhAnh).FirstOrDefaultAsync();
            }

            context.Update(dungCuModel);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("products/{id:int}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            var product = await context.DungCus.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }

            product.DaXoa = 1;
            product.SoLuong = 0;
            context.Update(product);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("categories")]
        public async Task<IActionResult> Categories()
        {
            var categories = await context.LoaiDungCus.ToListAsync();
            return Ok(categories);
        }

        [HttpPost("categories")]
        public async Task<IActionResult> CreateCategory([FromBody] string tenLoaiDungCu)
        {
            var existing = await context.LoaiDungCus.FirstOrDefaultAsync(c => c.TenLoaiDungCu == tenLoaiDungCu);
            if (existing != null)
            {
                return Conflict("Loại dụng cụ này đã tồn tại.");
            }

            var category = new LoaiDungCuModel { TenLoaiDungCu = tenLoaiDungCu };
            context.Add(category);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(Categories), new { id = category.Id_LoaiDungCu }, category);
        }

        [HttpDelete("categories/{id:int}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            var loaiDungCu = await context.LoaiDungCus.FindAsync(id);
            if (loaiDungCu == null)
            {
                return NotFound();
            }

            var hasProduct = await context.DungCus.FirstOrDefaultAsync(d => d.Id_LoaiDungCu == id);
            if (hasProduct != null)
            {
                return Conflict("Loại dụng cụ này đã có sản phẩm.");
            }

            context.LoaiDungCus.Remove(loaiDungCu);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("sale-off")]
        public async Task<IActionResult> SaleOff()
        {
            await ApplySaleOffInternal();
            var promotions = await context.KhuyenMai2s.ToListAsync();
            return Ok(promotions);
        }

        [HttpPost("sale-off")]
        public async Task<IActionResult> CreateSaleOff(KhuyenMaiModel khuyenMai)
        {
            if (khuyenMai.NgayBatDau > khuyenMai.NgayKetThuc)
            {
                return BadRequest("Ngày không hợp lệ.");
            }

            context.Add(khuyenMai);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(SaleOff), new { id = khuyenMai.Id_KhuyenMai }, khuyenMai);
        }

        [HttpDelete("sale-off/{id:int}")]
        public async Task<IActionResult> DeleteSaleOff(int id)
        {
            var details = await context.ChiTietKhuyenMais.Where(ct => ct.Id_KhuyenMai == id).ToListAsync();
            foreach (var ct in details)
            {
                context.ChiTietKhuyenMais.Remove(ct);
            }

            var promotion = await context.KhuyenMai2s.FindAsync(id);
            if (promotion != null)
            {
                context.KhuyenMai2s.Remove(promotion);
            }

            await context.SaveChangesAsync();
            return NoContent();
        }

        [HttpGet("sale-off/{id:int}/products")]
        public async Task<IActionResult> GetProductsInSale(int id)
        {
            var promotion = await context.KhuyenMai2s.FirstOrDefaultAsync(k => k.Id_KhuyenMai == id);
            if (promotion == null)
            {
                return NotFound();
            }

            var products = await context.DungCus.Where(p => p.DaXoa == 0).ToListAsync();
            var details = await context.ChiTietKhuyenMais.Include(ct => ct.SanPham).Include(ct => ct.KhuyenMai).Where(ct => ct.Id_KhuyenMai == id).ToListAsync();

            return Ok(new { promotion, products, details });
        }

        [HttpPost("sale-off/{id:int}/products")]
        public async Task<IActionResult> AddProductToSaleOff(int id, ChiTietKhuyenMaiModel chiTietKhuyenMai)
        {
            if (chiTietKhuyenMai.GiaTriGiam > 99 || chiTietKhuyenMai.GiaTriGiam < 1)
            {
                return BadRequest("Giá trị giảm phải từ 1 đến 99.");
            }

            var exists = await context.ChiTietKhuyenMais.FirstOrDefaultAsync(k => k.Id_SanPham == chiTietKhuyenMai.Id_SanPham);
            if (exists != null)
            {
                return Conflict("Sản phẩm đã tồn tại trong khuyến mãi.");
            }

            chiTietKhuyenMai.Id_KhuyenMai = id;
            context.Add(chiTietKhuyenMai);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetProductsInSale), new { id }, chiTietKhuyenMai);
        }

        [HttpDelete("sale-off/{saleId:int}/products/{detailId:int}")]
        public async Task<IActionResult> DeleteProductSaleOff(int saleId, int detailId)
        {
            var ct = await context.ChiTietKhuyenMais.FirstOrDefaultAsync(ct => ct.Id_CTKM == detailId && ct.Id_KhuyenMai == saleId);
            if (ct == null)
            {
                return NotFound();
            }

            context.ChiTietKhuyenMais.Remove(ct);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("vouchers")]
        public async Task<IActionResult> Voucher()
        {
            var vouchers = await context.MaGiamGias.ToListAsync();
            return Ok(vouchers);
        }

        [HttpPost("vouchers")]
        public async Task<IActionResult> CreateVoucher(MaGiamGiaModel maGiamGia)
        {
            var existing = await context.MaGiamGias.FirstOrDefaultAsync(k => k.Id_MaGiamGia == maGiamGia.Id_MaGiamGia);
            if (existing != null)
            {
                return Conflict("Mã giảm giá này đã tồn tại.");
            }

            context.Add(maGiamGia);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(Voucher), new { id = maGiamGia.Id_MaGiamGia }, maGiamGia);
        }

        [HttpDelete("vouchers/{id}")]
        public async Task<IActionResult> DeleteVoucher(string id)
        {
            var voucher = await context.MaGiamGias.FindAsync(id);
            if (voucher == null)
            {
                return NotFound();
            }

            context.MaGiamGias.Remove(voucher);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("orders")]
        public async Task<IActionResult> AllOrders()
        {
            var orders = await context.DonHangVanChuyens
                .Include(d => d.DonHang)
                .Include(d => d.PhuongThucThanhToan)
                .Include(d => d.TrangThaiVanChuyen)
                .OrderByDescending(p => p.Id_DHVC)
                .ToListAsync();

            var stats = new
            {
                choGiao = context.DonHangVanChuyens.Count(d => d.TinhTrang == 0),
                dangGiao = context.DonHangVanChuyens.Count(d => d.TinhTrang == 1),
                daGiao = context.DonHangVanChuyens.Count(d => d.TinhTrang == 2),
                daHuy = context.DonHangVanChuyens.Count(d => d.TinhTrang == 3)
            };

            return Ok(new { stats, orders });
        }

        [HttpGet("orders/not-delivered")]
        public async Task<IActionResult> OrdersNotDelivered()
        {
            var orders = await context.DonHangVanChuyens
                .Include(d => d.DonHang)
                .Include(d => d.PhuongThucThanhToan)
                .Include(d => d.TrangThaiVanChuyen)
                .Where(d => d.TrangThaiVanChuyen != null && d.TrangThaiVanChuyen.Id_TrangThai != 2)
                .OrderByDescending(d => d.DonHang.NgayDat ?? DateTime.MinValue)
                .ToListAsync();

            return Ok(orders);
        }

        [HttpGet("orders/delivered")]
        public async Task<IActionResult> OrdersDelivered()
        {
            var orders = await context.DonHangVanChuyens
                .Include(d => d.DonHang)
                .Include(d => d.PhuongThucThanhToan)
                .Include(d => d.TrangThaiVanChuyen)
                .Where(d => d.TrangThaiVanChuyen != null && d.TrangThaiVanChuyen.Id_TrangThai == 2)
                .OrderByDescending(d => d.DonHang.NgayDat ?? DateTime.MinValue)
                .ToListAsync();

            return Ok(orders);
        }

        [HttpGet("orders/{id}")]
        public async Task<IActionResult> OrderDetail(string id)
        {
            var donHang = await context.DonHangs.FindAsync(id);
            if (donHang == null)
            {
                return NotFound("Không tìm thấy hóa đơn.");
            }

            var chiTietDonHang = await context.ChiTietDonHangs.Where(ct => ct.Id_DonHang == id).Include(p => p.DungCu).ToListAsync();
            var donHangVanChuyen = await context.DonHangVanChuyens.Where(ct => ct.Id_DonHang == id).Include(p => p.TrangThaiVanChuyen).Include(p => p.PhuongThucThanhToan).FirstOrDefaultAsync();

            if (donHangVanChuyen == null || chiTietDonHang.Count == 0)
            {
                return NotFound("Không tìm thấy thông tin vận chuyển hoặc chi tiết đơn hàng.");
            }

            var tongtien = donHang.TongTien ?? 0;
            var tamtinh = await context.ChiTietDonHangs.Where(ct => ct.Id_DonHang == id).SumAsync(ct => (decimal?)ct.DonGia) ?? 0;
            var vat = tongtien == 0 ? 0 : Math.Round(tongtien * 8 / 108, 0);

            var magiamgia = donHang.Id_MaGiamGia;
            decimal giatrigiam = 0;
            if (magiamgia != null)
            {
                var giaTri = await context.MaGiamGias.Where(gg => gg.Id_MaGiamGia == magiamgia).Select(gg => (decimal?)gg.GiaTriGiam).FirstOrDefaultAsync();
                giatrigiam = giaTri ?? 0;
            }

            return Ok(new
            {
                donHang,
                chiTietDonHang,
                donHangVanChuyen,
                summary = new
                {
                    tamtinh,
                    vat,
                    magiamgia = giatrigiam,
                    tongtien,
                    phivanchuyen = donHangVanChuyen.PhiVanChuyen
                }
            });
        }

        [HttpGet("banners")]
        public async Task<IActionResult> Banner()
        {
            var banners = await context.BannerModel.ToListAsync();
            return Ok(banners);
        }

        [HttpPost("banners")]
        public async Task<IActionResult> CreateBanner([FromForm] BannerModel bannerModel, IFormFile? imageInput)
        {
            if (imageInput != null)
            {
                var newUrl = await UploadImage(imageInput, bannerModel.TenBanner ?? Guid.NewGuid().ToString());
                bannerModel.DuongDan = newUrl;
            }
            else
            {
                bannerModel.DuongDan = "null";
            }

            context.Add(bannerModel);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(Banner), new { id = bannerModel.Id_Banner }, bannerModel);
        }

        [HttpPut("banners/{id:int}")]
        public async Task<IActionResult> EditBanner(int id, [FromForm] BannerModel bannerModel, IFormFile? imageInput = null)
        {
            if (id != bannerModel.Id_Banner)
            {
                return BadRequest("Id mismatch with payload");
            }

            if (imageInput != null)
            {
                var currentUrl = bannerModel.DuongDan ?? string.Empty;
                var newUrl = await UpdateImage(currentUrl, imageInput);
                bannerModel.DuongDan = newUrl;
            }

            context.Update(bannerModel);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("banners/{id:int}")]
        public async Task<IActionResult> DeleteBanner(int id)
        {
            var banner = await context.Banners.FindAsync(id);
            if (banner == null)
            {
                return NotFound();
            }

            if (!string.IsNullOrEmpty(banner.TenBanner))
            {
                await DeleteImage(banner.TenBanner);
            }

            context.Banners.Remove(banner);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpPost("orders/{dhvc:int}/status")]
        public async Task<IActionResult> ChangeStatus(int dhvc, int value)
        {
            var donHangVanChuyen = await context.DonHangVanChuyens.Where(p => p.Id_DHVC == dhvc).FirstOrDefaultAsync();

            if (donHangVanChuyen == null)
            {
                return NotFound($"Order with ID {dhvc} not found.");
            }

            donHangVanChuyen.TinhTrang = value;
            context.Update(donHangVanChuyen);
            await context.SaveChangesAsync();
            return NoContent();
        }

        [HttpGet("earnings/last-six-months")]
        public async Task<IActionResult> GetEarningThisMonth()
        {
            var earnings = new List<decimal>();
            var currentDate = DateTime.Now;

            for (int i = 0; i < 6; i++)
            {
                var targetDate = currentDate.AddMonths(-i);
                var earning = context.DonHangs
                    .Where(d => d.TrangThai != "Chua thanh toán" && d.NgayDat.Value.Month == targetDate.Month && d.NgayDat.Value.Year == targetDate.Year)
                    .Sum(d => d.TongTien);
                earnings.Add((decimal)earning);
            }

            return Ok(earnings);
        }

        private async Task<string?> UploadImage(IFormFile fileInput, string filename)
        {
            try
            {
                using var inputStream = fileInput.OpenReadStream();
                using var image = await Image.LoadAsync(inputStream);
                var encoder = new JpegEncoder { Quality = 30 };

                using var outputStream = new MemoryStream();
                await image.SaveAsync(outputStream, encoder);
                outputStream.Seek(0, SeekOrigin.Begin);

                var storage = new FirebaseStorage("qldclb-770f5.appspot.com");
                var imageUrl = await storage.Child("images").Child(fileInput.FileName).PutAsync(outputStream);
                return imageUrl;
            }
            catch
            {
                return null;
            }
        }

        private async Task<string?> UpdateImage(string url, IFormFile fileInput)
        {
            var storage = new FirebaseStorage("qldclb-770f5.appspot.com");
            try
            {
                if (!string.IsNullOrWhiteSpace(url))
                {
                    var existingImage = await storage.Child("images").Child(Path.GetFileName(new Uri(url).LocalPath)).GetDownloadUrlAsync();
                    if (existingImage != null)
                    {
                        await storage.Child("images").Child(Path.GetFileName(new Uri(url).LocalPath)).DeleteAsync();
                    }
                }

                using var inputStream = fileInput.OpenReadStream();
                using var image = await Image.LoadAsync(inputStream);
                var encoder = new JpegEncoder { Quality = 50 };
                using var outputStream = new MemoryStream();
                await image.SaveAsync(outputStream, encoder);
                outputStream.Seek(0, SeekOrigin.Begin);
                var imageUrl = await storage.Child("images").Child(fileInput.FileName).PutAsync(outputStream);
                return imageUrl;
            }
            catch
            {
                return null;
            }
        }

        private async Task<string?> DeleteImage(string filename)
        {
            var storage = new FirebaseStorage("qldclb-770f5.appspot.com");
            if (string.IsNullOrWhiteSpace(filename))
            {
                return null;
            }

            var existingImage = await storage.Child("images").Child(Path.GetFileName(filename)).GetDownloadUrlAsync();
            if (existingImage != null)
            {
                await storage.Child("images").Child(Path.GetFileName(filename)).DeleteAsync();
            }

            return null;
        }

        private async Task ApplySaleOffInternal()
        {
            var products = await context.DungCus.ToListAsync();
            foreach (var product in products)
            {
                product.GiaKhuyenMai = 0;
                context.Update(product);
            }

            await context.SaveChangesAsync();

            var promotions = await context.KhuyenMai2s.ToListAsync();
            foreach (var km in promotions)
            {
                var details = await context.ChiTietKhuyenMais.Where(ct => ct.Id_KhuyenMai == km.Id_KhuyenMai).ToListAsync();
                foreach (var detail in details)
                {
                    var product = await context.DungCus.FirstOrDefaultAsync(d => d.Id_DungCu == detail.Id_SanPham);
                    if (product == null)
                    {
                        continue;
                    }

                    if (km.NgayBatDau <= DateTime.Now && km.NgayKetThuc >= DateTime.Now)
                    {
                        product.GiaKhuyenMai = (product.Gia * (100 - detail.GiaTriGiam)) / 100;
                    }
                    else
                    {
                        product.GiaKhuyenMai = 0;
                    }

                    context.Update(product);
                }
            }

            await context.SaveChangesAsync();
        }
    }
}
