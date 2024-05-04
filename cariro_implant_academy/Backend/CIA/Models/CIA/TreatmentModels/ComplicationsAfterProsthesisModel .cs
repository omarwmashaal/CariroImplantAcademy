using CIA.Models.CIA.TreatmentModels;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels
{
    public class ComplicationsAfterProsthesisParentModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public List<ComplicationsAfterProsthesisModel> Complications { get; set; } = new List<ComplicationsAfterProsthesisModel>();

        public int? Tooth { get; set; }
       

    }
    public class ComplicationsAfterProsthesisModel
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }

        [ForeignKey("ComplicationsAfterProsthesisParentModel")]
        public int? ParentId { get; set; }
        public ComplicationsAfterProsthesisParentModel? Parent { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }
        public String? Name { get; set; }
        public String? Notes { get; set; }
        public DateTime? Date { get; set; }
        public int? Tooth { get; set; }
        [NotMapped]
        public bool ScrewLoosness { get; set; } = false;
        [NotMapped]
        public bool CrownFall { get; set; } = false;
        [NotMapped]
        public bool FracturedZirconia { get; set; } = false;
        [NotMapped]
        public bool FracturedPrintedPMMA { get; set; } = false;
        [NotMapped]
        public bool FoodImpaction { get; set; } = false;
        [NotMapped]
        public bool Pain { get; set; } = false;

    }

}








