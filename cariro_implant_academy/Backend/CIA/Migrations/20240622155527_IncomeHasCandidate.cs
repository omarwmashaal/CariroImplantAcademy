using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class IncomeHasCandidate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CandidateId",
                table: "CashFlow",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_CandidateId",
                table: "CashFlow",
                column: "CandidateId");

            migrationBuilder.AddForeignKey(
                name: "FK_CashFlow_AspNetUsers_CandidateId",
                table: "CashFlow",
                column: "CandidateId",
                principalTable: "AspNetUsers",
                principalColumn: "IdInt",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CashFlow_AspNetUsers_CandidateId",
                table: "CashFlow");

            migrationBuilder.DropIndex(
                name: "IX_CashFlow_CandidateId",
                table: "CashFlow");

            migrationBuilder.DropColumn(
                name: "CandidateId",
                table: "CashFlow");
        }
    }
}
