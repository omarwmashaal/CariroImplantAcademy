using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class trass : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ReceiptId",
                table: "TreatmentItems",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "ToothReceiptData",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "Price",
                table: "ToothReceiptData",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentItems_ReceiptId",
                table: "TreatmentItems",
                column: "ReceiptId");

            migrationBuilder.AddForeignKey(
                name: "FK_TreatmentItems_Receipts_ReceiptId",
                table: "TreatmentItems",
                column: "ReceiptId",
                principalTable: "Receipts",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TreatmentItems_Receipts_ReceiptId",
                table: "TreatmentItems");

            migrationBuilder.DropIndex(
                name: "IX_TreatmentItems_ReceiptId",
                table: "TreatmentItems");

            migrationBuilder.DropColumn(
                name: "ReceiptId",
                table: "TreatmentItems");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "ToothReceiptData");

            migrationBuilder.DropColumn(
                name: "Price",
                table: "ToothReceiptData");
        }
    }
}
