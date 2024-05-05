using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class appliedTreatmentPircesAndAllowAssignAndiSsURGICALaNDrEEIPT : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            //migrationBuilder.DropForeignKey(
            //    name: "FK_SurgicalTreatments_Patients_PatientId",
            //    table: "SurgicalTreatments");

            //migrationBuilder.DropForeignKey(
            //    name: "FK_TreatmentItems_Receipts_ReceiptId",
            //    table: "TreatmentItems");

            //migrationBuilder.DropTable(
            //    name: "TreatmentPrices");

            //migrationBuilder.DropIndex(
            //    name: "IX_TreatmentItems_ReceiptId",
            //    table: "TreatmentItems");

            //migrationBuilder.DropIndex(
            //    name: "IX_SurgicalTreatments_PatientId",
            //    table: "SurgicalTreatments");

            //migrationBuilder.DropColumn(
            //    name: "ReceiptId",
            //    table: "TreatmentItems");

            migrationBuilder.AddColumn<bool>(
                name: "AllowAssign",
                table: "TreatmentItems",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "ShowInSurgical",
                table: "TreatmentItems",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<int>(
                name: "Website",
                table: "TreatmentItems",
                type: "integer",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AllowAssign",
                table: "TreatmentItems");

            migrationBuilder.DropColumn(
                name: "ShowInSurgical",
                table: "TreatmentItems");

            migrationBuilder.DropColumn(
                name: "Website",
                table: "TreatmentItems");

            //migrationBuilder.AddColumn<int>(
            //    name: "ReceiptId",
            //    table: "TreatmentItems",
            //    type: "integer",
            //    nullable: true);

            //    migrationBuilder.CreateTable(
            //        name: "TreatmentPrices",
            //        columns: table => new
            //        {
            //            Id = table.Column<int>(type: "integer", nullable: false)
            //                .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
            //            Crown = table.Column<int>(type: "integer", nullable: false),
            //            Extraction = table.Column<int>(type: "integer", nullable: false),
            //            Implant = table.Column<int>(type: "integer", nullable: false),
            //            Other = table.Column<int>(type: "integer", nullable: false),
            //            Restoration = table.Column<int>(type: "integer", nullable: false),
            //            RootCanalTreatment = table.Column<int>(type: "integer", nullable: false),
            //            Scaling = table.Column<int>(type: "integer", nullable: false)
            //        },
            //        constraints: table =>
            //        {
            //            table.PrimaryKey("PK_TreatmentPrices", x => x.Id);
            //        });

            //    migrationBuilder.InsertData(
            //        table: "TreatmentPrices",
            //        columns: new[] { "Id", "Crown", "Extraction", "Implant", "Other", "Restoration", "RootCanalTreatment", "Scaling" },
            //        values: new object[] { 1, 0, 0, 0, 0, 0, 0, 0 });

            //    migrationBuilder.CreateIndex(
            //        name: "IX_TreatmentItems_ReceiptId",
            //        table: "TreatmentItems",
            //        column: "ReceiptId");

            //    migrationBuilder.CreateIndex(
            //        name: "IX_SurgicalTreatments_PatientId",
            //        table: "SurgicalTreatments",
            //        column: "PatientId",
            //        unique: true);

            //    migrationBuilder.AddForeignKey(
            //        name: "FK_SurgicalTreatments_Patients_PatientId",
            //        table: "SurgicalTreatments",
            //        column: "PatientId",
            //        principalTable: "Patients",
            //        principalColumn: "Id");

            //    migrationBuilder.AddForeignKey(
            //        name: "FK_TreatmentItems_Receipts_ReceiptId",
            //        table: "TreatmentItems",
            //        column: "ReceiptId",
            //        principalTable: "Receipts",
            //        principalColumn: "Id");
        }
    }
}
