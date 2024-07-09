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
        [ForeignKey("DiagnosticMaterialItemModel")]
        public int? DiagnosticMaterialItemId { get; set; }
        public DiagnosticMaterialItemModel? DiagnosticMaterialItem { get; set; }
        [ForeignKey("DiagnosticTechniqueItemModel")]
        public int? DiagnosticTechniqueItemId { get; set; }
        public DiagnosticTechniqueItemModel? DiagnosticTechniqueItem { get; set; }
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
    public class DiagnosticMaterialItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }

        [ForeignKey("DiagnosticItemModel")]
        public int DiagnosticItemId { get; set; }
        public DiagnosticItemModel? DiagnosticItem { get; set; }
    }
    public class DiagnosticTechniqueItemModel
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

        public bool? ScrewRetained { get; set; }
        public bool? CementRetained { get; set; }
        public int? Tooth { get; set; }
        public List<int>? Teeth { get; set; } = new();
        public bool Single { get; set; } = false;
        public bool Bridge { get; set; } = false;
        public bool FullArchUpper { get; set; } = false;
        public bool FullArchLower { get; set; } = false;

        [ForeignKey("TryInCheckListModel")]
        public int? TryInCheckListId { get; set; }

        [ForeignKey("FinalItemModel")]
        public int? FinalItemId { get; set; }
        public FinalItemModel? FinalItem { get; set; }

        [ForeignKey("FinalStatusItemModel")]
        public int? FinalStatusItemId { get; set; }
        public FinalStatusItemModel? FinalStatusItem { get; set; }
        [ForeignKey("FinalNextVisitItemModel")]
        public int? FinalNextVisitItemId { get; set; }
        public FinalNextVisitItemModel? FinalNextVisitItem { get; set; }
        [ForeignKey("FinalMaterialItemModel")]
        public int? FinalMaterialItemId { get; set; }
        public FinalMaterialItemModel? FinalMaterialItem { get; set; }
        [ForeignKey("FinalTechniqueItemModel")]
        public int? FinalTechniqueItemId { get; set; }
        public FinalTechniqueItemModel? FinalTechniqueItem { get; set; }
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
    public class FinalMaterialItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }

        [ForeignKey("FinalItemModel")]
        public int FinalItemId { get; set; }
        public FinalItemModel? FinalItem { get; set; }
    }
    public class FinalTechniqueItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }

        [ForeignKey("FinalItemModel")]
        public int FinalItemId { get; set; }
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


    public class TryInCheckListModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public List<int>? Teeth { get; set; } = new();
        [ForeignKey("FinalStepModel")]
        public int? StepId { get; set; }
        public FinalStatusItemModel? Step { get; set; }
        public bool? Satisfied { get; set; }
        public bool? NonSatisfiedNewScan { get; set; }
        public String? NonSatisfiedDescription { get; set; }
        public bool? Seating { get; set; }
        public EnumTryInSeating? NonSeatingType { get; set; }
        public String? NonSeatingOtherNotes { get; set; }
        public EnumTryInContacts? MesialContacts { get; set; }
        public EnumTryInContacts? DistalContacts { get; set; }
        public EnumOcclusion? Occlusion { get; set; }
        public EnumBuccalContour? BuccalContour { get; set; }
        public bool? Passive { get; set; }
        public String? Retention { get; set; }
        public String? OcclusionNotes { get; set; }
        public String? OcclusalPlanAndMidline { get; set; }
        public String? CentricRelation { get; set; }
        public String? VerticalDimension { get; set; }
        public String? LipSupport { get; set; }
        public String? SizeAndShapeOfTeeth { get; set; }
        public String? Canting { get; set; }
        public String? FrontalSmilingAndLateralPhotos { get; set; }
        public String? Evaluation { get; set; }
        public String? ExplainWhy { get; set; }

    }




}


