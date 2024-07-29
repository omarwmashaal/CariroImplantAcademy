using AutoMapper;
using CIA.Models.CIA;
using CIA.Models.DTOs;

namespace CIA.AutoMappers
{
    public class VisitsMapper : Profile
    {
        public VisitsMapper()
        {
            CreateMap<VisitsLog,VisitDTO>()
                .ForMember(dest=> dest.DoctorName,op=>op.MapFrom(src=>src.Doctor==null?"":src.Doctor.Name??""))
                .ForMember(dest=> dest.PatientName,op=>op.MapFrom(src=>src.Patient==null?"":src.Patient.Name??""))
                .ForMember(dest=> dest.Title,op=>op.MapFrom(src=> $"Patient: {(src.Patient == null ? "" : src.Patient.Name)} || {src.Title??""} || Dr: {(src.Doctor == null ? "" : src.Doctor.Name??"")}"))
                .ForMember(dest=> dest.Status,op=>op.MapFrom(src=> src.Status.Value))
                .ForMember(dest=> dest.SecondaryId,op=>op.MapFrom(src=> src.Patient.SecondaryId))
                .ForMember(dest=> dest.Duration, op=>op.MapFrom(src=> 
                                (src.LeaveTime != null && src.EntersClinicTime != null)?
                                    (src.LeaveTime - src.EntersClinicTime)
                                    :null
                                )
                            )
                
                ;
        }
    }
}
