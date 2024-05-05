using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class LabRequestItems : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CompositeInlay_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CompositeInlay_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "EmaxVeneer_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "EmaxVeneer_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "MilledPMMA_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "MilledPMMA_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PFM_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PFM_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PrintedPMMA_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PrintedPMMA_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ThreeDPrinting_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ThreeDPrinting_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiAbutment_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiAbutment_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiBar_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TiBar_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "WaxUp_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "WaxUp_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ZirconUnit_Description",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ZirconUnit_Name",
                table: "Lab_Requests",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_Number",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Lab_Requests_Others",
                columns: table => new
                {
                    LabRequestId = table.Column<int>(name: "Lab_RequestId", type: "integer", nullable: false),
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: false),
                    Number = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lab_Requests_Others", x => new { x.LabRequestId, x.Id });
                    table.ForeignKey(
                        name: "FK_Lab_Requests_Others_Lab_Requests_Lab_RequestId",
                        column: x => x.LabRequestId,
                        principalTable: "Lab_Requests",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Lab_Requests_Others");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_Number",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Description",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Name",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Number",
                table: "Lab_Requests");
        }
    }
}
