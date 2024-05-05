using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class operatorToFinal : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "OperatorId",
                table: "FinalProsthesisParentsTable",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "OperatorId1",
                table: "FinalProsthesisParentsTable",
                type: "text",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_FinalProsthesisParentsTable_OperatorId1",
                table: "FinalProsthesisParentsTable",
                column: "OperatorId1");

            migrationBuilder.AddForeignKey(
                name: "FK_FinalProsthesisParentsTable_AspNetUsers_OperatorId1",
                table: "FinalProsthesisParentsTable",
                column: "OperatorId1",
                principalTable: "AspNetUsers",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FinalProsthesisParentsTable_AspNetUsers_OperatorId1",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropIndex(
                name: "IX_FinalProsthesisParentsTable_OperatorId1",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "OperatorId",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "OperatorId1",
                table: "FinalProsthesisParentsTable");
        }
    }
}
