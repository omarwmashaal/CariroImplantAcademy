using AutoMapper;
using CIA.Models.LAB;
using CIA.Models.LAB.DTO;

namespace CIA.AutoMappers
{
    public class LabRequestsMapper : Profile
    {
        public LabRequestsMapper() { 
        
        
            CreateMap<Lab_Request,LAB_RequestsDTO>();
            CreateMap<Lab_Request, LAB_MultiRequestsDTO>().PreserveReferences();
            CreateMap<Lab_RequestStep,LAB_RequestStepDTO>();
            CreateMap<Lab_Request,LAB_RequestsDTOCopy>().PreserveReferences();
        }
    }
}
