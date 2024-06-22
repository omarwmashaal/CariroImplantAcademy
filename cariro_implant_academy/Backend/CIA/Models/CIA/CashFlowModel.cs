using CIA.Models.LAB;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA
{
    public class CashFlowModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("Receipt")]
        public int? ReceiptID { get; set; }
        public Receipt? Receipt { get; set; }
        public DateTime? Date { get; set; }
        public string? Name { get; set; }
        [ForeignKey("DropDowns")]
        public int? CategoryId { get; set; }
        public DropDowns? Category { get; set; }

        [ForeignKey("SuppliersModel")]
        public int? SupplierId { get; set; }
        public SuppliersModel? Supplier { get; set; }
        [ForeignKey("CreatedBy.IdInt")]
        public int? CreatedById { get; set; }
        public ApplicationUser? CreatedBy { get; set; }
        public int? Price { get; set; }
        
        [ForeignKey("PaymentMethodsModel")]
        public int? PaymentMethodId { get; set; }
        public PaymentMethodsModel? PaymentMethod { get; set; }
        public string? Notes { get; set; }
       // public List<String>? Type { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? CandidateId { get; set; }
        public ApplicationUser? Candidate { get; set; }
        [ForeignKey("PaymentLog")]
        public int? PaymentLogId { get; set; }
        public PaymentLog? PaymentLog { get; set; }
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
        public EnumWebsite InventoryWebsite { get; set; } = EnumWebsite.CIA;
    }
    public class ExpensesModel : CashFlowModel { }
    public class IncomeModel : CashFlowModel {

        [ForeignKey("Lab_Request")]
        public int? LabRequestId { get; set; }
        public Lab_Request? LabRequest { get; set; }
    }

}
