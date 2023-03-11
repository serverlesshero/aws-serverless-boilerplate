using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DataModel;
using ServerlessHero.Lambdas.Catalog.Services;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddAWSLambdaHosting(LambdaEventSource.RestApi);

builder.Services.AddAWSService<IAmazonDynamoDB>();
builder.Services.AddScoped<IDynamoDBContext, DynamoDBContext>();
builder.Services.AddScoped<IProductService, ProductService>();

var app = builder.Build();
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.MapGet("/catalog", () => "Catalog Lambda running ASP.NET Core WebAPI on AWS Lambda!");
app.Run();
