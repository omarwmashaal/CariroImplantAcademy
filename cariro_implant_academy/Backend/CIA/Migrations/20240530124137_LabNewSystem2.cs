using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class LabNewSystem2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "LabOptionId",
                table: "LabRequestStepItems",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_LabRequestStepItems_LabOptionId",
                table: "LabRequestStepItems",
                column: "LabOptionId");

            migrationBuilder.AddForeignKey(
                name: "FK_LabRequestStepItems_LabOptions_LabOptionId",
                table: "LabRequestStepItems",
                column: "LabOptionId",
                principalTable: "LabOptions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_LabRequestStepItems_LabOptions_LabOptionId",
                table: "LabRequestStepItems");

            migrationBuilder.DropIndex(
                name: "IX_LabRequestStepItems_LabOptionId",
                table: "LabRequestStepItems");

            migrationBuilder.DropColumn(
                name: "LabOptionId",
                table: "LabRequestStepItems");
        }
    }
}
