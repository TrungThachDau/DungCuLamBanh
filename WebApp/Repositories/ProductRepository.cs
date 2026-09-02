using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class ProductRepository(AppDbContext context) : Repository<DungCuModel>(context), IProductRepository
{
    public IQueryable<DungCuModel> Products => Context.DungCus.AsQueryable();
    public IQueryable<LoaiDungCuModel> Categories => Context.LoaiDungCus.AsQueryable();
    public IQueryable<NhaSanXuatModel> Manufacturers => Context.NhaSanXuats.AsQueryable();
    public IQueryable<ChiTietDonHangModel> OrderDetails => Context.ChiTietDonHangs.AsQueryable();
    public IQueryable<YeuThichModel> Favorites => Context.YeuThichs.AsQueryable();

    public async Task<T?> FindAsync<T>(params object[] keyValues) where T : class
    {
        return await Context.Set<T>().FindAsync(keyValues);
    }

    public Task AddAsync<T>(T entity) where T : class
    {
        Context.Set<T>().Add(entity);
        return Task.CompletedTask;
    }

    public Task UpdateAsync<T>(T entity) where T : class
    {
        Context.Set<T>().Update(entity);
        return Task.CompletedTask;
    }

    public Task RemoveAsync<T>(T entity) where T : class
    {
        Context.Set<T>().Remove(entity);
        return Task.CompletedTask;
    }

    public new Task SaveChangesAsync()
    {
        return Context.SaveChangesAsync();
    }
}
