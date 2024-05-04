namespace CIA.Models.CIA.DTOs
{
    public class AdvancedPatientSearchDTO
    {
        public int? Id { get; set; }
        public List<int>? Ids { get; set; }
        public int? AgeRangeFrom { get; set; }
        public int? AgeRangeTo { get; set; }
        public EnumGender? Gender { get; set; }
        public bool? AnyDiseases { get; set; }
        public bool? NoTreatmentPlan { get; set; } = false;
        public List<BloodPressureEnum>? BloodPressureCategories { get; set; }
        public List<DiabetesEnum>? DiabetesCategories { get; set; }
        public int? LastHAB1c_From { get; set; }
        public int? LastHAB1c_To { get; set; }
        public bool? Penecilin { get; set; }
        public bool? IllegalDrugs { get; set; }
        public PregnancyEnum? Pregnancy { get; set; }
        public bool? Chewing { get; set; }
        public SmokingStatus? SmokingStatus { get; set; }
        public EnumCooperationScore? CooperationScore { get; set; }
        public EnumOralHygieneRating? OralHygieneRating { get; set; }


    }
}
