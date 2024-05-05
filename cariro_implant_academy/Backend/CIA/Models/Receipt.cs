using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;
using CIA.Models.CIA;
using CIA.Models.LAB;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.TreatmentModels;

namespace CIA.Models
{
    public class Receipt
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public DateTime Date { get; set; }
        [ForeignKey("Operator.IdInt")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }
        public int Total { get; set; } = 0;
        public int Paid { get; set; } = 0;
        public int Unpaid { get; set; } = 0; 
        [ForeignKey("Lab_Request")]
        public int? RequestId { get; set; }
        public Lab_Request? Request { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public List<ToothReceiptData> ToothReceiptData { get; set; } = new List<ToothReceiptData>();
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA; 
        public List<ClinicTreatmentParent> Prices { get; set; } = new List<ClinicTreatmentParent>();
        public bool IsPaid { get; set; } = false;
        public LabRequestItem? WaxUp { get; set; }
        public LabRequestItem? ZirconUnit { get; set; }
        public LabRequestItem? PFM { get; set; }
        public LabRequestItem? CompositeInlay { get; set; }
        public LabRequestItem? EmaxVeneer { get; set; }
        public LabRequestItem? MilledPMMA { get; set; }
        public LabRequestItem? PrintedPMMA { get; set; }
        public LabRequestItem? TiAbutment { get; set; }
        public LabRequestItem? TiBar { get; set; }
        public LabRequestItem? ThreeDPrinting { get; set; }
        public int? LabFees { get; set; } = 0;


    }

    [Owned]
    public class ToothReceiptData
    {
        public int Tooth { get; set; } = 0;
        public int Price { get; set; } = 0;
        public String Name { get; set; }
        public int Crown { get; set; }
        public int Extraction { get; set; }
        public int Implant { get; set; }
        public int Restoration { get; set; }
        public int Scaling { get; set; }
        public int RootCanalTreatment { get; set; }
    }

   
}
