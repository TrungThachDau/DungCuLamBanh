namespace WebDungCuLamBanh.Models.Location
{
    public class Province
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string EnglishName { get; set; }
        public List<District> Districts { get; set; }
    }
}
