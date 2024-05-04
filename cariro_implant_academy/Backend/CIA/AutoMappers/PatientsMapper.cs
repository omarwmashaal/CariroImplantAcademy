using AutoMapper;
using CIA.Features.Patients;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;

namespace CIA.AutoMappers
{
    public class PatientsMapper : Profile
    {
        public PatientsMapper()
        {
            CreateMap<Patient, PatientDTO>();
            CreateMap<Patient, DropDowns>();
            CreateMap<Patient, CreatePatientCommand.Command>();

        }
    }
}
