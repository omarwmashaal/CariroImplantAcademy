using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class AddNewPostheticSystemModifications : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "DiagnosticItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DiagnosticItems", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "FinalItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinalItems", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "DiagnosticNextVisitItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    DiagnosticItemId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DiagnosticNextVisitItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DiagnosticNextVisitItems_DiagnosticItems_DiagnosticItemId",
                        column: x => x.DiagnosticItemId,
                        principalTable: "DiagnosticItems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DiagnosticStatusItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    DiagnosticItemId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DiagnosticStatusItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DiagnosticStatusItems_DiagnosticItems_DiagnosticItemId",
                        column: x => x.DiagnosticItemId,
                        principalTable: "DiagnosticItems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "FinalNextVisitItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    FinalItemId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinalNextVisitItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FinalNextVisitItems_FinalItems_FinalItemId",
                        column: x => x.FinalItemId,
                        principalTable: "FinalItems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "FinalStatusItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    FinaltemId = table.Column<int>(type: "integer", nullable: false),
                    FinalItemId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinalStatusItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FinalStatusItems_FinalItems_FinalItemId",
                        column: x => x.FinalItemId,
                        principalTable: "FinalItems",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "DiagnosticSteps",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DiagnosticItemId = table.Column<int>(type: "integer", nullable: true),
                    DiagnosticStatusItemId = table.Column<int>(type: "integer", nullable: true),
                    DiagnosticNextVisitItemId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    NeedsRemake = table.Column<bool>(type: "boolean", nullable: true),
                    Scanned = table.Column<bool>(type: "boolean", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Index = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DiagnosticSteps", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DiagnosticSteps_AspNetUsers_OperatorId",
                        column: x => x.OperatorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DiagnosticSteps_DiagnosticItems_DiagnosticItemId",
                        column: x => x.DiagnosticItemId,
                        principalTable: "DiagnosticItems",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_DiagnosticSteps_DiagnosticNextVisitItems_DiagnosticNextVisi~",
                        column: x => x.DiagnosticNextVisitItemId,
                        principalTable: "DiagnosticNextVisitItems",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_DiagnosticSteps_DiagnosticStatusItems_DiagnosticStatusItemId",
                        column: x => x.DiagnosticStatusItemId,
                        principalTable: "DiagnosticStatusItems",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_DiagnosticSteps_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "FinalSteps",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Tooth = table.Column<int>(type: "integer", nullable: true),
                    Single = table.Column<bool>(type: "boolean", nullable: false),
                    Bridge = table.Column<bool>(type: "boolean", nullable: false),
                    FullArchUpper = table.Column<bool>(type: "boolean", nullable: false),
                    FullArchLower = table.Column<bool>(type: "boolean", nullable: false),
                    FinalItemId = table.Column<int>(type: "integer", nullable: true),
                    FinalStatusItemId = table.Column<int>(type: "integer", nullable: true),
                    FinalNextVisitItemId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    NeedsRemake = table.Column<bool>(type: "boolean", nullable: true),
                    Scanned = table.Column<bool>(type: "boolean", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Index = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinalSteps", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FinalSteps_AspNetUsers_OperatorId",
                        column: x => x.OperatorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_FinalSteps_FinalItems_FinalItemId",
                        column: x => x.FinalItemId,
                        principalTable: "FinalItems",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalSteps_FinalNextVisitItems_FinalNextVisitItemId",
                        column: x => x.FinalNextVisitItemId,
                        principalTable: "FinalNextVisitItems",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalSteps_FinalStatusItems_FinalStatusItemId",
                        column: x => x.FinalStatusItemId,
                        principalTable: "FinalStatusItems",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FinalSteps_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticNextVisitItems_DiagnosticItemId",
                table: "DiagnosticNextVisitItems",
                column: "DiagnosticItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticStatusItems_DiagnosticItemId",
                table: "DiagnosticStatusItems",
                column: "DiagnosticItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticSteps_DiagnosticItemId",
                table: "DiagnosticSteps",
                column: "DiagnosticItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticSteps_DiagnosticNextVisitItemId",
                table: "DiagnosticSteps",
                column: "DiagnosticNextVisitItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticSteps_DiagnosticStatusItemId",
                table: "DiagnosticSteps",
                column: "DiagnosticStatusItemId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticSteps_OperatorId",
                table: "DiagnosticSteps",
                column: "OperatorId");

            migrationBuilder.CreateIndex(
                name: "IX_DiagnosticSteps_PatientId",
                table: "DiagnosticSteps",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalNextVisitItems_FinalItemId",
                table: "FinalNextVisitItems",
                column: "FinalItemId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalStatusItems_FinalItemId",
                table: "FinalStatusItems",
                column: "FinalItemId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalSteps_FinalItemId",
                table: "FinalSteps",
                column: "FinalItemId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalSteps_FinalNextVisitItemId",
                table: "FinalSteps",
                column: "FinalNextVisitItemId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalSteps_FinalStatusItemId",
                table: "FinalSteps",
                column: "FinalStatusItemId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalSteps_OperatorId",
                table: "FinalSteps",
                column: "OperatorId");

            migrationBuilder.CreateIndex(
                name: "IX_FinalSteps_PatientId",
                table: "FinalSteps",
                column: "PatientId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DiagnosticSteps");

            migrationBuilder.DropTable(
                name: "FinalSteps");

            migrationBuilder.DropTable(
                name: "DiagnosticNextVisitItems");

            migrationBuilder.DropTable(
                name: "DiagnosticStatusItems");

            migrationBuilder.DropTable(
                name: "FinalNextVisitItems");

            migrationBuilder.DropTable(
                name: "FinalStatusItems");

            migrationBuilder.DropTable(
                name: "DiagnosticItems");

            migrationBuilder.DropTable(
                name: "FinalItems");
        }
    }
}
