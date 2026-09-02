using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;

namespace WebDungCuLamBanh.Repositories;

public class Repository<T>(AppDbContext context) : IRepository<T> where T : class
{
    protected readonly AppDbContext Context = context;
    protected readonly DbSet<T> DbSet = context.Set<T>();

    public virtual IQueryable<T> Query() => DbSet.AsQueryable();

    public virtual async Task<IEnumerable<T>> GetAllAsync() => await DbSet.ToListAsync();

    public virtual async Task<T?> GetByIdAsync(object id) => await DbSet.FindAsync(id);

    public virtual async Task<IEnumerable<T>> FindAsync(Expression<Func<T, bool>> predicate) =>
        await DbSet.Where(predicate).ToListAsync();

    public virtual async Task<T?> FirstOrDefaultAsync(Expression<Func<T, bool>> predicate) =>
        await DbSet.FirstOrDefaultAsync(predicate);

    public virtual async Task<bool> ExistsAsync(Expression<Func<T, bool>> predicate) =>
        await DbSet.AnyAsync(predicate);

    public virtual async Task<T> AddAsync(T entity)
    {
        await DbSet.AddAsync(entity);
        return entity;
    }

    public virtual async Task AddRangeAsync(IEnumerable<T> entities)
    {
        await DbSet.AddRangeAsync(entities);
    }

    public virtual Task UpdateAsync(T entity)
    {
        DbSet.Update(entity);
        return Task.CompletedTask;
    }

    public virtual Task DeleteAsync(T entity)
    {
        DbSet.Remove(entity);
        return Task.CompletedTask;
    }

    public virtual async Task DeleteByIdAsync(object id)
    {
        var entity = await GetByIdAsync(id);
        if (entity != null)
        {
            DbSet.Remove(entity);
        }
    }

    public virtual async Task<int> SaveChangesAsync() => await Context.SaveChangesAsync();
}
