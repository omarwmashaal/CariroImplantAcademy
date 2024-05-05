using AutoMapper;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;

namespace CIA.AutoMappers
{
    public class ComplainsMapper: Profile
    {
        
        public ComplainsMapper()
        {
           // _mapper = mapper;

            CreateMap<CIA_Complains, ComplainsDTO>();
        }
    }
}
