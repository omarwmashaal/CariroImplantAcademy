namespace CIA.Models.DTOs
{
    public class UpdatePatientDTO
    {
       
        public String? Name { get; set; }
        public EnumGender? Gender { get; set; }
        public String? Phone { get; set; }
        public String? Phone2 { get; set; }
        public DateOnly? DateOfBirth { get; set; }
        public String? MaritalStatus { get; set; }
        public String? Address { get; set; }
        public String? City { get; set; }
    }
}
