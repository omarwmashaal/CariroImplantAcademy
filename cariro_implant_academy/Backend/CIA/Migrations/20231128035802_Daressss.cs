using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class Daressss : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ClinicTreatmentParent_ClinicReceipts_ClinicReceiptModelId",
                table: "ClinicTreatmentParent");

            migrationBuilder.DropTable(
                name: "ClinicReceipts");

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "Receipts",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<bool>(
                name: "IsPaid",
                table: "Receipts",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_ClinicTreatmentParent_Receipts_ClinicReceiptModelId",
                table: "ClinicTreatmentParent",
                column: "ClinicReceiptModelId",
                principalTable: "Receipts",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ClinicTreatmentParent_Receipts_ClinicReceiptModelId",
                table: "ClinicTreatmentParent");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "Receipts");

            migrationBuilder.DropColumn(
                name: "IsPaid",
                table: "Receipts");

            migrationBuilder.CreateTable(
                name: "ClinicReceipts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Paid = table.Column<bool>(type: "boolean", nullable: false),
                    Total = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ClinicReceipts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ClinicReceipts_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_ClinicReceipts_PatientId",
                table: "ClinicReceipts",
                column: "PatientId");

            migrationBuilder.AddForeignKey(
                name: "FK_ClinicTreatmentParent_ClinicReceipts_ClinicReceiptModelId",
                table: "ClinicTreatmentParent",
                column: "ClinicReceiptModelId",
                principalTable: "ClinicReceipts",
                principalColumn: "Id");
        }
    }
}
