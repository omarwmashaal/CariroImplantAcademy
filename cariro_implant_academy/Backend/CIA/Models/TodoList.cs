using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class TodoList
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }
        public String? Data { get; set; } = string.Empty;
        public bool? Done { get; set; } = false;
        public DateTime? CreateDate { get; set; }
        public DateTime? DueDate { get; set; }
    }
}
