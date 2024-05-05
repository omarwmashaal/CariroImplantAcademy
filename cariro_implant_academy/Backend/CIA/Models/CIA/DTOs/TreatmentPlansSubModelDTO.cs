namespace CIA.Models.CIA.DTOs
{
    public class TreatmentPlansSubModelDTO
    {
        public int? Id { get; set; }
        public int? PatientId { get; set; }
        public PatientDTO? Patient { get; set; }
        public int Tooth { get; set; }
        public TreatmentPlanFieldsDTO? Scaling { get; set; }
        public TreatmentPlanFieldsDTO? Crown { get; set; }
        public TreatmentPlanFieldsDTO? RootCanalTreatment { get; set; }
        public TreatmentPlanFieldsDTO? Restoration { get; set; }
        public TreatmentPlanFieldsDTO? Pontic { get; set; }
        public TreatmentPlanFieldsDTO? Extraction { get; set; }
        public TreatmentPlanFieldsDTO? SimpleImplant { get; set; }
        public TreatmentPlanFieldsDTO? ImmediateImplant { get; set; }
        public TreatmentPlanFieldsDTO? ExpansionWithImplant { get; set; }
        public TreatmentPlanFieldsDTO? SplittingWithImplant { get; set; }
        public TreatmentPlanFieldsDTO? GBRWithImplant { get; set; }
        public TreatmentPlanFieldsDTO? OpenSinusWithImplant { get; set; }
        public TreatmentPlanFieldsDTO? ClosedSinusWithImplant { get; set; }
        public TreatmentPlanFieldsDTO? GuidedImplant { get; set; }
        public TreatmentPlanFieldsDTO? ExpansionWithoutImplant { get; set; }
        public TreatmentPlanFieldsDTO? SplittingWithoutImplant { get; set; }
        public TreatmentPlanFieldsDTO? GBRWithoutImplant { get; set; }
        public TreatmentPlanFieldsDTO? OpenSinusWithoutImplant { get; set; }
        public TreatmentPlanFieldsDTO? ClosedSinusWithoutImplant { get; set; }

    }
}
