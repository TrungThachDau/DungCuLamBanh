namespace WebDungCuLamBanh.DTOs.CheckTab;

public class CheckTabDto
{
    public int Id { get; set; }
    public string? Username { get; set; }
    public string? Command { get; set; }
}

public class CreateCheckTabDto
{
    public string? Username { get; set; }
    public string? Command { get; set; }
}
