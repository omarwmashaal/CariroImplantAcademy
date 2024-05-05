using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class AddClinicReceipts : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ClinicReceiptModelId",
                table: "ClinicTreatmentParent",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "ClinicReceipts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Total = table.Column<int>(type: "integer", nullable: false),
                    Paid = table.Column<bool>(type: "boolean", nullable: false)
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
                name: "IX_ClinicTreatmentParent_ClinicReceiptModelId",
                table: "ClinicTreatmentParent",
                column: "ClinicReceiptModelId");

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ClinicTreatmentParent_ClinicReceipts_ClinicReceiptModelId",
                table: "ClinicTreatmentParent");

            migrationBuilder.DropTable(
                name: "ClinicReceipts");

            migrationBuilder.DropIndex(
                name: "IX_ClinicTreatmentParent_ClinicReceiptModelId",
                table: "ClinicTreatmentParent");

            migrationBuilder.DropColumn(
                name: "ClinicReceiptModelId",
                table: "ClinicTreatmentParent");
        }
    }
}
