using ServerlessHero.Lambdas.Catalog.Models;

namespace ServerlessHero.Lambdas.Catalog.Services;

public interface IProductService
{
    Task<List<Product>> GetAll();
    Task<Product> GetById(int id);
}
