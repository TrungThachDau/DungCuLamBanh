using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.API;

[Route("api/[controller]")]
[ApiController]
public class AccountController(IStaffService staffService) : ControllerBase
{
    // GET: api/Account
    [HttpGet]
    public async Task<ActionResult<IEnumerable<AdminModel>>> GetAdmins()
    {
        var admins = await staffService.GetAllAsync();
        return Ok(admins);
    }

    // GET: api/Account/5
    [HttpGet("{id}")]
    public async Task<ActionResult<AdminModel>> GetAdminModel(string id)
    {
        var adminModel = await staffService.GetByUsernameAsync(id);

        if (adminModel == null)
        {
            return NotFound();
        }

        return Ok(adminModel);
    }

    // PUT: api/Account/5
    [HttpPut("{id}")]
    public async Task<IActionResult> PutAdminModel(string id, AdminModel adminModel)
    {
        if (id != adminModel.TenNguoiDung)
        {
            return BadRequest();
        }

        var result = await staffService.UpdateAsync(adminModel);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }

    // POST: api/Account
    [HttpPost]
    public async Task<ActionResult<AdminModel>> PostAdminModel(AdminModel adminModel)
    {
        var result = await staffService.CreateAsync(adminModel);
        if (!result.Success)
        {
            return Conflict(new { message = result.ErrorMessage });
        }

        return CreatedAtAction("GetAdminModel", new { id = adminModel.TenNguoiDung }, adminModel);
    }

    // DELETE: api/Account/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteAdminModel(string id)
    {
        var result = await staffService.DeleteAsync(id);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }
}
