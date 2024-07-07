using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Components;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Controllers
{
    [ProfileStatusFilter]
    public class ProductController(AppDbContext context, ILogger<AccountController> logger) : Controller
    {
        private readonly ILogger<AccountController> _logger = logger;

        public async Task<IActionResult> Index(string search = "", string SortColumn = "Newest", int min = 0, int max = 0, int page = 1, string type = "", string nph = "")
        {
            // Lấy danh sách các loại dụng cụ và nhà cung cấp để hiển thị trong dropdown list
            SelectList loaipmList = new SelectList(context.LoaiDungCus, "Id_LoaiDungCu", "TenLoaiDungCu");
            ViewBag.LoaiPMList = loaipmList;
            ViewBag.Publisher = new SelectList(context.NhaSanXuats, "Id_NhaSanXuat", "TenNSX");

            // Lấy dữ liệu dụng cụ từ database
            IQueryable<DungCuModel> query = context.DungCus
                .Include(p => p.LoaiDungCu)
                .Where(p => p.DaXoa == 0 && p.SoLuong != 0);

            // Lọc theo giá
            if (min > 0 && max > 0)
            {
                query = query.Where(p => p.Gia >= min && p.Gia <= max);
            }

            // Lọc theo từ khóa tìm kiếm
            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(p => p.TenDungCu.Contains(search));
            }

            // Lọc theo loại dụng cụ
            if (!string.IsNullOrEmpty(type))
            {
                query = query.Where(p => p.LoaiDungCu.TenLoaiDungCu.Contains(type));
            }

            // Lọc theo nhà cung cấp
            if (!string.IsNullOrEmpty(nph))
            {
                query = query.Where(p => p.NhaSanXuat.TenNSX.Contains(nph));
            }
            var orderDetails = await context.ChiTietDonHangs
                .GroupBy(p => p.Id_DungCu)
                .Select(p => new
                {
                    Id_DungCu = p.Key,
                    SoLuong = p.Sum(x => x.SoLuong)
                })
                .OrderByDescending(x => x.SoLuong)
                .ToListAsync();

// Dictionary để tra cứu thứ tự sắp xếp dựa trên Id_DungCu
            var productRank = orderDetails
                .Select((item, index) => new { item.Id_DungCu, Rank = index + 1 })
                .ToDictionary(x => x.Id_DungCu, x => x.Rank);

            // Sắp xếp theo cột được chọn
            query = SortColumn switch
            {
                "3" => query.OrderBy(p => p.TenDungCu),
                "4" => query.OrderByDescending(p => p.TenDungCu),
                "1" => query.OrderBy(p => p.TenDungCu),
                "2" => query.OrderByDescending(p => p.TenDungCu),
                "5" => query.OrderBy(p => p.Id_DungCu),
                "6" => query.OrderByDescending(p => p.Id_DungCu),
                //Lấy ra danh sách sp bán chạy từ productCoun
                "7" => query.OrderBy(p => productRank.ContainsKey(p.Id_DungCu) ? productRank[p.Id_DungCu] : int.MaxValue),
                
                _ => query.OrderByDescending(p => p.Id_LoaiDungCu),
            };
            // Giả sử bạn có một tập hợp OrderDetails (chi tiết hóa đơn) 
            

// Nếu cần lấy kết quả dưới dạng khác, bạn có thể tiếp tục thao tác với productCounts

            // Kiểm tra nếu không có kết quả
            int TotalItems = await query.CountAsync();
            if (TotalItems == 0)
            {
                // Nếu không tìm thấy kết quả nào, trả về null
                return View(null);
            }

            // Phân trang
            int ItemOfPage = 15;
            int TotalPage = (int)Math.Ceiling((double)TotalItems / ItemOfPage);

            if (page < 1)
            {
                page = 1;
            }
            if (page > TotalPage)
            {
                page = TotalPage;
            }

            int Start = (page - 1) * ItemOfPage;

            // Lấy danh sách dữ liệu đã phân trang
            var result = await query.Skip(Start).Take(ItemOfPage).ToListAsync();

            // Truyền các thông số phân trang và dữ liệu vào ViewBag để hiển thị trong View
            ViewBag.TotalPage = TotalPage;
            ViewBag.Page = page;

            return View(result);
        }



        public async Task<IActionResult> Detail(int? id, string MyData)
        {
            if (id == null)
            {
                return NotFound();
            }
            ViewBag.email = HttpContext.Session.GetString("email");
            HttpContext.Session.SetString("idspvuaxem", id.Value.ToString());

            var dungCuModel = await context.DungCus
                .Include(p => p.LoaiDungCu)
                .Include(p => p.NhaCungCap)
                .Include(p=>p.NhaSanXuat)
                .FirstOrDefaultAsync(m => m.Id_DungCu == id);

            if (dungCuModel == null)
            {
                return NotFound();
            }

            if (dungCuModel.SoLuong <= 0)
            {
                ViewBag.SoldOut = "Đã bán hết";
                ViewBag.TonKho = 0;
            }
            //Kiểm ra yêu thích
            var uid = HttpContext.Session.GetString("uid");
            if (uid != null)
            {
                var idsp = context.YeuThichs.Where(p => p.Id_SanPham == id && p.Id_KhachHang == uid).FirstOrDefault();
                if (idsp != null)
                {
                    ViewBag.isFavorite = true;
                }
                else
                {
                    ViewBag.isFavorite = false;
                }
            }
            else if (dungCuModel.SoLuong < 5)
            {
                ViewBag.SoldOut = "Còn ít hàng";
                ViewBag.TonKho = dungCuModel.SoLuong;
            }
            else
            {
                ViewBag.SoldOut = "Còn hàng";
                ViewBag.TonKho = dungCuModel.SoLuong;
            }

            SetSession("idspvuaxem", id.ToString());
            double phantramkhuyenmai = 0;
            if (dungCuModel.GiaKhuyenMai != 0)
            {
                phantramkhuyenmai = 100-(((double)dungCuModel.GiaKhuyenMai / (double)dungCuModel.Gia) * 100);
                ViewBag.phantramkm = phantramkhuyenmai;
            }
            return View(dungCuModel);
        }

        private void SetSession(string key, string value)
        {
            HttpContext.Session.Set(key, System.Text.Encoding.UTF8.GetBytes(value));
        }
    }
}
