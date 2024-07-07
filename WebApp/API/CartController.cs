using MailKit.Security;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MimeKit;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.API
{
    [Route("api/[controller]")]
    [ApiController]
    public class CartController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CartController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/Cart
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DonHangModel>>> GetChiTietDonHangs()
        {
            return await _context.DonHangs.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult> GetChiTietDonHangModel(string id)
        {

            var hoaDon = await _context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == id && hd.TrangThai == "Chưa thanh toán");


            if (hoaDon == null)
            {
                return NotFound();
            }
            else
            {
                string? maHD = hoaDon.Id_DonHang;
                if (_context.ChiTietDonHangs != null)
                {
                    var ctdh = await _context.ChiTietDonHangs
                        .Include(p => p.DungCu)
                        .Where(string.IsNullOrEmpty(maHD) ? p => p.Id_DonHang == maHD : p => p.Id_DonHang == maHD)
                        .ToListAsync();
                    return Ok(ctdh);
                }
            }
            return Ok(new { haha = "eror" });
        }
        [HttpGet("total/{id}")]
        public async Task<ActionResult> ToTal(string id)
        {
            var hoaDon = await _context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == id && hd.TrangThai == "Chưa thanh toán");
            if (hoaDon == null)
            {
                return NotFound();
            }
            else if (hoaDon != null)
            {
                return Ok(hoaDon.TongTien);
            }
            return Ok(new { haha = "eror" });
        }
        // PUT: api/Cart/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutChiTietDonHangModel(int id, ChiTietDonHangModel chiTietDonHangModel)
        {
            if (id != chiTietDonHangModel.Id_ChiTietDonHang)
            {
                return BadRequest();
            }

            _context.Entry(chiTietDonHangModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ChiTietDonHangModelExists(id))
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

        // POST: api/Cart
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ChiTietDonHangModel>> PostChiTietDonHangModel(ChiTietDonHangModel chiTietDonHangModel)
        {
            _context.ChiTietDonHangs.Add(chiTietDonHangModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetChiTietDonHangModel", new { id = chiTietDonHangModel.Id_ChiTietDonHang }, chiTietDonHangModel);
        }

        // DELETE: api/Cart/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteChiTietDonHangModel(int id)
        {
            var chiTietDonHangModel = await _context.ChiTietDonHangs.FindAsync(id);
            if (chiTietDonHangModel == null)
            {
                return NotFound();
            }

            _context.ChiTietDonHangs.Remove(chiTietDonHangModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ChiTietDonHangModelExists(int id)
        {
            return _context.ChiTietDonHangs.Any(e => e.Id_ChiTietDonHang == id);
        }
        [HttpGet("calculate-ship")]
        public async Task<ActionResult> CaculateShip(string zone)
        {
            var giaVanChuyen = await _context.CuocVanChuyens
                .FirstOrDefaultAsync(p => p.KhuVuc == zone);
            if (giaVanChuyen == null)
            {
                giaVanChuyen = await _context.CuocVanChuyens
                    .FirstOrDefaultAsync(cvc => cvc.KhuVuc == "Khác");
                return Ok(giaVanChuyen.CuocVanChuyen);
            }
            if (giaVanChuyen != null)
            {
                return Ok(giaVanChuyen.CuocVanChuyen);
            }
            return Ok(giaVanChuyen.CuocVanChuyen);
        }
        
    }
}