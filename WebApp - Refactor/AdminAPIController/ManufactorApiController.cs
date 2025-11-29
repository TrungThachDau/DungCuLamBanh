using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminAPIController
{
    [ApiController]
    [Route("api/admin/[controller]")]
    public class ManufactorApiController(AppDbContext context) : ControllerBase
    {
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NhaSanXuatModel>>> GetAllAsync()
        {
            var manufactors = await context.NhaSanXuats.ToListAsync();
            return Ok(manufactors);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<NhaSanXuatModel>> GetByIdAsync(int id)
        {
            var manufactor = await context.NhaSanXuats.FindAsync(id);
            if (manufactor == null)
            {
                return NotFound();
            }

            return Ok(manufactor);
        }

        [HttpPost]
        public async Task<ActionResult<NhaSanXuatModel>> CreateAsync(NhaSanXuatModel nhaSanXuatModel)
        {
            context.NhaSanXuats.Add(nhaSanXuatModel);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetByIdAsync), new { id = nhaSanXuatModel.Id_NhaSanXuat }, nhaSanXuatModel);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> UpdateAsync(int id, NhaSanXuatModel nhaSanXuatModel)
        {
            if (id != nhaSanXuatModel.Id_NhaSanXuat)
            {
                return BadRequest("Id mismatch with payload");
            }

            context.Entry(nhaSanXuatModel).State = EntityState.Modified;

            try
            {
                await context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!context.NhaSanXuats.Any(e => e.Id_NhaSanXuat == id))
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
            var manufactor = await context.NhaSanXuats.FindAsync(id);
            if (manufactor == null)
            {
                return NotFound();
            }

            context.NhaSanXuats.Remove(manufactor);
            await context.SaveChangesAsync();

            return NoContent();
        }
    }
}
