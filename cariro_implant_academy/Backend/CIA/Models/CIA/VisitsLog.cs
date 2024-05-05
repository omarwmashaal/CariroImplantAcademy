using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA
{
    public class VisitsLog
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }

        [ForeignKey("Patient")]
        public int PatientID { get; set; }
        public Patient? Patient { get; set; }
        public VisitsStatus? Status { get; set; }
        public DateTime? ReservationTime { get; set; }
        public DateTime? RealVisitTime { get; set; }
        public DateTime? EntersClinicTime { get; set; }
        public DateTime? From { get; set; }
        public DateTime? To { get; set; }
        public TimeSpan? Duration { get; set; }
        public string? Title { get; set; }

        [ForeignKey("RoomModel")]
        public int? RoomId { get; set; }
        public RoomModel? Room { get; set; }
        public DateTime? LeaveTime { get; set; }
        [ForeignKey("Doctor.IdInt")]
        public int? DoctorID { get; set; }
        public ApplicationUser? Doctor { get; set; }
        //[NotMapped]
        public String? Treatment { get; set; }

        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;

    }
    
}
