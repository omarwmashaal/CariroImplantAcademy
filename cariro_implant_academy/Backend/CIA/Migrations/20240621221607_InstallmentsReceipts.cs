using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class InstallmentsReceipts : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PaymentLogs_Patients_PatientId",
                table: "PaymentLogs");

            migrationBuilder.AlterColumn<int>(
                name: "PatientId",
                table: "PaymentLogs",
                type: "integer",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "integer");

            migrationBuilder.AddColumn<int>(
                name: "ReceiptId",
                table: "InstallmentPlans",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_InstallmentPlans_ReceiptId",
                table: "InstallmentPlans",
                column: "ReceiptId");

            migrationBuilder.AddForeignKey(
                name: "FK_InstallmentPlans_Receipts_ReceiptId",
                table: "InstallmentPlans",
                column: "ReceiptId",
                principalTable: "Receipts",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_PaymentLogs_Patients_PatientId",
                table: "PaymentLogs",
                column: "PatientId",
                principalTable: "Patients",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_InstallmentPlans_Receipts_ReceiptId",
                table: "InstallmentPlans");

            migrationBuilder.DropForeignKey(
                name: "FK_PaymentLogs_Patients_PatientId",
                table: "PaymentLogs");

            migrationBuilder.DropIndex(
                name: "IX_InstallmentPlans_ReceiptId",
                table: "InstallmentPlans");

            migrationBuilder.DropColumn(
                name: "ReceiptId",
                table: "InstallmentPlans");

            migrationBuilder.AlterColumn<int>(
                name: "PatientId",
                table: "PaymentLogs",
                type: "integer",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "integer",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_PaymentLogs_Patients_PatientId",
                table: "PaymentLogs",
                column: "PatientId",
                principalTable: "Patients",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
