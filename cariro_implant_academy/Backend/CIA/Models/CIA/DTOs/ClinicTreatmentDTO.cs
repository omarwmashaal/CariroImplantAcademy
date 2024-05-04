namespace CIA.Models.CIA.DTOs
{
    

    public class RestorationDTO
    {
        public int? Id { get; set; }


        public int? PatientId { get; set; }
        public int? ClinicReceiptModelId { get; set; }
        public DropDowns? Patient { get; set; }
        public int? Tooth { get; set; }
        public EnumClinicRestorationType? Type { get; set; } = EnumClinicRestorationType.NotSelected;
        public EnumClinicRestorationStatus? Status { get; set; } = EnumClinicRestorationStatus.NotSelected;
        public EnumClinicRestorationClass? Class { get; set; } = EnumClinicRestorationClass.NotSelected;
        public bool? Done { get; set; } = false;
        public DateTime? Date { get; set; }

        public int? AssistantId { get; set; }
        public DropDowns? Assistant { get; set; }

        public int? DoctorId { get; set; }
        public DropDowns? Doctor { get; set; }
        public int? Price { get; set; }
        public int? StatusPrice { get; set; }
        public int? TypePrice { get; set; }
        public int? ClassPrice { get; set; }
    }
    public class ClinicImplantDTO
    {


        public int? Id { get; set; }
        public int? ClinicReceiptModelId { get; set; }


        public int? PatientId { get; set; }
        public DropDowns? Patient { get; set; }
        public int? Tooth { get; set; }
        public EnumClinicImplantTypes? Type { get; set; } = EnumClinicImplantTypes.NotSelected;
        public String? Notes { get; set; }
        public int? ImplantId { get; set; }
        public DropDowns? Implant_ { get; set; }
        public int? ImplantCompanyId { get; set; }
        public DropDowns? ImplantCompany_ { get; set; }

        public int? ImplantLineId { get; set; }
        public DropDowns? ImplantLine_ { get; set; }
        public bool? Done { get; set; } = false;
        public DateTime? Date { get; set; }


        public int? AssistantId { get; set; }
        public DropDowns? Assistant { get; set; }


        public int? DoctorId { get; set; }
        public DropDowns? Doctor { get; set; }
        public int? Price { get; set; }

    }
    public class OrthoTreatmentDTO
    {


        public int?  Id { get; set; }
        public int? ClinicReceiptModelId { get; set; }


        public int? PatientId { get; set; }
        public DropDowns? Patient { get; set; }
        public int? Tooth { get; set; }
        public String? Notes { get; set; }
        public bool? Done { get; set; } = false;
        public DateTime? Date { get; set; }


        public int? AssistantId { get; set; }
        public DropDowns? Assistant { get; set; }


        public int? DoctorId { get; set; }
        public DropDowns? Doctor { get; set; }
        public int? Price { get; set; }

    }
    public class TMDDTO
    {


        public int? Id { get; set; }
        public int? ClinicReceiptModelId { get; set; }
        public int? StepNumber { get; set; } = 1;


        public int? PatientId { get; set; }
        public DropDowns? Patient { get; set; }
        public int? Tooth { get; set; }
        public String? Notes { get; set; }
        public EnumClinicTMDtypes? Type { get; set; } = EnumClinicTMDtypes.NotSelected;
        public bool? Done { get; set; } = false;
        public DateTime? Date { get; set; }


        public int? AssistantId { get; set; }
        public DropDowns? Assistant { get; set; }


        public int? DoctorId { get; set; }
        public DropDowns? Doctor { get; set; }
        public int? Price { get; set; }
        public int? SecondStepPrice { get; set; }
        public int? FirstStepPrice { get; set; }

    }

    public class PedoDTO
    {


        public int? Id { get; set; }
        public int? ClinicReceiptModelId { get; set; }


        public int? PatientId { get; set; }
        public DropDowns? Patient { get; set; }
        public int? Tooth { get; set; }
        public String? Notes { get; set; }
        public EnumClinicPedoFirstStep? FirstStep { get; set; } = EnumClinicPedoFirstStep.NotSelected;
        public EnumClinicPedoSecondStep? SecondStep { get; set; } = EnumClinicPedoSecondStep.NotSelected;
        public bool? Done { get; set; } = false;
        public DateTime? Date { get; set; }


        public int? AssistantId { get; set; }
        public DropDowns? Assistant { get; set; }


        public int? DoctorId { get; set; }
        public DropDowns? Doctor { get; set; }
        public int? Price { get; set; }

    }


    public class RootCanalTreatmentDTO
    {


        public int? Id { get; set; }
        public int? ClinicReceiptModelId { get; set; }


        public int? PatientId { get; set; }
        public DropDowns? Patient { get; set; }
        public int? Tooth { get; set; }
        public EnumClinicRootCanalTreatmentType? Type { get; set; }
        public String? Notes { get; set; }
        public int? Length { get; set; }
        public bool? Done { get; set; } = false;
        public DateTime? Date { get; set; }


        public int? AssistantId { get; set; }
        public DropDowns? Assistant { get; set; }


        public int? DoctorId { get; set; }
        public DropDowns? Doctor { get; set; }
        public int CanalNumber { get; set; }
        public int? Price { get; set; }

    }


    public class ScalingDTO
    {
        
        public int? Id { get; set; }
        public int? ClinicReceiptModelId { get; set; }
        public int? PatientId { get; set; }
        public DropDowns? Patient { get; set; }
        public int? StepNumber { get; set; }
        public int? Tooth { get; set; }
        public EnumClinicScalingType? Type { get; set; }
        public String? Notes { get; set; }
        public bool? Done { get; set; } = false;
        public DateTime? Date { get; set; }
        public int? AssistantId { get; set; }
        public DropDowns? Assistant { get; set; }
        public int? DoctorId { get; set; }
        public DropDowns? Doctor { get; set; }
        public int? Price { get; set; }

    }

}
