using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class PostSurgicalNotesOnEachHeadline : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "NotesGBR",
                table: "SurgicalTreatments",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NotesOSL",
                table: "SurgicalTreatments",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NotesSTG",
                table: "SurgicalTreatments",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NotesSuture",
                table: "SurgicalTreatments",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "NotesGBR",
                table: "SurgicalTreatments");

            migrationBuilder.DropColumn(
                name: "NotesOSL",
                table: "SurgicalTreatments");

            migrationBuilder.DropColumn(
                name: "NotesSTG",
                table: "SurgicalTreatments");

            migrationBuilder.DropColumn(
                name: "NotesSuture",
                table: "SurgicalTreatments");
        }
    }
}
