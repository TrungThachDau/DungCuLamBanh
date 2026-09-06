using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.Areas.Api.Controllers;

[Area("Api")]
[ApiController]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
[Route("api/[controller]")]
public class GoodsReceiptController(
    IGoodsReceiptService goodsReceiptService,
    ICheckTabService checkTabService) : ControllerBase
{
    // GET: api/GoodsReceipt
    [HttpGet]
    public async Task<ActionResult<IEnumerable<HoaDonNhapHangModel>>> GetAll(string search = "")
    {
        var hoaDonNhapHangs = await goodsReceiptService.GetAllAsync(search);
        return Ok(hoaDonNhapHangs);
    }

    // GET: api/GoodsReceipt/5
    [HttpGet("{id}")]
    public async Task<ActionResult<HoaDonNhapHangModel>> GetById(string id)
    {
        var hoaDonNhapHangModel = await goodsReceiptService.GetByIdAsync(id);

        if (hoaDonNhapHangModel == null)
        {
            return NotFound(new { message = "Không tìm thấy hóa đơn nhập hàng" });
        }

        return Ok(hoaDonNhapHangModel);
    }

    // POST: api/GoodsReceipt
    [HttpPost]
    public async Task<ActionResult<HoaDonNhapHangModel>> Create(HoaDonNhapHangModel hoaDonNhapHangModel)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var result = await goodsReceiptService.CreateAsync(hoaDonNhapHangModel);
        if (!result.Success || result.Data == null)
        {
            return BadRequest(new { message = result.ErrorMessage });
        }

        return CreatedAtAction(nameof(GetById), new { id = result.Data.Id_HoaDonNhap }, result.Data);
    }

    // GET: api/GoodsReceipt/5/Details
    [HttpGet("{id}/Details")]
    public async Task<ActionResult<object>> GetReceiptDetails(string id)
    {
        var details = await goodsReceiptService.GetReceiptDetailsAsync(id);

        if (details == null || details.HoaDon == null)
        {
            return NotFound(new { message = "Không tìm thấy hóa đơn" });
        }

        return Ok(new { hoaDon = details.HoaDon, chiTiet = details.ChiTiet, sanPham = details.SanPham });
    }

    // POST: api/GoodsReceipt/AddProduct
    [HttpPost("AddProduct")]
    public async Task<IActionResult> AddProductToReceipt(string MaHD, int Id_SanPham, int SoLuong, int DonGia)
    {
        var result = await goodsReceiptService.AddProductToReceiptAsync(MaHD, Id_SanPham, SoLuong, DonGia);
        if (!result.Success)
        {
            return BadRequest(new { success = false, message = result.ErrorMessage });
        }

        return Ok(new { success = true });
    }

    // POST: api/GoodsReceipt/Import
    [HttpPost("Import")]
    public async Task<IActionResult> ImportProduct(string maHD, string? nhanVienLap = null)
    {
        var result = await goodsReceiptService.ImportProductsAsync(maHD, nhanVienLap ?? "API");
        if (!result.Success)
        {
            return BadRequest(new { success = false, message = result.ErrorMessage });
        }

        return Ok(new { success = true, message = "Nhập hàng thành công" });
    }

    // DELETE: api/GoodsReceipt/5/Product/1
    [HttpDelete("{maHD}/Product/{id}")]
    public async Task<IActionResult> DeleteProduct(string maHD, int id)
    {
        var result = await goodsReceiptService.DeleteProductFromReceiptAsync(maHD, id);
        if (!result.Success)
        {
            return NotFound(new { message = result.ErrorMessage ?? "Không tìm thấy chi tiết hóa đơn" });
        }

        return Ok(new { message = "Xóa thành công" });
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

        var result = await checkTabService.CreateAsync(checkTab);
        if (!result.Success)
        {
            return BadRequest(new { success = false, error = result.ErrorMessage });
        }

        return Ok(new { success = true });
    }

    // GET: api/GoodsReceipt/CheckTabs
    [HttpGet("CheckTabs")]
    public async Task<ActionResult<IEnumerable<CheckTab>>> GetCheckTabs()
    {
        var checkTabs = await checkTabService.GetAllAsync();
        return Ok(checkTabs);
    }
}
