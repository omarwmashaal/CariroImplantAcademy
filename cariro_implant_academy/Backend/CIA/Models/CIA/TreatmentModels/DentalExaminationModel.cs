using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels
{
    //[Keyless]

    public class DentalExaminationModel
    {


        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public List<DentalExamination>? DentalExaminations { get; set; } = null;
        public EnumOralHygieneRating? OralHygieneRating { get; set; } = EnumOralHygieneRating.GoodHygiene;
        public DateTime? Date { get; set; }

        public string? OperatorImplantNotes { get; set; }

        [ForeignKey("Operator.IdInt")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }

        [Owned]
        public class DentalExamination
        {
            public int? Tooth { get; set; }
            public bool? Carious { get; set; }
            public bool? Filled { get; set; }
            public bool? Missed { get; set; }
            public bool? NotSure { get; set; }
            public bool? MobilityI { get; set; }
            public bool? MobilityII { get; set; }
            public bool? MobilityIII { get; set; }
            public bool? Hopelessteeth { get; set; }
            public bool? ImplantPlaced { get; set; }
            public bool? ImplantFailed { get; set; }
            public string? PreviousState { get; set; }
            public int? InterarchspaceRT { get; set; } = 0;
            public int? InterarchspaceLT { get; set; } = 0;

        }

        



    }
}
