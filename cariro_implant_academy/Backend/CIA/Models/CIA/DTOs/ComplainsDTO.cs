namespace CIA.Models.CIA.DTOs
{
    public class ComplainsDTO
    {
        public int? Id { get; set; }
        public String? Comment { get; set; }
        public int? PatientID { get; set; }
        public DropDowns? Patient { get; set; }
        public int? LastDoctorId { get; set; }
        public UserDTO? LastDoctor { get; set; }
        public int? LastSupervisorId { get; set; }
        public UserDTO? LastSupervisor { get; set; }
      //  public int? LastCandidateId { get; set; }
       // public UserDTO? LastCandidate { get; set; }
        public int? MentionedDoctorId { get; set; }
        public UserDTO? MentionedDoctor { get; set; }
        public int? EntryById { get; set; }
      //  public UserDTO? EntryBy { get; set; }
        public DateTime? EntryTime { get; set; }
        public EnumComplainStatus? Status { get; set; }
        public String? QueueNotes { get; set; }
        public int? ResolvedById { get; set; }
      //  public UserDTO? ResolvedBy { get; set; }
    }
}
