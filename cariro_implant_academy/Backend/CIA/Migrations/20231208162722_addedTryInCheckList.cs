using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class addedTryInCheckList : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "BuccalContour",
                table: "FinalProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Canting",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CentricRelation",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Contacts",
                table: "FinalProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Evaluation",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ExplainWhy",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "FrontalSmilingAndLateralPhotos",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "LipSupport",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NonSatisfiedDescription",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "NonSatisfiedNewScan",
                table: "FinalProsthesisParentsTable",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NonSeatingOtherNotes",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "NonSeatingType",
                table: "FinalProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "OcclusalPlanAndMidline",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Occlusion",
                table: "FinalProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "OcclusionNotes",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Passive",
                table: "FinalProsthesisParentsTable",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Retention",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Satisfied",
                table: "FinalProsthesisParentsTable",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Seating",
                table: "FinalProsthesisParentsTable",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "SizeAndShapeOfTeeth",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "VerticalDimension",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "BuccalContour",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Canting",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "CentricRelation",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Contacts",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Evaluation",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "ExplainWhy",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "FrontalSmilingAndLateralPhotos",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "LipSupport",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "NonSatisfiedDescription",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "NonSatisfiedNewScan",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "NonSeatingOtherNotes",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "NonSeatingType",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "OcclusalPlanAndMidline",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Occlusion",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "OcclusionNotes",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Passive",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Retention",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Satisfied",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "Seating",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "SizeAndShapeOfTeeth",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "VerticalDimension",
                table: "FinalProsthesisParentsTable");
        }
    }
}
