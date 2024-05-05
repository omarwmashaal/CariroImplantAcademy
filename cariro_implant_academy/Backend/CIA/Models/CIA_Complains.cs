using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class CIA_Complains
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String? Comment { get; set; }
        [ForeignKey("Patient")]
        public int? PatientID { get; set; }
        public Patient? Patient { get; set; }
        [ForeignKey("LastDoctor.IdInt")]
        public int? LastDoctorId { get; set; }
        public ApplicationUser? LastDoctor { get; set; }
        [ForeignKey("LastSupervisor.IdInt")]
        public int? LastSupervisorId { get; set; }
        public ApplicationUser? LastSupervisor { get; set; }
        [ForeignKey("LastCandidate.IdInt")]
        public int? LastCandidateId { get; set; }
        public ApplicationUser? LastCandidate { get; set; }
        [ForeignKey("MentionedDoctor.IdInt")]
        public int? MentionedDoctorId { get; set; }
        public ApplicationUser? MentionedDoctor { get; set; }
        [ForeignKey("EntryBy.IdInt")]
        public int? EntryById { get; set; }
        public ApplicationUser? EntryBy { get; set; }
        public DateTime? EntryTime { get; set; }
        public EnumComplainStatus? Status { get; set; }
        public String? QueueNotes { get; set; }

        [ForeignKey("ResolvedBy.IdInt")]
        public int? ResolvedById { get; set; }
        public ApplicationUser? ResolvedBy { get; set; }

        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
    }
    public class Clinic_Complains : CIA_Complains { }
}
