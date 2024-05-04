using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA
{
    public class Implant :StockItem
    {

       
    }

    public class ImplantCompany
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string? Name { get; set; }
        public List<ImplantLine>? Lines { get; set; } = new List<ImplantLine>();


    }

    public class ImplantLine
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string? Name { get; set; }

       
        public List<Implant>? Implants { get; set; } = new List<Implant>();

        [ForeignKey("ImplantCompany")]
        public int? ImplantCompanyId { get; set; }
        public ImplantCompany? ImplantCompany { get; set; }
    }
}
