using CIA.Models.CIA;
using CIA.Models.CIA.TreatmentModels;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.TreatmentModels
{



    public class TreatmentPlanModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]

        public int? Id { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }

        [ForeignKey("Operator.IdInt")]
        public int? OperatorId { get; set; }
        public ApplicationUser? Operator { get; set; }
        public DateTime? Date { get; set; }
        public bool ClearanceUpper { get; set; } = false;
        public bool ClearanceLower { get; set; } = false;

        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
        public class TreatmentPlanSubModel
        {
            [Key]
            [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
            public int? Id { get; set; }

            [ForeignKey("Patient")]
            public int? PatientId { get; set; }
            public Patient? Patient { get; set; }
            public int Tooth { get; set; }

            public TreatmentPlanFieldsModel? Scaling { get; set; }
            public TreatmentPlanFieldsModel? Crown { get; set; }
            public TreatmentPlanFieldsModel? RootCanalTreatment { get; set; }
            public TreatmentPlanFieldsModel? Restoration { get; set; }
            public TreatmentPlanFieldsModel? Pontic { get; set; }
            public TreatmentPlanFieldsModel? Extraction { get; set; }
            public TreatmentPlanFieldsModel? SimpleImplant { get; set; }
            public TreatmentPlanFieldsModel? ImmediateImplant { get; set; }
            public TreatmentPlanFieldsModel? ExpansionWithImplant { get; set; }
            public TreatmentPlanFieldsModel? SplittingWithImplant { get; set; }
            public TreatmentPlanFieldsModel? GBRWithImplant { get; set; }
            public TreatmentPlanFieldsModel? OpenSinusWithImplant { get; set; }
            public TreatmentPlanFieldsModel? ClosedSinusWithImplant { get; set; }
            public TreatmentPlanFieldsModel? GuidedImplant { get; set; }
            public TreatmentPlanFieldsModel? ExpansionWithoutImplant { get; set; }
            public TreatmentPlanFieldsModel? SplittingWithoutImplant { get; set; }
            public TreatmentPlanFieldsModel? GBRWithoutImplant { get; set; }
            public TreatmentPlanFieldsModel? OpenSinusWithoutImplant { get; set; }
            public TreatmentPlanFieldsModel? ClosedSinusWithoutImplant { get; set; }

            public EnumWebsite Website { get; set; } = EnumWebsite.CIA;



        }

        [Owned]
        public class TreatmentPlanFieldsModel
        {
            [ForeignKey("RequestChangeModel")]
            public int? RequestChangeId { get; set; }
            public RequestChangeModel? RequestChangeModel { get; set; }
            public String Value { get; set; } = "";
            public bool Status { get; set; }
            [ForeignKey("AssignedTo.IdInt")]
            public int? AssignedToID { get; set; }
            public int? PlanPrice { get; set; } = 0;

            public ApplicationUser? AssignedTo { get; set; }
            public DateTime? Date { get; set; }

            [ForeignKey("DoneByAssistant.IdInt")]
            public int? DoneByAssistantID { get; set; }
            public ApplicationUser? DoneByAssistant { get; set; }
            [ForeignKey("DoneBySupervisor.IdInt")]
            public int? DoneBySupervisorID { get; set; }
            public ApplicationUser? DoneBySupervisor { get; set; }
            [ForeignKey("DoneByCandidate.IdInt")]
            public int? DoneByCandidateID { get; set; }
            public ApplicationUser? DoneByCandidate { get; set; }
            [ForeignKey("CandidatesBatch")]
            public int? DoneByCandidateBatchID { get; set; }
            public DropDowns? DoneByCandidateBatch { get; set; }
            [ForeignKey("Implant")]
            public int? ImplantID { get; set; }
            public Implant? Implant { get; set; }
            [ForeignKey("ImplantRequest")]
            public int? ImplantIDRequest { get; set; }
            public Implant? ImplantRequest { get; set; }

            public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
        }


    


}


    public class TreatmentDetailsModel
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }

        [ForeignKey("PostSurgeryModelId")]
        public int? PostSurgeryModelId { get; set; }
        [ForeignKey("TreatmentItemModel")]
        public int? TreatmentItemId { get; set; }
        public TreatmentItemModel? TreatmentItem { get; set; }
        public int Tooth { get; set; }
        public String Name { get; set; } = "";

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public Patient? Patient { get; set; }
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;

        [ForeignKey("RequestChangeModel")]
        public int? RequestChangeId { get; set; }
        public RequestChangeModel? RequestChangeModel { get; set; }
        public String Value { get; set; } = "";
        public bool Status { get; set; }

        [ForeignKey("AssignedTo.IdInt")]
        public int? AssignedToID { get; set; }
        public ApplicationUser? AssignedTo { get; set; }

        public int? PlanPrice { get; set; } = 0;

        public DateTime? Date { get; set; }

        [ForeignKey("DoneByAssistant.IdInt")]
        public int? DoneByAssistantID { get; set; }
        public ApplicationUser? DoneByAssistant { get; set; }
        [ForeignKey("DoneBySupervisor.IdInt")]
        public int? DoneBySupervisorID { get; set; }
        public ApplicationUser? DoneBySupervisor { get; set; }
        [ForeignKey("DoneByCandidate.IdInt")]
        public int? DoneByCandidateID { get; set; }
        public ApplicationUser? DoneByCandidate { get; set; }
        [ForeignKey("CandidatesBatch")]
        public int? DoneByCandidateBatchID { get; set; }
        public DropDowns? DoneByCandidateBatch { get; set; }
        [ForeignKey("Implant")]
        public int? ImplantID { get; set; }
        public Implant? Implant { get; set; }
        [ForeignKey("ImplantRequest")]
        public int? ImplantIDRequest { get; set; }
        public Implant? ImplantRequest { get; set; }

    }

    public class PostSurgeryModel
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("TreatmentDetailsModelId")]
        public int? TreatmentDetailsModelId { get; set; }

        [ForeignKey("Patient")]
        public int? PatientId { get; set; }
        public List<RequestChangeModel>? RequestChanges { get; set; }
        public bool? GuidedBoneRegeneration { get; set; }
        public bool? GuidedBoneRegeneration_BlockGraft { get; set; }
        public bool? GuidedBoneRegeneration_BlockGraft_Chin { get; set; }
        public bool? GuidedBoneRegeneration_BlockGraft_Ramus { get; set; }
        public bool? GuidedBoneRegeneration_BlockGraft_Tuberosity { get; set; }
        public string? GuidedBoneRegeneration_BlockGraft_Other { get; set; }
        public bool? GuidedBoneRegeneration_CutBy { get; set; }
        public bool? GuidedBoneRegeneration_CutBy_Disc { get; set; }
        public bool? GuidedBoneRegeneration_CutBy_Piezo { get; set; }
        public bool? GuidedBoneRegeneration_CutBy_Screws { get; set; }
        public int? GuidedBoneRegeneration_CutBy_ScrewsNumber { get; set; }
        public bool? GuidedBoneRegeneration_BoneParticle { get; set; }
        public int? GuidedBoneRegeneration_BoneParticle_100Autogenous { get; set; }
        public int? GuidedBoneRegeneration_BoneParticle_100Xenograft { get; set; }
        //public string? GuidedBoneRegeneration_BoneParticle_XenograftPercent { get; set; }
        public bool? GuidedBoneRegeneration_ACMBur { get; set; }
        public string? GuidedBoneRegeneration_ACMBur_Area { get; set; }
        public string? GuidedBoneRegeneration_ACMBur_Notes { get; set; }
        public bool? OpenSinusLift { get; set; }
        public bool? OpenSinusLift_Approach { get; set; }
        public string? OpenSinusLift_Approach_String { get; set; }
        public bool? OpenSinusLift_FillMaterial { get; set; }
        public string? OpenSinusLift_FillMaterial_String { get; set; }


        [ForeignKey("Membrane")]
        public int? OpenSinusLift_MembraneID { get; set; }
        public Membrane? OpenSinusLift_Membrane { get; set; }
        [ForeignKey("MembraneCompany")]
        public int? OpenSinusLift_Membrane_CompanyID { get; set; }
        public MembraneCompany? OpenSinusLift_Membrane_Company { get; set; }
        public int? OpenSinusLiftTacsNumber { get; set; }


        [ForeignKey("TacCompany")]
        public int? OpenSinusLift_TacsCompanyID { get; set; }
        public TacCompany? OpenSinusLift_TacsCompany { get; set; }
        public bool? SoftTissueGraft { get; set; }
        public bool? SoftTissueGraft_SurgeryType { get; set; }
        public bool? SoftTissueGraft_SurgeryType_SoftTissueGraft { get; set; }
        public bool? SoftTissueGraft_SurgeryType_Advanced { get; set; }
        public bool? SoftTissueGraft_SurgeryType_FreeGinivalGraft { get; set; }
        public bool? SoftTissueGraft_SurgeryType_ConnectiveTissueGraft { get; set; }
        public string? SoftTissueGraft_SurgeryType_SurgeryTechnique { get; set; }
        public bool? SoftTissueGraft_Exposure { get; set; }
        public string? SoftTissueGraft_Exposure_CustomizedHealingCollarTeethNumber { get; set; }
        public bool? SoftTissueGraft_DonorSite { get; set; }
        public string? SoftTissueGraft_DonorSite_Notes { get; set; }
        public bool? SoftTissueGraft_Suture { get; set; }
        public string? SoftTissueGraft_Suture_Material { get; set; }
        public string? SoftTissueGraft_Suture_Technique { get; set; }
        public string? SoftTissueGraft_Suture_PackType { get; set; }
        public bool? SoftTissueGraft_RecipientSite { get; set; }
        public string? SoftTissueGraft_RecipientSite_Area { get; set; }
        public bool? SoftTissueGraft_Augmentation { get; set; }
        public bool? SoftTissueGraft_Augmentation_Buccal { get; set; }
        public bool? SoftTissueGraft_Augmentation_Crestal { get; set; }
        public bool? SoftTissueGraft_Augmentation_Lingual { get; set; }
        public bool? SoftTissueGraft_Augmentation_Mesial { get; set; }
        public bool? SoftTissueGraft_Augmentation_Distal { get; set; }
        public bool? SoftTissueGraft_Frenectomy { get; set; }
        public string? SoftTissueGraft_Frenectomy_Notes { get; set; }
        public bool? SoftTissueGraft_BoneGraft { get; set; }
        public string? SoftTissueGraft_BoneGraft_Notes { get; set; }
        public bool? SutureAndTemporizationAndXRay { get; set; }
        public bool? SutureAndTemporizationAndXRay_SutureSize { get; set; }
        public bool? SutureAndTemporizationAndXRay_SutureSize_3_0 { get; set; }
        public bool? SutureAndTemporizationAndXRay_SutureSize_4_0 { get; set; }
        public bool? SutureAndTemporizationAndXRay_SutureSize_5_0 { get; set; }
        public bool? SutureAndTemporizationAndXRay_SutureSize_6_0 { get; set; }
        public bool? SutureAndTemporizationAndXRay_SutureSize_7_0 { get; set; }
        public bool? SutureAndTemporizationAndXRay_SutureSize_ImplantSubcrestal { get; set; }
        public bool? SutureAndTemporizationAndXRay_Material { get; set; }
        public bool? SutureAndTemporizationAndXRay_Material_Vicryl { get; set; }
        public bool? SutureAndTemporizationAndXRay_Material_Proline { get; set; }
        public bool? SutureAndTemporizationAndXRay_Material_XRay { get; set; }
        public string? SutureAndTemporizationAndXRay_Material_SutureTechnique { get; set; }
        public bool? SutureAndTemporizationAndXRay_Temporary { get; set; }
        public bool? SutureAndTemporizationAndXRay_Temporary_HealingCollar { get; set; }
        public bool? SutureAndTemporizationAndXRay_Temporary_CustomizedHeallingCollar { get; set; }
        public bool? SutureAndTemporizationAndXRay_Temporary_Crown { get; set; }
        public bool? SutureAndTemporizationAndXRay_Temporary_MarylandBridge { get; set; }
        public bool? SutureAndTemporizationAndXRay_Temporary_BridgeOnTeeth { get; set; }
        public bool? SutureAndTemporizationAndXRay_Temporary_DentureWithGlassFiber { get; set; }

    }

    public class TreatmentItemModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; }
        public int Price { get; set; } = 0;
        public String? PriceAction { get; set; }
        public bool AllowAssign { get; set; } = true;
        public bool ShowInSurgical { get; set; } = true;
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;
        
    }

}
