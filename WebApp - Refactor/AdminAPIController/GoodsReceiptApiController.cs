using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminAPIController
{
    [ApiController]
    [Route("api/admin/[controller]")]
    public class GoodsReceiptApiController(AppDbContext context) : ControllerBase
    {
        [HttpGet]
        public async Task<ActionResult<IEnumerable<HoaDonNhapHangModel>>> GetAllAsync(string search = "")
        {
            var query = context.HoaDonNhapHangs.Include(h => h.NhaCungCap).AsQueryable();

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(d => d.Id_HoaDonNhap.Contains(search) || (d.NhaCungCap != null && d.NhaCungCap.TenNhaCungCap != null && d.NhaCungCap.TenNhaCungCap.Contains(search)));
            }

            var receipts = await query.OrderByDescending(p => p.NgayLapHoaDon).ToListAsync();
            return Ok(receipts);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<HoaDonNhapHangModel>> GetByIdAsync(string id)
        {
            var receipt = await context.HoaDonNhapHangs.Include(h => h.NhaCungCap).FirstOrDefaultAsync(m => m.Id_HoaDonNhap == id);
            if (receipt == null)
            {
                return NotFound();
            }

            return Ok(receipt);
        }

        [HttpPost]
        public async Task<ActionResult<HoaDonNhapHangModel>> CreateAsync(HoaDonNhapHangModel hoaDonNhapHangModel)
        {
            hoaDonNhapHangModel.NgayLapHoaDon = DateTime.Now;
            hoaDonNhapHangModel.TrangThai = 0;
            hoaDonNhapHangModel.NhanVienLap = "Chua lap";
            context.Add(hoaDonNhapHangModel);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetByIdAsync), new { id = hoaDonNhapHangModel.Id_HoaDonNhap }, hoaDonNhapHangModel);
        }

        [HttpGet("{id}/items")]
        public async Task<IActionResult> GetItemsAsync(string id)
        {
            var receipt = await context.HoaDonNhapHangs.Include(h => h.NhaCungCap).FirstOrDefaultAsync(h => h.Id_HoaDonNhap == id);
            if (receipt == null)
            {
                return NotFound();
            }

            var availableProducts = await context.DungCus.Where(p => p.DaXoa == 0 && p.Id_NhaCungCap == receipt.Id_NhaCungCap).ToListAsync();
            var details = await context.ChiTietHoaDonNhapHangs.Include(ct => ct.SanPham).Where(ct => ct.Id_HoaDonNhap == id).ToListAsync();

            return Ok(new
            {
                Receipt = receipt,
                AvailableProducts = availableProducts,
                Items = details
            });
        }

        [HttpPost("{id}/items")]
        public async Task<IActionResult> AddItemAsync(string id, GoodsReceiptItemRequest request)
        {
            var receipt = await context.HoaDonNhapHangs.FindAsync(id);
            if (receipt == null)
            {
                return NotFound();
            }

            var item = new CTHDNhapHangModel
            {
                Id_HoaDonNhap = id,
                Id_SanPham = request.Id_SanPham,
                SoLuong = request.SoLuong,
                DonGia = request.DonGia,
                GiaTien = request.SoLuong * request.DonGia
            };

            context.ChiTietHoaDonNhapHangs.Add(item);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetItemsAsync), new { id }, item);
        }

        [HttpPost("{id}/import")]
        public async Task<IActionResult> ImportProductAsync(string id)
        {
            var details = await context.ChiTietHoaDonNhapHangs.Include(ct => ct.SanPham).Where(ct => ct.Id_HoaDonNhap == id).ToListAsync();
            if (details.Count == 0)
            {
                return BadRequest("Receipt does not contain any items");
            }

            foreach (var item in details)
            {
                var product = await context.DungCus.FindAsync(item.Id_SanPham);
                if (product == null)
                {
                    continue;
                }

                product.SoLuong += item.SoLuong;
                product.GiaNhap = item.DonGia;
                context.DungCus.Update(product);
            }

            var receipt = await context.HoaDonNhapHangs.FindAsync(id);
            if (receipt == null)
            {
                return NotFound();
            }

            receipt.TongTien = details.Sum(ct => ct.GiaTien);
            receipt.NgayNhapHang = DateTime.Now;
            receipt.NhanVienLap = HttpContext.Session.GetString("admin") ?? "api";
            receipt.TrangThai = 1;

            context.HoaDonNhapHangs.Update(receipt);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{receiptId}/items/{itemId:int}")]
        public async Task<IActionResult> DeleteItemAsync(string receiptId, int itemId)
        {
            var receipt = await context.HoaDonNhapHangs.FirstOrDefaultAsync(hd => hd.Id_HoaDonNhap == receiptId);
            if (receipt == null)
            {
                return NotFound();
            }

            var detail = await context.ChiTietHoaDonNhapHangs.FirstOrDefaultAsync(ct => ct.Id_CTHDNhapHang == itemId);
            if (detail == null)
            {
                return NotFound();
            }

            context.ChiTietHoaDonNhapHangs.Remove(detail);
            await context.SaveChangesAsync();

            return NoContent();
        }

        [HttpPost("check-tabs")]
        public async Task<IActionResult> CheckTabs([FromBody] CheckTab model)
        {
            if (model == null)
            {
                return BadRequest("Invalid data");
            }

            var checkTab = new CheckTab
            {
                Username = model.Username,
                Command = model.Command
            };

            context.CheckTabs.Add(checkTab);
            await context.SaveChangesAsync();

            return Ok(checkTab);
        }

        [HttpGet("check-tabs")]
        public async Task<ActionResult<IEnumerable<CheckTab>>> GetCheckTabs()
        {
            var checkTabs = await context.CheckTabs.ToListAsync();
            return Ok(checkTabs);
        }
    }

    public record GoodsReceiptItemRequest(int Id_SanPham, int SoLuong, int DonGia);
}
