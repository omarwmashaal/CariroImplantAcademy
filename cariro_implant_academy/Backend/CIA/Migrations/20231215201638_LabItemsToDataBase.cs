using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class LabItemsToDataBase : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "LabItemId",
                table: "Lab_Requests_Others",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Code",
                table: "CashFlow",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Consumed",
                table: "CashFlow",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ConsumedCount",
                table: "CashFlow",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "LabItemShadeId",
                table: "CashFlow",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "LabItemParents",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true),
                    Discriminator = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LabItemParents", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "LabItemCompanies",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true),
                    LabItemParentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LabItemCompanies", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LabItemCompanies_LabItemParents_LabItemParentId",
                        column: x => x.LabItemParentId,
                        principalTable: "LabItemParents",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "LabItemShades",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true),
                    LabItemCompanyId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LabItemShades", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LabItemShades_LabItemCompanies_LabItemCompanyId",
                        column: x => x.LabItemCompanyId,
                        principalTable: "LabItemCompanies",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "LabItemParents",
                columns: new[] { "Id", "Discriminator", "Name" },
                values: new object[,]
                {
                    { 1, "LabItem_ZirconUnit", "Zircon Unit" },
                    { 2, "LabItem_PFM", "PFM" },
                    { 3, "LabItem_CompositeInlay", "Composite Inlay" },
                    { 4, "LabItem_EmaxVeneer", "Emax Veneer" },
                    { 5, "LabItem_MilledPMMA", "Milled PMMA" },
                    { 6, "LabItem_PrintedPMMA", "Printed PMMA" },
                    { 7, "LabItem_TiAbutment", "Ti Abutment" },
                    { 8, "LabItem_TiBar", "Ti Bar" },
                    { 9, "LabItem_ThreeDPrinting", "3D Printing" },
                    { 10, "LabItem_WaxUp", "Wax Up" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_Others_LabItemId",
                table: "Lab_Requests_Others",
                column: "LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_CompositeInlay_LabItemId",
                table: "Lab_Requests",
                column: "CompositeInlay_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_EmaxVeneer_LabItemId",
                table: "Lab_Requests",
                column: "EmaxVeneer_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_MilledPMMA_LabItemId",
                table: "Lab_Requests",
                column: "MilledPMMA_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_PFM_LabItemId",
                table: "Lab_Requests",
                column: "PFM_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_PrintedPMMA_LabItemId",
                table: "Lab_Requests",
                column: "PrintedPMMA_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_ThreeDPrinting_LabItemId",
                table: "Lab_Requests",
                column: "ThreeDPrinting_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_TiAbutment_LabItemId",
                table: "Lab_Requests",
                column: "TiAbutment_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_TiBar_LabItemId",
                table: "Lab_Requests",
                column: "TiBar_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_WaxUp_LabItemId",
                table: "Lab_Requests",
                column: "WaxUp_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_ZirconUnit_LabItemId",
                table: "Lab_Requests",
                column: "ZirconUnit_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_LabItemShadeId",
                table: "CashFlow",
                column: "LabItemShadeId");

            migrationBuilder.CreateIndex(
                name: "IX_LabItemCompanies_LabItemParentId",
                table: "LabItemCompanies",
                column: "LabItemParentId");

            migrationBuilder.CreateIndex(
                name: "IX_LabItemShades_LabItemCompanyId",
                table: "LabItemShades",
                column: "LabItemCompanyId");

            migrationBuilder.AddForeignKey(
                name: "FK_CashFlow_LabItemShades_LabItemShadeId",
                table: "CashFlow",
                column: "LabItemShadeId",
                principalTable: "LabItemShades",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_CompositeInlay_LabItemId",
                table: "Lab_Requests",
                column: "CompositeInlay_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_EmaxVeneer_LabItemId",
                table: "Lab_Requests",
                column: "EmaxVeneer_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_MilledPMMA_LabItemId",
                table: "Lab_Requests",
                column: "MilledPMMA_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_PFM_LabItemId",
                table: "Lab_Requests",
                column: "PFM_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_PrintedPMMA_LabItemId",
                table: "Lab_Requests",
                column: "PrintedPMMA_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_ThreeDPrinting_LabItemId",
                table: "Lab_Requests",
                column: "ThreeDPrinting_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_TiAbutment_LabItemId",
                table: "Lab_Requests",
                column: "TiAbutment_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_TiBar_LabItemId",
                table: "Lab_Requests",
                column: "TiBar_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_WaxUp_LabItemId",
                table: "Lab_Requests",
                column: "WaxUp_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_CashFlow_ZirconUnit_LabItemId",
                table: "Lab_Requests",
                column: "ZirconUnit_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_Others_CashFlow_LabItemId",
                table: "Lab_Requests_Others",
                column: "LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CashFlow_LabItemShades_LabItemShadeId",
                table: "CashFlow");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_CompositeInlay_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_EmaxVeneer_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_MilledPMMA_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_PFM_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_PrintedPMMA_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_ThreeDPrinting_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_TiAbutment_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_TiBar_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_WaxUp_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_CashFlow_ZirconUnit_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_Others_CashFlow_LabItemId",
                table: "Lab_Requests_Others");

            migrationBuilder.DropTable(
                name: "LabItemShades");

            migrationBuilder.DropTable(
                name: "LabItemCompanies");

            migrationBuilder.DropTable(
                name: "LabItemParents");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_Others_LabItemId",
                table: "Lab_Requests_Others");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_CompositeInlay_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_EmaxVeneer_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_MilledPMMA_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_PFM_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_PrintedPMMA_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_ThreeDPrinting_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_TiAbutment_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_TiBar_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_WaxUp_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_ZirconUnit_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_CashFlow_LabItemShadeId",
                table: "CashFlow");

            migrationBuilder.DropColumn(
                name: "LabItemId",
                table: "Lab_Requests_Others");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Code",
                table: "CashFlow");

            migrationBuilder.DropColumn(
                name: "Consumed",
                table: "CashFlow");

            migrationBuilder.DropColumn(
                name: "ConsumedCount",
                table: "CashFlow");

            migrationBuilder.DropColumn(
                name: "LabItemShadeId",
                table: "CashFlow");
        }
    }
}
