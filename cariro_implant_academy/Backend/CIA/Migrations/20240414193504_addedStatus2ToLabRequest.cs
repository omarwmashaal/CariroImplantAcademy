using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class addedStatus2ToLabRequest : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "Free",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Status2",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Free",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Status2",
                table: "Lab_Requests");
        }
    }
}
