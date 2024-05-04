using AutoMapper;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.DTOs;

namespace CIA.AutoMappers
{
    public class RegisterMapper : Profile
    {
        public RegisterMapper()
        {
            CreateMap<RegisterDTO, ApplicationUser>()
                .ForMember(
                dest => dest.PhoneNumber,
                op => op.MapFrom(src => src.PhoneNumber)
                );


            CreateMap<AddPatientDTO, Patient>().ForMember(
                dest => dest.Doctor,
                op => op.Ignore()
                ).ForMember(
                dest => dest.RelativePatient,
                op => op.Ignore()
                ).ForMember(
                dest => dest.ReferralPatient,
                op => op.Ignore()
                );
            CreateMap<Patient, AddPatientDTO>().ForMember(
                dest => dest.Doctor,
                op => op.MapFrom(src => src.Doctor == null ? null : src.Doctor.Name)
                ).ForMember(
                dest => dest.DoctorID,
                op => op.MapFrom(src => src.Doctor == null ? null : src.Doctor.IdInt)
                ).ForMember(
                dest => dest.RegisteredBy,
                op => op.MapFrom(src => src.RegisteredBy == null ? null : src.RegisteredBy.Name)
                ).ForMember(
                dest => dest.RegisteredById,
                op => op.MapFrom(src => src.RegisteredBy == null ? null : src.RegisteredBy.IdInt)
                ).ForMember(
                dest => dest.RelativePatient,
                op => op.MapFrom(src => src.RelativePatient == null ? null : src.RelativePatient.Name)
                ).ForMember(
                dest => dest.ReferralPatient,
                op => op.MapFrom(src => src.ReferralPatient == null ? null : src.ReferralPatient.Name)
                );
            CreateMap<UpdatePatientDTO, Patient>();
            CreateMap<Patient, UpdatePatientDTO>();
        }
    }
}
