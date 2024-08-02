using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations;

namespace CIA.Models.DTOs
{
    public class RegisterDTO
    {
        public String? Email { get; set; }
        public String Name { get; set; }
        //public String Role { get; set; }
        public List<String> Roles { get; set; }
        public String Gender { get; set; }
        public String PhoneNumber { get; set; }
        public DateOnly? DateOfBirth { get; set; }
        public String? GraduatedFrom { get; set; }
        public String? ClassYear { get; set; }
        public String? Speciality { get; set; }
        public List<EnumWebsite>? AccessWebsites { get; set; }

        [Required]
        public EnumWebsite WorkPlaceEnum { get; set; }
        public int? BatchId { get; set; }
        public CandidatesBatchesModel? Batch { get; set; }
        public String? InstagramLink { get; set; }
        public String? FacebookLink { get; set; }
    }
}
