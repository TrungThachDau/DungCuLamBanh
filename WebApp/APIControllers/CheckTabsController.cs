using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.API;

[Route("api/[controller]")]
[ApiController]
public class CheckTabsController(ICheckTabService checkTabService) : ControllerBase
{
    // GET: api/CheckTabs
    [HttpGet]
    public async Task<ActionResult<IEnumerable<CheckTab>>> GetCheckTabs()
    {
        var items = await checkTabService.GetAllAsync();
        return Ok(items);
    }

    // GET: api/CheckTabs/5
    [HttpGet("{id}")]
    public async Task<ActionResult<CheckTab>> GetCheckTab(int? id)
    {
        var checkTab = await checkTabService.GetByIdAsync(id);

        if (checkTab == null)
        {
            return NotFound();
        }

        return Ok(checkTab);
    }

    // PUT: api/CheckTabs/5
    [HttpPut("{id}")]
    public async Task<IActionResult> PutCheckTab(int? id, CheckTab checkTab)
    {
        if (id != checkTab.Id)
        {
            return BadRequest();
        }

        var result = await checkTabService.UpdateAsync(checkTab);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }

    [HttpPost]
    public async Task<ActionResult<CheckTab>> PostCheckTab([FromBody] CheckTab model)
    {
        var checkTab = new CheckTab
        {
            Username = model.Username,
            Command = model.Command
        };

        var result = await checkTabService.CreateAsync(checkTab);
        if (!result.Success)
        {
            return BadRequest(new { message = result.ErrorMessage });
        }

        return CreatedAtAction("GetCheckTab", new { id = checkTab.Id }, checkTab);
    }

    // DELETE: api/CheckTabs/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteCheckTab(int? id)
    {
        var result = await checkTabService.DeleteAsync(id);
        if (!result.Success)
        {
            return NotFound();
        }

        return NoContent();
    }
}
