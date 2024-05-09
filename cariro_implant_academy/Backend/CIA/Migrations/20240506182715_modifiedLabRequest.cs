using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class modifiedLabRequest : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            //migrationBuilder.DropColumn(
            //    name: "CompositeInlay_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "EmaxVeneer_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "MilledPMMA_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "PFM_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "PrintedPMMA_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "ThreeDPrinting_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "TiAbutment_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "TiBar_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "WaxUp_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "ZirconUnit_Name",
            //    table: "Receipts");

            //migrationBuilder.DropColumn(
            //    name: "Name",
            //    table: "Lab_Requests_Others");

            //migrationBuilder.DropColumn(
            //    name: "CompositeInlay_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "EmaxVeneer_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "MilledPMMA_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "PFM_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "PrintedPMMA_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "ThreeDPrinting_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "TiAbutment_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "TiBar_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "WaxUp_Name",
            //    table: "Lab_Requests");

            //migrationBuilder.DropColumn(
            //    name: "ZirconUnit_Name",
            //    table: "Lab_Requests");

            migrationBuilder.CreateTable(
                name: "LabRequestStepItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    LabRequestId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    LabItemFromSettingsId = table.Column<int>(type: "integer", nullable: true),
                    ConsumedLabItemId = table.Column<int>(type: "integer", nullable: true),
                    LabPrice = table.Column<int>(type: "integer", nullable: true),
                    Tooth = table.Column<int>(type: "integer", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LabRequestStepItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LabRequestStepItems_CashFlow_ConsumedLabItemId",
                        column: x => x.ConsumedLabItemId,
                        principalTable: "CashFlow",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_LabRequestStepItems_LabItemParents_LabItemFromSettingsId",
                        column: x => x.LabItemFromSettingsId,
                        principalTable: "LabItemParents",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_LabRequestStepItems_ConsumedLabItemId",
                table: "LabRequestStepItems",
                column: "ConsumedLabItemId");

            migrationBuilder.CreateIndex(
                name: "IX_LabRequestStepItems_LabItemFromSettingsId",
                table: "LabRequestStepItems",
                column: "LabItemFromSettingsId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "LabRequestStepItems");

            //migrationBuilder.AddColumn<string>(
            //    name: "CompositeInlay_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "EmaxVeneer_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "MilledPMMA_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "PFM_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "PrintedPMMA_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "ThreeDPrinting_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "TiAbutment_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "TiBar_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "WaxUp_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "ZirconUnit_Name",
            //    table: "Receipts",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "Name",
            //    table: "Lab_Requests_Others",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "CompositeInlay_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "EmaxVeneer_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "MilledPMMA_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "PFM_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "PrintedPMMA_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "ThreeDPrinting_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "TiAbutment_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "TiBar_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "WaxUp_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);

            //migrationBuilder.AddColumn<string>(
            //    name: "ZirconUnit_Name",
            //    table: "Lab_Requests",
            //    type: "text",
            //    nullable: true);
        }
    }
}
