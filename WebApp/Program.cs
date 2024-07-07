using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.ResponseCompression;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Primitives;
using WebDungCuLamBanh.Data;

namespace WebDungCuLamBanh
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            var config = builder.Configuration;

            // Add services to the container.
            builder.Services.AddControllersWithViews();
            builder.Services.AddDbContext<AppDbContext>(options =>
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"), options => options.EnableRetryOnFailure()));

            builder.Services.AddDistributedMemoryCache();
            builder.Services.AddResponseCompression();
            builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
                //.AddCookie(options =>
                //{
                //    options.LoginPath = "/Account/SignIn";
                //    options.AccessDeniedPath = "/Account/AccessDenied";
                //    options.LogoutPath = "/Account/SignOut";
                //    options.Cookie.HttpOnly = true;
                //})
                .AddCookie("Firebase", options =>
                {
                    options.LoginPath = "/Account/SignIn";
                    options.AccessDeniedPath = "/Account/AccessDenied";
                    options.LogoutPath = "/Account/SignOut";
                    options.Cookie.HttpOnly = true;
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
                options.IdleTimeout = TimeSpan.MaxValue;
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true;
                //options.Cookie.Expiration = TimeSpan.FromDays(30);
            });

            builder.Services.AddResponseCompression(options =>
            {
                options.Providers.Add<BrotliCompressionProvider>();
                options.Providers.Add<GzipCompressionProvider>();
                options.MimeTypes = ResponseCompressionDefaults.MimeTypes.Concat(new[] { "image/svg+xml" });
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            app.UseExceptionHandler("/Error");
            // Cấu hình trang lỗi cho các mã lỗi khác như 404 - Not Found
            app.UseStatusCodePagesWithReExecute("/Error/");
            app.UseHsts();

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseWhen(context => context.Request.Path.StartsWithSegments("/wwwroot/js"), appBuilder =>
            {
                appBuilder.UseStaticFiles(new StaticFileOptions
                {
                    OnPrepareResponse = context =>
                    {
                        context.Context.Response.Headers.Add("Cache-Control", "public, max-age=31536000");
                        if (context.Context.Request.Headers.TryGetValue("Accept-Encoding", out StringValues value) && value.ToString().Contains("br"))
                        {
                            context.Context.Response.Headers.Add("Content-Encoding", "br");
                        }
                        else
                        {
                            context.Context.Response.Headers.Add("Content-Encoding", "gzip");
                        }
                    }
                });
            });
            app.UseResponseCompression();
            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseSession();
            app.UseStatusCodePagesWithReExecute("/Error/{0}");

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");

            app.Run();
        }
    }
}