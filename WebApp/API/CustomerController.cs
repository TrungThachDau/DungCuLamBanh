using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.API
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CustomerController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/Customer
        [HttpGet]
        public async Task<ActionResult<IEnumerable<KhachHangModel>>> GetKhachHangs()
        {
            return await _context.KhachHangs.ToListAsync();
        }

        // GET: api/Customer/5
        [HttpGet("{id}")]
        public async Task<ActionResult<KhachHangModel>> GetKhachHangModel(string id)
        {
            var khachHangModel = await _context.KhachHangs.FindAsync(id);

            if (khachHangModel == null)
            {
                return NotFound();
            }

            return khachHangModel;
        }
        
        // PUT: api/Customer/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutKhachHangModel(string id, KhachHangModel khachHangModel)
        {
            if (id != khachHangModel.Id_KhachHang)
            {
                return BadRequest();
            }

            _context.Entry(khachHangModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!KhachHangModelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Customer
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<KhachHangModel>> PostKhachHangModel(KhachHangModel khachHangModel)
        {
            _context.KhachHangs.Add(khachHangModel);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (KhachHangModelExists(khachHangModel.Id_KhachHang))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetKhachHangModel", new { id = khachHangModel.Id_KhachHang }, khachHangModel);
        }

        // DELETE: api/Customer/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteKhachHangModel(string id)
        {
            var khachHangModel = await _context.KhachHangs.FindAsync(id);
            if (khachHangModel == null)
            {
                return NotFound();
            }

            _context.KhachHangs.Remove(khachHangModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool KhachHangModelExists(string id)
        {
            return _context.KhachHangs.Any(e => e.Id_KhachHang == id);
        }
    }
}
