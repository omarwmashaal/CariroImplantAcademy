using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.LAB
{
    public class Lab_RequestStep
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public int? index { get; set; }

        [ForeignKey("Lab_DefaultStep")]
        public int? StepId { get; set; }
        public Lab_DefaultStep? Step { get; set; }

        [ForeignKey("Technician.IdInt")]
        public int? TechnicianId { get; set; }
        public ApplicationUser? Technician { get; set; } 
        public DateTime? Date { get; set; }
        public EnumLabRequestStepStatus? Status { get; set; }

        [ForeignKey("Lab_Request")]
        public int? RequestId { get; set; }
        public Lab_Request? Request { get; set; }
        public int? Price { get; set; } = 0;
        public String? Notes { get; set; }

        [ForeignKey("AskForStepUser.IdInt")]
        public int? AskForStepUserId { get; set; }
        public ApplicationUser? AskForStepUser { get; set; }


    }
}
