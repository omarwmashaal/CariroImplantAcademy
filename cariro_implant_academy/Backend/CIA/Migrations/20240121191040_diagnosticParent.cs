using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class diagnosticParent : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_AspNetUsers_OperatorId1",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_Patients_PatientId",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_ProstheticTreatments_Pro~",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropTable(
                name: "ProstheticTreatments_Bite");

            migrationBuilder.DropTable(
                name: "ProstheticTreatments_DiagnosticImpression");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ProstheticTreatments_ScanAppliance",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.RenameTable(
                name: "ProstheticTreatments_ScanAppliance",
                newName: "DiagnosticProsthesisParentsTable");

            migrationBuilder.RenameIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_ProstheticTreatmentDiagn~",
                table: "DiagnosticProsthesisParentsTable",
                newName: "IX_DiagnosticProsthesisParentsTable_ProstheticTreatmentDiagnos~");

            migrationBuilder.RenameIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_PatientId",
                table: "DiagnosticProsthesisParentsTable",
                newName: "IX_DiagnosticProsthesisParentsTable_PatientId");

            migrationBuilder.RenameIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_OperatorId1",
                table: "DiagnosticProsthesisParentsTable",
                newName: "IX_DiagnosticProsthesisParentsTable_OperatorId1");

            migrationBuilder.AddColumn<int>(
                name: "BiteModel_Diagnostic",
                table: "DiagnosticProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "BiteModel_NextStep",
                table: "DiagnosticProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "BiteModel_ProstheticTreatmentDiagnosticModelId",
                table: "DiagnosticProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "DiagnosticProsthesisParentsTable",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "NextStep",
                table: "DiagnosticProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ScanApplianceModel_Diagnostic",
                table: "DiagnosticProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ScanApplianceModel_ProstheticTreatmentDiagnosticModelId",
                table: "DiagnosticProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_DiagnosticProsthesisParentsTable",
                table: "DiagnosticProsthesisParentsTable",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticProsthesisParentsTable_BiteModel_ProstheticTreatm~",
                table: "DiagnosticProsthesisParentsTable",
                column: "BiteModel_ProstheticTreatmentDiagnosticModelId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticProsthesisParentsTable_ScanApplianceModel_Prosthe~",
                table: "DiagnosticProsthesisParentsTable",
                column: "ScanApplianceModel_ProstheticTreatmentDiagnosticModelId");

            migrationBuilder.AddForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_AspNetUsers_OperatorId1",
                table: "DiagnosticProsthesisParentsTable",
                column: "OperatorId1",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_Patients_PatientId",
                table: "DiagnosticProsthesisParentsTable",
                column: "PatientId",
                principalTable: "Patients",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_ProstheticTreatments_BiteM~",
                table: "DiagnosticProsthesisParentsTable",
                column: "BiteModel_ProstheticTreatmentDiagnosticModelId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_ProstheticTreatments_Prost~",
                table: "DiagnosticProsthesisParentsTable",
                column: "ProstheticTreatmentDiagnosticModelId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_ProstheticTreatments_ScanA~",
                table: "DiagnosticProsthesisParentsTable",
                column: "ScanApplianceModel_ProstheticTreatmentDiagnosticModelId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_AspNetUsers_OperatorId1",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_Patients_PatientId",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_ProstheticTreatments_BiteM~",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_ProstheticTreatments_Prost~",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropForeignKey(
                name: "FK_DiagnosticProsthesisParentsTable_ProstheticTreatments_ScanA~",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropPrimaryKey(
                name: "PK_DiagnosticProsthesisParentsTable",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropIndex(
                name: "IX_DiagnosticProsthesisParentsTable_BiteModel_ProstheticTreatm~",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropIndex(
                name: "IX_DiagnosticProsthesisParentsTable_ScanApplianceModel_Prosthe~",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "BiteModel_Diagnostic",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "BiteModel_NextStep",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "BiteModel_ProstheticTreatmentDiagnosticModelId",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "NextStep",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "ScanApplianceModel_Diagnostic",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "ScanApplianceModel_ProstheticTreatmentDiagnosticModelId",
                table: "DiagnosticProsthesisParentsTable");

            migrationBuilder.RenameTable(
                name: "DiagnosticProsthesisParentsTable",
                newName: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.RenameIndex(
                name: "IX_DiagnosticProsthesisParentsTable_ProstheticTreatmentDiagnos~",
                table: "ProstheticTreatments_ScanAppliance",
                newName: "IX_ProstheticTreatments_ScanAppliance_ProstheticTreatmentDiagn~");

            migrationBuilder.RenameIndex(
                name: "IX_DiagnosticProsthesisParentsTable_PatientId",
                table: "ProstheticTreatments_ScanAppliance",
                newName: "IX_ProstheticTreatments_ScanAppliance_PatientId");

            migrationBuilder.RenameIndex(
                name: "IX_DiagnosticProsthesisParentsTable_OperatorId1",
                table: "ProstheticTreatments_ScanAppliance",
                newName: "IX_ProstheticTreatments_ScanAppliance_OperatorId1");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ProstheticTreatments_ScanAppliance",
                table: "ProstheticTreatments_ScanAppliance",
                column: "Id");

            migrationBuilder.CreateTable(
                name: "ProstheticTreatments_Bite",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Diagnostic = table.Column<int>(type: "integer", nullable: true),
                    NeedsRemake = table.Column<bool>(type: "boolean", nullable: true),
                    NextStep = table.Column<int>(type: "integer", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    ProstheticTreatmentDiagnosticModelId = table.Column<int>(type: "integer", nullable: true),
                    Scanned = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProstheticTreatments_Bite", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_Bite_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_Bite_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_Bite_ProstheticTreatments_ProstheticTr~",
                        column: x => x.ProstheticTreatmentDiagnosticModelId,
                        principalTable: "ProstheticTreatments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProstheticTreatments_DiagnosticImpression",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Diagnostic = table.Column<int>(type: "integer", nullable: true),
                    NeedsRemake = table.Column<bool>(type: "boolean", nullable: true),
                    NextStep = table.Column<int>(type: "integer", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    ProstheticTreatmentDiagnosticModelId = table.Column<int>(type: "integer", nullable: true),
                    Scanned = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProstheticTreatments_DiagnosticImpression", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_DiagnosticImpression_AspNetUsers_Opera~",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_DiagnosticImpression_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                        column: x => x.ProstheticTreatmentDiagnosticModelId,
                        principalTable: "ProstheticTreatments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_Bite_OperatorId1",
                table: "ProstheticTreatments_Bite",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_Bite_PatientId",
                table: "ProstheticTreatments_Bite",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_Bite_ProstheticTreatmentDiagnosticMode~",
                table: "ProstheticTreatments_Bite",
                column: "ProstheticTreatmentDiagnosticModelId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_OperatorId1",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_PatientId",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "ProstheticTreatmentDiagnosticModelId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_AspNetUsers_OperatorId1",
                table: "ProstheticTreatments_ScanAppliance",
                column: "OperatorId1",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_Patients_PatientId",
                table: "ProstheticTreatments_ScanAppliance",
                column: "PatientId",
                principalTable: "Patients",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ProstheticTreatments_ScanAppliance_ProstheticTreatments_Pro~",
                table: "ProstheticTreatments_ScanAppliance",
                column: "ProstheticTreatmentDiagnosticModelId",
                principalTable: "ProstheticTreatments",
                principalColumn: "Id");
        }
    }
}
