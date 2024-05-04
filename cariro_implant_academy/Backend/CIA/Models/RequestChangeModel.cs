using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class RequestChangeModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Description { get; set; } = "";
        public RequestChangeEnum RequestEnum { get; set; }
        [ForeignKey("User.IdInt")]
        public int? UserId { get; set; }
        public ApplicationUser? User { get; set; }
        
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public int? DataId { get; set; }
        public String? DataName { get; set; }


    }

    public enum RequestChangeEnum
    {
        ImplantChange,
        MembraneChange,
        TacsChange,
        ScrewChange,
    }
}
