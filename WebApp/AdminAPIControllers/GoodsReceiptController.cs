using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminAPIControllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GoodsReceiptController(AppDbContext context) : ControllerBase
    {
        // GET: api/GoodsReceipt
        [HttpGet]
        public async Task<ActionResult<IEnumerable<HoaDonNhapHangModel>>> GetAll(string search = "")
        {
            // Truy vấn cơ bản bao gồm bảng HoaDonNhapHangs và bảng liên kết NhaCungCap
            var query = context.HoaDonNhapHangs.Include(h => h.NhaCungCap).AsQueryable();

            // Lọc theo từ khóa tìm kiếm nếu có
            if (!string.IsNullOrEmpty(search))
            {
                // Tìm kiếm theo Id_HoaDonNhap hoặc TenNhaCungCap
                query = query.Where(d => d.Id_HoaDonNhap.Contains(search) ||
                                         d.NhaCungCap.TenNhaCungCap.Contains(search));
            }

            // Sắp xếp kết quả theo NgayLapHoaDon giảm dần
            var hoaDonNhapHangs = await query.OrderByDescending(p => p.NgayLapHoaDon).ToListAsync();

            return hoaDonNhapHangs;
        }

        // GET: api/GoodsReceipt/5
        [HttpGet("{id}")]
        public async Task<ActionResult<HoaDonNhapHangModel>> GetById(string id)
        {
            var hoaDonNhapHangModel = await context.HoaDonNhapHangs
                .Include(h => h.NhaCungCap)
                .FirstOrDefaultAsync(m => m.Id_HoaDonNhap == id);
            
            if (hoaDonNhapHangModel == null)
            {
                return NotFound(new { message = "Không tìm thấy hóa đơn nhập hàng" });
            }

            return hoaDonNhapHangModel;
        }

        // POST: api/GoodsReceipt
        [HttpPost]
        public async Task<ActionResult<HoaDonNhapHangModel>> Create(HoaDonNhapHangModel hoaDonNhapHangModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            hoaDonNhapHangModel.NgayLapHoaDon = DateTime.Now;
            hoaDonNhapHangModel.TrangThai = 0;
            hoaDonNhapHangModel.NhanVienLap = "Chưa lập";
            context.Add(hoaDonNhapHangModel);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new { id = hoaDonNhapHangModel.Id_HoaDonNhap }, hoaDonNhapHangModel);
        }

        // GET: api/GoodsReceipt/5/Details
        [HttpGet("{id}/Details")]
        public async Task<ActionResult<object>> GetReceiptDetails(string id)
        {
            var hoaDon = await context.HoaDonNhapHangs
                .Include(h => h.NhaCungCap)
                .FirstOrDefaultAsync(h => h.Id_HoaDonNhap == id);

            if (hoaDon == null)
            {
                return NotFound(new { message = "Không tìm thấy hóa đơn" });
            }

            var chiTiet = await context.ChiTietHoaDonNhapHangs
                .Include(ct => ct.SanPham)
                .Where(ct => ct.Id_HoaDonNhap == id)
                .ToListAsync();

            var sanPham = await context.DungCus
                .Where(p => p.DaXoa == 0 && p.Id_NhaCungCap == hoaDon.Id_NhaCungCap)
                .ToListAsync();

            return new { hoaDon, chiTiet, sanPham };
        }

        // POST: api/GoodsReceipt/AddProduct
        [HttpPost("AddProduct")]
        public async Task<IActionResult> AddProductToReceipt(string MaHD, int Id_SanPham, int SoLuong, int DonGia)
        {
            var ctdhnhaphang = new CTHDNhapHangModel()
            {
                Id_HoaDonNhap = MaHD,
                Id_SanPham = Id_SanPham,
                SoLuong = SoLuong,
                DonGia = DonGia,
                GiaTien = SoLuong * DonGia
            };
            try
            {
                context.ChiTietHoaDonNhapHangs.Add(ctdhnhaphang);
                await context.SaveChangesAsync();
                return Ok(new { success = true });
            }
            catch (Exception e)
            {
                return BadRequest(new { success = false, message = e.Message });
            }
        }

        // POST: api/GoodsReceipt/Import
        [HttpPost("Import")]
        public async Task<IActionResult> ImportProduct(string maHD, string? nhanVienLap = null)
        {
            //Nhap san pham tu cthd vao sanpham
            var cthd = context.ChiTietHoaDonNhapHangs.Include(ct => ct.SanPham).Where(ct => ct.Id_HoaDonNhap == maHD).ToList();
            foreach (var item in cthd)
            {
                var dungCu = context.DungCus.Find(item.Id_SanPham);
                if (dungCu != null)
                {
                    dungCu.SoLuong += item.SoLuong;
                    dungCu.GiaNhap = item.DonGia;
                    context.DungCus.Update(dungCu);
                }
            }
            //Cap nhat tong tien cho hoa don
            try
            {
                var hoaDon = context.HoaDonNhapHangs.Find(maHD);
                if (hoaDon != null)
                {
                    hoaDon.TongTien = cthd.Sum(ct => ct.GiaTien);
                    hoaDon.NgayNhapHang = DateTime.Now;
                    hoaDon.NhanVienLap = nhanVienLap ?? "API";
                    hoaDon.TrangThai = 1;

                    context.HoaDonNhapHangs.Update(hoaDon);
                    await context.SaveChangesAsync();
                    return Ok(new { success = true, message = "Nhập hàng thành công" });
                }
                return NotFound(new { success = false, message = "Không tìm thấy hóa đơn" });
            }
            catch (Exception e)
            {
                return BadRequest(new { success = false, message = e.Message });
            }
        }

        // DELETE: api/GoodsReceipt/5/Product/1
        [HttpDelete("{maHD}/Product/{id}")]
        public async Task<IActionResult> DeleteProduct(string maHD, int id)
        {
            var ct = await context.ChiTietHoaDonNhapHangs
                .FirstOrDefaultAsync(ct => ct.Id_CTHDNhapHang == id && ct.Id_HoaDonNhap == maHD);

            if (ct == null)
            {
                return NotFound(new { message = "Không tìm thấy chi tiết hóa đơn" });
            }

            context.ChiTietHoaDonNhapHangs.Remove(ct);
            await context.SaveChangesAsync();

            return Ok(new { message = "Xóa thành công" });
        }

        private bool HoaDonNhapHangModelExists(string id)
        {
            return context.HoaDonNhapHangs.Any(e => e.Id_HoaDonNhap == id);
        }

        // POST: api/GoodsReceipt/CheckTabs
        [HttpPost("CheckTabs")]
        public async Task<ActionResult> CreateCheckTab([FromBody] CheckTab model)
        {
            if (model == null)
            {
                return BadRequest(new { success = false, error = "Invalid data" });
            }

            var checkTab = new CheckTab
            {
                Username = model.Username,
                Command = model.Command
            };

            context.CheckTabs.Add(checkTab);
            await context.SaveChangesAsync();

            return Ok(new { success = true });
        }

        // GET: api/GoodsReceipt/CheckTabs
        [HttpGet("CheckTabs")]
        public async Task<ActionResult<IEnumerable<CheckTab>>> GetCheckTabs()
        {
            var checkTabs = await context.CheckTabs.ToListAsync();
            return Ok(checkTabs);
        }
    }
}
