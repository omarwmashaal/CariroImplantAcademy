using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.DTOs
{
    public class VisitDTO
    {
        public int? Id { get; set; }       
        public int? PatientID { get; set; }
        public String? SecondaryId { get; set; }
        public String? PatientName { get; set; }
        public String? Status { get; set; }
        public DateTime? ReservationTime { get; set; }
        public DateTime? RealVisitTime { get; set; }
        public DateTime? EntersClinicTime { get; set; }
        public DateTime? From { get; set; }
        public DateTime? To { get; set; }
        public TimeSpan? Duration { get; set; }
        public string? Title { get; set; }
        public int? RoomId { get; set; }
        public RoomModel? Room { get; set; }
        public DateTime? LeaveTime { get; set; }
        public int? DoctorID { get; set; }
        public int? EntryById { get; set; }
        public String? DoctorName { get; set; }     
        public String? Treatment { get; set; }
        public VisitDTO? ChangeRequest { get; set; }
        public int? VisitsLogIdUpdateRequestId { get; set; }

    }
}
