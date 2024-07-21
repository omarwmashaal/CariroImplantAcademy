using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class addPaymentMethodIdToPaymentLog : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PaymentMethodId",
                table: "PaymentLogs",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_PaymentLogs_PaymentMethodId",
                table: "PaymentLogs",
                column: "PaymentMethodId");

            migrationBuilder.AddForeignKey(
                name: "FK_PaymentLogs_DropDowns_PaymentMethodId",
                table: "PaymentLogs",
                column: "PaymentMethodId",
                principalTable: "DropDowns",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PaymentLogs_DropDowns_PaymentMethodId",
                table: "PaymentLogs");

            migrationBuilder.DropIndex(
                name: "IX_PaymentLogs_PaymentMethodId",
                table: "PaymentLogs");

            migrationBuilder.DropColumn(
                name: "PaymentMethodId",
                table: "PaymentLogs");
        }
    }
}
