using System.Text;
using System.Threading.RateLimiting;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.AspNetCore.ResponseCompression;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Primitives;
using Microsoft.IdentityModel.Tokens;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Repositories;
using WebDungCuLamBanh.Services;

var builder = WebApplication.CreateBuilder(args);
var config = builder.Configuration;

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"), options => options.EnableRetryOnFailure()));

// Add Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    // Only include API controllers (exclude MVC controllers)
    c.DocInclusionPredicate((docName, apiDesc) =>
    {
        if (apiDesc.ActionDescriptor is ControllerActionDescriptor controllerActionDescriptor)
        {
            // Only include controllers with [ApiController] attribute
            return controllerActionDescriptor.ControllerTypeInfo
                .GetCustomAttributes(typeof(Microsoft.AspNetCore.Mvc.ApiControllerAttribute), true).Any();
        }
        return false;
    });
});

builder.Services.AddDistributedMemoryCache();
builder.Services.AddResponseCompression();
builder.Services.AddProblemDetails();

// Throttle brute-force attempts against login endpoints
builder.Services.AddRateLimiter(options =>
{
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
    options.AddFixedWindowLimiter("login", limiterOptions =>
    {
        limiterOptions.Window = TimeSpan.FromMinutes(1);
        limiterOptions.PermitLimit = 5;
        limiterOptions.QueueLimit = 0;
    });
});

var jwtSection = config.GetSection("Jwt");
var jwtKey = jwtSection["Key"] ?? throw new InvalidOperationException("JWT signing key is missing.");

builder.Services.AddAuthentication(options =>
{
    options.DefaultScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;
})
    .AddCookie()
    .AddCookie("Firebase", options =>
    {
        options.LoginPath = "/Account/SignIn";
        options.AccessDeniedPath = "/Account/AccessDenied";
        options.LogoutPath = "/Account/SignOut";
        options.Cookie.HttpOnly = true;
    })
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = jwtSection["Issuer"],
            ValidAudience = jwtSection["Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey)),
            ClockSkew = TimeSpan.Zero
        };
    });

builder.Services.ConfigureApplicationCookie(options =>
{
    options.Cookie.HttpOnly = true;
    options.ExpireTimeSpan = TimeSpan.FromMinutes(30);
    options.LoginPath = "/Account/SignIn";
    options.AccessDeniedPath = "/Account/AccessDenied";
    options.SlidingExpiration = true;
});

builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

builder.Services.AddResponseCompression(options =>
{
    options.Providers.Add<BrotliCompressionProvider>();
    options.Providers.Add<GzipCompressionProvider>();
    options.MimeTypes = ResponseCompressionDefaults.MimeTypes.Concat(new[] { "image/svg+xml" });
});

// Dependency Injection - Repository & Service registrations
builder.Services.AddScoped(typeof(IRepository<>), typeof(Repository<>));

// Administrator services
builder.Services.AddScoped<IAdministratorRepository, AdministratorRepository>();
builder.Services.AddScoped<IAdministratorService, AdministratorService>();

// Customer/Account services
builder.Services.AddScoped<ICustomerRepository, CustomerRepository>();
builder.Services.AddScoped<ICustomerService, CustomerService>();

// Cart services
builder.Services.AddScoped<ICartRepository, CartRepository>();
builder.Services.AddScoped<ICartService, CartService>();

// Product services
builder.Services.AddScoped<IProductRepository, ProductRepository>();
builder.Services.AddScoped<IProductService, ProductService>();

// Home services
builder.Services.AddScoped<IHomeRepository, HomeRepository>();
builder.Services.AddScoped<IHomeService, HomeService>();

// Goods Receipt services
builder.Services.AddScoped<IGoodsReceiptRepository, GoodsReceiptRepository>();
builder.Services.AddScoped<IGoodsReceiptService, GoodsReceiptService>();

// Manufacturer services
builder.Services.AddScoped<IManufacturerRepository, ManufacturerRepository>();
builder.Services.AddScoped<IManufacturerService, ManufacturerService>();

// Supplier services
builder.Services.AddScoped<ISupplierRepository, SupplierRepository>();
builder.Services.AddScoped<ISupplierService, SupplierService>();

// Staff services
builder.Services.AddScoped<IStaffRepository, StaffRepository>();
builder.Services.AddScoped<IStaffService, StaffService>();

// Order services
builder.Services.AddScoped<IOrderRepository, OrderRepository>();
builder.Services.AddScoped<IOrderService, OrderService>();

// CheckTab services
builder.Services.AddScoped<ICheckTabRepository, CheckTabRepository>();
builder.Services.AddScoped<ICheckTabService, CheckTabService>();

var app = builder.Build();

// Swagger UI is a development/diagnostic tool only
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Admin API v1");
        c.RoutePrefix = "swagger"; // Access at /swagger
    });
}
else
{
    app.UseHsts();
}

// Configure the HTTP request pipeline.
app.UseExceptionHandler("/Error");
// Cấu hình trang lỗi cho các mã lỗi khác như 404 - Not Found
app.UseStatusCodePagesWithReExecute("/Error/");

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseWhen(context => context.Request.Path.StartsWithSegments("/wwwroot/js"), appBuilder =>
{
    appBuilder.UseStaticFiles(new StaticFileOptions
    {
        OnPrepareResponse = context =>
        {
            context.Context.Response.Headers.Append("Cache-Control", "public, max-age=31536000");
            if (context.Context.Request.Headers.TryGetValue("Accept-Encoding", out StringValues value) && value.ToString().Contains("br"))
            {
                context.Context.Response.Headers.Append("Content-Encoding", "br");
            }
            else
            {
                context.Context.Response.Headers.Append("Content-Encoding", "gzip");
            }
        }
    });
});
app.UseResponseCompression();
app.UseRouting();
app.UseRateLimiter();
app.UseAuthentication();
app.UseAuthorization();
app.UseSession();
app.UseStatusCodePagesWithReExecute("/Error/{0}");

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();

public partial class Program { }
