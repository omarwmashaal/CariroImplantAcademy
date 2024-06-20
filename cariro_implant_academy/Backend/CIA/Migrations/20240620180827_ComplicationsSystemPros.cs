using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class ComplicationsSystemPros : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("Delete from \"ComplicationsAfterProsthesis\" where \"Name\" Is Null");
            migrationBuilder.AddColumn<int>(
                name: "DefaultProstheticComplicationsId",
                table: "ComplicationsAfterProsthesis",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "DefaultProstheticComplications",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DefaultProstheticComplications", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "DefaultProstheticComplications",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Screw Loosness" },
                    { 2, "Crown Fall" },
                    { 3, "Fractured Zirconia" },
                    { 4, "Fractured Printed PMMA" },
                    { 5, "Food Impaction" },
                    { 6, "Pain" },
                    { 7, "Implant Fracture" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterProsthesis_DefaultProstheticComplications~",
                table: "ComplicationsAfterProsthesis",
                column: "DefaultProstheticComplicationsId");

            migrationBuilder.AddForeignKey(
                name: "FK_ComplicationsAfterProsthesis_DefaultProstheticComplications~",
                table: "ComplicationsAfterProsthesis",
                column: "DefaultProstheticComplicationsId",
                principalTable: "DefaultProstheticComplications",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ComplicationsAfterProsthesis_DefaultProstheticComplications~",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropTable(
                name: "DefaultProstheticComplications");

            migrationBuilder.DropIndex(
                name: "IX_ComplicationsAfterProsthesis_DefaultProstheticComplications~",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "DefaultProstheticComplicationsId",
                table: "ComplicationsAfterProsthesis");
        }
    }
}
