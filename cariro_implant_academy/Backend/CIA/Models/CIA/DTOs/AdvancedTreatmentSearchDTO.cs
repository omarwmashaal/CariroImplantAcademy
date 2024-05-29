
using CIA.Models.CIA.TreatmentModels;

namespace CIA.Models.CIA.DTOs
{
    public class AdvancedTreatmentSearchDTO
    {
        public int? Id { get; set; }
        public List<int>? Ids { get; set; }
        public String? PatientName { get; set; }
        public bool? Done { get; set; } = false;
        public bool? NoTreatmentPlan { get; set; } = false;
        public bool? Scaling { get; set; }
        public bool? Crown { get; set; }
        public bool? RootCanalTreatment { get; set; }
        public bool? Restoration { get; set; }
        public bool? Pontic { get; set; }
        public bool? Extraction { get; set; }
        public bool? SimpleImplant { get; set; }
        public bool? ImmediateImplant { get; set; }
        public bool? ExpansionWithImplant { get; set; }
        public bool? SplittingWithImplant { get; set; }
        public bool? GBRWithImplant { get; set; }
        public bool? OpenSinusWithImplant { get; set; }
        public bool? ClosedSinusWithImplant { get; set; }
        public bool? GuidedImplant { get; set; }
        public bool? ExpansionWithoutImplant { get; set; }
        public bool? SplittingWithoutImplant { get; set; }
        public bool? GBRWithoutImplant { get; set; }
        public bool? OpenSinusWithoutImplant { get; set; }
        public bool? ClosedSinusWithoutImplant { get; set; }
        public EnumTeethClassification? TeethClassification { get; set; }
        public List<int> And_TreatmentIds { get; set; }
        public List<int> Or_TreatmentIds { get; set; }
        public bool? And_scaling { get; set; }
        public bool? And_crown { get; set; }
        public bool? And_rootCanalTreatment { get; set; }
        public bool? And_restoration { get; set; }
        public bool? And_pontic { get; set; }
        public bool? And_extraction { get; set; }
        public bool? And_simpleImplant { get; set; }
        public bool? And_immediateImplant { get; set; }
        public bool? And_expansionWithImplant { get; set; }
        public bool? And_splittingWithImplant { get; set; }
        public bool? And_gbrWithImplant { get; set; }
        public bool? And_openSinusWithImplant { get; set; }
        public bool? And_closedSinusWithImplant { get; set; }
        public bool? And_guidedImplant { get; set; }
        public bool? And_expansionWithoutImplant { get; set; }
        public bool? And_splittingWithoutImplant { get; set; }
        public bool? And_gbrWithoutImplant { get; set; }
        public bool? And_openSinusWithoutImplant { get; set; }
        public bool? And_closedSinusWithoutImplant { get; set; }
        public bool? ClearanceUpper { get; set; }
        public bool? ClearanceLower { get; set; }

        public ComplicationsAfterSurgeryModel? complicationsAfterSurgery { get; set; }
        public ComplicationsAfterSurgeryModel? complicationsAfterSurgeryOr { get; set; }
        public bool? ImplantFailed { get; set; }
     




    }
}
