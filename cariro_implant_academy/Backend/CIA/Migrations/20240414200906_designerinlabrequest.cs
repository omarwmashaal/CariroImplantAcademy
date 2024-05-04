using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class designerinlabrequest : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "c5a83c0f-81c4-40a4-83d7-3e126aee87fd");

            migrationBuilder.AddColumn<int>(
                name: "DesignerId",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DesignerId1",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { "4999dc08-005d-4e4d-a99d-3150b0e75f1d", null, "labdesigner", "LABDESIGNER" });

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_DesignerId1",
                table: "Lab_Requests",
                column: "DesignerId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_DesignerId1",
                table: "Lab_Requests",
                column: "DesignerId1",
                principalTable: "AspNetUsers",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Lab_Requests_AspNetUsers_DesignerId1",
                table: "Lab_Requests");

            migrationBuilder.DropIndex(
                name: "IX_Lab_Requests_DesignerId1",
                table: "Lab_Requests");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "4999dc08-005d-4e4d-a99d-3150b0e75f1d");

            migrationBuilder.DropColumn(
                name: "DesignerId",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "DesignerId1",
                table: "Lab_Requests");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { "c5a83c0f-81c4-40a4-83d7-3e126aee87fd", null, "labdesigner", "LABDESIGNER" });
        }
    }
}
