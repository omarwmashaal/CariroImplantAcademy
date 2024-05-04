using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using CIA.Models.CIA.DTOs;

namespace CIA.Models.LAB.DTO
{
    public class LAB_RequestStepDTO
    {
       
        public int? Id { get; set; }
        public int? index { get; set; }
        public int? StepId { get; set; }
        public Lab_DefaultStep? Step { get; set; }
        public int? TechnicianId { get; set; }
        public UserDTO? Technician { get; set; }
        public DateTime? Date { get; set; }
        public EnumLabRequestStepStatus? Status { get; set; }       
        public int? Price { get; set; } = 0;
        public String? Notes { get; set; }
        public int? AskForStepUserId { get; set; }
        public UserDTO? AskForStepUser { get; set; }
    }
}
