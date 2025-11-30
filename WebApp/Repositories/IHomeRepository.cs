using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories
{
    public interface IHomeRepository
    {
        IQueryable<BannerModel> Banners { get; }
        IQueryable<DungCuModel> Products { get; }
    }
}
