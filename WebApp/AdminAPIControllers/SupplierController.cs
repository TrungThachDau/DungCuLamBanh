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
    public class SupplierController(AppDbContext context) : ControllerBase
    {
        // GET: api/Supplier
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NhaCungCapModel>>> GetAll()
        {
            return await context.NhaCungCaps.ToListAsync();
        }

        // GET: api/Supplier/5
        [HttpGet("{id}")]
        public async Task<ActionResult<NhaCungCapModel>> GetById(int id)
        {
            var nhaCungCapModel = await context.NhaCungCaps
                .FirstOrDefaultAsync(m => m.Id_NhaCungCap == id);
            
            if (nhaCungCapModel == null)
            {
                return NotFound(new { message = "Không tìm thấy nhà cung cấp" });
            }

            return nhaCungCapModel;
        }

        // POST: api/Supplier
        [HttpPost]
        public async Task<ActionResult<NhaCungCapModel>> Create(NhaCungCapModel nhaCungCapModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            context.Add(nhaCungCapModel);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new { id = nhaCungCapModel.Id_NhaCungCap }, nhaCungCapModel);
        }

        // PUT: api/Supplier/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, NhaCungCapModel nhaCungCapModel)
        {
            if (id != nhaCungCapModel.Id_NhaCungCap)
            {
                return BadRequest(new { message = "ID không khớp" });
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            context.Entry(nhaCungCapModel).State = EntityState.Modified;

            try
            {
                await context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NhaCungCapModelExists(id))
                {
                    return NotFound(new { message = "Không tìm thấy nhà cung cấp" });
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Supplier/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var nhaCungCapModel = await context.NhaCungCaps.FindAsync(id);
            if (nhaCungCapModel == null)
            {
                return NotFound(new { message = "Không tìm thấy nhà cung cấp" });
            }

            context.NhaCungCaps.Remove(nhaCungCapModel);
            await context.SaveChangesAsync();

            return Ok(new { message = "Xóa thành công" });
        }

        private bool NhaCungCapModelExists(int id)
        {
            return context.NhaCungCaps.Any(e => e.Id_NhaCungCap == id);
        }
    }
}
