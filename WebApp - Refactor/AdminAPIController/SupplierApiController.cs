using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminAPIController
{
    [ApiController]
    [Route("api/admin/[controller]")]
    public class SupplierApiController(AppDbContext context) : ControllerBase
    {
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NhaCungCapModel>>> GetAllAsync()
        {
            var suppliers = await context.NhaCungCaps.ToListAsync();
            return Ok(suppliers);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<NhaCungCapModel>> GetByIdAsync(int id)
        {
            var supplier = await context.NhaCungCaps.FindAsync(id);
            if (supplier == null)
            {
                return NotFound();
            }

            return Ok(supplier);
        }

        [HttpPost]
        public async Task<ActionResult<NhaCungCapModel>> CreateAsync(NhaCungCapModel nhaCungCapModel)
        {
            context.NhaCungCaps.Add(nhaCungCapModel);
            await context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetByIdAsync), new { id = nhaCungCapModel.Id_NhaCungCap }, nhaCungCapModel);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> UpdateAsync(int id, NhaCungCapModel nhaCungCapModel)
        {
            if (id != nhaCungCapModel.Id_NhaCungCap)
            {
                return BadRequest("Id mismatch with payload");
            }

            context.Entry(nhaCungCapModel).State = EntityState.Modified;

            try
            {
                await context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!context.NhaCungCaps.Any(e => e.Id_NhaCungCap == id))
                {
                    return NotFound();
                }

                throw;
            }

            return NoContent();
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var supplier = await context.NhaCungCaps.FindAsync(id);
            if (supplier == null)
            {
                return NotFound();
            }

            context.NhaCungCaps.Remove(supplier);
            await context.SaveChangesAsync();
            return NoContent();
        }
    }
}
