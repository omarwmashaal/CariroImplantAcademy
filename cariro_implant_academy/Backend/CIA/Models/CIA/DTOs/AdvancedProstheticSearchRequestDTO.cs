using CIA.Models.CIA.TreatmentModels;
using CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels;

namespace CIA.Models.CIA.DTOs
{
    public class AdvancedProstheticSearchRequestDTO
    {
        public List<int>? Ids { get; set; }
        public ProstheticTreatmentDiagnosticModel? DiagnosticAnd { get; set; }
        public ProstheticTreatmentFinalSingleBridge? SingleAndBridgeAnd { get; set; }
        public ProstheticTreatmentFinalFullArch? FullArchAnd { get; set; }
        public ProstheticTreatmentDiagnosticModel? DiagnosticOr { get; set; }
        public ProstheticTreatmentFinalSingleBridge? SingleAndBridgeOr { get; set; }
        public ProstheticTreatmentFinalFullArch? FullArchOr { get; set; }
        public ComplicationsAfterProsthesisModel? complicationsAnd { get; set; }
        public ComplicationsAfterProsthesisModel? complicationsOr { get; set; }

    }

    public class AdvancedProstheticSearchResponseDTO
    {
        public int? Id { get; set; }
        public int? Tooth { get; set; }
        public String? SecondaryId { get; set; }
        public String? PatientName { get; set; }
        public DiagnosticImpressionModel? DiagnosticImpression { get; set; }
        public BiteModel? Bite { get; set; }
        public ScanApplianceModel? ScanAppliance { get; set; }
        public FinalProsthesisHealingCollar? SingleAndBridge_HealingCollar { get; set; }
        public FinalProsthesisImpression? SingleAndBridge_Impression { get; set; }
        public FinalProsthesisTryIn? SingleAndBridge_TryIn { get; set; }
        public FinalProsthesisDelivery? SingleAndBridge_Delivery { get; set; }
        public FinalProsthesisHealingCollar? FullArch_HealingCollar { get; set; }
        public FinalProsthesisImpression? FullArch_Impression { get; set; }
        public FinalProsthesisTryIn? FullArch_TryIn { get; set; }
        public FinalProsthesisDelivery? FullArch_Delivery { get; set; }
        public String? Str_ComplicationsAfterProsthesis { get; set; }
    }
}
