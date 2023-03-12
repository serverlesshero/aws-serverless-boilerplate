using Amazon.DynamoDBv2.DataModel;

namespace ServerlessHero.Lambdas.Catalog.Models;

[DynamoDBTable("products")]
public class Product
{
    [DynamoDBHashKey("id")]
    public int? Id { get; set; }

    [DynamoDBProperty("name")]
    public string? Name { get; set; }

    [DynamoDBProperty("description")]
    public string? Description { get; set; }

    [DynamoDBProperty("creation_date")]
    public DateTime CreationDate { get; set; } = DateTime.UtcNow;

    [DynamoDBProperty("price")]
    public int Price { get; set; }
}
