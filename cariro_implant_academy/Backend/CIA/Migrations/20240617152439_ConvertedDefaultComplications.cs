using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class ConvertedDefaultComplications : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "DefaultSurgicalComplicationsId",
                table: "ComplicationsAfterSurgery",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "DefaultSurgicalComplications",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DefaultSurgicalComplications", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "DefaultSurgicalComplications",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Swelling" },
                    { 2, "Open Wound" },
                    { 3, "Numbness" },
                    { 4, "Oroantral Communication" },
                    { 5, "Pus In Implant Site" },
                    { 6, "Pus In Donor Site" },
                    { 7, "Sinus Elevation Failure" },
                    { 8, "GBR Failure" },
                    { 9, "Implant Failed" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterSurgery_DefaultSurgicalComplicationsId",
                table: "ComplicationsAfterSurgery",
                column: "DefaultSurgicalComplicationsId");

            migrationBuilder.AddForeignKey(
                name: "FK_ComplicationsAfterSurgery_DefaultSurgicalComplications_Defa~",
                table: "ComplicationsAfterSurgery",
                column: "DefaultSurgicalComplicationsId",
                principalTable: "DefaultSurgicalComplications",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ComplicationsAfterSurgery_DefaultSurgicalComplications_Defa~",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropTable(
                name: "DefaultSurgicalComplications");

            migrationBuilder.DropIndex(
                name: "IX_ComplicationsAfterSurgery_DefaultSurgicalComplicationsId",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "DefaultSurgicalComplicationsId",
                table: "ComplicationsAfterSurgery");
        }
    }
}
