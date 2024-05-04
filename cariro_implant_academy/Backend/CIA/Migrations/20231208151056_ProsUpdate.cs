using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class ProsUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_Bite_ProstheticTreatments_ProstheticTr~",
                table: "ProstheticTreatments_Bite");

            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression");

            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_ProstheticTreatments_Pro~",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_ProstheticTreatmentId",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression");

            migrationBuilder.DropIndex(
                name: "IX_ProstheticTreatments_Bite_ProstheticTreatmentId",
                table: "ProstheticTreatments_Bite");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchDelivery",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchDeliveryDate",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchDeliveryNextVisit",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchDeliveryStatus",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchHealingCollar",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchHealingCollarDate",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchHealingCollarNextVisit",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchHealingCollarStatus",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchImpression",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchImpressionDate",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchImpressionNextVisit",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchImpressionStatus",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchTryIn",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchTryInDate",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchTryInNextVisit",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisFullArchTryInStatus",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeDelivery",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeDeliveryDate",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeDeliveryNextVisit",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeDeliveryStatus",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeHealingCollar",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeHealingCollarDate",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeHealingCollarNextVisit",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeHealingCollarStatus",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeImpression",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeImpressionDate",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeImpressionNextVisit",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeImpressionStatus",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeTeeth",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeTryIn",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeTryInDate",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeTryInNextVisit",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "FinalProthesisSingleBridgeTryInStatus",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "Website",
                table: "ProstheticTreatments");

            migrationBuilder.AddColumn<int>(
                name: "ProstheticTreatmentDiagnosticModelId",
                table: "ProstheticTreatments_ScanAppliance",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ProstheticTreatmentDiagnosticModelId",
                table: "ProstheticTreatments_DiagnosticImpression",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ProstheticTreatmentDiagnosticModelId",
                table: "ProstheticTreatments_Bite",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "ProstheticTreatmentFinalFullArchs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProstheticTreatmentFinalFullArchs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProstheticTreatmentFinalFullArchs_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProstheticTreatmentFinalSingleBridges",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProstheticTreatmentFinalSingleBridges", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProstheticTreatmentFinalSingleBridges_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "FinalProsthesisParentsTable",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    SearchTeethClassification = table.Column<int>(type: "integer", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false),
                    FinalProthesisTeeth = table.Column<List<int>>(type: "integer[]", nullable: true),
                    Discriminator = table.Column<string>(type: "text", nullable: false),
                    FinalProthesisDelivery = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisDeliveryStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisDeliveryNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisDeliveryDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProsthesisDeliveryProstheticTreatmentFinalFullArchId = table.Column<int>(name: "FinalProsthesisDelivery_ProstheticTreatmentFinalFullArchId", type: "integer", nullable: true),
                    FinalProsthesisDeliveryProstheticTreatmentFinalSingleBridgeId = table.Column<int>(name: "FinalProsthesisDelivery_ProstheticTreatmentFinalSingleBridgeId", type: "integer", nullable: true),
                    FinalProthesisHealingCollar = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisHealingCollarStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisHealingCollarNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisHealingCollarDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProsthesisHealingCollarProstheticTreatmentFinalFullArchId = table.Column<int>(name: "FinalProsthesisHealingCollar_ProstheticTreatmentFinalFullArchId", type: "integer", nullable: true),
                    FinalProsthesisHealingCollarProstheticTreatmentFinalSingleBri = table.Column<int>(name: "FinalProsthesisHealingCollar_ProstheticTreatmentFinalSingleBri~", type: "integer", nullable: true),
                    FinalProthesisImpression = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisImpressionStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisImpressionNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisImpressionDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    ProstheticTreatmentFinalFullArchId = table.Column<int>(type: "integer", nullable: true),
                    ProstheticTreatmentFinalSingleBridgeId = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisTryIn = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisTryInStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisTryInNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisTryInDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProsthesisTryInProstheticTreatmentFinalFullArchId = table.Column<int>(name: "FinalProsthesisTryIn_ProstheticTreatmentFinalFullArchId", type: "integer", nullable: true),
                    FinalProsthesisTryInProstheticTreatmentFinalSingleBridgeId = table.Column<int>(name: "FinalProsthesisTryIn_ProstheticTreatmentFinalSingleBridgeId", type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinalProsthesisParentsTable", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_ProstheticTreatmentFinalFullArc~",
                        column: x => x.ProstheticTreatmentFinalFullArchId,
                        principalTable: "ProstheticTreatmentFinalFullArchs",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_ProstheticTreatmentFinalFullAr~1",
                        column: x => x.FinalProsthesisHealingCollarProstheticTreatmentFinalFullArchId,
                        principalTable: "ProstheticTreatmentFinalFullArchs",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_ProstheticTreatmentFinalFullAr~2",
                        column: x => x.FinalProsthesisDeliveryProstheticTreatmentFinalFullArchId,
                        principalTable: "ProstheticTreatmentFinalFullArchs",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_ProstheticTreatmentFinalFullAr~3",
                        column: x => x.FinalProsthesisTryInProstheticTreatmentFinalFullArchId,
                        principalTable: "ProstheticTreatmentFinalFullArchs",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_ProstheticTreatmentFinalSingleB~",
                        column: x => x.ProstheticTreatmentFinalSingleBridgeId,
                        principalTable: "ProstheticTreatmentFinalSingleBridges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_ProstheticTreatmentFinalSingle~1",
                        column: x => x.FinalProsthesisHealingCollarProstheticTreatmentFinalSingleBri,
                        principalTable: "ProstheticTreatmentFinalSingleBridges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_ProstheticTreatmentFinalSingle~2",
                        column: x => x.FinalProsthesisDeliveryProstheticTreatmentFinalSingleBridgeId,
                        principalTable: "ProstheticTreatmentFinalSingleBridges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalProsthesisParentsTable_ProstheticTreatmentFinalSingle~3",
                        column: x => x.FinalProsthesisTryInProstheticTreatmentFinalSingleBridgeId,
                        principalTable: "ProstheticTreatmentFinalSingleBridges",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_ProstheticTreatmentDiagn~",
                table: "ProstheticTreatments_ScanAppliance",
                column: "ProstheticTreatmentDiagnosticModelId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "ProstheticTreatmentDiagnosticModelId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_Bite_ProstheticTreatmentDiagnosticMode~",
                table: "ProstheticTreatments_Bite",
                column: "ProstheticTreatmentDiagnosticModelId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_FinalProsthesisDelivery_Prosth~1",
                table: "FinalProsthesisParentsTable",
                column: "FinalProsthesisDelivery_ProstheticTreatmentFinalSingleBridgeId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_FinalProsthesisDelivery_Prosthe~",
                table: "FinalProsthesisParentsTable",
                column: "FinalProsthesisDelivery_ProstheticTreatmentFinalFullArchId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_FinalProsthesisHealingCollar_P~1",
                table: "FinalProsthesisParentsTable",
                column: "FinalProsthesisHealingCollar_ProstheticTreatmentFinalSingleBri~");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_FinalProsthesisHealingCollar_Pr~",
                table: "FinalProsthesisParentsTable",
                column: "FinalProsthesisHealingCollar_ProstheticTreatmentFinalFullArchId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_FinalProsthesisTryIn_Prostheti~1",
                table: "FinalProsthesisParentsTable",
                column: "FinalProsthesisTryIn_ProstheticTreatmentFinalSingleBridgeId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_FinalProsthesisTryIn_Prosthetic~",
                table: "FinalProsthesisParentsTable",
                column: "FinalProsthesisTryIn_ProstheticTreatmentFinalFullArchId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_PatientId",
                table: "FinalProsthesisParentsTable",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_ProstheticTreatmentFinalFullArc~",
                table: "FinalProsthesisParentsTable",
                column: "ProstheticTreatmentFinalFullArchId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_ProstheticTreatmentFinalSingleB~",
                table: "FinalProsthesisParentsTable",
                column: "ProstheticTreatmentFinalSingleBridgeId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatmentFinalFullArchs_PatientId",
                table: "ProstheticTreatmentFinalFullArchs",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatmentFinalSingleBridges_PatientId",
                table: "ProstheticTreatmentFinalSingleBridges",
                column: "PatientId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_Bite_ProstheticTreatments_ProstheticTr~",
                table: "ProstheticTreatments_Bite",
                column: "ProstheticTreatmentDiagnosticModelId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "ProstheticTreatmentDiagnosticModelId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_ProstheticTreatments_Pro~",
                table: "ProstheticTreatments_ScanAppliance",
                column: "ProstheticTreatmentDiagnosticModelId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_Bite_ProstheticTreatments_ProstheticTr~",
                table: "ProstheticTreatments_Bite");

            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression");

            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_ProstheticTreatments_Pro~",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropTable(
                name: "FinalProsthesisParentsTable");

            migrationBuilder.DropTable(
                name: "ProstheticTreatmentFinalFullArchs");

            migrationBuilder.DropTable(
                name: "ProstheticTreatmentFinalSingleBridges");

            migrationBuilder.DropIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_ProstheticTreatmentDiagn~",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression");

            migrationBuilder.DropIndex(
                name: "IX_ProstheticTreatments_Bite_ProstheticTreatmentDiagnosticMode~",
                table: "ProstheticTreatments_Bite");

            migrationBuilder.DropColumn(
                name: "ProstheticTreatmentDiagnosticModelId",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropColumn(
                name: "ProstheticTreatmentDiagnosticModelId",
                table: "ProstheticTreatments_DiagnosticImpression");

            migrationBuilder.DropColumn(
                name: "ProstheticTreatmentDiagnosticModelId",
                table: "ProstheticTreatments_Bite");

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisFullArchDelivery",
                table: "ProstheticTreatments",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisFullArchDeliveryDate",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisFullArchDeliveryNextVisit",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisFullArchDeliveryStatus",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisFullArchHealingCollar",
                table: "ProstheticTreatments",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisFullArchHealingCollarDate",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisFullArchHealingCollarNextVisit",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisFullArchHealingCollarStatus",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisFullArchImpression",
                table: "ProstheticTreatments",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisFullArchImpressionDate",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisFullArchImpressionNextVisit",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisFullArchImpressionStatus",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisFullArchTryIn",
                table: "ProstheticTreatments",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisFullArchTryInDate",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisFullArchTryInNextVisit",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisFullArchTryInStatus",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisSingleBridgeDelivery",
                table: "ProstheticTreatments",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisSingleBridgeDeliveryDate",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisSingleBridgeDeliveryNextVisit",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisSingleBridgeDeliveryStatus",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisSingleBridgeHealingCollar",
                table: "ProstheticTreatments",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisSingleBridgeHealingCollarDate",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisSingleBridgeHealingCollarNextVisit",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisSingleBridgeHealingCollarStatus",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisSingleBridgeImpression",
                table: "ProstheticTreatments",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisSingleBridgeImpressionDate",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisSingleBridgeImpressionNextVisit",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisSingleBridgeImpressionStatus",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<List<int>>(
                name: "FinalProthesisSingleBridgeTeeth",
                table: "ProstheticTreatments",
                type: "integer[]",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisSingleBridgeTryIn",
                table: "ProstheticTreatments",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisSingleBridgeTryInDate",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisSingleBridgeTryInNextVisit",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalProthesisSingleBridgeTryInStatus",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Website",
                table: "ProstheticTreatments",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_ProstheticTreatmentId",
                table: "ProstheticTreatments_ScanAppliance",
                column: "ProstheticTreatmentId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "ProstheticTreatmentId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_Bite_ProstheticTreatmentId",
                table: "ProstheticTreatments_Bite",
                column: "ProstheticTreatmentId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_Bite_ProstheticTreatments_ProstheticTr~",
                table: "ProstheticTreatments_Bite",
                column: "ProstheticTreatmentId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "ProstheticTreatmentId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_ProstheticTreatments_Pro~",
                table: "ProstheticTreatments_ScanAppliance",
                column: "ProstheticTreatmentId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");
        }
    }
}
