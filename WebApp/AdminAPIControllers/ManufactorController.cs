using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.AdminAPIControllers;

[ApiController]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
[Route("api/[controller]")]
public class ManufactorController(IManufacturerService manufacturerService) : ControllerBase
{
    // GET: api/Manufactor
    [HttpGet]
    public async Task<ActionResult<IEnumerable<NhaSanXuatModel>>> GetAll()
    {
        var items = await manufacturerService.GetAllAsync();
        return Ok(items);
    }

    // GET: api/Manufactor/5
    [HttpGet("{id}")]
    public async Task<ActionResult<NhaSanXuatModel>> GetById(int id)
    {
        var nhaSanXuatModel = await manufacturerService.GetByIdAsync(id);
        
        if (nhaSanXuatModel == null)
        {
            return NotFound(new { message = "Không tìm thấy nhà sản xuất" });
        }

        return Ok(nhaSanXuatModel);
    }

    // POST: api/Manufactor
    [HttpPost]
    public async Task<ActionResult<NhaSanXuatModel>> Create(NhaSanXuatModel nhaSanXuatModel)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var result = await manufacturerService.CreateAsync(nhaSanXuatModel);
        if (!result.Success || result.Data == null)
        {
            return BadRequest(new { message = result.ErrorMessage });
        }

        return CreatedAtAction(nameof(GetById), new { id = result.Data.Id_NhaSanXuat }, result.Data);
    }

    // PUT: api/Manufactor/5
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, NhaSanXuatModel nhaSanXuatModel)
    {
        if (id != nhaSanXuatModel.Id_NhaSanXuat)
        {
            return BadRequest(new { message = "ID không khớp" });
        }

        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var result = await manufacturerService.UpdateAsync(nhaSanXuatModel);
        if (!result.Success)
        {
            return NotFound(new { message = result.ErrorMessage ?? "Không tìm thấy nhà sản xuất" });
        }

        return NoContent();
    }

    // DELETE: api/Manufactor/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        var result = await manufacturerService.DeleteAsync(id);
        if (!result.Success)
        {
            return NotFound(new { message = result.ErrorMessage ?? "Không tìm thấy nhà sản xuất" });
        }

        return Ok(new { message = "Xóa thành công" });
    }
}
