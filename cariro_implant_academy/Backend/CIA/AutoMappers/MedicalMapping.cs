using AutoMapper;
using CIA.Models.CIA.DTOs;
using CIA.Models.TreatmentModels;

namespace CIA.AutoMappers
{
    public class MedicalMapping : Profile
    {
        public MedicalMapping() {

            CreateMap<MedicalExaminationModel, MedicalHistoryDTO>();
        }
    }
}
