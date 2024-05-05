using AutoMapper;
using CIA.Models.CIA.DTOs;
using CIA.Models.TreatmentModels;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;

namespace CIA.AutoMappers
{
    public class TreatmentPlanMapper : Profile
    {
        public TreatmentPlanMapper()
        {
            CreateMap<TreatmentPlanModel, TreatmentPlansModelDTO>();
            CreateMap<TreatmentDetailsModel, TreatmentPlanDetailsDTO>().ReverseMap();
        }
       
    }
}
