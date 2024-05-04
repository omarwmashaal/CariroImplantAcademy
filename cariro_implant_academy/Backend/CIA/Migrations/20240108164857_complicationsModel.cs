using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class complicationsModel : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ComplicationsAfterProsthesis",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    ScrewLoosness = table.Column<bool>(type: "boolean", nullable: true),
                    CrownFall = table.Column<bool>(type: "boolean", nullable: true),
                    FracturedZirconia = table.Column<bool>(type: "boolean", nullable: true),
                    FracturedPrintedPMMA = table.Column<bool>(type: "boolean", nullable: true),
                    FoodImpaction = table.Column<bool>(type: "boolean", nullable: true),
                    Pain = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ComplicationsAfterProsthesis", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ComplicationsAfterProsthesis_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ComplicationsAfterSurgery",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Swelling = table.Column<bool>(type: "boolean", nullable: true),
                    OpenWound = table.Column<bool>(type: "boolean", nullable: true),
                    Numbness = table.Column<bool>(type: "boolean", nullable: true),
                    OroantralCommunication = table.Column<bool>(type: "boolean", nullable: true),
                    PusInImplantSite = table.Column<bool>(type: "boolean", nullable: true),
                    PusInDonorSite = table.Column<bool>(type: "boolean", nullable: true),
                    SinusElevationFailure = table.Column<bool>(type: "boolean", nullable: true),
                    GBRFailure = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ComplicationsAfterSurgery", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ComplicationsAfterSurgery_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterProsthesis_PatientId",
                table: "ComplicationsAfterProsthesis",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ComplicationsAfterSurgery_PatientId",
                table: "ComplicationsAfterSurgery",
                column: "PatientId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ComplicationsAfterProsthesis");

            migrationBuilder.DropTable(
                name: "ComplicationsAfterSurgery");
        }
    }
}
