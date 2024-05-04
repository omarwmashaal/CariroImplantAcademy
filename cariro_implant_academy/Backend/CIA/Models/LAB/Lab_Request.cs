using CIA.Models.CIA;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.LAB
{
    public class Lab_Request
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public DateTime? Date { get; set; }
        public DateOnly? DeliveryDate { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? EntryById { get; set; }
        public ApplicationUser? EntryBy { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? AssignedToId { get; set; }
        public ApplicationUser? AssignedTo { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? DesignerId { get; set; }
        public ApplicationUser? Designer { get; set; }
        public EnumLabRequestSources? Source { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? CustomerId { get; set; }
        public ApplicationUser? Customer { get; set; }
        [ForeignKey("Patient")]
        public int PatientId { get; set; }
        public Patient? Patient { get; set; }
        public EnumLabRequestStatus? Status { get; set; }
        public EnumLabRequestStatus2? Status2 { get; set; }
        public bool? Free { get; set; }
        public bool? Paid { get; set; }
        public int? Cost { get; set; }
        public int? LabFees { get; set; } = 0;
        public int? PaidAmount { get; set; }
        public String? Notes { get; set; }
        public String? NotesFromTech { get; set; }
        public String? RequiredStep { get; set; }
        [ForeignKey("Lab_RequestStep")]
        public List<Lab_RequestStep>? Steps { get; set; }

        [ForeignKey("Lab_File")]
        public int? FileId { get; set; }
        public Lab_File? File { get; set; }
        public List<int>? Teeth { get; set; }
        public EnumLabRequestInitStatus? InitStatus { get; set; }
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
        public List<LabRequestItem>? Others { get; set; }







    }

    [Owned]
    public class LabRequestItem
    {
        public String? Name { get; set; }
        public String Description { get; set; }
        public int? Price { get; set; }
        public int? TotalPrice { get; set; }
        public int Number { get; set; } = 0;
        [ForeignKey("LabItem")]
        public int? LabItemId { get; set; }
        public LabItem? LabItem { get; set; }
    }

}
