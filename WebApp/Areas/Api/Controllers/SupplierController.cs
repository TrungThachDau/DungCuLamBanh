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
public class SupplierController(ISupplierService supplierService) : ControllerBase
{
    // GET: api/Supplier
    [HttpGet]
    public async Task<ActionResult<IEnumerable<NhaCungCapModel>>> GetAll()
    {
        var items = await supplierService.GetAllAsync();
        return Ok(items);
    }

    // GET: api/Supplier/5
    [HttpGet("{id}")]
    public async Task<ActionResult<NhaCungCapModel>> GetById(int id)
    {
        var nhaCungCapModel = await supplierService.GetByIdAsync(id);

        if (nhaCungCapModel == null)
        {
            return NotFound(new { message = "Không tìm thấy nhà cung cấp" });
        }

        return Ok(nhaCungCapModel);
    }

    // POST: api/Supplier
    [HttpPost]
    public async Task<ActionResult<NhaCungCapModel>> Create(NhaCungCapModel nhaCungCapModel)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var result = await supplierService.CreateAsync(nhaCungCapModel);
        if (!result.Success || result.Data == null)
        {
            return BadRequest(new { message = result.ErrorMessage });
        }

        return CreatedAtAction(nameof(GetById), new { id = result.Data.Id_NhaCungCap }, result.Data);
    }

    // PUT: api/Supplier/5
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, NhaCungCapModel nhaSanXuatModel)
    {
        if (id != nhaSanXuatModel.Id_NhaCungCap)
        {
            return BadRequest(new { message = "ID không khớp" });
        }

        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var result = await supplierService.UpdateAsync(nhaSanXuatModel);
        if (!result.Success)
        {
            return NotFound(new { message = result.ErrorMessage ?? "Không tìm thấy nhà cung cấp" });
        }

        return NoContent();
    }

    // DELETE: api/Supplier/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        var result = await supplierService.DeleteAsync(id);
        if (!result.Success)
        {
            return NotFound(new { message = result.ErrorMessage ?? "Không tìm thấy nhà cung cấp" });
        }

        return Ok(new { message = "Xóa thành công" });
    }
}
