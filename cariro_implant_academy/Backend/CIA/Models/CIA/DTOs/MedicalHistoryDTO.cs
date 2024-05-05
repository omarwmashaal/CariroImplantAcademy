using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using static CIA.Models.TreatmentModels.MedicalExaminationModel;

namespace CIA.Models.CIA.DTOs
{
    public class MedicalHistoryDTO
    {
        
        public int? Id { get; set; }
        public int? PatientId { get; set; }
        public GeneralHealthEnum? GeneralHealth { get; set; }
        public PregnancyEnum? PregnancyStatus { get; set; } = PregnancyEnum.None;
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
        public int? OperatorId { get; set; }
        public UserDTO? Operator { get; set; }
        public DateTime? Date { get; set; }
        public bool? HasChanges { get; set; } = false;
        public EnumWebsite Website { get; set; }




    }
}


