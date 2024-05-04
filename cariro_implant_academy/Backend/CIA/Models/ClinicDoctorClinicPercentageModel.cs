using CIA.Models.CIA;
using CIA.Models.CIA.TreatmentModels;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class ClinicDoctorClinicPercentageModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public DateTime DateTime { get; set; }

        [ForeignKey("ClinicTreatmentParent")]

        public int? ClinicTreatmentId { get; set; }

        [ForeignKey("ApplicationUser")]
        public int? DoctorId { get; set; }
        public ApplicationUser? Doctor { get; set; }
        [ForeignKey("Restoration")]
        public int? RestorationId { get; set; }
        public Restoration? Restoration { get; set; }
        [ForeignKey("ClinicImplant")]
        public int? ClinicImplantId { get; set; }
        public ClinicImplant? ClinicImplant { get; set; }
        [ForeignKey("OrthoTreatment")]
        public int? OrthoTreatmentId { get; set; }
        public OrthoTreatment? OrthoTreatment { get; set; }
        [ForeignKey("TMD")]
        public int? TMDId { get; set; }
        public TMD? TMD { get; set; }
        [ForeignKey("Pedo")]
        public int? PedoId { get; set; }
        public Pedo? Pedo { get; set; }
        [ForeignKey("RootCanalTreatment")]
        public int? RootCanalTreatmentId { get; set; }
        public RootCanalTreatment? RootCanalTreatment { get; set; }
        [ForeignKey("Scaling")]
        public int? ScalingId { get; set; }
        public Scaling? Scaling { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public int OperationFee { get; set; }
        public int DoctorsFees { get; set; }
        public EnumDortorsPercentageEnum? DoctorFeesType { get; set; }
        public int ClinicFee { get; set; }
        public bool Paid { get; set; } = false;
    }
    public class ClinicDoctorClinicPercentageDTO
    {
        public int Id { get; set; }
        public int? ClinicTreatmentId { get; set; }
        public DateTime DateTime { get; set; }

        public int? DoctorId { get; set; }
        public DropDowns? Doctor { get; set; }
        public int? RestorationId { get; set; }
        public DropDowns? Restoration { get; set; }
        public int? ClinicImplantId { get; set; }
        public DropDowns? ClinicImplant { get; set; }
        public int? OrthoTreatmentId { get; set; }
        public DropDowns? OrthoTreatment { get; set; }
        public int? TMDId { get; set; }
        public DropDowns? TMD { get; set; }
        public int? PedoId { get; set; }
        public DropDowns? Pedo { get; set; }
        public int? RootCanalTreatmentId { get; set; }
        public DropDowns? RootCanalTreatment { get; set; }
        public int? ScalingId { get; set; }
        public DropDowns? Scaling { get; set; }
        public int? PatientId { get; set; }
        public DropDowns? Patient { get; set; }
        public int OperationFee { get; set; }
        public int DoctorsFees { get; set; }
        public EnumDortorsPercentageEnum? DoctorFeesType { get; set; }
        public int ClinicFee { get; set; }
        public bool Paid { get; set; } = false;
    }
}
