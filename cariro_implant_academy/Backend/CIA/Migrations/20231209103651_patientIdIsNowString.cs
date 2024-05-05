using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class patientIdIsNowString : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.RenameColumn(
                name: "SecondaryId",
                table: "Patients",
                newName: "SecondaryIds");

            migrationBuilder.AddColumn<String>(
                name: "SecondaryId",
                table: "Patients",
                type: "text",
                nullable: true);
            migrationBuilder.Sql("Update \"Patients\"" +
                "Set \"SecondaryId\" = \"SecondaryIds\"");

            migrationBuilder.DropColumn(
                name: "SecondaryIds",
                table: "Patients");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "SecondaryId",
                table: "Patients",
                type: "integer",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);
        }
    }
}
