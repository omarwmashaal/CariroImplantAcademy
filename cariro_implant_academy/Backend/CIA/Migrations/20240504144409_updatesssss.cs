using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class updatesssss : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_NonSurgicalTreatment_AspNetUsers_OperatorId",
                table: "NonSurgicalTreatment");

            migrationBuilder.DropForeignKey(
                name: "FK_NonSurgicalTreatment_AspNetUsers_SupervisorId",
                table: "NonSurgicalTreatment");

            migrationBuilder.DropForeignKey(
                name: "FK_NonSurgicalTreatment_Patients_PatientId",
                table: "NonSurgicalTreatment");

            migrationBuilder.DropForeignKey(
                name: "FK_RequestChanges_SurgicalTreatments_SurgicalTreatmentModelId",
                table: "RequestChanges");

            migrationBuilder.DropForeignKey(
                name: "FK_TreatmentItems_Receipts_ReceiptId",
                table: "TreatmentItems");

            migrationBuilder.DropTable(
                name: "SurgicalTreatments");

            migrationBuilder.DropIndex(
                name: "IX_TreatmentItems_ReceiptId",
                table: "TreatmentItems");

            migrationBuilder.DropIndex(
                name: "IX_RequestChanges_SurgicalTreatmentModelId",
                table: "RequestChanges");

            migrationBuilder.DropPrimaryKey(
                name: "PK_NonSurgicalTreatment",
                table: "NonSurgicalTreatment");

            migrationBuilder.DropColumn(
                name: "ReceiptId",
                table: "TreatmentItems");

            migrationBuilder.DropColumn(
                name: "Crown",
                table: "ToothReceiptData");

            migrationBuilder.DropColumn(
                name: "Extraction",
                table: "ToothReceiptData");

            migrationBuilder.DropColumn(
                name: "Implant",
                table: "ToothReceiptData");

            migrationBuilder.DropColumn(
                name: "Restoration",
                table: "ToothReceiptData");

            migrationBuilder.DropColumn(
                name: "RootCanalTreatment",
                table: "ToothReceiptData");

            migrationBuilder.DropColumn(
                name: "Scaling",
                table: "ToothReceiptData");

            migrationBuilder.DropColumn(
                name: "SurgicalTreatmentModelId",
                table: "RequestChanges");

            migrationBuilder.RenameTable(
                name: "NonSurgicalTreatment",
                newName: "NonSurgicalTreatmentModel");

            migrationBuilder.RenameIndex(
                name: "IX_NonSurgicalTreatment_SupervisorId",
                table: "NonSurgicalTreatmentModel",
                newName: "IX_NonSurgicalTreatmentModel_SupervisorId");

            migrationBuilder.RenameIndex(
                name: "IX_NonSurgicalTreatment_PatientId",
                table: "NonSurgicalTreatmentModel",
                newName: "IX_NonSurgicalTreatmentModel_PatientId");

            migrationBuilder.RenameIndex(
                name: "IX_NonSurgicalTreatment_OperatorId",
                table: "NonSurgicalTreatmentModel",
                newName: "IX_NonSurgicalTreatmentModel_OperatorId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_NonSurgicalTreatmentModel",
                table: "NonSurgicalTreatmentModel",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_NonSurgicalTreatmentModel_AspNetUsers_OperatorId",
                table: "NonSurgicalTreatmentModel",
                column: "OperatorId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_NonSurgicalTreatmentModel_AspNetUsers_SupervisorId",
                table: "NonSurgicalTreatmentModel",
                column: "SupervisorId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_NonSurgicalTreatmentModel_Patients_PatientId",
                table: "NonSurgicalTreatmentModel",
                column: "PatientId",
                principalTable: "Patients",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_NonSurgicalTreatmentModel_AspNetUsers_OperatorId",
                table: "NonSurgicalTreatmentModel");

            migrationBuilder.DropForeignKey(
                name: "FK_NonSurgicalTreatmentModel_AspNetUsers_SupervisorId",
                table: "NonSurgicalTreatmentModel");

            migrationBuilder.DropForeignKey(
                name: "FK_NonSurgicalTreatmentModel_Patients_PatientId",
                table: "NonSurgicalTreatmentModel");

            migrationBuilder.DropPrimaryKey(
                name: "PK_NonSurgicalTreatmentModel",
                table: "NonSurgicalTreatmentModel");

            migrationBuilder.RenameTable(
                name: "NonSurgicalTreatmentModel",
                newName: "NonSurgicalTreatment");

            migrationBuilder.RenameIndex(
                name: "IX_NonSurgicalTreatmentModel_SupervisorId",
                table: "NonSurgicalTreatment",
                newName: "IX_NonSurgicalTreatment_SupervisorId");

            migrationBuilder.RenameIndex(
                name: "IX_NonSurgicalTreatmentModel_PatientId",
                table: "NonSurgicalTreatment",
                newName: "IX_NonSurgicalTreatment_PatientId");

            migrationBuilder.RenameIndex(
                name: "IX_NonSurgicalTreatmentModel_OperatorId",
                table: "NonSurgicalTreatment",
                newName: "IX_NonSurgicalTreatment_OperatorId");

            migrationBuilder.AddColumn<int>(
                name: "ReceiptId",
                table: "TreatmentItems",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Crown",
                table: "ToothReceiptData",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Extraction",
                table: "ToothReceiptData",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Implant",
                table: "ToothReceiptData",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Restoration",
                table: "ToothReceiptData",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "RootCanalTreatment",
                table: "ToothReceiptData",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Scaling",
                table: "ToothReceiptData",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "SurgicalTreatmentModelId",
                table: "RequestChanges",
                type: "integer",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_NonSurgicalTreatment",
                table: "NonSurgicalTreatment",
                column: "Id");

            migrationBuilder.CreateTable(
                name: "SurgicalTreatments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    OpenSinusLiftMembraneCompanyID = table.Column<int>(name: "OpenSinusLift_Membrane_CompanyID", type: "integer", nullable: true),
                    OpenSinusLiftMembraneID = table.Column<int>(name: "OpenSinusLift_MembraneID", type: "integer", nullable: true),
                    OpenSinusLiftTacsCompanyID = table.Column<int>(name: "OpenSinusLift_TacsCompanyID", type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    GuidedBoneRegeneration = table.Column<bool>(type: "boolean", nullable: true),
                    GuidedBoneRegenerationACMBur = table.Column<bool>(name: "GuidedBoneRegeneration_ACMBur", type: "boolean", nullable: true),
                    GuidedBoneRegenerationACMBurArea = table.Column<string>(name: "GuidedBoneRegeneration_ACMBur_Area", type: "text", nullable: true),
                    GuidedBoneRegenerationACMBurNotes = table.Column<string>(name: "GuidedBoneRegeneration_ACMBur_Notes", type: "text", nullable: true),
                    GuidedBoneRegenerationBlockGraft = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftChin = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Chin", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftOther = table.Column<string>(name: "GuidedBoneRegeneration_BlockGraft_Other", type: "text", nullable: true),
                    GuidedBoneRegenerationBlockGraftRamus = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Ramus", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftTuberosity = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Tuberosity", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBoneParticle = table.Column<bool>(name: "GuidedBoneRegeneration_BoneParticle", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBoneParticle100Autogenous = table.Column<int>(name: "GuidedBoneRegeneration_BoneParticle_100Autogenous", type: "integer", nullable: true),
                    GuidedBoneRegenerationBoneParticle100Xenograft = table.Column<int>(name: "GuidedBoneRegeneration_BoneParticle_100Xenograft", type: "integer", nullable: true),
                    GuidedBoneRegenerationCutBy = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByDisc = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Disc", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByPiezo = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Piezo", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByScrews = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Screws", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByScrewsNumber = table.Column<int>(name: "GuidedBoneRegeneration_CutBy_ScrewsNumber", type: "integer", nullable: true),
                    OpenSinusLift = table.Column<bool>(type: "boolean", nullable: true),
                    OpenSinusLiftTacsNumber = table.Column<int>(type: "integer", nullable: true),
                    OpenSinusLiftApproach = table.Column<bool>(name: "OpenSinusLift_Approach", type: "boolean", nullable: true),
                    OpenSinusLiftApproachString = table.Column<string>(name: "OpenSinusLift_Approach_String", type: "text", nullable: true),
                    OpenSinusLiftFillMaterial = table.Column<bool>(name: "OpenSinusLift_FillMaterial", type: "boolean", nullable: true),
                    OpenSinusLiftFillMaterialString = table.Column<string>(name: "OpenSinusLift_FillMaterial_String", type: "text", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    SoftTissueGraft = table.Column<bool>(type: "boolean", nullable: true),
                    SoftTissueGraftAugmentation = table.Column<bool>(name: "SoftTissueGraft_Augmentation", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationBuccal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Buccal", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationCrestal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Crestal", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationDistal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Distal", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationLingual = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Lingual", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationMesial = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Mesial", type: "boolean", nullable: true),
                    SoftTissueGraftBoneGraft = table.Column<bool>(name: "SoftTissueGraft_BoneGraft", type: "boolean", nullable: true),
                    SoftTissueGraftBoneGraftNotes = table.Column<string>(name: "SoftTissueGraft_BoneGraft_Notes", type: "text", nullable: true),
                    SoftTissueGraftDonorSite = table.Column<bool>(name: "SoftTissueGraft_DonorSite", type: "boolean", nullable: true),
                    SoftTissueGraftDonorSiteNotes = table.Column<string>(name: "SoftTissueGraft_DonorSite_Notes", type: "text", nullable: true),
                    SoftTissueGraftExposure = table.Column<bool>(name: "SoftTissueGraft_Exposure", type: "boolean", nullable: true),
                    SoftTissueGraftExposureCustomizedHealingCollarTeethNumber = table.Column<string>(name: "SoftTissueGraft_Exposure_CustomizedHealingCollarTeethNumber", type: "text", nullable: true),
                    SoftTissueGraftFrenectomy = table.Column<bool>(name: "SoftTissueGraft_Frenectomy", type: "boolean", nullable: true),
                    SoftTissueGraftFrenectomyNotes = table.Column<string>(name: "SoftTissueGraft_Frenectomy_Notes", type: "text", nullable: true),
                    SoftTissueGraftRecipientSite = table.Column<bool>(name: "SoftTissueGraft_RecipientSite", type: "boolean", nullable: true),
                    SoftTissueGraftRecipientSiteArea = table.Column<string>(name: "SoftTissueGraft_RecipientSite_Area", type: "text", nullable: true),
                    SoftTissueGraftSurgeryType = table.Column<bool>(name: "SoftTissueGraft_SurgeryType", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeAdvanced = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_Advanced", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeConnectiveTissueGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_ConnectiveTissueGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeFreeGinivalGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_FreeGinivalGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeSoftTissueGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_SoftTissueGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeSurgeryTechnique = table.Column<string>(name: "SoftTissueGraft_SurgeryType_SurgeryTechnique", type: "text", nullable: true),
                    SoftTissueGraftSuture = table.Column<bool>(name: "SoftTissueGraft_Suture", type: "boolean", nullable: true),
                    SoftTissueGraftSutureMaterial = table.Column<string>(name: "SoftTissueGraft_Suture_Material", type: "text", nullable: true),
                    SoftTissueGraftSuturePackType = table.Column<string>(name: "SoftTissueGraft_Suture_PackType", type: "text", nullable: true),
                    SoftTissueGraftSutureTechnique = table.Column<string>(name: "SoftTissueGraft_Suture_Technique", type: "text", nullable: true),
                    SutureAndTemporizationAndXRay = table.Column<bool>(type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterial = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialProline = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_Proline", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialSutureTechnique = table.Column<string>(name: "SutureAndTemporizationAndXRay_Material_SutureTechnique", type: "text", nullable: true),
                    SutureAndTemporizationAndXRayMaterialVicryl = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_Vicryl", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialXRay = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_XRay", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize30 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_3_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize40 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_4_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize50 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_5_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize60 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_6_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize70 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_7_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_ImplantSubcrestal", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporary = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryBridgeOnTeeth = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_BridgeOnTeeth", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryCrown = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_Crown", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryCustomizedHeallingColl = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_CustomizedHeallingColl~", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_DentureWithGlassFiber", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryHealingCollar = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_HealingCollar", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryMarylandBridge = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_MarylandBridge", type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SurgicalTreatments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SurgicalTreatments_CashFlow_OpenSinusLift_MembraneID",
                        column: x => x.OpenSinusLiftMembraneID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_SurgicalTreatments_CashFlow_OpenSinusLift_TacsCompanyID",
                        column: x => x.OpenSinusLiftTacsCompanyID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_SurgicalTreatments_MembraneCompanies_OpenSinusLift_Membrane~",
                        column: x => x.OpenSinusLiftMembraneCompanyID,
                        principalTable: "MembraneCompanies",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_SurgicalTreatments_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentItems_ReceiptId",
                table: "TreatmentItems",
                column: "ReceiptId");

            migrationBuilder.CreateIndex(
                name: "IX_RequestChanges_SurgicalTreatmentModelId",
                table: "RequestChanges",
                column: "SurgicalTreatmentModelId");

            migrationBuilder.CreateIndex(
                name: "IX_SurgicalTreatments_OpenSinusLift_Membrane_CompanyID",
                table: "SurgicalTreatments",
                column: "OpenSinusLift_Membrane_CompanyID");

            migrationBuilder.CreateIndex(
                name: "IX_SurgicalTreatments_OpenSinusLift_MembraneID",
                table: "SurgicalTreatments",
                column: "OpenSinusLift_MembraneID");

            migrationBuilder.CreateIndex(
                name: "IX_SurgicalTreatments_OpenSinusLift_TacsCompanyID",
                table: "SurgicalTreatments",
                column: "OpenSinusLift_TacsCompanyID");

            migrationBuilder.CreateIndex(
                name: "IX_SurgicalTreatments_PatientId",
                table: "SurgicalTreatments",
                column: "PatientId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_NonSurgicalTreatment_AspNetUsers_OperatorId",
                table: "NonSurgicalTreatment",
                column: "OperatorId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_NonSurgicalTreatment_AspNetUsers_SupervisorId",
                table: "NonSurgicalTreatment",
                column: "SupervisorId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_NonSurgicalTreatment_Patients_PatientId",
                table: "NonSurgicalTreatment",
                column: "PatientId",
                principalTable: "Patients",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_RequestChanges_SurgicalTreatments_SurgicalTreatmentModelId",
                table: "RequestChanges",
                column: "SurgicalTreatmentModelId",
                principalTable: "SurgicalTreatments",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_TreatmentItems_Receipts_ReceiptId",
                table: "TreatmentItems",
                column: "ReceiptId",
                principalTable: "Receipts",
                principalColumn: "Id");
        }
    }
}
