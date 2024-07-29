using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels
{
    public class ComplicationsAfterSurgeryParentModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public int? Tooth { get; set; }
        public List<ComplicationsAfterSurgeryModel> Complications { get; set; } = new List<ComplicationsAfterSurgeryModel>();
    }
    public class ComplicationsAfterSurgeryModel
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String? Name { get; set; }
        
        [ForeignKey("ComplicationsAfterSurgeryParentModel")]
        public int? ParentId { get; set; }
        public ComplicationsAfterSurgeryParentModel? Parent { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }
        [ForeignKey("DefaultSurgicalComplications")]
        public int? DefaultSurgicalComplicationsId { get; set; }
        public DefaultSurgicalComplications? DefaultSurgicalComplication { get; set; }
        public String? Notes { get; set; }
        public DateTime? Date { get; set; }
        public int? Tooth { get; set; }
        [NotMapped]
        public bool Swelling { get; set; } = false;
        [NotMapped]
        public bool OpenWound { get; set; } = false;
        [NotMapped]
        public bool Numbness { get; set; } = false;
        [NotMapped]
        public bool OroantralCommunication { get; set; } = false;
        [NotMapped]
        public bool PusInImplantSite { get; set; } = false;
        [NotMapped]
        public bool PusInDonorSite { get; set; } = false;
        [NotMapped]
        public bool SinusElevationFailure { get; set; } = false;
        [NotMapped]
        public bool GBRFailure { get; set; } = false;
        [NotMapped]
        public bool ImplantFailed { get; set; } = false;
        
    }

    public class DefaultSurgicalComplications
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }
    }

}
