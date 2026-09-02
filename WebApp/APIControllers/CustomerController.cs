using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.API;

[Route("api/[controller]")]
[ApiController]
public class CustomerController(ICustomerService customerService) : ControllerBase
{
    // GET: api/Customer
    [HttpGet]
    public async Task<ActionResult<IEnumerable<KhachHangModel>>> GetKhachHangs()
    {
        var customers = await customerService.GetAllCustomersAsync();
        return Ok(customers);
    }

    // GET: api/Customer/5
    [HttpGet("{id}")]
    public async Task<ActionResult<KhachHangModel>> GetKhachHangModel(string id)
    {
        var khachHangModel = await customerService.GetCustomerByIdAsync(id);

        if (khachHangModel == null)
        {
            return NotFound();
        }

        return Ok(khachHangModel);
    }
    
    // PUT: api/Customer/5
    [HttpPut("{id}")]
    public async Task<IActionResult> PutKhachHangModel(string id, KhachHangModel khachHangModel)
    {
        if (id != khachHangModel.Id_KhachHang)
        {
            return BadRequest();
        }

        var result = await customerService.UpdateCustomerDetailsAsync(khachHangModel);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }

    // POST: api/Customer
    [HttpPost]
    public async Task<ActionResult<KhachHangModel>> PostKhachHangModel(KhachHangModel khachHangModel)
    {
        var result = await customerService.CreateCustomerAsync(khachHangModel);
        if (!result.Success)
        {
            return Conflict(new { message = result.ErrorMessage });
        }

        return CreatedAtAction("GetKhachHangModel", new { id = khachHangModel.Id_KhachHang }, khachHangModel);
    }

    // DELETE: api/Customer/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteKhachHangModel(string id)
    {
        var result = await customerService.DeleteCustomerAsync(id);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }
}
