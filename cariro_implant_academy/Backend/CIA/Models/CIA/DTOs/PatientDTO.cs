namespace CIA.Models.CIA.DTOs
{
    public class PatientDTO

    {
        public int Id { get; set; }
        public String Name { get; set; }
        public EnumGender? Gender { get; set; }
        public String? Phone { get; set; }
        public bool? Listed { get; set; }
        public String? Phone2 { get; set; }
        public DateOnly? DateOfBirth { get; set; }
        public String? MaritalStatus { get; set; }
        public String? Address { get; set; }
        public String? City { get; set; }
        public String? PhotoDirectory { get; set; }
        public String? NationalID { get; set; }
        public String? NationalIDDirectory_front { get; set; }
        public String? NationalIDDirectory_back { get; set; }
        public EnumPatientType? PatientType { get; set; } = EnumPatientType.CIA;
        public DateTime? LabDateOfVisit { get; set; }
        public int? RegisteredById { get; set; }
        public UserDTO? RegisteredBy { get; set; }
        public DateTime? RegisterationDate { get; set; }
        public int? ReferralPatientID { get; set; }
        //public Patient? ReferralPatient { get; set; }
        public int? RelativePatientID { get; set; }
        //  public Patient? RelativePatient { get; set; }

        public int? DoctorID { get; set; }
        public UserDTO? Doctor { get; set; }




        public int? ProfileImageId { get; set; }
        public int? IdBackImageId { get; set; }
        public int? IdFrontImageId { get; set; }



    }
}
