namespace WebDungCuLamBanh.Models.admin
{
    public class CategoryViewModel
    {
        public IEnumerable<LoaiDungCuModel> Category { get; set; }
        public LoaiDungCuModel NewCategory { get; set; }
    }
}
