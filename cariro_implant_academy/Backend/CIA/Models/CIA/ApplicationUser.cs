using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using CIA.Models.LAB;
using Microsoft.EntityFrameworkCore;
using CIA.Models.CIA.DTOs;

namespace CIA.Models.CIA
{
    public class ApplicationUser : IdentityUser
    {

        public string? Name { get; set; }
        public DateOnly? DateOfBirth { get; set; }
        public string? Gender { get; set; }
        public string? PhoneNumber2 { get; set; }
        public string? GraduatedFrom { get; set; }
        public string? ClassYear { get; set; }
        public string? Speciality { get; set; }
        public string? MaritalStatus { get; set; }
        public string? Address { get; set; }
        public string? City { get; set; }
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? IdInt { get; set; }

        [ForeignKey("RegisteredBy.IdInt")]
        public int? RegisteredById { get; set; }
        public ApplicationUser? RegisteredBy { get; set; }
        public DateTime? RegisterationDate { get; set; }
        public EnumWebsite? Website { get; set; }

        [NotMapped]
        public String? Token { get; set; }


        [ForeignKey("Lab_CustomerWorkPlace")]
        public int? WorkplaceId { get; set; }
        public Lab_CustomerWorkPlace? WorkPlace { get; set; }
        public EnumLabRequestSources? WorkPlaceEnum { get; set; }
        [ForeignKey("CandidatesBatchesModel")]
        public int? BatchId { get; set; }
        public CandidatesBatchesModel? Batch { get; set; }
        [ForeignKey("Image")]
        public int? ProfileImageId { get; set; }
        public Image? ProfileImage { get; set; } = new Image();
        public List<ConnectionModel>? Connections { get; set; } = new List<ConnectionModel>();
        [NotMapped]
        public String? Role { get; set; }
        [NotMapped]
        public List<String>? Roles { get; set; }
        public List<EnumWebsite> AccessWebsites { get; set; } = new List<EnumWebsite>();
        public String? InstagramLink { get; set; }
        public String? FacebookLink { get; set; }
        public int? ImplantCount { get; set; }

    }

    public static class UserConversion
    {
        public static UserDTO ToUserDTO(this ApplicationUser user)
        {
            return new UserDTO()
            {
                Name = user.Name,
                IdInt = (int)user.IdInt
            };
        }
    }
    public class ApplicationRole : IdentityRole<int>
    {
    }

    public class ApplicationRoleClaim : IdentityRoleClaim<int>
    {
    }
    public class ApplicationUserClaim : IdentityUserClaim<int>
    {
    }

    [Owned]
    public class ConnectionModel
    {
        
        public String ConnectionId { get; set; }
        public bool isConnected { get; set; }
    }
}
