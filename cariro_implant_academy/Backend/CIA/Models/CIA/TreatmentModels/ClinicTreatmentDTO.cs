using CIA.Models.CIA.DTOs;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels
{

    [Table("ClinicTreatmentParent")]
    public class ClinicTreatmentParent
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [ForeignKey("ClinicReceiptModel")]
        public int? ClinicReceiptModelId { get; set; }
        [ForeignKey("Patient")]
        public int PatientId { get; set; }
        public Patient? Patient { get; set; }
        public int Tooth { get; set; }
        public bool Done { get; set; } = false;
        public DateTime? Date { get; set; }

        [ForeignKey("AssistantId")]
        public int? AssistantId { get; set; }
        public ApplicationUser? Assistant { get; set; }

        [ForeignKey("DoctorId")]
        public int? DoctorId { get; set; }
        public ApplicationUser? Doctor { get; set; }
        public int? Price { get; set; } = 0;
        public String? Notes { get; set; }


    }
    public class ClinicTreatmentDTO

    {
        public int PatientId { get; set; }
        public List<RestorationDTO>? Restorations { get; set; } = new List<RestorationDTO> { };
        public List<ClinicImplantDTO>? ClinicImplants { get; set; } = new List<ClinicImplantDTO> { };
        public List<OrthoTreatmentDTO>? OrthoTreatments { get; set; } = new List<OrthoTreatmentDTO> { };
        public List<TMDDTO>? TMDs { get; set; } = new List<TMDDTO> { };
        public List<PedoDTO>? Pedos { get; set; } = new List<PedoDTO> { };
        public List<RootCanalTreatmentDTO>? RootCanalTreatments { get; set; } = new List<RootCanalTreatmentDTO> { };
        public List<ScalingDTO>? Scalings { get; set; } = new List<ScalingDTO> { };
        public DropDowns? PatientsDoctor { get; set; }



    }
    public class ClinicTreatment

    {
        public int PatientId { get; set; }
        public List<Restoration>? Restorations { get; set; } = new List<Restoration> { };
        public List<ClinicImplant>? ClinicImplants { get; set; } = new List<ClinicImplant> { };
        public List<OrthoTreatment>? OrthoTreatments { get; set; } = new List<OrthoTreatment> { };
        public List<TMD>? TMDs { get; set; } = new List<TMD> { };
        public List<Pedo>? Pedos { get; set; } = new List<Pedo> { };
        public List<RootCanalTreatment>? RootCanalTreatments { get; set; } = new List<RootCanalTreatment> { };
        public List<Scaling>? Scalings { get; set; } = new List<Scaling> { };



    }

    public class Restoration : ClinicTreatmentParent
    {

        public EnumClinicRestorationType Type { get; set; } = EnumClinicRestorationType.NotSelected;
        public EnumClinicRestorationStatus Status { get; set; } = EnumClinicRestorationStatus.NotSelected;
        public EnumClinicRestorationClass Class { get; set; } = EnumClinicRestorationClass.NotSelected;

        public int? StatusPrice { get; set; }
        public int? TypePrice { get; set; }
        public int? ClassPrice { get; set; }
    }
    public class ClinicImplant : ClinicTreatmentParent
    {
        public EnumClinicImplantTypes Type { get; set; } = EnumClinicImplantTypes.NotSelected;
        [ForeignKey("Implant")]
        public int? ImplantId { get; set; }
        public Implant? Implant_ { get; set; }
        [ForeignKey("ImplantCompany")]
        public int? ImplantCompanyId { get; set; }
        public ImplantCompany? ImplantCompany_ { get; set; }
        [ForeignKey("ImplantLine")]
        public int? ImplantLineId { get; set; }
        public ImplantLine? ImplantLine_ { get; set; }

    }
    public class OrthoTreatment : ClinicTreatmentParent
    {




    }
    public class TMD : ClinicTreatmentParent
    {

        public int? StepNumber { get; set; } = 1;

        public EnumClinicTMDtypes Type { get; set; } = EnumClinicTMDtypes.NotSelected;


    }

    public class Pedo : ClinicTreatmentParent
    {


        public EnumClinicPedoFirstStep FirstStep { get; set; } = EnumClinicPedoFirstStep.NotSelected;
        public EnumClinicPedoSecondStep SecondStep { get; set; } = EnumClinicPedoSecondStep.NotSelected;
        public int? SecondStepPrice { get; set; }
        public int? FirstStepPrice { get; set; }

    }


    public class RootCanalTreatment : ClinicTreatmentParent
    {

        public int? CanalNumber { get; set; }
        public EnumClinicRootCanalTreatmentType Type { get; set; }

        public int? Length { get; set; }

    }
    public class Scaling : ClinicTreatmentParent
    {

        public int? StepNumber { get; set; }
        public EnumClinicScalingType Type { get; set; }



    }



}


