using CIA.Models.CIA;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.LAB;
using CIA.Models.TreatmentModels;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class Patient
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public String? SecondaryId { get; set; }
        public bool? Listed { get; set; }
        public String Name { get; set; }
        public bool Out { get; set; } = false;
        public String? OutReason { get; set; } = "";
        public EnumGender? Gender { get; set; }
        public String? Phone { get; set; }
        public String? Phone2 { get; set; }
        public DateOnly? DateOfBirth { get; set; }
        public String? MaritalStatus { get; set; }
        public String? Address { get; set; }
        public String? City { get; set; }
        public String? PhotoDirectory { get; set; }
        public String? NationalID { get; set; }
        public String? NationalIDDirectory_front { get; set; }
        public String? NationalIDDirectory_back { get; set; }
        //public EnumPatientType? PatientType { get; set; } = EnumPatientType.CIA;

        [ForeignKey("Lab_Request")]
        public List<Lab_Request>? Requests { get; set; }
        public DateTime? LabDateOfVisit { get; set; }
        public MedicalExaminationModel? MedicalExamination { get; set; } = new();

        public DentalHistoryModel? DentalHistory { get; set; } = new();

        public DentalExaminationModel? DentalExamination { get; set; } = new();
        public String? OperatorImplantNotes { get; set; } = null;

        public List<NonSurgicalTreatmentModel>? NonSurgicalTreatment { get; set; }
        public TreatmentPlanModel? TreatmenPlan { get; set; }
        public ProstheticTreatmentDiagnosticModel? ProstheticTreatment { get; set; }

        [ForeignKey("RegisteredBy.IdInt")]
        public int? RegisteredById { get; set; }
        public ApplicationUser? RegisteredBy { get; set; }
        public DateTime? RegisterationDate { get; set; }

        [ForeignKey(nameof(ReferralPatient))]
        public int? ReferralPatientID { get; set; }
        public Patient? ReferralPatient { get; set; }
        [ForeignKey("Doctor.IdInt")]
        public int? ReferralDoctorID { get; set; }
        public ApplicationUser? ReferralDoctor { get; set; }


        [ForeignKey(nameof(RelativePatient))]
        public int? RelativePatientID { get; set; }
        public Patient? RelativePatient { get; set; }

        [ForeignKey("Doctor.IdInt")]
        public int? DoctorID { get; set; }
        public ApplicationUser? Doctor { get; set; }

        [NotMapped]
        public String? ProfilePhoto { get; set; }
        [NotMapped]
        public String? IdBackPhoto { get; set; }
        [NotMapped]
        public String? IdFrontPhoto { get; set; }

        [ForeignKey("Image")]
        public int? ProfileImageId { get; set; }
        public Image? ProfileImage { get; set; } = new Image();
        [ForeignKey("Image")]
        public int? IdBackImageId { get; set; }
        public Image? IdBackImage { get; set; } = new Image();
        [ForeignKey("Image")]
        public int? IdFrontImageId { get; set; }
        public Image? IdFrontImage { get; set; } = new Image();
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;

    }
}
