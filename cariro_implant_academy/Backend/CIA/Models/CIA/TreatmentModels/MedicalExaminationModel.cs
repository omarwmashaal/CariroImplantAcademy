using CIA.Models.CIA;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace CIA.Models.TreatmentModels
{
    

    public class MedicalExaminationModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public GeneralHealthEnum? GeneralHealth { get; set; } = GeneralHealthEnum.Good;
        public PregnancyEnum? PregnancyStatus { get; set; }       
        public String? AreYouTreatedFromAnyThing { get; set; }
        public String? RecentSurgery { get; set; }
        public String? Comment { get; set; }
        public List<DiseasesEnum>? Diseases { get; set; }
        public String? OtherDiseases { get; set; }
        public BloodPressureModel? BloodPressure { get; set; }
        public Diabetes? Diabetic { get; set; }
        public List<HBA1cModel>? HBA1c { get; set; }
        public bool? Penicillin { get; set; }
        public bool? Sulfa { get; set; }
        public bool? OtherAllergy { get; set; }
        public String? OtherAllergyComment { get; set; }
        public bool? ProlongedBleedingOrAspirin { get; set; }
        public bool? ChronicDigestion { get; set; }
        public String? IllegalDrugs { get; set; }
        public String? OperatorComments { get; set; }
        public List<String>? DrugsTaken { get; set; }

        [ForeignKey("Operator.IdInt")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }
        public DateTime? Date { get; set; }
        public bool? HasChanges { get; set; } = false;
        public DateTime? Notification_Hba1c { get; set; }


        [Owned]
        public class BloodPressureModel
        {
            public String? LastReading { get; set; }
            public DateOnly? When { get; set; }
            public String? Drug { get; set; }
            public String? ReadingInClinic { get; set; }
            public BloodPressureEnum? Status { get; set; }
                
        }
        
        [Owned]

        public class Diabetes
        {
            public int? LastReading { get; set; }
            public DateOnly? When { get; set; }
            public int? RandomInClinic { get; set; }
            public DiabetesEnum? Status { get; set; }
            public DiabetesType? Type { get; set; }
        }
        [Owned]

        public class HBA1cModel
        {
            public DateOnly? Date { get; set; }
            public double? Reading { get; set; }
        }

        
    }
    

}
