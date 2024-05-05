using AutoMapper;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.DTOs;
using System.Security.AccessControl;

namespace CIA.AutoMappers
{
    public class ClinicTreatmentMapper : Profile
    {
        public ClinicTreatmentMapper()
        {
            CreateMap<ClinicTreatmentDTO, ClinicTreatment>().ReverseMap();
            CreateMap<Restoration, RestorationDTO>()
                .ForMember(dest => dest.Doctor, op => op.MapFrom(src => src.Doctor == null ? null : new DropDowns() { Name = src.Doctor.Name, Id = src.Doctor.IdInt }))
                .ForMember(dest => dest.Patient, op => op.MapFrom(src => src.Patient == null ? null : new DropDowns() { Name = src.Patient.Name, Id = src.Patient.Id }))
                .ForMember(dest => dest.Assistant, op => op.MapFrom(src => src.Assistant == null ? null : new DropDowns() { Name = src.Assistant.Name, Id = src.Assistant.IdInt }))
                .ReverseMap();

            CreateMap<ClinicImplant, ClinicImplantDTO>()
                .ForMember(dest => dest.Doctor, op => op.MapFrom(src => src.Doctor == null ? null : new DropDowns() { Name = src.Doctor.Name, Id = src.Doctor.IdInt }))
                .ForMember(dest => dest.Patient, op => op.MapFrom(src => src.Patient == null ? null : new DropDowns() { Name = src.Patient.Name, Id = src.Patient.Id }))
                .ForMember(dest => dest.Implant_, op => op.MapFrom(src => src.Implant_ == null ? null : new DropDowns() { Name = src.Implant_.Name, Id = src.Implant_.Id }))
                .ForMember(dest => dest.ImplantLine_, op => op.MapFrom(src => src.ImplantLine_ == null ? null : new DropDowns() { Name = src.ImplantLine_.Name, Id = src.ImplantLine_.Id }))
                .ForMember(dest => dest.ImplantCompany_, op => op.MapFrom(src => src.ImplantCompany_ == null ? null : new DropDowns() { Name = src.ImplantCompany_.Name, Id = src.ImplantCompany_.Id }))
                .ForMember(dest => dest.Assistant, op => op.MapFrom(src => src.Assistant == null ? null : new DropDowns() { Name = src.Assistant.Name, Id = src.Assistant.IdInt }))
                .ReverseMap();

            CreateMap<OrthoTreatment, OrthoTreatmentDTO>()
                .ForMember(dest => dest.Doctor, op => op.MapFrom(src => src.Doctor == null ? null : new DropDowns() { Name = src.Doctor.Name, Id = src.Doctor.IdInt }))
                .ForMember(dest => dest.Patient, op => op.MapFrom(src => src.Patient == null ? null : new DropDowns() { Name = src.Patient.Name, Id = src.Patient.Id }))
                .ForMember(dest => dest.Assistant, op => op.MapFrom(src => src.Assistant == null ? null : new DropDowns() { Name = src.Assistant.Name, Id = src.Assistant.IdInt }))
                .ReverseMap();

            CreateMap<TMD, TMDDTO>()
                .ForMember(dest => dest.Doctor, op => op.MapFrom(src => src.Doctor == null ? null : new DropDowns() { Name = src.Doctor.Name, Id = src.Doctor.IdInt }))
                .ForMember(dest => dest.Patient, op => op.MapFrom(src => src.Patient == null ? null : new DropDowns() { Name = src.Patient.Name, Id = src.Patient.Id }))
                .ForMember(dest => dest.Assistant, op => op.MapFrom(src => src.Assistant == null ? null : new DropDowns() { Name = src.Assistant.Name, Id = src.Assistant.IdInt }))
                .ReverseMap();

            CreateMap<Pedo, PedoDTO>()
                .ForMember(dest => dest.Doctor, op => op.MapFrom(src => src.Doctor == null ? null : new DropDowns() { Name = src.Doctor.Name, Id = src.Doctor.IdInt }))
                .ForMember(dest => dest.Patient, op => op.MapFrom(src => src.Patient == null ? null : new DropDowns() { Name = src.Patient.Name, Id = src.Patient.Id }))
                .ForMember(dest => dest.Assistant, op => op.MapFrom(src => src.Assistant == null ? null : new DropDowns() { Name = src.Assistant.Name, Id = src.Assistant.IdInt }))
                .ReverseMap();

            CreateMap<RootCanalTreatment, RootCanalTreatmentDTO>()
                .ForMember(dest => dest.Doctor, op => op.MapFrom(src => src.Doctor == null ? null : new DropDowns() { Name = src.Doctor.Name, Id = src.Doctor.IdInt }))
                .ForMember(dest => dest.Patient, op => op.MapFrom(src => src.Patient == null ? null : new DropDowns() { Name = src.Patient.Name, Id = src.Patient.Id }))
                .ForMember(dest => dest.Assistant, op => op.MapFrom(src => src.Assistant == null ? null : new DropDowns() { Name = src.Assistant.Name, Id = src.Assistant.IdInt }))
               .ReverseMap();

            CreateMap<Scaling, ScalingDTO>()
                .ForMember(dest => dest.Doctor, op => op.MapFrom(src => src.Doctor == null ? null : new DropDowns() { Name = src.Doctor.Name, Id = src.Doctor.IdInt }))
                .ForMember(dest => dest.Patient, op => op.MapFrom(src => src.Patient == null ? null : new DropDowns() { Name = src.Patient.Name, Id = src.Patient.Id }))
                .ForMember(dest => dest.Assistant, op => op.MapFrom(src => src.Assistant == null ? null : new DropDowns() { Name = src.Assistant.Name, Id = src.Assistant.IdInt }))
               .ReverseMap();

            CreateMap<ClinicDoctorClinicPercentageModel, ClinicDoctorClinicPercentageDTO>()
              .ForMember(dest => dest.Doctor, op => op.MapFrom(src => src.Doctor == null ? null : new DropDowns() { Name = src.Doctor.Name, Id = src.Doctor.IdInt }))
              .ForMember(dest => dest.Patient, op => op.MapFrom(src => src.Patient == null ? null : new DropDowns() { Name = src.Patient.Name, Id = src.Patient.Id }))
              .ForMember(dest => dest.Restoration, op => op.MapFrom(src => src.Restoration == null ? null : new DropDowns() { Name = $"Tooth: {src.Restoration.Tooth}||{(src.Restoration.Status == null ? "" : Enum.GetName(src.Restoration.Status))} {(src.Restoration.Type == null ? "" : Enum.GetName(src.Restoration.Type))} {(src.Restoration.Class == null ? "" : Enum.GetName(src.Restoration.Class))}", Id = src.Restoration.Id }))
              .ForMember(dest => dest.ClinicImplant, op => op.MapFrom(src => src.ClinicImplant == null ? null : new DropDowns() { Name = $"Tooth: {src.ClinicImplant.Tooth}||{(src.ClinicImplant.Type == null ? "" : Enum.GetName(src.ClinicImplant.Type))}", Id = src.ClinicImplant.Id }))
              .ForMember(dest => dest.TMD, op => op.MapFrom(src => src.TMD == null ? null : new DropDowns() { Name = $"Tooth: {src.TMD.Tooth}||{(src.TMD.Type == null ? "" : Enum.GetName(src.TMD.Type))}", Id = src.ClinicImplant.Id }))
              .ForMember(dest => dest.Scaling, op => op.MapFrom(src => src.Scaling == null ? null : new DropDowns() { Name = $"Tooth: {src.Scaling.Tooth}||{(src.Scaling.Type == null ? "" : Enum.GetName(src.Scaling.Type))}", Id = src.ClinicImplant.Id }))
              .ForMember(dest => dest.RootCanalTreatment, op => op.MapFrom(src => src.RootCanalTreatment == null ? null : new DropDowns() { Name = $"Tooth: {src.RootCanalTreatment.Tooth}||{(src.RootCanalTreatment.Type == null ? "" : Enum.GetName(src.RootCanalTreatment.Type))}", Id = src.ClinicImplant.Id }))
              .ForMember(dest => dest.Pedo, op => op.MapFrom(src => src.Pedo == null ? null : new DropDowns() { Name = $"Tooth: {src.Pedo.Tooth}||{(src.Pedo.FirstStep == null ? "" : Enum.GetName(src.Pedo.FirstStep))} {(src.Pedo.SecondStep == null ? "" : Enum.GetName(src.Pedo.SecondStep))}", Id = src.ClinicImplant.Id }))
              .ForMember(dest => dest.OrthoTreatment, op => op.MapFrom(src => src.OrthoTreatment == null ? null : new DropDowns() { Name = $"Tooth: {src.OrthoTreatment.Tooth}", Id = src.OrthoTreatment.Id }))
             .ReverseMap();


            CreateMap<Restoration, DropDowns>()
            .ForMember(dest => dest.Id, op => op.MapFrom(src => src.Price))
            .ForMember(dest => dest.Name, op => op.MapFrom(src => $"Restoration: Tooth: {src.Tooth}|| {Enum.GetName(src.Type)} {Enum.GetName(src.Status)} {Enum.GetName(src.Class)}"))
            .ReverseMap();



            CreateMap<TMD, DropDowns>()
            .ForMember(dest => dest.Id, op => op.MapFrom(src => src.Price))
            .ForMember(dest => dest.Name, op => op.MapFrom(src => $"TMD: Tooth: {src.Tooth}|| {Enum.GetName(src.Type)}"))
            .ReverseMap();


            CreateMap<OrthoTreatment, DropDowns>()
            .ForMember(dest => dest.Id, op => op.MapFrom(src => src.Price))
            .ForMember(dest => dest.Name, op => op.MapFrom(src => $"Ortho: Tooth: {src.Tooth}"))
            .ReverseMap();




            CreateMap<Scaling, DropDowns>()
            .ForMember(dest => dest.Id, op => op.MapFrom(src => src.Price))
            .ForMember(dest => dest.Name, op => op.MapFrom(src => $"Scaling: Tooth: {src.Tooth}|| {Enum.GetName(src.Type)}"))
            .ReverseMap();



            CreateMap<Pedo, DropDowns>()
            .ForMember(dest => dest.Id, op => op.MapFrom(src => src.Price))
            .ForMember(dest => dest.Name, op => op.MapFrom(src => $"Pedo: Tooth: {src.Tooth}|| {Enum.GetName(src.FirstStep)} {Enum.GetName(src.SecondStep)} "))
            .ReverseMap();



            CreateMap<ClinicImplant, DropDowns>()
            .ForMember(dest => dest.Id, op => op.MapFrom(src => src.Price))
            .ForMember(dest => dest.Name, op => op.MapFrom(src => $"{Enum.GetName(src.Type)}Implant: Tooth: {src.Tooth}"))
            .ReverseMap();



            CreateMap<ClinicTreatmentParent, DropDowns>()

                .ConvertUsing<ClinicTreatmentTypeConverter>()
            ;






        }
    }
}
public class ClinicTreatmentTypeConverter : ITypeConverter<ClinicTreatmentParent, DropDowns>
{


    public DropDowns Convert(ClinicTreatmentParent source, DropDowns destination, ResolutionContext context)
    {
        Console.WriteLine("GOT HERE");
        if (source.GetType() == typeof(Restoration))
            return context.Mapper.Map<DropDowns>((Restoration)source);
        else if (source.GetType() == typeof(TMD))
            return context.Mapper.Map<DropDowns>((TMD)source);
        else if (source.GetType() == typeof(ClinicImplant))
            return context.Mapper.Map<DropDowns>((ClinicImplant)source);
        else if (source.GetType() == typeof(Pedo))
            return context.Mapper.Map<DropDowns>((Pedo)source);
        else if (source.GetType() == typeof(Scaling))
            return context.Mapper.Map<DropDowns>((Scaling)source);
        else if (source.GetType() == typeof(OrthoTreatment))
            return context.Mapper.Map<DropDowns>((OrthoTreatment)source);
        return new DropDowns() {};
    }
}