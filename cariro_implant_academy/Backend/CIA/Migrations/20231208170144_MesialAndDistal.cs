using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class MesialAndDistal : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Contacts",
                table: "FinalProsthesisParentsTable",
                newName: "MesialContacts");

            migrationBuilder.AddColumn<int>(
                name: "DistalContacts",
                table: "FinalProsthesisParentsTable",
                type: "integer",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DistalContacts",
                table: "FinalProsthesisParentsTable");

            migrationBuilder.RenameColumn(
                name: "MesialContacts",
                table: "FinalProsthesisParentsTable",
                newName: "Contacts");
        }
    }
}
