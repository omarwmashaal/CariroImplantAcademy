using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.TreatmentModels
{
    public class ProstheticParentStepModel
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
        public bool? NeedsRemake { get; set; }
        public bool? Scanned { get; set; }
        public DateTime? Date { get; set; }
        public int? Index { get; set; }
    }

    public class DiagnosticStepModel : ProstheticParentStepModel
    {


        [ForeignKey("DiagnosticItemModel")]
        public int? DiagnosticItemId { get; set; }
        public DiagnosticItemModel? DiagnosticItem { get; set; }

        [ForeignKey("DiagnosticStatusItemModel")]
        public int? DiagnosticStatusItemId { get; set; }
        public DiagnosticStatusItemModel? DiagnosticStatusItem { get; set; }
        [ForeignKey("DiagnosticNextVisitItemModel")]
        public int? DiagnosticNextVisitItemId { get; set; }
        public DiagnosticNextVisitItemModel? DiagnosticNextVisitItem { get; set; }
    }

    public class DiagnosticItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }
    }

    public class DiagnosticStatusItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }

        [ForeignKey("DiagnosticItemModel")]
        public int DiagnosticItemId { get; set; }
        public DiagnosticItemModel? DiagnosticItem { get; set; }
    }
    public class DiagnosticNextVisitItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }

        [ForeignKey("DiagnosticItemModel")]
        public int DiagnosticItemId { get; set; }
        public DiagnosticItemModel? DiagnosticItem { get; set; }
    }

    public class FinalStepModel : ProstheticParentStepModel
    {

        public int? Tooth { get; set; }
        public bool Single { get; set; } = false;
        public bool Bridge { get; set; } = false;
        public bool FullArchUpper { get; set; } = false;
        public bool FullArchLower { get; set; } = false;

        [ForeignKey("FinalItemModel")]
        public int? FinalItemId { get; set; }
        public FinalItemModel? FinalItem { get; set; }

        [ForeignKey("FinalStatusItemModel")]
        public int? FinalStatusItemId { get; set; }
        public FinalStatusItemModel? FinalStatusItem { get; set; }
        [ForeignKey("FinalNextVisitItemModel")]
        public int? FinalNextVisitItemId { get; set; }
        public FinalNextVisitItemModel? FinalNextVisitItem { get; set; }
    }

    public class FinalItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }
    }

    public class FinalStatusItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }

        [ForeignKey("FinalItemModel")]
        public int FinaltemId { get; set; }
        public FinalItemModel? FinalItem { get; set; }
    }
    public class FinalNextVisitItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }

        [ForeignKey("FinalItemModel")]
        public int FinalItemId { get; set; }
        public FinalItemModel? FinalItem { get; set; }
    }




}


