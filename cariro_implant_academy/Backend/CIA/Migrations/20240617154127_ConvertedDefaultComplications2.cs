using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class ConvertedDefaultComplications2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "DefaultSurgicalComplications",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 10, "Infection" },
                    { 11, "Inflamation" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "DefaultSurgicalComplications",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "DefaultSurgicalComplications",
                keyColumn: "Id",
                keyValue: 11);
        }
    }
}
