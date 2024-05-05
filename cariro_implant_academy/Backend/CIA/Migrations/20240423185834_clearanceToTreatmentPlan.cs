using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class clearanceToTreatmentPlan : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {


            migrationBuilder.AddColumn<bool>(
                name: "ClearanceLower",
                table: "TreatmentPlans",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "ClearanceUpper",
                table: "TreatmentPlans",
                type: "boolean",
                nullable: false,
                defaultValue: false);

        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
   

            migrationBuilder.DropColumn(
                name: "ClearanceLower",
                table: "TreatmentPlans");

            migrationBuilder.DropColumn(
                name: "ClearanceUpper",
                table: "TreatmentPlans");

             }
    }
}
