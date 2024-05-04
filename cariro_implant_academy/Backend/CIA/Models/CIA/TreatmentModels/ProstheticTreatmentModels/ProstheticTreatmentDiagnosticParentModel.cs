using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels
{
    [Table("DiagnosticProsthesisParentsTable")]

    public class ProstheticTreatmentDiagnosticParentModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
     //   [ForeignKey("ProstheticTreatmentModel")]
       // public int? ProstheticTreatmentId { get; set; }
      //  public ProstheticTreatmentModel? ProstheticTreatment { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public DateTime? Date { get; set; }

        [ForeignKey("Operator.IdInt")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }
        public bool? NeedsRemake { get; set; } = false;
        public bool? Scanned { get; set; } = false;


    }

    public class DiagnosticImpressionModel : ProstheticTreatmentDiagnosticParentModel
    {
        public EnumProstheticDiagnosticDiagnosticImpressionDiagnostic? Diagnostic { get; set; }
        public EnumProstheticDiagnosticDiagnosticImpressionNextStep? NextStep { get; set; }

    }
    public class BiteModel : ProstheticTreatmentDiagnosticParentModel
    {
        public EnumProstheticDiagnosticBiteDiagnostic? Diagnostic { get; set; }
        public EnumProstheticDiagnosticBiteNextStep? NextStep { get; set; }

    }
    public class ScanApplianceModel : ProstheticTreatmentDiagnosticParentModel
    {
        public EnumProstheticDiagnosticScanApplianceDiagnostic? Diagnostic { get; set; }
    }

}
