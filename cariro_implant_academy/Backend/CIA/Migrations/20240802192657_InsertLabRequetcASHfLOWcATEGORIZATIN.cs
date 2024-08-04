using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class InsertLabRequetcASHfLOWcATEGORIZATIN : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(
            @"INSERT INTO ""DropDowns"" (""Name"", ""Website"", ""Discriminator"")
            SELECT  'CIA Lab Request', 1, 'IncomeCategoriesModel'
            WHERE NOT EXISTS (
                SELECT 1 FROM ""DropDowns"" WHERE ""Name"" = 'CIA Lab Request'
            );

            INSERT INTO ""DropDowns"" (""Name"", ""Website"", ""Discriminator"")
            SELECT  'Clinic Lab Request', 1, 'IncomeCategoriesModel'
            WHERE NOT EXISTS (
                SELECT 1 FROM ""DropDowns"" WHERE ""Name"" = 'Clinic Lab Request'
            );

            INSERT INTO ""DropDowns"" (""Name"", ""Website"", ""Discriminator"")
            SELECT  'Private Lab Request', 1, 'IncomeCategoriesModel'
            WHERE NOT EXISTS (
                SELECT 1 FROM ""DropDowns"" WHERE ""Name"" = 'Private Lab Request'
            );
            ");

            migrationBuilder.Sql(@"
            Do $$
            Declare
	            ciaId INT := (Select ""Id"" From ""DropDowns"" Where ""Name""='CIA Lab Request');
	            clinicId INT := (Select ""Id"" From ""DropDowns"" Where ""Name""='Clinic Lab Request');
	            privateId INT := (Select ""Id"" From ""DropDowns"" Where ""Name""='Private Lab Request');
            Begin		
	            Update ""CashFlow"" cf 
	            Set ""CategoryId"" = CASE
		            WHEN lr.""Source"" = 0 THEN ciaId
		            WHEN lr.""Source"" = 1 THEN privateId
		            WHEN lr.""Source"" = 3 THEN privateId
		            WHEN lr.""Source"" = 2 THEN clinicId
		            ELSE cf.""CategoryId""
	            END
	            FROM ""Lab_Requests"" lr
	            where cf.""LabRequestId"" = lr.""Id"";
            END $$;
	

            ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
