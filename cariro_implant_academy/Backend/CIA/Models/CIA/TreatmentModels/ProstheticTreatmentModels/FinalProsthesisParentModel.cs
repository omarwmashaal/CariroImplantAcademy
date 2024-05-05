using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels
{
    [Table("FinalProsthesisParentsTable")]
    public class FinalProsthesisParentModel
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

        [NotMapped]
        public DropDowns? OperatorDTO { get; set; }
        public EnumTeethClassification? SearchTeethClassification { get; set; }
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
        public List<int>? FinalProthesisTeeth { get; set; } = new List<int>();
        public DateTime? Date { get; set; }



    }

    public class FinalProsthesisHealingCollar : FinalProsthesisParentModel
    {
        public FinalProsthesisHealingCollar CopyWithTeeth(List<int> teeth)
        {

            return new FinalProsthesisHealingCollar()
            {
                Date = this.Date,
                FinalProthesisTeeth = teeth,
                Id = this.Id,
                Operator = this.Operator,
                OperatorId = this.OperatorId,
                Patient = this.Patient,
                PatientId = this.PatientId,
                SearchTeethClassification = this.SearchTeethClassification,
                Website = this.Website,
                FinalProthesisHealingCollarNextVisit = this.FinalProthesisHealingCollarNextVisit,
                FinalProthesisHealingCollarStatus = this.FinalProthesisHealingCollarStatus,
            };
        }

        public EnumFinalProthesisHealingCollarStatus? FinalProthesisHealingCollarStatus { get; set; }
        public EnumFinalProthesisHealingCollarNextVisit? FinalProthesisHealingCollarNextVisit { get; set; }

    }
    public class FinalProsthesisImpression : FinalProsthesisParentModel
    {
        public FinalProsthesisImpression CopyWithTeeth(List<int> teeth)
        {

            return new FinalProsthesisImpression()
            {
                Date = this.Date,
                FinalProthesisTeeth = teeth,
                Id = this.Id,
                Operator = this.Operator,
                OperatorId = this.OperatorId,
                Patient = this.Patient,
                PatientId = this.PatientId,
                SearchTeethClassification = this.SearchTeethClassification,
                Website = this.Website,
                FinalProthesisImpressionStatus = this.FinalProthesisImpressionStatus,
                FinalProthesisImpressionNextVisit = this.FinalProthesisImpressionNextVisit,
            };
        }
        public EnumFinalProthesisImpressionStatus? FinalProthesisImpressionStatus { get; set; }
        public EnumFinalProthesisImpressionNextVisit? FinalProthesisImpressionNextVisit { get; set; }

    }
    public class FinalProsthesisTryIn : FinalProsthesisParentModel
    {
        public FinalProsthesisTryIn CopyWithTeeth(List<int> teeth)
        {

            return new FinalProsthesisTryIn()
            {
                Date = this.Date,
                FinalProthesisTeeth = teeth,
                Id = this.Id,
                Operator = this.Operator,
                OperatorId = this.OperatorId,
                Patient = this.Patient,
                PatientId = this.PatientId,
                SearchTeethClassification = this.SearchTeethClassification,
                Website = this.Website,
                FinalProthesisTryInStatus = this.FinalProthesisTryInStatus,
                FinalProthesisTryInNextVisit = this.FinalProthesisTryInNextVisit,
                BuccalContour = this.BuccalContour,
                Canting= this.Canting,
                CentricRelation=this.CentricRelation,
                DistalContacts= this.DistalContacts,
                Evaluation = this.Evaluation,
                ExplainWhy = this.ExplainWhy,
                FrontalSmilingAndLateralPhotos = this.FrontalSmilingAndLateralPhotos,
                LipSupport = this.LipSupport,
                MesialContacts = this.MesialContacts,
                NonSatisfiedDescription = this.NonSatisfiedDescription,
                NonSatisfiedNewScan = this.NonSatisfiedNewScan,
                NonSeatingOtherNotes = this.NonSeatingOtherNotes,
                NonSeatingType = this.NonSeatingType,
                OcclusalPlanAndMidline = this.OcclusalPlanAndMidline,
                Occlusion = this.Occlusion,
                OcclusionNotes = this.OcclusionNotes,
                Passive = this.Passive,
                Retention = this.Retention,
                Satisfied = this.Satisfied,
                Seating = this.Seating,
                SizeAndShapeOfTeeth=this.SizeAndShapeOfTeeth,   
                VerticalDimension = this.VerticalDimension,
            };
        }
        public EnumFinalProthesisTryInStatus? FinalProthesisTryInStatus { get; set; }
        public EnumFinalProthesisTryInNextVisit? FinalProthesisTryInNextVisit { get; set; }
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
    public class FinalProsthesisDelivery : FinalProsthesisParentModel
    {
        public FinalProsthesisDelivery CopyWithTeeth(List<int> teeth)
        {

            return new FinalProsthesisDelivery()
            {
                Date = this.Date,
                FinalProthesisTeeth = teeth,
                Id = this.Id,
                Operator = this.Operator,
                OperatorId = this.OperatorId,
                Patient = this.Patient,
                PatientId = this.PatientId,
                SearchTeethClassification = this.SearchTeethClassification,
                Website = this.Website,
                FinalProthesisDeliveryStatus = this.FinalProthesisDeliveryStatus,
                FinalProthesisDeliveryNextVisit = this.FinalProthesisDeliveryNextVisit,
            };
        }
        public EnumFinalProthesisDeliveryStatus? FinalProthesisDeliveryStatus { get; set; }
        public EnumFinalProthesisDeliveryNextVisit? FinalProthesisDeliveryNextVisit { get; set; }

    }

}
