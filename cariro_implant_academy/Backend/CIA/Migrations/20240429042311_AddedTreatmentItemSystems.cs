using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class AddedTreatmentItemSystems : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "TreatmentItemId",
                table: "TreatmentDetails",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "TreatmentItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Price = table.Column<int>(type: "integer", nullable: false),
                    PriceAction = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TreatmentItems", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentDetails_TreatmentItemId",
                table: "TreatmentDetails",
                column: "TreatmentItemId");

            migrationBuilder.AddForeignKey(
                name: "FK_TreatmentDetails_TreatmentItems_TreatmentItemId",
                table: "TreatmentDetails",
                column: "TreatmentItemId",
                principalTable: "TreatmentItems",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TreatmentDetails_TreatmentItems_TreatmentItemId",
                table: "TreatmentDetails");

            migrationBuilder.DropTable(
                name: "TreatmentItems");

            migrationBuilder.DropIndex(
                name: "IX_TreatmentDetails_TreatmentItemId",
                table: "TreatmentDetails");

            migrationBuilder.DropColumn(
                name: "TreatmentItemId",
                table: "TreatmentDetails");
        }
    }
}
