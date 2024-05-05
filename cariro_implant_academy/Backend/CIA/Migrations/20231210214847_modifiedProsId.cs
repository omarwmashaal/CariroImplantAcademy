using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class modifiedProsId : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ProstheticTreatmentId",
                table: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropColumn(
                name: "ProstheticTreatmentId",
                table: "ProstheticTreatments_DiagnosticImpression");

            migrationBuilder.DropColumn(
                name: "ProstheticTreatmentId",
                table: "ProstheticTreatments_Bite");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ProstheticTreatmentId",
                table: "ProstheticTreatments_ScanAppliance",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ProstheticTreatmentId",
                table: "ProstheticTreatments_DiagnosticImpression",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ProstheticTreatmentId",
                table: "ProstheticTreatments_Bite",
                type: "integer",
                nullable: true);
        }
    }
}
