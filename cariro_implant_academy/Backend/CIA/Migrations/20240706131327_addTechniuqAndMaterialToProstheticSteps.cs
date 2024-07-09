using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class addTechniuqAndMaterialToProstheticSteps : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "FinalMaterialItemId",
                table: "FinalSteps",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FinalTechniqueItemId",
                table: "FinalSteps",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "DiagnosticMaterialItemId",
                table: "DiagnosticSteps",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "DiagnosticTechniqueItemId",
                table: "DiagnosticSteps",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "DiagnosticMaterialItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    DiagnosticItemId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DiagnosticMaterialItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DiagnosticMaterialItems_DiagnosticItems_DiagnosticItemId",
                        column: x => x.DiagnosticItemId,
                        principalTable: "DiagnosticItems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DiagnosticTechniqueItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    DiagnosticItemId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DiagnosticTechniqueItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DiagnosticTechniqueItems_DiagnosticItems_DiagnosticItemId",
                        column: x => x.DiagnosticItemId,
                        principalTable: "DiagnosticItems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "FinalMaterialItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    FinalItemId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinalMaterialItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FinalMaterialItems_FinalItems_FinalItemId",
                        column: x => x.FinalItemId,
                        principalTable: "FinalItems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "FinalTechniqueItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    FinalItemId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinalTechniqueItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FinalTechniqueItems_FinalItems_FinalItemId",
                        column: x => x.FinalItemId,
                        principalTable: "FinalItems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_FinalSteps_FinalMaterialItemId",
                table: "FinalSteps",
                column: "FinalMaterialItemId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalSteps_FinalTechniqueItemId",
                table: "FinalSteps",
                column: "FinalTechniqueItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticSteps_DiagnosticMaterialItemId",
                table: "DiagnosticSteps",
                column: "DiagnosticMaterialItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticSteps_DiagnosticTechniqueItemId",
                table: "DiagnosticSteps",
                column: "DiagnosticTechniqueItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticMaterialItems_DiagnosticItemId",
                table: "DiagnosticMaterialItems",
                column: "DiagnosticItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticTechniqueItems_DiagnosticItemId",
                table: "DiagnosticTechniqueItems",
                column: "DiagnosticItemId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalMaterialItems_FinalItemId",
                table: "FinalMaterialItems",
                column: "FinalItemId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalTechniqueItems_FinalItemId",
                table: "FinalTechniqueItems",
                column: "FinalItemId");

            migrationBuilder.AddForeignKey(
                name: "FK_DiagnosticSteps_DiagnosticMaterialItems_DiagnosticMaterialI~",
                table: "DiagnosticSteps",
                column: "DiagnosticMaterialItemId",
                principalTable: "DiagnosticMaterialItems",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_DiagnosticSteps_DiagnosticTechniqueItems_DiagnosticTechniqu~",
                table: "DiagnosticSteps",
                column: "DiagnosticTechniqueItemId",
                principalTable: "DiagnosticTechniqueItems",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_FinalSteps_FinalMaterialItems_FinalMaterialItemId",
                table: "FinalSteps",
                column: "FinalMaterialItemId",
                principalTable: "FinalMaterialItems",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_FinalSteps_FinalTechniqueItems_FinalTechniqueItemId",
                table: "FinalSteps",
                column: "FinalTechniqueItemId",
                principalTable: "FinalTechniqueItems",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DiagnosticSteps_DiagnosticMaterialItems_DiagnosticMaterialI~",
                table: "DiagnosticSteps");

            migrationBuilder.DropForeignKey(
                name: "FK_DiagnosticSteps_DiagnosticTechniqueItems_DiagnosticTechniqu~",
                table: "DiagnosticSteps");

            migrationBuilder.DropForeignKey(
                name: "FK_FinalSteps_FinalMaterialItems_FinalMaterialItemId",
                table: "FinalSteps");

            migrationBuilder.DropForeignKey(
                name: "FK_FinalSteps_FinalTechniqueItems_FinalTechniqueItemId",
                table: "FinalSteps");

            migrationBuilder.DropTable(
                name: "DiagnosticMaterialItems");

            migrationBuilder.DropTable(
                name: "DiagnosticTechniqueItems");

            migrationBuilder.DropTable(
                name: "FinalMaterialItems");

            migrationBuilder.DropTable(
                name: "FinalTechniqueItems");

            migrationBuilder.DropIndex(
                name: "IX_FinalSteps_FinalMaterialItemId",
                table: "FinalSteps");

            migrationBuilder.DropIndex(
                name: "IX_FinalSteps_FinalTechniqueItemId",
                table: "FinalSteps");

            migrationBuilder.DropIndex(
                name: "IX_DiagnosticSteps_DiagnosticMaterialItemId",
                table: "DiagnosticSteps");

            migrationBuilder.DropIndex(
                name: "IX_DiagnosticSteps_DiagnosticTechniqueItemId",
                table: "DiagnosticSteps");

            migrationBuilder.DropColumn(
                name: "FinalMaterialItemId",
                table: "FinalSteps");

            migrationBuilder.DropColumn(
                name: "FinalTechniqueItemId",
                table: "FinalSteps");

            migrationBuilder.DropColumn(
                name: "DiagnosticMaterialItemId",
                table: "DiagnosticSteps");

            migrationBuilder.DropColumn(
                name: "DiagnosticTechniqueItemId",
                table: "DiagnosticSteps");
        }
    }
}
