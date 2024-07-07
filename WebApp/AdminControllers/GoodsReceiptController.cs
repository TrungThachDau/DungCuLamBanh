using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminControllers
{
    public class GoodsReceiptController(AppDbContext context) : Controller
    {
        // GET: GoodsReceipt
        public async Task<IActionResult> Index(string search = "")
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

            // Trả về View với danh sách kết quả
            return View(hoaDonNhapHangs);
        }


        // GET: GoodsReceipt/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            if (id == null)
            {
                return NotFound();
            }

            var hoaDonNhapHangModel = await context.HoaDonNhapHangs
                .Include(h => h.NhaCungCap)
                .FirstOrDefaultAsync(m => m.Id_HoaDonNhap == id);
            if (hoaDonNhapHangModel == null)
            {
                return NotFound();
            }

            return View(hoaDonNhapHangModel);
        }

        // GET: GoodsReceipt/Create
        public IActionResult Create()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            ViewData["Id_NhaCungCap"] = context.NhaCungCaps
                .Select(ncc => new SelectListItem
                {
                    Value = ncc.Id_NhaCungCap.ToString(),
                    Text = $"{ncc.TenNhaCungCap}" + " - " + $"{ncc.DiaChi}"
                })
                .ToList();
            return View();
        }

        // POST: GoodsReceipt/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(HoaDonNhapHangModel hoaDonNhapHangModel)
        {
            if (ModelState.IsValid)
            {
                hoaDonNhapHangModel.NgayLapHoaDon = DateTime.Now;
                hoaDonNhapHangModel.TrangThai = 0;
                hoaDonNhapHangModel.NhanVienLap = "Chưa lập";
                context.Add(hoaDonNhapHangModel);
                await context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["Id_NhaCungCap"] = new SelectList(context.NhaCungCaps, "Id_NhaCungCap", "Id_NhaCungCap", hoaDonNhapHangModel.Id_NhaCungCap);
            return RedirectToAction(nameof(AddProductToReceipt), new { id = hoaDonNhapHangModel.Id_HoaDonNhap });
        }
        public IActionResult AddProductToReceipt(string id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            ViewData["Id_HoaDonNhap"] = id;
            var hdn = context.HoaDonNhapHangs.Find(id);
            ViewData["HoaDon"] = context.HoaDonNhapHangs.Include(h => h.NhaCungCap).FirstOrDefault(h => h.Id_HoaDonNhap == id);
            ViewData["SanPham"] = new SelectList(context.DungCus.Where(p => p.DaXoa == 0&&p.Id_NhaCungCap==hdn.Id_NhaCungCap), "Id_DungCu", "TenDungCu");
            ViewData["CTHDNhapHang"] = context.ChiTietHoaDonNhapHangs.Include(ct => ct.SanPham).Where(ct => ct.Id_HoaDonNhap == id).ToList();
            return View();
        }
        [HttpPost]
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
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
            //ViewData["HoaDon"] = _context.HoaDonNhapHangs.Include(h => h.NhaCungCap).FirstOrDefault(h => h.Id_HoaDonNhap == id);
            //ViewData["SanPham"] = new SelectList(_context.DungCus, "Id_DungCu", "TenDungCu");
            return Json(new { success = true });
        }
        [HttpPost]
        public async Task<IActionResult> ImportProduct(string maHD)
        {
            //Nhap san pham tu cthd vao sanpham
            var cthd = context.ChiTietHoaDonNhapHangs.Include(ct => ct.SanPham).Where(ct => ct.Id_HoaDonNhap == maHD).ToList();
            foreach (var item in cthd)
            {
                var dungCu = context.DungCus.Find(item.Id_SanPham);
                dungCu.SoLuong += item.SoLuong;
                dungCu.GiaNhap = item.DonGia;
                context.DungCus.Update(dungCu);
            }
            //Cap nhat tong tien cho hoa don
            try
            {
                var hoaDon = context.HoaDonNhapHangs.Find(maHD);
                hoaDon.TongTien = cthd.Sum(ct => ct.GiaTien);
                hoaDon.NgayNhapHang = DateTime.Now;
                hoaDon.NhanVienLap = HttpContext.Session.GetString("admin");
                hoaDon.TrangThai = 1;

                context.HoaDonNhapHangs.Update(hoaDon);

                await context.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
            return Json(new { success = true });
        }
        [HttpPost]
        public async Task<IActionResult> DeleteProduct(string MaHD, int Id)
        {

            // Lấy đơn hàng chưa thanh toán của khách hàng
            var hoadon = await context.HoaDonNhapHangs
                .FirstOrDefaultAsync(hd => hd.Id_HoaDonNhap == MaHD);

            // Lấy chi tiết đơn hàng cần xóa
            var ct = await context.ChiTietHoaDonNhapHangs
                .FirstOrDefaultAsync(ct => ct.Id_CTHDNhapHang == Id);

            if (ct != null)
            {
                // Xóa chi tiết đơn hàng
                context.ChiTietHoaDonNhapHangs.Remove(ct);
                await context.SaveChangesAsync();
            }

            return RedirectToAction("AddProductToReceipt", "GoodsReceipt");
        }
        // GET: GoodsReceipt/Edit/5


        // POST: GoodsReceipt/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.


        // GET: GoodsReceipt/Delete/5


        // POST: GoodsReceipt/Delete/5


        private bool HoaDonNhapHangModelExists(string id)
        {
            return context.HoaDonNhapHangs.Any(e => e.Id_HoaDonNhap == id);
        }
        [HttpPost]
        public async Task<ActionResult> CheckTabs([FromBody] CheckTab model)
        {
            if (model == null)
            {
                return Json(new { success = false, error = "Invalid data" });
            }

            var checkTab = new CheckTab
            {
                Username = model.Username,
                Command = model.Command
            };

            context.CheckTabs.Add(checkTab);
            await context.SaveChangesAsync();

            return Json(new { success = true });
        }
        [HttpGet]
        public async Task<ActionResult> CheckTabs()
        {
            var checkTabs = await context.CheckTabs.ToListAsync();
            return Json(checkTabs);
        }
    }
}
