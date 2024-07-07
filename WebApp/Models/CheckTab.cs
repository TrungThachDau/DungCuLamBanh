using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("checkTab", Schema = "dbo")]
    public class CheckTab
    {
        [Key]
        [Required]
        public int? Id { get; set; }
        public string? Username { get; set; }
        public string? Command { get; set; }
    }
}
