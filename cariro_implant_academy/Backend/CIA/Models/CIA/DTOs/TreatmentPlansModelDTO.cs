using System.ComponentModel.DataAnnotations.Schema;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;

namespace CIA.Models.CIA.DTOs
{
    public class TreatmentPlansModelDTO
    {
        public int? Id { get; set; }
        public int? PatientId { get; set; }
        public int? OperatorId { get; set; }
        public UserDTO? Operator { get; set; }
        public DateTime? Date { get; set; }
        public DropDowns? Doctor { get; set; }
        public bool ClearanceUpper { get; set; } = false;
        public bool ClearanceLower { get; set; } = false;

    }

    public class TreatmentPlanDetailsDTO
    {
        public int? Id { get; set; }
        public String Name { get; set; }
        public int Tooth { get; set; }
        public int? PatientId { get; set; }
        public PatientDTO? Patient { get; set; }
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
        public int? PostSurgeryModelId { get; set; }
        public int? ImplantID { get; set; }
        public ImplantDTO? Implant { get; set; }
        public int? ImplantIDRequest { get; set; }
        public ImplantDTO? ImplantRequest { get; set; }
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;



    }
}
