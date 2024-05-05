using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class AddedTreatmentDetailsAndPostSurgeries : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PostSurgeryModelId",
                table: "RequestChanges",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "PostSurgeries",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    TreatmentDetailsModelId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    GuidedBoneRegeneration = table.Column<bool>(type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraft = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftChin = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Chin", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftRamus = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Ramus", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftTuberosity = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Tuberosity", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftOther = table.Column<string>(name: "GuidedBoneRegeneration_BlockGraft_Other", type: "text", nullable: true),
                    GuidedBoneRegenerationCutBy = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByDisc = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Disc", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByPiezo = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Piezo", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByScrews = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Screws", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByScrewsNumber = table.Column<int>(name: "GuidedBoneRegeneration_CutBy_ScrewsNumber", type: "integer", nullable: true),
                    GuidedBoneRegenerationBoneParticle = table.Column<bool>(name: "GuidedBoneRegeneration_BoneParticle", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBoneParticle100Autogenous = table.Column<int>(name: "GuidedBoneRegeneration_BoneParticle_100Autogenous", type: "integer", nullable: true),
                    GuidedBoneRegenerationBoneParticle100Xenograft = table.Column<int>(name: "GuidedBoneRegeneration_BoneParticle_100Xenograft", type: "integer", nullable: true),
                    GuidedBoneRegenerationACMBur = table.Column<bool>(name: "GuidedBoneRegeneration_ACMBur", type: "boolean", nullable: true),
                    GuidedBoneRegenerationACMBurArea = table.Column<string>(name: "GuidedBoneRegeneration_ACMBur_Area", type: "text", nullable: true),
                    GuidedBoneRegenerationACMBurNotes = table.Column<string>(name: "GuidedBoneRegeneration_ACMBur_Notes", type: "text", nullable: true),
                    OpenSinusLift = table.Column<bool>(type: "boolean", nullable: true),
                    OpenSinusLiftApproach = table.Column<bool>(name: "OpenSinusLift_Approach", type: "boolean", nullable: true),
                    OpenSinusLiftApproachString = table.Column<string>(name: "OpenSinusLift_Approach_String", type: "text", nullable: true),
                    OpenSinusLiftFillMaterial = table.Column<bool>(name: "OpenSinusLift_FillMaterial", type: "boolean", nullable: true),
                    OpenSinusLiftFillMaterialString = table.Column<string>(name: "OpenSinusLift_FillMaterial_String", type: "text", nullable: true),
                    OpenSinusLiftMembraneID = table.Column<int>(name: "OpenSinusLift_MembraneID", type: "integer", nullable: true),
                    OpenSinusLiftMembraneCompanyID = table.Column<int>(name: "OpenSinusLift_Membrane_CompanyID", type: "integer", nullable: true),
                    OpenSinusLiftTacsNumber = table.Column<int>(type: "integer", nullable: true),
                    OpenSinusLiftTacsCompanyID = table.Column<int>(name: "OpenSinusLift_TacsCompanyID", type: "integer", nullable: true),
                    SoftTissueGraft = table.Column<bool>(type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryType = table.Column<bool>(name: "SoftTissueGraft_SurgeryType", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeSoftTissueGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_SoftTissueGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeAdvanced = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_Advanced", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeFreeGinivalGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_FreeGinivalGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeConnectiveTissueGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_ConnectiveTissueGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeSurgeryTechnique = table.Column<string>(name: "SoftTissueGraft_SurgeryType_SurgeryTechnique", type: "text", nullable: true),
                    SoftTissueGraftExposure = table.Column<bool>(name: "SoftTissueGraft_Exposure", type: "boolean", nullable: true),
                    SoftTissueGraftExposureCustomizedHealingCollarTeethNumber = table.Column<string>(name: "SoftTissueGraft_Exposure_CustomizedHealingCollarTeethNumber", type: "text", nullable: true),
                    SoftTissueGraftDonorSite = table.Column<bool>(name: "SoftTissueGraft_DonorSite", type: "boolean", nullable: true),
                    SoftTissueGraftDonorSiteNotes = table.Column<string>(name: "SoftTissueGraft_DonorSite_Notes", type: "text", nullable: true),
                    SoftTissueGraftSuture = table.Column<bool>(name: "SoftTissueGraft_Suture", type: "boolean", nullable: true),
                    SoftTissueGraftSutureMaterial = table.Column<string>(name: "SoftTissueGraft_Suture_Material", type: "text", nullable: true),
                    SoftTissueGraftSutureTechnique = table.Column<string>(name: "SoftTissueGraft_Suture_Technique", type: "text", nullable: true),
                    SoftTissueGraftSuturePackType = table.Column<string>(name: "SoftTissueGraft_Suture_PackType", type: "text", nullable: true),
                    SoftTissueGraftRecipientSite = table.Column<bool>(name: "SoftTissueGraft_RecipientSite", type: "boolean", nullable: true),
                    SoftTissueGraftRecipientSiteArea = table.Column<string>(name: "SoftTissueGraft_RecipientSite_Area", type: "text", nullable: true),
                    SoftTissueGraftAugmentation = table.Column<bool>(name: "SoftTissueGraft_Augmentation", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationBuccal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Buccal", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationCrestal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Crestal", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationLingual = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Lingual", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationMesial = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Mesial", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationDistal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Distal", type: "boolean", nullable: true),
                    SoftTissueGraftFrenectomy = table.Column<bool>(name: "SoftTissueGraft_Frenectomy", type: "boolean", nullable: true),
                    SoftTissueGraftFrenectomyNotes = table.Column<string>(name: "SoftTissueGraft_Frenectomy_Notes", type: "text", nullable: true),
                    SoftTissueGraftBoneGraft = table.Column<bool>(name: "SoftTissueGraft_BoneGraft", type: "boolean", nullable: true),
                    SoftTissueGraftBoneGraftNotes = table.Column<string>(name: "SoftTissueGraft_BoneGraft_Notes", type: "text", nullable: true),
                    SutureAndTemporizationAndXRay = table.Column<bool>(type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize30 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_3_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize40 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_4_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize50 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_5_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize60 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_6_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize70 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_7_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_ImplantSubcrestal", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterial = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialVicryl = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_Vicryl", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialProline = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_Proline", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialXRay = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_XRay", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialSutureTechnique = table.Column<string>(name: "SutureAndTemporizationAndXRay_Material_SutureTechnique", type: "text", nullable: true),
                    SutureAndTemporizationAndXRayTemporary = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryHealingCollar = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_HealingCollar", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryCustomizedHeallingColl = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_CustomizedHeallingColl~", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryCrown = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_Crown", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryMarylandBridge = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_MarylandBridge", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryBridgeOnTeeth = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_BridgeOnTeeth", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_DentureWithGlassFiber", type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PostSurgeries", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PostSurgeries_CashFlow_OpenSinusLift_MembraneID",
                        column: x => x.OpenSinusLiftMembraneID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_PostSurgeries_CashFlow_OpenSinusLift_TacsCompanyID",
                        column: x => x.OpenSinusLiftTacsCompanyID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_PostSurgeries_MembraneCompanies_OpenSinusLift_Membrane_Comp~",
                        column: x => x.OpenSinusLiftMembraneCompanyID,
                        principalTable: "MembraneCompanies",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "TreatmentDetails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PostSurgeryModelId = table.Column<int>(type: "integer", nullable: true),
                    Tooth = table.Column<int>(type: "integer", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false),
                    RequestChangeId = table.Column<int>(type: "integer", nullable: true),
                    Value = table.Column<string>(type: "text", nullable: false),
                    Status = table.Column<bool>(type: "boolean", nullable: false),
                    AssignedToID = table.Column<int>(type: "integer", nullable: true),
                    PlanPrice = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    DoneByAssistantID = table.Column<int>(type: "integer", nullable: true),
                    DoneBySupervisorID = table.Column<int>(type: "integer", nullable: true),
                    DoneByCandidateID = table.Column<int>(type: "integer", nullable: true),
                    DoneByCandidateBatchID = table.Column<int>(type: "integer", nullable: true),
                    ImplantID = table.Column<int>(type: "integer", nullable: true),
                    ImplantIDRequest = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TreatmentDetails", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_AspNetUsers_AssignedToID",
                        column: x => x.AssignedToID,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_AspNetUsers_DoneByAssistantID",
                        column: x => x.DoneByAssistantID,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_AspNetUsers_DoneByCandidateID",
                        column: x => x.DoneByCandidateID,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_AspNetUsers_DoneBySupervisorID",
                        column: x => x.DoneBySupervisorID,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_CashFlow_ImplantID",
                        column: x => x.ImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_CashFlow_ImplantIDRequest",
                        column: x => x.ImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_DropDowns_DoneByCandidateBatchID",
                        column: x => x.DoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentDetails_RequestChanges_RequestChangeId",
                        column: x => x.RequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_RequestChanges_PostSurgeryModelId",
                table: "RequestChanges",
                column: "PostSurgeryModelId");

            migrationBuilder.CreateIndex(
                name: "IX_PostSurgeries_OpenSinusLift_Membrane_CompanyID",
                table: "PostSurgeries",
                column: "OpenSinusLift_Membrane_CompanyID");

            migrationBuilder.CreateIndex(
                name: "IX_PostSurgeries_OpenSinusLift_MembraneID",
                table: "PostSurgeries",
                column: "OpenSinusLift_MembraneID");

            migrationBuilder.CreateIndex(
                name: "IX_PostSurgeries_OpenSinusLift_TacsCompanyID",
                table: "PostSurgeries",
                column: "OpenSinusLift_TacsCompanyID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_AssignedToID",
                table: "TreatmentDetails",
                column: "AssignedToID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_DoneByAssistantID",
                table: "TreatmentDetails",
                column: "DoneByAssistantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_DoneByCandidateBatchID",
                table: "TreatmentDetails",
                column: "DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_DoneByCandidateID",
                table: "TreatmentDetails",
                column: "DoneByCandidateID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_DoneBySupervisorID",
                table: "TreatmentDetails",
                column: "DoneBySupervisorID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_ImplantID",
                table: "TreatmentDetails",
                column: "ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_ImplantIDRequest",
                table: "TreatmentDetails",
                column: "ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_PatientId",
                table: "TreatmentDetails",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_RequestChangeId",
                table: "TreatmentDetails",
                column: "RequestChangeId");

            migrationBuilder.AddForeignKey(
                name: "FK_RequestChanges_PostSurgeries_PostSurgeryModelId",
                table: "RequestChanges",
                column: "PostSurgeryModelId",
                principalTable: "PostSurgeries",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_RequestChanges_PostSurgeries_PostSurgeryModelId",
                table: "RequestChanges");

            migrationBuilder.DropTable(
                name: "PostSurgeries");

            migrationBuilder.DropTable(
                name: "TreatmentDetails");

            migrationBuilder.DropIndex(
                name: "IX_RequestChanges_PostSurgeryModelId",
                table: "RequestChanges");

            migrationBuilder.DropColumn(
                name: "PostSurgeryModelId",
                table: "RequestChanges");
        }
    }
}
