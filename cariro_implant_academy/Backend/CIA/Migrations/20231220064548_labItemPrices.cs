using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class labItemPrices : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UnitPrice",
                table: "CashFlow");

            migrationBuilder.AddColumn<int>(
                name: "UnitPrice",
                table: "LabItemParents",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 1,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 2,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 3,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 4,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 5,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 6,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 7,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 8,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 9,
                column: "UnitPrice",
                value: 0);

            migrationBuilder.UpdateData(
                table: "LabItemParents",
                keyColumn: "Id",
                keyValue: 10,
                column: "UnitPrice",
                value: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UnitPrice",
                table: "LabItemParents");

            migrationBuilder.AddColumn<int>(
                name: "UnitPrice",
                table: "CashFlow",
                type: "integer",
                nullable: true);
        }
    }
}
