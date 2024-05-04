using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class removedTreatmentPricesModel : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TreatmentPrices");

            migrationBuilder.AddColumn<int>(
                name: "Website",
                table: "TreatmentItems",
                type: "integer",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Website",
                table: "TreatmentItems");

            migrationBuilder.CreateTable(
                name: "TreatmentPrices",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Crown = table.Column<int>(type: "integer", nullable: false),
                    Extraction = table.Column<int>(type: "integer", nullable: false),
                    Implant = table.Column<int>(type: "integer", nullable: false),
                    Other = table.Column<int>(type: "integer", nullable: false),
                    Restoration = table.Column<int>(type: "integer", nullable: false),
                    RootCanalTreatment = table.Column<int>(type: "integer", nullable: false),
                    Scaling = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TreatmentPrices", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "TreatmentPrices",
                columns: new[] { "Id", "Crown", "Extraction", "Implant", "Other", "Restoration", "RootCanalTreatment", "Scaling" },
                values: new object[] { 1, 0, 0, 0, 0, 0, 0, 0 });
        }
    }
}
