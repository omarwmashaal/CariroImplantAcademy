using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class CandidateDetails
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("Candidate.IdInt")]
        public int? CandidateId { get; set; }
        public ApplicationUser? Candidate { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public String? Procedure { get; set; }
        public DateTime? Date { get; set; }
        public int? Tooth { get; set; }

        [ForeignKey("Implant")]
        public int? ImplantId { get; set; }
        public Implant? Implant { get; set; }
        public int? ImplantCount { get; set; }
        public List<String>? OtherProcedures { get; set; }
        public int? TotalImplantCount { get; set; }

        
    }
}
