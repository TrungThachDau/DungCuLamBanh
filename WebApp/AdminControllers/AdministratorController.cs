using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Diagnostics;
using WebDungCuLamBanh.Helpers;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Models.admin;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.AdminControllers
{
    public class AdministratorController : Controller
    {
        private readonly IAdministratorService _administratorService;

        public AdministratorController(IAdministratorService administratorService)
        {
            _administratorService = administratorService;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index(AdminModel adminModel)
        {
            try
            {
                var admin = await _administratorService.AuthenticateAsync(adminModel);
                if (admin != null && admin.Quyen == 1)
                {
                    HttpContext.Session.Set("admin", System.Text.Encoding.UTF8.GetBytes(admin.TenNguoiDung.ToString()));
                    return RedirectToAction("Dashboard");
                }

                ViewBag.Error = "Dang nh?p kh�ng th�nh c�ng!";
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }

        public IActionResult SignOut()
        {
            HttpContext.Session.Remove("admin");
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Dashboard(DateTime fromDate, DateTime toDate)
        {
            ViewBag.fromDate = fromDate;
            ViewBag.toDate = toDate;
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var data = await _administratorService.GetDashboardAsync(fromDate, toDate);
            ViewBag.tienVatThangNay = HtmlHelpers.FormatCurrency((decimal)data.TienVatThangNay);
            ViewBag.tienShipThangNay = HtmlHelpers.FormatCurrency((decimal)data.TienShipThangNay);
            ViewBag.doanhThuSauThuevaChiPhiThangNay = HtmlHelpers.FormatCurrency((decimal)data.DoanhThuSauThuevaChiPhiThangNay);
            ViewBag.tienNhapHangThangNay = HtmlHelpers.FormatCurrency((decimal)data.TienNhapHangThangNay);
            ViewBag.loiNhuanThangNay = HtmlHelpers.FormatCurrency((decimal)data.LoiNhuanThangNay);
            ViewBag.vatThangNay = HtmlHelpers.FormatCurrency((decimal)data.VatThangNay);
            ViewBag.thangNay = data.ThangNay;
            ViewBag.doanhThuThangNay = HtmlHelpers.FormatCurrency((decimal)data.DoanhThuThangNay);
            ViewBag.donHangChoXuLy = data.DonHangChoXuLy;

            ViewBag.doanhThuLoc = data.DoanhThuLoc;
            ViewBag.tienShipLoc = data.TienShipLoc;
            ViewBag.doanhThuSauThuevaChiPhiLoc = data.DoanhThuSauThuevaChiPhiLoc;
            ViewBag.tienNhapHangLoc = data.TienNhapHangLoc;
            ViewBag.tienLoiLoc = data.TienLoiLoc;
            ViewBag.vatLoc = data.VatLoc;
            ViewBag.fromDate = data.FromDate;
            ViewBag.toDate = data.ToDate;

            ViewBag.doanhThuHomNay = HtmlHelpers.FormatCurrency((decimal)data.DoanhThuHomNay);
            ViewBag.tienShipHomNay = HtmlHelpers.FormatCurrency((decimal)data.TienShipHomNay);
            ViewBag.doanhThuSauThuevaChiPhiHomNay = HtmlHelpers.FormatCurrency((decimal)data.DoanhThuSauThuevaChiPhiHomNay);
            ViewBag.tienNhapHangHomNay = HtmlHelpers.FormatCurrency((decimal)data.TienNhapHangHomNay);
            ViewBag.tienLoiHomNay = HtmlHelpers.FormatCurrency((decimal)data.TienLoiHomNay);
            ViewBag.vatHomNay = HtmlHelpers.FormatCurrency((decimal)data.VatHomNay);

            ViewData["ProductInfo"] = data.TopProducts;
            return View();
        }

        public async Task<IActionResult> Product(string search = "")
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var products = await _administratorService.GetProductsAsync(search);
            return View(products);
        }

        public async Task<IActionResult> CreateProduct()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            await SetProductFormOptionsAsync();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateProduct(DungCuModel dungCuModel, IFormFile? imageInput = null)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var result = await _administratorService.CreateProductAsync(dungCuModel, imageInput);
                    if (!result.Success)
                    {
                        ModelState.AddModelError(string.Empty, result.ErrorMessage ?? "Da c� l?i x?y ra.");
                        await SetProductFormOptionsAsync();
                        return View(dungCuModel);
                    }

                    return RedirectToAction(nameof(Product));
                }
            }
            catch (Exception ex)
            {
                return View("Error", new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier, Message = ex.Message });
            }

            await SetProductFormOptionsAsync();
            return View(dungCuModel);
        }

        public async Task<IActionResult> EditProduct(int? id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            if (id == null)
            {
                return NotFound();
            }

            var dungCuModel = await _administratorService.GetProductForEditAsync(id);
            if (dungCuModel == null)
            {
                return NotFound();
            }

            await SetProductFormOptionsAsync(dungCuModel);
            return View(dungCuModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditProduct(int id, DungCuModel dungCuModel, IFormFile? imageInput = null)
        {
            if (id != dungCuModel.Id_DungCu)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var result = await _administratorService.UpdateProductAsync(dungCuModel, imageInput);
                    if (!result.Success)
                    {
                        ModelState.AddModelError(string.Empty, result.ErrorMessage ?? "Da c� l?i x?y ra.");
                        await SetProductFormOptionsAsync(dungCuModel);
                        return View(dungCuModel);
                    }
                }
                catch (Exception ex)
                {
                    return View("Error", new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier, Message = ex.Message });
                }
                return RedirectToAction(nameof(Product));
            }

            await SetProductFormOptionsAsync(dungCuModel);
            return View(dungCuModel);
        }

        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var dungCuModel = await _administratorService.GetProductForEditAsync(id);
            if (dungCuModel == null)
            {
                return NotFound();
            }

            return View(dungCuModel);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            try
            {
                var result = await _administratorService.SoftDeleteProductAsync(id);
                if (!result.Success)
                {
                    return View("Error", new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier, Message = result.ErrorMessage });
                }

                return RedirectToAction(nameof(Product));
            }
            catch (Exception ex)
            {
                return View("Error", new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier, Message = ex.Message });
            }
        }

        public async Task<IActionResult> Category()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var viewModel = await _administratorService.GetCategoriesAsync();
            return View(viewModel);
        }

        [HttpPost]
        public async Task<IActionResult> CreateCategory(string TenLoaiDungCu)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            try
            {
                if (ModelState.IsValid)
                {
                    var result = await _administratorService.CreateCategoryAsync(TenLoaiDungCu);
                    if (!result.Success)
                    {
                        ModelState.AddModelError(string.Empty, result.ErrorMessage ?? "Da c� l?i x?y ra.");
                        var viewModel = await _administratorService.GetCategoriesAsync();
                        return View("Category", viewModel);
                    }

                    return RedirectToAction(nameof(Category));
                }
            }
            catch (Exception ex)
            {
                return View("Error", new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier, Message = ex.Message });
            }

            var fallbackViewModel = await _administratorService.GetCategoriesAsync();
            return View("Category", fallbackViewModel);
        }

        public async Task<IActionResult> SaleOff()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            await _administratorService.ApplySaleOffAsync();
            var appDbContext = await _administratorService.GetSaleOffsAsync();
            return View(appDbContext);
        }

        public async Task<IActionResult> CreateSaleOff()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            var products = await _administratorService.GetProductsAsync(string.Empty);
            ViewData["Id_SanPham"] = new SelectList(products, "Id_DungCu", "TenDungCu");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateSaleOff(KhuyenMaiModel khuyenMai2)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var result = await _administratorService.CreateSaleOffAsync(khuyenMai2);
            if (!result.Success)
            {
                ModelState.AddModelError(string.Empty, result.ErrorMessage ?? "Da c� l?i x?y ra.");
                var products = await _administratorService.GetProductsAsync(string.Empty);
                ViewData["Id_SanPham"] = new SelectList(products, "Id_DungCu", "TenDungCu");
                return View(khuyenMai2);
            }

            return RedirectToAction(nameof(AddProductToSaleOff), new { id = khuyenMai2.Id_KhuyenMai });
        }

        public async Task<IActionResult> DeleteSaleOff(int? id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            await _administratorService.DeleteSaleOffAsync(id);
            return RedirectToAction(nameof(SaleOff));
        }

        public async Task<IActionResult> AddProductToSaleOff(int id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            var data = await _administratorService.GetSaleOffDetailAsync(id);
            ViewData["Id_KhuyenMai"] = id;
            ViewData["KhuyenMai"] = data.KhuyenMai;
            ViewData["SanPham"] = new SelectList(data.Products, "Id_DungCu", "TenDungCu");
            ViewData["ChiTietKhuyenMai"] = data.Details;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddProductToSaleOff(ChiTietKhuyenMaiModel chiTietKhuyenMai)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var result = await _administratorService.AddProductToSaleOffAsync(chiTietKhuyenMai);
            if (!result.Success)
            {
                return Json(new { success = false, message = result.ErrorMessage });
            }
            return Json(new { success = true });
        }

        [HttpPost]
        public async Task<IActionResult> DeleteProductSaleOff(int Id_KhuyenMai, int Id_CTKM)
        {
            await _administratorService.DeleteProductSaleOffAsync(Id_KhuyenMai, Id_CTKM);
            return RedirectToAction("AddProductToSaleOff", "Administrator", new { id = Id_KhuyenMai });
        }

        [HttpPost]
        public async Task<ActionResult> ApplySaleOff()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var result = await _administratorService.ApplySaleOffAsync();
            if (!result.Success)
            {
                return Json(new { success = false, message = result.ErrorMessage });
            }

            return Json(new { success = true });
        }

        public async Task<IActionResult> Voucher()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            var appDbContext = await _administratorService.GetVouchersAsync();
            return View(appDbContext);
        }

        public IActionResult CreateVoucher()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateVoucher(MaGiamGiaModel maGiamGia)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var result = await _administratorService.CreateVoucherAsync(maGiamGia);
            if (!result.Success)
            {
                ModelState.AddModelError(string.Empty, result.ErrorMessage ?? "Da c� l?i x?y ra.");
                return View(maGiamGia);
            }

            return RedirectToAction(nameof(Voucher));
        }

        public async Task<IActionResult> DeleteVoucher(string? id)
        {
            await _administratorService.DeleteVoucherAsync(id);
            return RedirectToAction(nameof(Voucher));
        }

        public async Task<IActionResult> DeleteCategory(int? id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var result = await _administratorService.DeleteCategoryAsync(id);
            if (!result.Success)
            {
                return View("Error", new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier, Message = result.ErrorMessage ?? "Da c� l?i x?y ra." });
            }

            return RedirectToAction(nameof(Category));
        }

        public async Task<IActionResult> AllOrders()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }

            var data = await _administratorService.GetAllOrdersAsync();
            ViewBag.donHangChuaGiao = data.DonHangChuaGiao;
            ViewBag.donHangDaGiao = data.DonHangDaGiao;
            ViewBag.donHangDangGiao = data.DonHangDangGiao;
            ViewBag.donHangDaHuy = data.DonHangDaHuy;
            ViewData["TrangThaiVanChuyen"] = data.ShippingStatusOptions;
            return View(data.Orders);
        }

        public async Task<IActionResult> OrdersNotDelivered()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            var data = await _administratorService.GetOrdersNotDeliveredAsync();
            ViewData["TrangThaiVanChuyen"] = data.ShippingStatusOptions;
            return View(data.Orders);
        }

        public async Task<IActionResult> OrdersDelivered()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            var data = await _administratorService.GetOrdersDeliveredAsync();
            ViewData["TrangThaiVanChuyen"] = data.ShippingStatusOptions;
            return View(data.Orders);
        }

        public async Task<IActionResult> OrderDetail(string id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            var session = HttpContext.Session.GetString("admin");
            ViewBag.email = session;

            var result = await _administratorService.GetOrderDetailAsync(id);
            if (!result.Success || result.Data?.ViewModel == null)
            {
                return NotFound(result.ErrorMessage ?? "Kh�ng t�m th?y h�a don.");
            }

            ViewBag.tamtinh = result.Data.TamTinh;
            ViewBag.vat = result.Data.Vat;
            ViewBag.magiamgia = result.Data.GiaTriGiam;
            ViewBag.tongtien = result.Data.TongTien;
            ViewBag.phivanchuyen = result.Data.PhiVanChuyen;

            return View(result.Data.ViewModel);
        }

        public async Task<IActionResult> Banner()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            var appDbContext = await _administratorService.GetBannersAsync();
            return View(appDbContext);
        }

        public IActionResult CreateBanner()
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateBanner(BannerModel bannerModel, IFormFile? imageInput)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var result = await _administratorService.CreateBannerAsync(bannerModel, imageInput);
                    if (!result.Success)
                    {
                        ModelState.AddModelError(string.Empty, result.ErrorMessage ?? "Da c� l?i x?y ra.");
                        return View(bannerModel);
                    }
                    return RedirectToAction(nameof(Banner));
                }
            }
            catch (Exception ex)
            {
                return View("Error", new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier, Message = ex.Message });
            }
            return View(bannerModel);
        }

        public async Task<IActionResult> EditBanner(int? id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            if (id == null)
            {
                return NotFound();
            }

            var bannerModel = await _administratorService.GetBannerAsync(id);
            if (!bannerModel.Success || bannerModel.Data == null)
            {
                return NotFound();
            }
            return View(bannerModel.Data);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditBanner(int id, BannerModel bannerModel, IFormFile? imageInput = null)
        {
            if (id != bannerModel.Id_Banner)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var result = await _administratorService.UpdateBannerAsync(bannerModel, imageInput);
                    if (!result.Success)
                    {
                        ModelState.AddModelError(string.Empty, result.ErrorMessage ?? "Da c� l?i x?y ra.");
                        return View(bannerModel);
                    }
                }
                catch (Exception)
                {
                    return NotFound();
                }
                return RedirectToAction(nameof(Index));
            }
            return View(bannerModel);
        }

        public async Task<IActionResult> DeleteBanner(int? id)
        {
            if (HttpContext.Session.GetString("admin") == null)
            {
                return RedirectToAction("Index");
            }
            await _administratorService.DeleteBannerAsync(id);
            return RedirectToAction(nameof(Banner));
        }

        [HttpPost]
        [Route("/Administrator/ChangeStatus")]
        public async Task<IActionResult> ChangeStatus(int dhvc, int value)
        {
            var result = await _administratorService.ChangeStatusAsync(dhvc, value);
            if (!result.Success)
            {
                return Json(new { success = false, error = result.ErrorMessage });
            }

            return Json(new { success = true });
        }

        [HttpGet]
        [Route("/Administrator/GetEarningThisMonth")]
        public async Task<IActionResult> GetEarningThisMonth()
        {
            var earnings = await _administratorService.GetEarningThisMonthAsync();
            return Json(earnings);
        }

        private async Task SetProductFormOptionsAsync(DungCuModel? dungCuModel = null)
        {
            var options = await _administratorService.GetProductFormOptionsAsync();
            ViewData["LoaiDungCu"] = new SelectList(options.Categories, "Id_LoaiDungCu", "TenLoaiDungCu", dungCuModel?.Id_LoaiDungCu);
            ViewData["Id_LoaiDungCu"] = new SelectList(options.Categories, "Id_LoaiDungCu", "TenLoaiDungCu", dungCuModel?.Id_LoaiDungCu);
            ViewData["NhaCungCap"] = options.Suppliers
                .Select(ncc => new SelectListItem
                {
                    Value = ncc.Id_NhaCungCap.ToString(),
                    Text = $"{ncc.TenNhaCungCap}" + " - " + $"{ncc.DiaChi}"
                })
                .ToList();
            ViewData["Id_NhaCungCap"] = ViewData["NhaCungCap"];
            ViewData["NhaSanXuat"] = options.Manufacturers
                .Select(ncc => new SelectListItem
                {
                    Value = ncc.Id_NhaSanXuat.ToString(),
                    Text = $"{ncc.TenNSX}"
                })
                .ToList();
            ViewData["Id_NhaSanXuat"] = ViewData["NhaSanXuat"];
        }
    }
}
