using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminAPIControllers
{
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    public class StaffController(AppDbContext context) : ControllerBase
    {
        // GET: api/Staff
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AdminModel>>> GetAll()
        {
            return await context.Admins.ToListAsync();
        }

        // GET: api/Staff/username
        [HttpGet("{id}")]
        public async Task<ActionResult<AdminModel>> GetById(string id)
        {
            var adminModel = await context.Admins
                .FirstOrDefaultAsync(m => m.TenNguoiDung == id);
            
            if (adminModel == null)
            {
                return NotFound(new { message = "Không tìm thấy nhân viên" });
            }

            return adminModel;
        }

        // POST: api/Staff
        [HttpPost]
        public async Task<ActionResult<AdminModel>> Create(AdminModel adminModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            context.Add(adminModel);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new { id = adminModel.TenNguoiDung }, adminModel);
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

            context.Entry(adminModel).State = EntityState.Modified;

            try
            {
                await context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AdminModelExists(id))
                {
                    return NotFound(new { message = "Không tìm thấy nhân viên" });
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Staff/username
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            var adminModel = await context.Admins.FindAsync(id);
            if (adminModel == null)
            {
                return NotFound(new { message = "Không tìm thấy nhân viên" });
            }

            context.Admins.Remove(adminModel);
            await context.SaveChangesAsync();

            return Ok(new { message = "Xóa thành công" });
        }

        private bool AdminModelExists(string id)
        {
            return context.Admins.Any(e => e.TenNguoiDung == id);
        }
    }
}
