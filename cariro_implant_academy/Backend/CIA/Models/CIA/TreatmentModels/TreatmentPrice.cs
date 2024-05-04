using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels
{
    
    public class TreatmentPrice
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int Extraction { get; set; }
        public int Scaling { get; set; }
        public int Crown { get; set; }
        public int Restoration { get; set; }
        public int RootCanalTreatment { get; set; }
        public int Implant { get; set; }
        public int Other { get; set; }
        [NotMapped]
        public int Tooth { get; set; }
    }
}
