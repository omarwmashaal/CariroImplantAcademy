using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class PaymentLog
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [ForeignKey("Patient")]
        public int PatientId { get; set; }
        public Patient Patient { get; set; }
        [ForeignKey("Operator.IdInt")]
        public int OperatorId { get; set; }
        public ApplicationUser Operator { get; set; }
        public DateTime Date { get; set; }
        [ForeignKey("Receipt")]
        public int ReceiptId { get; set; }
        public Receipt Receipt { get; set; }
        public int PaidAmount { get; set; } = 0;
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
    }
}
