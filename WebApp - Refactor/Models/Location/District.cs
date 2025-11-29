namespace WebDungCuLamBanh.Models.Location
{
    public class District
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string EnglishName { get; set; }
        public List<Commune> Communes { get; set; }
    }
}
