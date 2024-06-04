using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class LabNewSystem1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("Update \"LabItemCompanies\" set \"LabItemParentId\" = Null");
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
                name: "FK_LabRequestStepItems_LabItemParents_LabItemFromSettingsId",
                table: "LabRequestStepItems");

            migrationBuilder.DropIndex(
                name: "IX_LabRequestStepItems_LabItemFromSettingsId",
                table: "LabRequestStepItems");

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

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DropColumn(
                name: "LabItemFromSettingsId",
                table: "LabRequestStepItems");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "LabItemParents");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_LabItemId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.RenameColumn(
                name: "UnitPrice",
                table: "LabItemParents",
                newName: "Threshold");

            migrationBuilder.AddColumn<int>(
                name: "LabItemParentId",
                table: "LabItemShades",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "HasCode",
                table: "LabItemParents",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "HasCompanies",
                table: "LabItemParents",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "HasShades",
                table: "LabItemParents",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "HasSize",
                table: "LabItemParents",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "IsStock",
                table: "LabItemParents",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<int>(
                name: "LabItemCompanyId",
                table: "CashFlow",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "LabItemParentId",
                table: "CashFlow",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "LabOptions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Price = table.Column<int>(type: "integer", nullable: false),
                    LabItemParentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LabOptions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LabOptions_LabItemParents_LabItemParentId",
                        column: x => x.LabItemParentId,
                        principalTable: "LabItemParents",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_LabItemShades_LabItemParentId",
                table: "LabItemShades",
                column: "LabItemParentId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_LabItemCompanyId",
                table: "CashFlow",
                column: "LabItemCompanyId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_LabItemParentId",
                table: "CashFlow",
                column: "LabItemParentId");

            migrationBuilder.CreateIndex(
                name: "IX_LabOptions_LabItemParentId",
                table: "LabOptions",
                column: "LabItemParentId");

            migrationBuilder.AddForeignKey(
                name: "FK_CashFlow_LabItemCompanies_LabItemCompanyId",
                table: "CashFlow",
                column: "LabItemCompanyId",
                principalTable: "LabItemCompanies",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_CashFlow_LabItemParents_LabItemParentId",
                table: "CashFlow",
                column: "LabItemParentId",
                principalTable: "LabItemParents",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_LabItemShades_LabItemParents_LabItemParentId",
                table: "LabItemShades",
                column: "LabItemParentId",
                principalTable: "LabItemParents",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CashFlow_LabItemCompanies_LabItemCompanyId",
                table: "CashFlow");

            migrationBuilder.DropForeignKey(
                name: "FK_CashFlow_LabItemParents_LabItemParentId",
                table: "CashFlow");

            migrationBuilder.DropForeignKey(
                name: "FK_LabItemShades_LabItemParents_LabItemParentId",
                table: "LabItemShades");

            migrationBuilder.DropTable(
                name: "LabOptions");

            migrationBuilder.DropIndex(
                name: "IX_LabItemShades_LabItemParentId",
                table: "LabItemShades");

            migrationBuilder.DropIndex(
                name: "IX_CashFlow_LabItemCompanyId",
                table: "CashFlow");

            migrationBuilder.DropIndex(
                name: "IX_CashFlow_LabItemParentId",
                table: "CashFlow");

            migrationBuilder.DropColumn(
                name: "LabItemParentId",
                table: "LabItemShades");

            migrationBuilder.DropColumn(
                name: "HasCode",
                table: "LabItemParents");

            migrationBuilder.DropColumn(
                name: "HasCompanies",
                table: "LabItemParents");

            migrationBuilder.DropColumn(
                name: "HasShades",
                table: "LabItemParents");

            migrationBuilder.DropColumn(
                name: "HasSize",
                table: "LabItemParents");

            migrationBuilder.DropColumn(
                name: "IsStock",
                table: "LabItemParents");

            migrationBuilder.DropColumn(
                name: "LabItemCompanyId",
                table: "CashFlow");

            migrationBuilder.DropColumn(
                name: "LabItemParentId",
                table: "CashFlow");

            migrationBuilder.RenameColumn(
                name: "Threshold",
                table: "LabItemParents",
                newName: "UnitPrice");

            migrationBuilder.AddColumn<int>(
                name: "LabItemFromSettingsId",
                table: "LabRequestStepItems",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "LabItemParents",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "CompositeInlay_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "EmaxVeneer_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "MilledPMMA_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PFM_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PrintedPMMA_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ThreeDPrinting_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiAbutment_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiBar_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "WaxUp_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ZirconUnit_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_LabItemId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.InsertData(
                table: "LabItemParents",
                columns: new[] { "Id", "Discriminator", "Name", "UnitPrice" },
                values: new object[,]
                {
                    { 1, "LabItem_ZirconUnit", "Zircon Unit", 0 },
                    { 2, "LabItem_PFM", "PFM", 0 },
                    { 3, "LabItem_CompositeInlay", "Composite Inlay", 0 },
                    { 4, "LabItem_EmaxVeneer", "Emax Veneer", 0 },
                    { 5, "LabItem_MilledPMMA", "Milled PMMA", 0 },
                    { 6, "LabItem_PrintedPMMA", "Printed PMMA", 0 },
                    { 7, "LabItem_TiAbutment", "Ti Abutment", 0 },
                    { 8, "LabItem_TiBar", "Ti Bar", 0 },
                    { 9, "LabItem_ThreeDPrinting", "3D Printing", 0 },
                    { 10, "LabItem_WaxUp", "Wax Up", 0 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_LabRequestStepItems_LabItemFromSettingsId",
                table: "LabRequestStepItems",
                column: "LabItemFromSettingsId");

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
                name: "FK_LabRequestStepItems_LabItemParents_LabItemFromSettingsId",
                table: "LabRequestStepItems",
                column: "LabItemFromSettingsId",
                principalTable: "LabItemParents",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
