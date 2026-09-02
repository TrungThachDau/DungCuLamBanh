using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.AdminAPIControllers;

[ApiController]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
[Route("api/[controller]")]
public class StaffController(IStaffService staffService) : ControllerBase
{
    // GET: api/Staff
    [HttpGet]
    public async Task<ActionResult<IEnumerable<AdminModel>>> GetAll()
    {
        var items = await staffService.GetAllAsync();
        return Ok(items);
    }

    // GET: api/Staff/username
    [HttpGet("{id}")]
    public async Task<ActionResult<AdminModel>> GetById(string id)
    {
        var adminModel = await staffService.GetByUsernameAsync(id);
        
        if (adminModel == null)
        {
            return NotFound(new { message = "Không tìm thấy nhân viên" });
        }

        return Ok(adminModel);
    }

    // POST: api/Staff
    [HttpPost]
    public async Task<ActionResult<AdminModel>> Create(AdminModel adminModel)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var result = await staffService.CreateAsync(adminModel);
        if (!result.Success || result.Data == null)
        {
            return BadRequest(new { message = result.ErrorMessage });
        }

        return CreatedAtAction(nameof(GetById), new { id = result.Data.TenNguoiDung }, result.Data);
    }

    // PUT: api/Staff/username
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(string id, AdminModel adminModel)
    {
        if (id != adminModel.TenNguoiDung)
        {
            return BadRequest(new { message = "ID không khớp" });
        }

        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var result = await staffService.UpdateAsync(adminModel);
        if (!result.Success)
        {
            return NotFound(new { message = result.ErrorMessage ?? "Không tìm thấy nhân viên" });
        }

        return NoContent();
    }

    // DELETE: api/Staff/username
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(string id)
    {
        var result = await staffService.DeleteAsync(id);
        if (!result.Success)
        {
            return NotFound(new { message = result.ErrorMessage ?? "Không tìm thấy nhân viên" });
        }

        return Ok(new { message = "Xóa thành công" });
    }
}
