using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.LAB
{
    public class LabDoctorPriceListModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public int DoctorId { get; set; }
        public int LabOptionId { get; set; }
        public int Price { get; set; }
    }
}
