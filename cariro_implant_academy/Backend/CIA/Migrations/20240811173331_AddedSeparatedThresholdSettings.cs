using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class AddedSeparatedThresholdSettings : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Threshold",
                table: "LabItemParents");

            migrationBuilder.AddColumn<int>(
                name: "Threshold",
                table: "CashFlow",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "LabSizesThresholds",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    ParentId = table.Column<int>(type: "integer", nullable: false),
                    Size = table.Column<string>(type: "text", nullable: false),
                    Threshold = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LabSizesThresholds", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "LabSizesThresholds");

            migrationBuilder.DropColumn(
                name: "Threshold",
                table: "CashFlow");

            migrationBuilder.AddColumn<int>(
                name: "Threshold",
                table: "LabItemParents",
                type: "integer",
                nullable: false,
                defaultValue: 0);
        }
    }
}
