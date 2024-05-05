using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class labItemPricesInRequest : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Price",
                table: "Lab_Requests_Others",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "CompositeInlay_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "EmaxVeneer_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MilledPMMA_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PFM_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PrintedPMMA_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ThreeDPrinting_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiAbutment_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TiBar_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WaxUp_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ZirconUnit_Price",
                table: "Lab_Requests",
                type: "integer",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Price",
                table: "Lab_Requests_Others");

            migrationBuilder.DropColumn(
                name: "CompositeInlay_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "EmaxVeneer_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "MilledPMMA_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PFM_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "PrintedPMMA_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ThreeDPrinting_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiAbutment_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "TiBar_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "WaxUp_Price",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "ZirconUnit_Price",
                table: "Lab_Requests");
        }
    }
}
