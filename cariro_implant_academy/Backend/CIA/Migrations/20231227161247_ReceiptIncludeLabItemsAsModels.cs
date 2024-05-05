using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class ReceiptIncludeLabItemsAsModels : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_AssignedToId1",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_CustomerId1",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_EntryById1",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_AssignedToId1",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_CustomerId1",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_EntryById1",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "AssignedToId1",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "CustomerId1",
                table: "Lab_Requests");

            migrationBuilder.RenameColumn(
                name: "EntryById1",
                table: "Lab_Requests",
                newName: "NotesFromTech");

            migrationBuilder.AddColumn<string>(
                name: "CompositeInlay_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CompositeInlay_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "EmaxVeneer_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "EmaxVeneer_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "LabFees",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "MilledPMMA_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "MilledPMMA_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PFM_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PFM_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PrintedPMMA_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PrintedPMMA_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ThreeDPrinting_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ThreeDPrinting_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiAbutment_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiAbutment_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiBar_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiBar_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "WaxUp_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "WaxUp_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ZirconUnit_Description",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_LabItemId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ZirconUnit_Name",
                table: "Receipts",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_Number",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_Price",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_TotalPrice",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TotalPrice",
                table: "Lab_Requests_Others",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "LabFees",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_TotalPrice",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_CompositeInlay_LabItemId",
                table: "Receipts",
                column: "CompositeInlay_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_EmaxVeneer_LabItemId",
                table: "Receipts",
                column: "EmaxVeneer_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_MilledPMMA_LabItemId",
                table: "Receipts",
                column: "MilledPMMA_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_PFM_LabItemId",
                table: "Receipts",
                column: "PFM_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_PrintedPMMA_LabItemId",
                table: "Receipts",
                column: "PrintedPMMA_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_ThreeDPrinting_LabItemId",
                table: "Receipts",
                column: "ThreeDPrinting_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_TiAbutment_LabItemId",
                table: "Receipts",
                column: "TiAbutment_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_TiBar_LabItemId",
                table: "Receipts",
                column: "TiBar_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_WaxUp_LabItemId",
                table: "Receipts",
                column: "WaxUp_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_ZirconUnit_LabItemId",
                table: "Receipts",
                column: "ZirconUnit_LabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_AssignedToId",
                table: "Lab_Requests",
                column: "AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_CustomerId",
                table: "Lab_Requests",
                column: "CustomerId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_EntryById",
                table: "Lab_Requests",
                column: "EntryById");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_AssignedToId",
                table: "Lab_Requests",
                column: "AssignedToId",
                principalTable: "AspNetUsers",
                principalColumn: "IdInt",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_CustomerId",
                table: "Lab_Requests",
                column: "CustomerId",
                principalTable: "AspNetUsers",
                principalColumn: "IdInt",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_EntryById",
                table: "Lab_Requests",
                column: "EntryById",
                principalTable: "AspNetUsers",
                principalColumn: "IdInt",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_CompositeInlay_LabItemId",
                table: "Receipts",
                column: "CompositeInlay_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_EmaxVeneer_LabItemId",
                table: "Receipts",
                column: "EmaxVeneer_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_MilledPMMA_LabItemId",
                table: "Receipts",
                column: "MilledPMMA_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_PFM_LabItemId",
                table: "Receipts",
                column: "PFM_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_PrintedPMMA_LabItemId",
                table: "Receipts",
                column: "PrintedPMMA_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_ThreeDPrinting_LabItemId",
                table: "Receipts",
                column: "ThreeDPrinting_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_TiAbutment_LabItemId",
                table: "Receipts",
                column: "TiAbutment_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_TiBar_LabItemId",
                table: "Receipts",
                column: "TiBar_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_WaxUp_LabItemId",
                table: "Receipts",
                column: "WaxUp_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_CashFlow_ZirconUnit_LabItemId",
                table: "Receipts",
                column: "ZirconUnit_LabItemId",
                principalTable: "CashFlow",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_AssignedToId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_CustomerId",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_EntryById",
                table: "Lab_Requests");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_CompositeInlay_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_EmaxVeneer_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_MilledPMMA_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_PFM_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_PrintedPMMA_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_ThreeDPrinting_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_TiAbutment_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_TiBar_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_WaxUp_LabItemId",
                table: "Receipts");

            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_CashFlow_ZirconUnit_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_CompositeInlay_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_EmaxVeneer_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_MilledPMMA_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_PFM_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_PrintedPMMA_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_ThreeDPrinting_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_TiAbutment_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_TiBar_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_WaxUp_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_ZirconUnit_LabItemId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_AssignedToId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_CustomerId",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_EntryById",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "LabFees",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PFM_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PFM_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PFM_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PFM_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PFM_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PFM_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiAbutment_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiAbutment_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiBar_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiBar_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiBar_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiBar_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiBar_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TiBar_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "WaxUp_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "WaxUp_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "WaxUp_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "WaxUp_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "WaxUp_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "WaxUp_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Description",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_LabItemId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Name",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Number",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Price",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_TotalPrice",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "TotalPrice",
                table: "Lab_Requests_Others");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "LabFees",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_TotalPrice",
                table: "Lab_Requests");

            migrationBuilder.RenameColumn(
                name: "NotesFromTech",
                table: "Lab_Requests",
                newName: "EntryById1");

            migrationBuilder.AddColumn<string>(
                name: "AssignedToId1",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CustomerId1",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_AssignedToId1",
                table: "Lab_Requests",
                column: "AssignedToId1");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_CustomerId1",
                table: "Lab_Requests",
                column: "CustomerId1");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_EntryById1",
                table: "Lab_Requests",
                column: "EntryById1");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_AssignedToId1",
                table: "Lab_Requests",
                column: "AssignedToId1",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_CustomerId1",
                table: "Lab_Requests",
                column: "CustomerId1",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_EntryById1",
                table: "Lab_Requests",
                column: "EntryById1",
                principalTable: "AspNetUsers",
                principalColumn: "Id");
        }
    }
}
