using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class diagnosticAndComplications : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "GBRFailure",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "Numbness",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "OpenWound",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "OroantralCommunication",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "PusInDonorSite",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "PusInImplantSite",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "SinusElevationFailure",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "Swelling",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "CrownFall",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "FoodImpaction",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "FracturedPrintedPMMA",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "FracturedZirconia",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "Pain",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "ScrewLoosness",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "ComplicationsAfterSurgery",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Notes",
                table: "ComplicationsAfterSurgery",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "OperatorId",
                table: "ComplicationsAfterSurgery",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ParentId",
                table: "ComplicationsAfterSurgery",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Tooth",
                table: "ComplicationsAfterSurgery",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "ComplicationsAfterProsthesis",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Notes",
                table: "ComplicationsAfterProsthesis",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "OperatorId",
                table: "ComplicationsAfterProsthesis",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ParentId",
                table: "ComplicationsAfterProsthesis",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Tooth",
                table: "ComplicationsAfterProsthesis",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "ComplicationsAfterProsthesisParents",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Tooth = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ComplicationsAfterProsthesisParents", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ComplicationsAfterProsthesisParents_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ComplicationsAfterSurgeryParents",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Tooth = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ComplicationsAfterSurgeryParents", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ComplicationsAfterSurgeryParents_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterSurgery_OperatorId",
                table: "ComplicationsAfterSurgery",
                column: "OperatorId");

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterSurgery_ParentId",
                table: "ComplicationsAfterSurgery",
                column: "ParentId");

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterProsthesis_OperatorId",
                table: "ComplicationsAfterProsthesis",
                column: "OperatorId");

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterProsthesis_ParentId",
                table: "ComplicationsAfterProsthesis",
                column: "ParentId");

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterProsthesisParents_PatientId",
                table: "ComplicationsAfterProsthesisParents",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterSurgeryParents_PatientId",
                table: "ComplicationsAfterSurgeryParents",
                column: "PatientId");

            migrationBuilder.AddForeignKey(
                name: "FK_ComplicationsAfterProsthesis_AspNetUsers_OperatorId",
                table: "ComplicationsAfterProsthesis",
                column: "OperatorId",
                principalTable: "AspNetUsers",
                principalColumn: "IdInt",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ComplicationsAfterProsthesis_ComplicationsAfterProsthesisPa~",
                table: "ComplicationsAfterProsthesis",
                column: "ParentId",
                principalTable: "ComplicationsAfterProsthesisParents",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ComplicationsAfterSurgery_AspNetUsers_OperatorId",
                table: "ComplicationsAfterSurgery",
                column: "OperatorId",
                principalTable: "AspNetUsers",
                principalColumn: "IdInt",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ComplicationsAfterSurgery_ComplicationsAfterSurgeryParents_~",
                table: "ComplicationsAfterSurgery",
                column: "ParentId",
                principalTable: "ComplicationsAfterSurgeryParents",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ComplicationsAfterProsthesis_AspNetUsers_OperatorId",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropForeignKey(
                name: "FK_ComplicationsAfterProsthesis_ComplicationsAfterProsthesisPa~",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropForeignKey(
                name: "FK_ComplicationsAfterSurgery_AspNetUsers_OperatorId",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropForeignKey(
                name: "FK_ComplicationsAfterSurgery_ComplicationsAfterSurgeryParents_~",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropTable(
                name: "ComplicationsAfterProsthesisParents");

            migrationBuilder.DropTable(
                name: "ComplicationsAfterSurgeryParents");

            migrationBuilder.DropIndex(
                name: "IX_ComplicationsAfterSurgery_OperatorId",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropIndex(
                name: "IX_ComplicationsAfterSurgery_ParentId",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropIndex(
                name: "IX_ComplicationsAfterProsthesis_OperatorId",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropIndex(
                name: "IX_ComplicationsAfterProsthesis_ParentId",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "Notes",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "OperatorId",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "ParentId",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "Tooth",
                table: "ComplicationsAfterSurgery");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "Notes",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "OperatorId",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "ParentId",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.DropColumn(
                name: "Tooth",
                table: "ComplicationsAfterProsthesis");

            migrationBuilder.AddColumn<bool>(
                name: "GBRFailure",
                table: "ComplicationsAfterSurgery",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "Numbness",
                table: "ComplicationsAfterSurgery",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "OpenWound",
                table: "ComplicationsAfterSurgery",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "OroantralCommunication",
                table: "ComplicationsAfterSurgery",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "PusInDonorSite",
                table: "ComplicationsAfterSurgery",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "PusInImplantSite",
                table: "ComplicationsAfterSurgery",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "SinusElevationFailure",
                table: "ComplicationsAfterSurgery",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "Swelling",
                table: "ComplicationsAfterSurgery",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CrownFall",
                table: "ComplicationsAfterProsthesis",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "FoodImpaction",
                table: "ComplicationsAfterProsthesis",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "FracturedPrintedPMMA",
                table: "ComplicationsAfterProsthesis",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "FracturedZirconia",
                table: "ComplicationsAfterProsthesis",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "Pain",
                table: "ComplicationsAfterProsthesis",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "ScrewLoosness",
                table: "ComplicationsAfterProsthesis",
                type: "boolean",
                nullable: false,
                defaultValue: false);
        }
    }
}
