using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    [Table("OutSourcePatients")]
    public class OutSourcePatient:Patient
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
    }

    [Table("ClinicPatients")]
    public class ClinicPatient:Patient
    {
       
    }
}
