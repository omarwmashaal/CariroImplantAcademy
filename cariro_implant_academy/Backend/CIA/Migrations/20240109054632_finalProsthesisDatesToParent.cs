using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class finalProsthesisDatesToParent : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "Date",
                table: "FinalProsthesisParentsTable",
                type: "timestamp with time zone",
                nullable: true);
            migrationBuilder.Sql("Update \"FinalProsthesisParentsTable\" set \"Date\" = coalesce(\"Date\",\"FinalProthesisDeliveryDate\")");
            migrationBuilder.Sql("Update \"FinalProsthesisParentsTable\" set \"Date\" = coalesce(\"Date\",\"FinalProthesisHealingCollarDate\")");
            migrationBuilder.Sql("Update \"FinalProsthesisParentsTable\" set \"Date\" = coalesce(\"Date\",\"FinalProthesisImpressionDate\")");
            migrationBuilder.Sql("Update \"FinalProsthesisParentsTable\" set \"Date\" = coalesce(\"Date\",\"FinalProthesisTryInDate\")");

            migrationBuilder.DropColumn(
                name: "FinalProthesisDeliveryDate",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "FinalProthesisHealingCollarDate",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.DropColumn(
                name: "FinalProthesisImpressionDate",
                table: "FinalProsthesisParentsTable");


            migrationBuilder.DropColumn(
                name: "FinalProthesisTryInDate",
                table: "FinalProsthesisParentsTable"
                );


        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Date",
                table: "FinalProsthesisParentsTable"
                );

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisTryInDate",
                table: "FinalProsthesisParentsTable",
                type: "timestamp with time zone",
                nullable: true);
            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisDeliveryDate",
                table: "FinalProsthesisParentsTable",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisHealingCollarDate",
                table: "FinalProsthesisParentsTable",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FinalProthesisImpressionDate",
                table: "FinalProsthesisParentsTable",
                type: "timestamp with time zone",
                nullable: true);
        }
    }
}
