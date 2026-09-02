using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class HomeRepository(AppDbContext context) : IHomeRepository
{
    public IQueryable<BannerModel> Banners => context.Banners.AsQueryable();
    public IQueryable<DungCuModel> Products => context.DungCus.AsQueryable();
}
