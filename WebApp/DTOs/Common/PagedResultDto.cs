namespace WebDungCuLamBanh.DTOs.Common;

public class PagedResultDto<T>
{
    public List<T> Items { get; set; } = [];
    public int TotalPages { get; set; }
    public int CurrentPage { get; set; }
    public int PageSize { get; set; }
    public int TotalCount { get; set; }
}
