using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class AddNotificationToHBA1CToMedicalExamination : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Notification_Hba1c",
                table: "Patients");

            migrationBuilder.AddColumn<DateTime>(
                name: "Notification_Hba1c",
                table: "MedicalExaminations",
                type: "timestamp with time zone",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Notification_Hba1c",
                table: "MedicalExaminations");

            migrationBuilder.AddColumn<DateTime>(
                name: "Notification_Hba1c",
                table: "Patients",
                type: "timestamp with time zone",
                nullable: true);
        }
    }
}
