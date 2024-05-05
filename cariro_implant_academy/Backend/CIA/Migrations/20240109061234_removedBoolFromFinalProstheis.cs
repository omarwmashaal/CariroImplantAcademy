using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class removedBoolFromFinalProstheis : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FinalProthesisDelivery",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "FinalProthesisHealingCollar",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "FinalProthesisImpression",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "FinalProthesisTryIn",
                table: "FinalProsthesisParentsTable");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisDelivery",
                table: "FinalProsthesisParentsTable",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisHealingCollar",
                table: "FinalProsthesisParentsTable",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisImpression",
                table: "FinalProsthesisParentsTable",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "FinalProthesisTryIn",
                table: "FinalProsthesisParentsTable",
                type: "boolean",
                nullable: true);
        }
    }
}
