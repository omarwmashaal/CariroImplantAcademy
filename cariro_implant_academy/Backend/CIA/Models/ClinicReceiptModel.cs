using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.LAB;
using CIA.Models.LAB.DTO;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class ClinicReceiptModel : Receipt
    {
        
    }
    public class ReceiptDTO
    {
        public int? Id { get; set; }
        public DateTime Date { get; set; }
        public int? OperatorId { get; set; }
        public int? CanidateId { get; set; }
        public UserDTO? Candidate { get; set; }
        public UserDTO? Operator { get; set; }
        public int Total { get; set; } = 0;
        public int Paid { get; set; } = 0;
        public int Unpaid { get; set; } = 0;
        public int? RequestId { get; set; } 
       // public LAB_RequestsDTO? Request { get; set; }
        public int? PatientId { get; set; }
        public PatientDTO? Patient { get; set; }
        public List<ToothReceiptData> ToothReceiptData { get; set; } = new List<ToothReceiptData>();
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
        public List<DropDowns> ClinicPrices { get; set; } = new List<DropDowns>();
        public List<ClinicTreatmentParent> Prices { get; set; } = new List<ClinicTreatmentParent>();
        public bool IsPaid { get; set; } = false;

    }


}
