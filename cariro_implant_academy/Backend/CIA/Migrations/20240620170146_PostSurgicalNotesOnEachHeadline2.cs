using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class PostSurgicalNotesOnEachHeadline2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.AddColumn<string>(
                name: "NotesGBR",
                table: "PostSurgeries",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NotesOSL",
                table: "PostSurgeries",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NotesSTG",
                table: "PostSurgeries",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NotesSuture",
                table: "PostSurgeries",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "NotesGBR",
                table: "PostSurgeries");

            migrationBuilder.DropColumn(
                name: "NotesOSL",
                table: "PostSurgeries");

            migrationBuilder.DropColumn(
                name: "NotesSTG",
                table: "PostSurgeries");

            migrationBuilder.DropColumn(
                name: "NotesSuture",
                table: "PostSurgeries");

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
    }
}
