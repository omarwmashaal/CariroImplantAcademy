using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels
{


    public class DentalHistoryModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public bool? SenstiveHotCold { get; set; }
        public bool? SenstiveSweets { get; set; }
        public bool? BittingCheweing { get; set; }
        public string? Clench { get; set; }
        public int? Smoke { get; set; }
        public SmokingStatus? SmokingStatus { get; set; }
        public string? SeriousInjury { get; set; }
        public string? Satisfied { get; set; }
        public int? CooperationScore { get; set; }
        public int? WillingForImplantScore { get; set; }

        [ForeignKey("Operator.IdInt")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }
        public DateTime? Date { get; set; }
        public bool? HasChanges { get; set; } = false;
        public List<CBCTModel> CBCT { get; set; } = new List<CBCTModel>();


        [Owned]
        public class CBCTModel
        {
            public DateTime date { get; set; }
            public bool Done { get; set; }
        }
    }

   
}
