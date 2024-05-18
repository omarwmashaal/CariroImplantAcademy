using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class modificationsInPors : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "CementRetained",
                table: "FinalSteps",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "ScrewRetained",
                table: "FinalSteps",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<List<int>>(
                name: "Teeth",
                table: "FinalSteps",
                type: "integer[]",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TryInCheckListId",
                table: "FinalSteps",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "TryInCheckLists",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Teeth = table.Column<List<int>>(type: "integer[]", nullable: true),
                    StepId = table.Column<int>(type: "integer", nullable: true),
                    Satisfied = table.Column<bool>(type: "boolean", nullable: true),
                    NonSatisfiedNewScan = table.Column<bool>(type: "boolean", nullable: true),
                    NonSatisfiedDescription = table.Column<string>(type: "text", nullable: true),
                    Seating = table.Column<bool>(type: "boolean", nullable: true),
                    NonSeatingType = table.Column<int>(type: "integer", nullable: true),
                    NonSeatingOtherNotes = table.Column<string>(type: "text", nullable: true),
                    MesialContacts = table.Column<int>(type: "integer", nullable: true),
                    DistalContacts = table.Column<int>(type: "integer", nullable: true),
                    Occlusion = table.Column<int>(type: "integer", nullable: true),
                    BuccalContour = table.Column<int>(type: "integer", nullable: true),
                    Passive = table.Column<bool>(type: "boolean", nullable: true),
                    Retention = table.Column<string>(type: "text", nullable: true),
                    OcclusionNotes = table.Column<string>(type: "text", nullable: true),
                    OcclusalPlanAndMidline = table.Column<string>(type: "text", nullable: true),
                    CentricRelation = table.Column<string>(type: "text", nullable: true),
                    VerticalDimension = table.Column<string>(type: "text", nullable: true),
                    LipSupport = table.Column<string>(type: "text", nullable: true),
                    SizeAndShapeOfTeeth = table.Column<string>(type: "text", nullable: true),
                    Canting = table.Column<string>(type: "text", nullable: true),
                    FrontalSmilingAndLateralPhotos = table.Column<string>(type: "text", nullable: true),
                    Evaluation = table.Column<string>(type: "text", nullable: true),
                    ExplainWhy = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TryInCheckLists", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TryInCheckLists_FinalStatusItems_StepId",
                        column: x => x.StepId,
                        principalTable: "FinalStatusItems",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TryInCheckLists_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_TryInCheckLists_PatientId",
                table: "TryInCheckLists",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_TryInCheckLists_StepId",
                table: "TryInCheckLists",
                column: "StepId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TryInCheckLists");

            migrationBuilder.DropColumn(
                name: "CementRetained",
                table: "FinalSteps");

            migrationBuilder.DropColumn(
                name: "ScrewRetained",
                table: "FinalSteps");

            migrationBuilder.DropColumn(
                name: "Teeth",
                table: "FinalSteps");

            migrationBuilder.DropColumn(
                name: "TryInCheckListId",
                table: "FinalSteps");
        }
    }
}
