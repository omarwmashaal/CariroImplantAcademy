using AutoMapper;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;

namespace CIA.AutoMappers
{
    public class UserMapper : Profile
    {
        public UserMapper()
        {
            CreateMap<ApplicationUser, UserDTO>().ForMember(
                o => o.IdInt,
                d => d.MapFrom(s => s.IdInt)
                ).ForMember(
                o => o.Phone,
                d => d.MapFrom(s => s.PhoneNumber)
                ).ReverseMap();
            CreateMap<LoginResponseDTO, ApplicationUser>();
            CreateMap<ApplicationUser, DropDowns>().ForMember(
                o => o.Id,
                d => d.MapFrom(s => s.IdInt)
                );

        }
    }
}
