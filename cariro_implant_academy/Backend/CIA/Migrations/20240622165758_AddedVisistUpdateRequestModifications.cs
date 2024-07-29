using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class AddedVisistUpdateRequestModifications : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
           
            migrationBuilder.RenameColumn(
                name: "VisitsLogIdUpdateRequest",
                table: "VisitsLogs",
                newName: "VisitsLogIdUpdateRequestId");

            migrationBuilder.AlterColumn<int>(
                name: "PatientID",
                table: "VisitsLogs",
                type: "integer",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "integer");

            migrationBuilder.AddColumn<int>(
                name: "EntryById",
                table: "VisitsLogs",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_VisitsLogs_EntryById",
                table: "VisitsLogs",
                column: "EntryById");

            migrationBuilder.AddForeignKey(
                name: "FK_VisitsLogs_AspNetUsers_EntryById",
                table: "VisitsLogs",
                column: "EntryById",
                principalTable: "AspNetUsers",
                principalColumn: "IdInt",
                onDelete: ReferentialAction.Cascade);

        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_VisitsLogs_AspNetUsers_EntryById",
                table: "VisitsLogs");

            migrationBuilder.DropForeignKey(
                name: "FK_VisitsLogs_Patients_PatientID",
                table: "VisitsLogs");

            migrationBuilder.DropIndex(
                name: "IX_VisitsLogs_EntryById",
                table: "VisitsLogs");

            migrationBuilder.DropColumn(
                name: "EntryById",
                table: "VisitsLogs");

            migrationBuilder.RenameColumn(
                name: "VisitsLogIdUpdateRequestId",
                table: "VisitsLogs",
                newName: "VisitsLogIdUpdateRequest");

            migrationBuilder.AlterColumn<int>(
                name: "PatientID",
                table: "VisitsLogs",
                type: "integer",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "integer",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_VisitsLogs_Patients_PatientID",
                table: "VisitsLogs",
                column: "PatientID",
                principalTable: "Patients",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
