using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class intraarchSpaceNowForEachTooth : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "InterarchspaceLT",
                table: "DentalExaminations");

            migrationBuilder.DropColumn(
                name: "InterarchspaceRT",
                table: "DentalExaminations");

            migrationBuilder.AddColumn<int>(
                name: "InterarchspaceLT",
                table: "DentalExamination",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "InterarchspaceRT",
                table: "DentalExamination",
                type: "integer",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "InterarchspaceLT",
                table: "DentalExamination");

            migrationBuilder.DropColumn(
                name: "InterarchspaceRT",
                table: "DentalExamination");

            migrationBuilder.AddColumn<int>(
                name: "InterarchspaceLT",
                table: "DentalExaminations",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "InterarchspaceRT",
                table: "DentalExaminations",
                type: "integer",
                nullable: true);
        }
    }
}
