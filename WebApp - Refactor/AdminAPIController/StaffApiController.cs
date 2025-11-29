using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminAPIController
{
    [ApiController]
    [Route("api/admin/[controller]")]
    public class StaffApiController(AppDbContext context) : ControllerBase
    {
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AdminModel>>> GetAllAsync()
        {
            var admins = await context.Admins.ToListAsync();
            return Ok(admins);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<AdminModel>> GetByIdAsync(string id)
        {
            var admin = await context.Admins.FindAsync(id);
            if (admin == null)
            {
                return NotFound();
            }

            return Ok(admin);
        }

        [HttpPost]
        public async Task<ActionResult<AdminModel>> CreateAsync(AdminModel adminModel)
        {
            context.Admins.Add(adminModel);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetByIdAsync), new { id = adminModel.TenNguoiDung }, adminModel);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateAsync(string id, AdminModel adminModel)
        {
            if (id != adminModel.TenNguoiDung)
            {
                return BadRequest("Id mismatch with payload");
            }

            context.Entry(adminModel).State = EntityState.Modified;

            try
            {
                await context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!context.Admins.Any(e => e.TenNguoiDung == id))
                {
                    return NotFound();
                }

                throw;
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAsync(string id)
        {
            var admin = await context.Admins.FindAsync(id);
            if (admin == null)
            {
                return NotFound();
            }

            context.Admins.Remove(admin);
            await context.SaveChangesAsync();

            return NoContent();
        }
    }
}
