using CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels
{
    public class ProstheticTreatmentDiagnosticModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public DateTime? Date { get; set; }
        public List<DiagnosticImpressionModel> ProstheticDiagnostic_DiagnosticImpression { get; set; } = new List<DiagnosticImpressionModel>();
        public List<BiteModel> ProstheticDiagnostic_Bite { get; set; } = new List<BiteModel>();
        public List<ScanApplianceModel> ProstheticDiagnostic_ScanAppliance { get; set; } = new List<ScanApplianceModel>();
        [NotMapped]
        public DiagnosticImpressionModel? SearchProstheticDiagnostic_DiagnosticImpression { get; set; }
        [NotMapped]
        public BiteModel? SearchProstheticDiagnostic_Bite { get; set; }
        [NotMapped]
        public ScanApplianceModel? SearchProstheticDiagnostic_ScanAppliance { get; set; }
        [NotMapped]
        public EnumTeethClassification? SearchTeethClassification { get; set; }
        

    }

    public class ProstheticTreatmentFinalSingleBridge : PorstheticTreatmentFinalParent
    {


        
    }

    public class ProstheticTreatmentFinalFullArch : PorstheticTreatmentFinalParent
    {
        
        
    }
    public class PorstheticTreatmentFinalParent
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public DateTime? Date { get; set; }
        public List<FinalProsthesisHealingCollar>? HealingCollars { get; set; }
        public List<FinalProsthesisImpression>? Impressions { get; set; }
        public List<FinalProsthesisTryIn>? TryIns { get; set; }
        public List<FinalProsthesisDelivery>? Delivery { get; set; }
    }
}
