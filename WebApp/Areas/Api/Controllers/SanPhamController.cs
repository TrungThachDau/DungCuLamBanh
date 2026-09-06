using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.Areas.Api.Controllers;

[Area("Api")]
[Route("api/[controller]")]
[ApiController]
public class SanPhamController(IProductService productService) : ControllerBase
{
    // GET: api/SanPham
    [HttpGet]
    public async Task<ActionResult<IEnumerable<DungCuModel>>> GetDungCus()
    {
        var products = await productService.GetAllActiveProductsAsync();
        return Ok(products);
    }

    // GET: api/SanPham/5
    [HttpGet("{id}")]
    public async Task<ActionResult> GetDungCuModel(int id)
    {
        var dungcu = await productService.GetByIdAsync(id);
        if (dungcu == null)
        {
            return NotFound();
        }

        return Ok(dungcu);
    }

    // PUT: api/SanPham/5
    [HttpPut("{id}")]
    public async Task<IActionResult> PutDungCuModel(int id, DungCuModel dungCuModel)
    {
        if (id != dungCuModel.Id_DungCu)
        {
            return BadRequest();
        }

        var result = await productService.UpdateAsync(dungCuModel);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }

    // POST: api/SanPham
    [HttpPost]
    public async Task<ActionResult<DungCuModel>> PostDungCuModel(DungCuModel dungCuModel)
    {
        var result = await productService.CreateAsync(dungCuModel);
        if (!result.Success)
        {
            return BadRequest(new { message = result.ErrorMessage });
        }

        return CreatedAtAction("GetDungCuModel", new { id = dungCuModel.Id_DungCu }, dungCuModel);
    }

    // DELETE: api/SanPham/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteDungCuModel(int id)
    {
        var result = await productService.DeleteAsync(id);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }

    [HttpGet("khuyenmai")]
    public async Task<ActionResult<IEnumerable<DungCuModel>>> GetKhuyenMai()
    {
        var products = await productService.GetDiscountedProductsAsync();
        return Ok(products);
    }

    [HttpGet("newproduct")]
    public async Task<ActionResult<IEnumerable<DungCuModel>>> GetNewProduct()
    {
        var products = await productService.GetNewProductsAsync();
        return Ok(products);
    }

    [HttpPost("webhook")]
    public async Task<IActionResult> Webhook([FromBody] JObject request)
    {
        var queryResult = request["queryResult"];
        if (queryResult == null) return BadRequest();

        var intent = queryResult["intent"]?["displayName"]?.ToString();

        if (intent == "FindProduct")
        {
            var productName = queryResult["parameters"]?["product"]?.ToString() ?? string.Empty;
            var responseText = await productService.SearchProductForWebhookAsync(productName);

            var response = new
            {
                fulfillmentText = responseText
            };

            return Ok(response);
        }

        return BadRequest();
    }
}
