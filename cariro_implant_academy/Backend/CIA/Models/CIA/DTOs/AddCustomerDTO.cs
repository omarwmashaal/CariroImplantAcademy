using CIA.Models.LAB;
using System.ComponentModel.DataAnnotations;

namespace CIA.Models.CIA.DTOs
{
    public class AddCustomerDTO
    {
        public String? Name{get; set;}
        public String? PhoneNumber{get; set;}
        public String? PhoneNumber2{get; set;}
        public int? WorkplaceId{get; set;}
        public Lab_CustomerWorkPlace? WorkPlace{get; set;}
        [Required]
        public EnumWebsite WorkPlaceEnum { get; set; }
    }
}
