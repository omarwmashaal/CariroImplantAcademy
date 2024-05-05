using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.DTOs
{
    public class TreatmentPlanFieldsDTO
    {
        public String Value { get; set; } = "";
        public bool Status { get; set; }
        public int? AssignedToID { get; set; }
        public int? PlanPrice { get; set; } = 0;
        public int? Price { get; set; } = 0;
        public UserDTO? AssignedTo { get; set; }
        public DateTime? Date { get; set; }        
        public int? DoneByAssistantID { get; set; }
        public UserDTO? DoneByAssistant { get; set; }        
        public int? DoneBySupervisorID { get; set; }
        public UserDTO? DoneBySupervisor { get; set; }        
        public int? DoneByCandidateID { get; set; }
        public UserDTO? DoneByCandidate { get; set; }
        public int? DoneByCandidateBatchID { get; set; }
        public DropDowns? DoneByCandidateBatch { get; set; }
    }
}
