using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Components;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.Controllers
{
    [ProfileStatusFilter]
    public class ProductController(IProductService productService, ILogger<ProductController> logger) : Controller
    {
        public async Task<IActionResult> Index(string search = "", string SortColumn = "Newest", int min = 0, int max = 0, int page = 1, string type = "", string nph = "")
        {
            var (categories, manufacturers) = await productService.GetProductFiltersAsync();
            ViewBag.LoaiPMList = categories;
            ViewBag.Publisher = manufacturers;

            var (products, totalPages, currentPage) = await productService.GetProductListAsync(search, SortColumn, min, max, page, type, nph);

            if (products.Count == 0)
            {
                return View(null);
            }

            ViewBag.TotalPage = totalPages;
            ViewBag.Page = currentPage;

            return View(products);
        }

        public async Task<IActionResult> Detail(int? id, string MyData)
        {
            if (id == null)
            {
                return NotFound();
            }

            ViewBag.email = HttpContext.Session.GetString("email");
            HttpContext.Session.SetString("idspvuaxem", id.Value.ToString());

            var product = await productService.GetProductDetailAsync((int)id);

            if (product == null)
            {
                return NotFound();
            }

            // Check stock status
            if (product.SoLuong <= 0)
            {
                ViewBag.SoldOut = "Đã bán hết";
                ViewBag.TonKho = 0;
            }
            else if (product.SoLuong < 5)
            {
                ViewBag.SoldOut = "Còn ít hàng";
                ViewBag.TonKho = product.SoLuong;
            }
            else
            {
                ViewBag.SoldOut = "Còn hàng";
                ViewBag.TonKho = product.SoLuong;
            }

            // Check if favorite
            var uid = HttpContext.Session.GetString("uid");
            if (uid != null)
            {
                var isFavorite = await productService.IsFavoriteAsync((int)id, uid);
                ViewBag.isFavorite = isFavorite;
            }

            SetSession("idspvuaxem", id?.ToString() ?? string.Empty);

            // Calculate discount percentage
            double discountPercentage = 0;
            if (product.GiaKhuyenMai != 0 && product.Gia.HasValue && product.GiaKhuyenMai.HasValue)
            {
                discountPercentage = 100 - (((double)product.GiaKhuyenMai / (double)product.Gia) * 100);
                ViewBag.phantramkm = discountPercentage;
            }

            return View(product);
        }

        private void SetSession(string key, string value)
        {
            HttpContext.Session.Set(key, System.Text.Encoding.UTF8.GetBytes(value));
        }
    }
}
