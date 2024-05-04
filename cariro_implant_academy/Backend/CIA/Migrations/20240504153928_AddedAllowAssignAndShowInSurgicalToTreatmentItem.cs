using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class AddedAllowAssignAndShowInSurgicalToTreatmentItem : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "AllowAssign",
                table: "TreatmentItems",
                type: "boolean",
                nullable: false,
                defaultValue: true);

            migrationBuilder.AddColumn<bool>(
                name: "ShowInSurgical",
                table: "TreatmentItems",
                type: "boolean",
                nullable: false,
                defaultValue: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AllowAssign",
                table: "TreatmentItems");

            migrationBuilder.DropColumn(
                name: "ShowInSurgical",
                table: "TreatmentItems");
        }
    }
}
