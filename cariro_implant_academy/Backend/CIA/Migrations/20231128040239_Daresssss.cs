using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class Daresssss : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ClinicTreatmentParent_Receipts_ClinicReceiptModelId",
                table: "ClinicTreatmentParent");

            migrationBuilder.DropIndex(
                name: "IX_ClinicTreatmentParent_ClinicReceiptModelId",
                table: "ClinicTreatmentParent");

            migrationBuilder.AlterColumn<bool>(
                name: "IsPaid",
                table: "Receipts",
                type: "boolean",
                nullable: false,
                defaultValue: false,
                oldClrType: typeof(bool),
                oldType: "boolean",
                oldNullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ReceiptId",
                table: "ClinicTreatmentParent",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_ClinicTreatmentParent_ReceiptId",
                table: "ClinicTreatmentParent",
                column: "ReceiptId");

            migrationBuilder.AddForeignKey(
                name: "FK_ClinicTreatmentParent_Receipts_ReceiptId",
                table: "ClinicTreatmentParent",
                column: "ReceiptId",
                principalTable: "Receipts",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ClinicTreatmentParent_Receipts_ReceiptId",
                table: "ClinicTreatmentParent");

            migrationBuilder.DropIndex(
                name: "IX_ClinicTreatmentParent_ReceiptId",
                table: "ClinicTreatmentParent");

            migrationBuilder.DropColumn(
                name: "ReceiptId",
                table: "ClinicTreatmentParent");

            migrationBuilder.AlterColumn<bool>(
                name: "IsPaid",
                table: "Receipts",
                type: "boolean",
                nullable: true,
                oldClrType: typeof(bool),
                oldType: "boolean");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicTreatmentParent_ClinicReceiptModelId",
                table: "ClinicTreatmentParent",
                column: "ClinicReceiptModelId");

            migrationBuilder.AddForeignKey(
                name: "FK_ClinicTreatmentParent_Receipts_ClinicReceiptModelId",
                table: "ClinicTreatmentParent",
                column: "ClinicReceiptModelId",
                principalTable: "Receipts",
                principalColumn: "Id");
        }
    }
}
