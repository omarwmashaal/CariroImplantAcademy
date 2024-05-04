using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class ClinicPricesModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public EnumClinicPrices Category { get; set; }
        public int Price { get; set; } = 0;
        public int? Tooth { get; set; }
        [NotMapped]
        public EnumClinicPedoTooth? PedoTooth { get; set; }
    }
}
