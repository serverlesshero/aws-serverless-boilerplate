using Amazon.DynamoDBv2.DataModel;
using ServerlessHero.Lambdas.Catalog.Models;

namespace ServerlessHero.Lambdas.Catalog.Services;

public class ProductService : IProductService
{
    private readonly IDynamoDBContext _context;
    public ProductService(IDynamoDBContext context)
    {
        _context = context;
    }
    public async Task<List<Product>> GetAll()
    {
        return await _context.ScanAsync<Product>(default).GetRemainingAsync();
    }

    public async Task<Product> GetById(int id)
    {
        return await _context.LoadAsync<Product>(id).ConfigureAwait(false);
    }
}
