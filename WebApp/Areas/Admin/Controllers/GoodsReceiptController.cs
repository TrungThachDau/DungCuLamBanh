using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.Areas.Admin.Controllers;

[Area("Admin")]
public class GoodsReceiptController(
    IGoodsReceiptService goodsReceiptService,
    ISupplierService supplierService,
    IProductService productService,
    ICheckTabService checkTabService) : Controller
{
    // GET: GoodsReceipt
    public async Task<IActionResult> Index(string search = "")
    {
        var hoaDonNhapHangs = await goodsReceiptService.GetAllAsync(search);
        return View(hoaDonNhapHangs);
    }

    // GET: GoodsReceipt/Details/5
    public async Task<IActionResult> Details(string id)
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        if (string.IsNullOrEmpty(id))
        {
            return NotFound();
        }

        var hoaDonNhapHangModel = await goodsReceiptService.GetByIdAsync(id);
        if (hoaDonNhapHangModel == null)
        {
            return NotFound();
        }

        return View(hoaDonNhapHangModel);
    }

    // GET: GoodsReceipt/Create
    public async Task<IActionResult> Create()
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }

        var suppliers = await supplierService.GetAllAsync();
        ViewData["Id_NhaCungCap"] = suppliers
            .Select(ncc => new SelectListItem
            {
                Value = ncc.Id_NhaCungCap.ToString(),
                Text = $"{ncc.TenNhaCungCap} - {ncc.DiaChi}"
            })
            .ToList();

        return View();
    }

    // POST: GoodsReceipt/Create
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(HoaDonNhapHangModel hoaDonNhapHangModel)
    {
        if (ModelState.IsValid)
        {
            var result = await goodsReceiptService.CreateAsync(hoaDonNhapHangModel);
            if (result.Success)
            {
                return RedirectToAction(nameof(Index));
            }
        }

        var suppliers = await supplierService.GetAllAsync();
        ViewData["Id_NhaCungCap"] = new SelectList(suppliers, "Id_NhaCungCap", "Id_NhaCungCap", hoaDonNhapHangModel.Id_NhaCungCap);
        return RedirectToAction(nameof(AddProductToReceipt), new { id = hoaDonNhapHangModel.Id_HoaDonNhap });
    }

    public async Task<IActionResult> AddProductToReceipt(string id)
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }

        ViewData["Id_HoaDonNhap"] = id;
        var details = await goodsReceiptService.GetReceiptDetailsAsync(id);
        if (details == null)
        {
            return NotFound();
        }

        ViewData["HoaDon"] = details.HoaDon;
        ViewData["SanPham"] = new SelectList(details.SanPham, "Id_DungCu", "TenDungCu");
        ViewData["CTHDNhapHang"] = details.ChiTiet;
        return View();
    }

    [HttpPost]
    public async Task<IActionResult> AddProductToReceipt(string MaHD, int Id_SanPham, int SoLuong, int DonGia)
    {
        var result = await goodsReceiptService.AddProductToReceiptAsync(MaHD, Id_SanPham, SoLuong, DonGia);
        if (!result.Success)
        {
            return Json(new { success = false, message = result.ErrorMessage });
        }

        return Json(new { success = true });
    }

    [HttpPost]
    public async Task<IActionResult> ImportProduct(string maHD)
    {
        var admin = HttpContext.Session.GetString("admin");
        var result = await goodsReceiptService.ImportProductsAsync(maHD, admin);
        if (!result.Success)
        {
            return Json(new { success = false, message = result.ErrorMessage });
        }

        return Json(new { success = true });
    }

    [HttpPost]
    public async Task<IActionResult> DeleteProduct(string MaHD, int Id)
    {
        await goodsReceiptService.DeleteProductFromReceiptAsync(MaHD, Id);
        return RedirectToAction("AddProductToReceipt", "GoodsReceipt");
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

        var result = await checkTabService.CreateAsync(checkTab);
        if (!result.Success)
        {
            return Json(new { success = false, error = result.ErrorMessage });
        }

        return Json(new { success = true });
    }

    [HttpGet]
    public async Task<ActionResult> CheckTabs()
    {
        var checkTabs = await checkTabService.GetAllAsync();
        return Json(checkTabs);
    }
}
