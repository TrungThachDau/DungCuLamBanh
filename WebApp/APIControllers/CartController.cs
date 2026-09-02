using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.API;

[Route("api/[controller]")]
[ApiController]
public class CartController(ICartService cartService) : ControllerBase
{
    // GET: api/Cart
    [HttpGet]
    public async Task<ActionResult<IEnumerable<DonHangModel>>> GetChiTietDonHangs()
    {
        var orders = await cartService.GetAllOrdersAsync();
        return Ok(orders);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult> GetChiTietDonHangModel(string id)
    {
        var ctdh = await cartService.GetUnpaidOrderDetailsByCustomerIdAsync(id);

        if (ctdh == null)
        {
            return NotFound();
        }

        return Ok(ctdh);
    }

    [HttpGet("total/{id}")]
    public async Task<ActionResult> ToTal(string id)
    {
        var total = await cartService.GetUnpaidOrderTotalAsync(id);
        if (total == null)
        {
            return NotFound();
        }

        return Ok(total);
    }

    // PUT: api/Cart/5
    [HttpPut("{id}")]
    public async Task<IActionResult> PutChiTietDonHangModel(int id, ChiTietDonHangModel chiTietDonHangModel)
    {
        if (id != chiTietDonHangModel.Id_ChiTietDonHang)
        {
            return BadRequest();
        }

        var result = await cartService.UpdateOrderDetailAsync(chiTietDonHangModel);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }

    // POST: api/Cart
    [HttpPost]
    public async Task<ActionResult<ChiTietDonHangModel>> PostChiTietDonHangModel(ChiTietDonHangModel chiTietDonHangModel)
    {
        var result = await cartService.CreateOrderDetailAsync(chiTietDonHangModel);
        if (!result.Success)
        {
            return BadRequest(new { message = result.ErrorMessage });
        }

        return CreatedAtAction("GetChiTietDonHangModel", new { id = chiTietDonHangModel.Id_ChiTietDonHang }, chiTietDonHangModel);
    }

    // DELETE: api/Cart/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteChiTietDonHangModel(int id)
    {
        var result = await cartService.DeleteOrderDetailAsync(id);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }

    [HttpGet("calculate-ship")]
    public async Task<ActionResult> CaculateShip(string zone)
    {
        var fee = await cartService.CalculateShippingForZoneAsync(zone);
        return Ok(fee);
    }
}