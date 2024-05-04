using CIA.Models.CIA;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.TreatmentModels
{
  
    public class NonSurgicalTreatmentModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public String? Treatment { get; set; } = "";
        [ForeignKey("Operator.IdInt")]
        public int? OperatorID { get; set; }
        public ApplicationUser? Operator { get; set; }
        [ForeignKey("Supervisor.IdInt")]
        public int? SupervisorID { get; set; }
        public ApplicationUser? Supervisor { get; set; }
        public DateTime? Date { get; set; }
        public DateTime? NextVisit { get; set; }
        public bool? HasChanges { get; set; } = false;


    }
}
