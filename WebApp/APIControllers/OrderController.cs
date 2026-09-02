using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.API;

[Route("api/[controller]")]
[ApiController]
public class OrderController(IOrderService orderService) : ControllerBase
{
    // GET: api/Order
    [HttpGet("{uid}")]
    public async Task<ActionResult<IEnumerable<DonHangVanChuyenModel>>> GetDonHangs(string uid)
    {
        var donHangs = await orderService.GetOrdersByCustomerUidAsync(uid);
        if (donHangs == null || donHangs.Count == 0)
        {
            return NotFound();
        }

        return Ok(donHangs);
    }

    // GET: api/Order/5
    [HttpGet("OrderDetail/{id}")]
    public async Task<ActionResult<DonHangModel>> GetDonHangModel(string id)
    {
        var donHangModel = await orderService.GetOrderByIdAsync(id);

        if (donHangModel == null)
        {
            return NotFound();
        }

        return Ok(donHangModel);
    }
}
