using CIA.Models.CIA.TreatmentModels;
using CIA.Models.TreatmentModels;

namespace CIA.Models.CIA
{
    public class AdvancedSearchModel
    {
        public MedicalExaminationModel? MedicalExaminationModel { get; set; }
        public DentalHistoryModel? DentalHistoryModel { get; set; }
        public DentalExaminationAdvancedSearchModel? DentalExaminationModel { get; set; }
        public TreatmentPlanAdvancedSearchModel? TreatmentPlan { get; set; }
        public TreatmentPlanAdvancedSearchModel? SurgicalTreatment { get; set; }
        public bool? IllegalDrugs { get; set; }
        public bool? WillingToImplant { get; set; }
        public bool? ClenchOrGrind { get; set; }
        public ValuesEnum? Hba1cValueEnum { get; set; }
        public TobaccoEnum? TobaccoEnum { get; set; }
        public int? CandidateId { get; set; }


    }

    public enum ValuesEnum { GreaterThan, Equals, LessThan }

    public enum TobaccoEnum { NonSmoker, LightSmoker, MediumSmoker, HeavySmoker }

    public class TreatmentPlanAdvancedSearchModel
    {
        public bool? SimpleImplant { get; set; }
        public bool? ImmediateImplant { get; set; }
        public bool? GuidedImplant { get; set; }
        public bool? ExpansionWithImplant { get; set; }
        public bool? SplittingWithImplant { get; set; }
        public bool? GBRWithImplant { get; set; }
        public bool? OpenSinusWithImplant { get; set; }
        public bool? ClosedSinusWithImplant { get; set; }
        public bool? ExpansionWithoutImplant { get; set; }
        public bool? SplittingWithoutImplant { get; set; }
        public bool? GBRWithoutImplant { get; set; }
        public bool? OpenSinusWithoutImplant { get; set; }
        public bool? ClosedSinusWithoutImplant { get; set; }
        public bool? Extraction { get; set; }
        public bool? Restoration { get; set; }
        public bool? RootCanalTreatment { get; set; }
        public bool? Pontic { get; set; }
    }

    public class AdvancedSearchTreatmentResponseModel
    {
        public int? Id { get; set; }
        public int? Tooth { get; set; }
        public string? SecondaryId { get; set; }
        public string? PatientName { get; set; }
        public string TreatmentValue { get; set; }
        public string TreatmentName { get; set; }
        public int TreatmentId { get; set; }
        public bool? ClearanceUpper { get; set; }
        public bool? ClearanceLower { get; set; }
        public DentalExaminationModel.DentalExamination? ImplantFailed { get; set; }
        public String? Str_ComplicationsAfterSurgery { get; set; }
        public String? Str_ComplicationsAfterProsthesis { get; set; }
        public DropDowns? Candidate { get; set; }
        public DropDowns? CandidateBatch { get; set; }
        public String? Implant { get; set; }
        public String? ImplantLine { get; set; }
    }

    
    public class AdvancedSearchTreatmentToothDetails
    {
        public int Id { get; set; }
        public String Value { get; set; }
    }
    public class DentalExaminationAdvancedSearchModel
    {
        public bool? Carious { get; set; }
        public bool? Filled { get; set; }
        public bool? Missed { get; set; }
        public bool? NotSure { get; set; }
        public bool? MobilityI { get; set; }
        public bool? MobilityII { get; set; }
        public bool? MobilityIII { get; set; }
        public bool? HopelessTeeth { get; set; }
        public bool? ImplantPlaced { get; set; }
        public bool? ImplantFailed { get; set; }
    }

}
