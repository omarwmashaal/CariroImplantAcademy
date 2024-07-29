using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class ReceiptsHasCandidate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CandidateId",
                table: "Receipts",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_CandidateId",
                table: "Receipts",
                column: "CandidateId");

            migrationBuilder.AddForeignKey(
                name: "FK_Receipts_AspNetUsers_CandidateId",
                table: "Receipts",
                column: "CandidateId",
                principalTable: "AspNetUsers",
                principalColumn: "IdInt",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Receipts_AspNetUsers_CandidateId",
                table: "Receipts");

            migrationBuilder.DropIndex(
                name: "IX_Receipts_CandidateId",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "CandidateId",
                table: "Receipts");
        }
    }
}
