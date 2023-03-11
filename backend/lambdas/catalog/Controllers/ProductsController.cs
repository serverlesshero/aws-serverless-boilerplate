using Microsoft.AspNetCore.Mvc;
using ServerlessHero.Lambdas.Catalog.Services;

namespace ServerlessHero.Lambdas.Catalog.Controllers;

[ApiController]
[Route("catalog/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly IProductService _service;

    public ProductsController(IProductService service)
    {
        _service = service;
    }

    [HttpGet]
    public async Task<IActionResult> GetProductsAsync()
    {
        var products = await _service.GetAll();
        return Ok(products);
    }
    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetProductByIdAsync(int id)
    {
        var product = await _service.GetById(id);
        if (product is null) return NotFound(id);
        return Ok(product);
    }
}
