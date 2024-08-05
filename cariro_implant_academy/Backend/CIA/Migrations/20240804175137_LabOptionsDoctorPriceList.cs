using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class LabOptionsDoctorPriceList : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "LabDoctorPriceList",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DoctorId = table.Column<int>(type: "integer", nullable: false),
                    LabOptionId = table.Column<int>(type: "integer", nullable: false),
                    Price = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LabDoctorPriceList", x => x.Id);
                });
            migrationBuilder.Sql(@"INSERT INTO ""LabDoctorPriceList"" (""DoctorId"", ""LabOptionId"", ""Price"")
                SELECT 
                    au.""IdInt"" AS ""DoctorId"",
                    lo.""Id"" AS ""LabOptionId"",
                    lo.""Price""
                FROM 
                    ""AspNetUsers"" au, 
                    ""LabOptions"" lo;");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "LabDoctorPriceList");
        }
    }
}
