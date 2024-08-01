using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class labrequestSourceToBeWebsite : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("Update \"Patients\" Set \"Website\" = 3 where \"Website\" = 1");
            migrationBuilder.Sql(@"
                                UPDATE ""Lab_Requests"" lr
                                SET ""Source"" = p.""Website""
                                FROM ""Patients"" p
                                WHERE lr.""PatientId"" = p.""Id"";
                                ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
