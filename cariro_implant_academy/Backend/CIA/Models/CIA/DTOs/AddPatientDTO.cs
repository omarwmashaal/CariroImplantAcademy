using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.DTOs
{
    public class AddPatientDTO
    {
        public int? Id { get; set; }
        public String? SecondaryId { get; set; }
        public string Name { get; set; }
        public bool Listed { get; set; }
        public EnumGender Gender { get; set; }
        public string Phone { get; set; }
        public string? OutReason { get; set; }
        public bool Out { get; set; } = false;
        public String? NationalID { get; set; }
        public string? Phone2 { get; set; }
        public DateOnly DateOfBirth { get; set; }
        public string MaritalStatus { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string? ProfilePhoto { get; set; }
        public string? IdBackPhoto { get; set; }
        public string? IdFrontPhoto { get; set; }
        public int? ReferralPatientID { get; set; }
        public int? RelativePatientID { get; set; }
        public String? RelativePatient { get; set; }
        public String? ReferralPatient { get; set; }
        public String? Doctor { get; set; }
        public int? DoctorID { get; set; }
        public int? RegisteredById { get; set; }
        public String? RegisteredBy { get; set; }
        public DateTime? RegisterationDate { get; set; }
        public EnumPatientType? PatientType { get; set; } = EnumPatientType.CIA;
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
        public int? ProfileImageId { get; set; }
        public int? IdBackImageId { get; set; }
        public int? IdFrontImageId { get; set; }

    }
}
