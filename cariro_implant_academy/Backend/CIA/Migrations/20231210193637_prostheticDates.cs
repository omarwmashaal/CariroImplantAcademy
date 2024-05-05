using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class prostheticDates : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "Date",
                table: "ProstheticTreatments",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "Date",
                table: "ProstheticTreatmentFinalSingleBridges",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "Date",
                table: "ProstheticTreatmentFinalFullArchs",
                type: "timestamp with time zone",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Date",
                table: "ProstheticTreatments");

            migrationBuilder.DropColumn(
                name: "Date",
                table: "ProstheticTreatmentFinalSingleBridges");

            migrationBuilder.DropColumn(
                name: "Date",
                table: "ProstheticTreatmentFinalFullArchs");
        }
    }
}
