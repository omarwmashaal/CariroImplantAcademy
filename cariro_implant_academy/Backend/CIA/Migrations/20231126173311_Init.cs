using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AspNetRoles",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    Name = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    NormalizedName = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ClinicPrices",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Category = table.Column<int>(type: "integer", nullable: false),
                    Price = table.Column<int>(type: "integer", nullable: false),
                    Tooth = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ClinicPrices", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "DropDowns",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Website = table.Column<int>(type: "integer", nullable: false),
                    Discriminator = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DropDowns", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Images",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Type = table.Column<int>(type: "integer", nullable: true),
                    Directory = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Images", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ImplantCompanies",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ImplantCompanies", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Lab_CustomerWorkPlaces",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lab_CustomerWorkPlaces", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Lab_DefaultSteps",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lab_DefaultSteps", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Lab_Files",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true),
                    Directory = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lab_Files", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "MembraneCompanies",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MembraneCompanies", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Rooms",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Color = table.Column<long>(type: "bigint", nullable: false),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rooms", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "TreatmentPrices",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Extraction = table.Column<int>(type: "integer", nullable: false),
                    Scaling = table.Column<int>(type: "integer", nullable: false),
                    Crown = table.Column<int>(type: "integer", nullable: false),
                    Restoration = table.Column<int>(type: "integer", nullable: false),
                    RootCanalTreatment = table.Column<int>(type: "integer", nullable: false),
                    Other = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TreatmentPrices", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "AspNetRoleClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    RoleId = table.Column<string>(type: "text", nullable: false),
                    ClaimType = table.Column<string>(type: "text", nullable: true),
                    ClaimValue = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoleClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetRoleClaims_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ImplantLines",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true),
                    ImplantCompanyId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ImplantLines", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ImplantLines_ImplantCompanies_ImplantCompanyId",
                        column: x => x.ImplantCompanyId,
                        principalTable: "ImplantCompanies",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "AspNetUsers",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: true),
                    DateOfBirth = table.Column<DateOnly>(type: "date", nullable: true),
                    Gender = table.Column<string>(type: "text", nullable: true),
                    PhoneNumber2 = table.Column<string>(type: "text", nullable: true),
                    GraduatedFrom = table.Column<string>(type: "text", nullable: true),
                    ClassYear = table.Column<string>(type: "text", nullable: true),
                    Speciality = table.Column<string>(type: "text", nullable: true),
                    MaritalStatus = table.Column<string>(type: "text", nullable: true),
                    Address = table.Column<string>(type: "text", nullable: true),
                    City = table.Column<string>(type: "text", nullable: true),
                    IdInt = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    RegisteredById = table.Column<int>(type: "integer", nullable: true),
                    RegisteredById1 = table.Column<string>(type: "text", nullable: true),
                    RegisterationDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: true),
                    WorkplaceId = table.Column<int>(type: "integer", nullable: true),
                    WorkPlaceEnum = table.Column<int>(type: "integer", nullable: true),
                    BatchId = table.Column<int>(type: "integer", nullable: true),
                    ProfileImageId = table.Column<int>(type: "integer", nullable: true),
                    UserName = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    NormalizedUserName = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    Email = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    NormalizedEmail = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    EmailConfirmed = table.Column<bool>(type: "boolean", nullable: false),
                    PasswordHash = table.Column<string>(type: "text", nullable: true),
                    SecurityStamp = table.Column<string>(type: "text", nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "text", nullable: true),
                    PhoneNumber = table.Column<string>(type: "text", nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(type: "boolean", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    LockoutEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUsers", x => x.Id);
                    table.UniqueConstraint("AK_AspNetUsers_IdInt", x => x.IdInt);
                    table.ForeignKey(
                        name: "FK_AspNetUsers_AspNetUsers_RegisteredById1",
                        column: x => x.RegisteredById1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_AspNetUsers_DropDowns_BatchId",
                        column: x => x.BatchId,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_AspNetUsers_Images_ProfileImageId",
                        column: x => x.ProfileImageId,
                        principalTable: "Images",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_AspNetUsers_Lab_CustomerWorkPlaces_WorkplaceId",
                        column: x => x.WorkplaceId,
                        principalTable: "Lab_CustomerWorkPlaces",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    UserId = table.Column<string>(type: "text", nullable: false),
                    ClaimType = table.Column<string>(type: "text", nullable: true),
                    ClaimValue = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetUserClaims_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserLogins",
                columns: table => new
                {
                    LoginProvider = table.Column<string>(type: "text", nullable: false),
                    ProviderKey = table.Column<string>(type: "text", nullable: false),
                    ProviderDisplayName = table.Column<string>(type: "text", nullable: true),
                    UserId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserLogins", x => new { x.LoginProvider, x.ProviderKey });
                    table.ForeignKey(
                        name: "FK_AspNetUserLogins_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserRoles",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "text", nullable: false),
                    RoleId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserRoles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserTokens",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "text", nullable: false),
                    LoginProvider = table.Column<string>(type: "text", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Value = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserTokens", x => new { x.UserId, x.LoginProvider, x.Name });
                    table.ForeignKey(
                        name: "FK_AspNetUserTokens_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ConnectionModel",
                columns: table => new
                {
                    ApplicationUserId = table.Column<string>(type: "text", nullable: false),
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    ConnectionId = table.Column<string>(type: "text", nullable: false),
                    isConnected = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ConnectionModel", x => new { x.ApplicationUserId, x.Id });
                    table.ForeignKey(
                        name: "FK_ConnectionModel_AspNetUsers_ApplicationUserId",
                        column: x => x.ApplicationUserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Notifications",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Title = table.Column<string>(type: "text", nullable: true),
                    Content = table.Column<string>(type: "text", nullable: true),
                    Read = table.Column<bool>(type: "boolean", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    InfoId = table.Column<int>(type: "integer", nullable: true),
                    Type = table.Column<int>(type: "integer", nullable: true),
                    UserId = table.Column<int>(type: "integer", nullable: true),
                    UserId1 = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Notifications", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Notifications_AspNetUsers_UserId1",
                        column: x => x.UserId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Patients",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    SecondaryId = table.Column<int>(type: "integer", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Out = table.Column<bool>(type: "boolean", nullable: false),
                    OutReason = table.Column<string>(type: "text", nullable: true),
                    Gender = table.Column<int>(type: "integer", nullable: true),
                    Phone = table.Column<string>(type: "text", nullable: true),
                    Phone2 = table.Column<string>(type: "text", nullable: true),
                    DateOfBirth = table.Column<DateOnly>(type: "date", nullable: true),
                    MaritalStatus = table.Column<string>(type: "text", nullable: true),
                    Address = table.Column<string>(type: "text", nullable: true),
                    City = table.Column<string>(type: "text", nullable: true),
                    PhotoDirectory = table.Column<string>(type: "text", nullable: true),
                    NationalID = table.Column<string>(type: "text", nullable: true),
                    NationalIDDirectoryfront = table.Column<string>(name: "NationalIDDirectory_front", type: "text", nullable: true),
                    NationalIDDirectoryback = table.Column<string>(name: "NationalIDDirectory_back", type: "text", nullable: true),
                    PatientType = table.Column<int>(type: "integer", nullable: true),
                    LabDateOfVisit = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    OperatorImplantNotes = table.Column<string>(type: "text", nullable: true),
                    RegisteredById = table.Column<int>(type: "integer", nullable: true),
                    RegisteredById1 = table.Column<string>(type: "text", nullable: true),
                    RegisterationDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    ReferralPatientID = table.Column<int>(type: "integer", nullable: true),
                    ReferralDoctorID = table.Column<int>(type: "integer", nullable: true),
                    ReferralDoctorId = table.Column<string>(type: "text", nullable: true),
                    RelativePatientID = table.Column<int>(type: "integer", nullable: true),
                    DoctorID = table.Column<int>(type: "integer", nullable: true),
                    DoctorId = table.Column<string>(type: "text", nullable: true),
                    ProfileImageId = table.Column<int>(type: "integer", nullable: true),
                    IdBackImageId = table.Column<int>(type: "integer", nullable: true),
                    IdFrontImageId = table.Column<int>(type: "integer", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Patients", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Patients_AspNetUsers_DoctorId",
                        column: x => x.DoctorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Patients_AspNetUsers_ReferralDoctorId",
                        column: x => x.ReferralDoctorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Patients_AspNetUsers_RegisteredById1",
                        column: x => x.RegisteredById1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Patients_Images_IdBackImageId",
                        column: x => x.IdBackImageId,
                        principalTable: "Images",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Patients_Images_IdFrontImageId",
                        column: x => x.IdFrontImageId,
                        principalTable: "Images",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Patients_Images_ProfileImageId",
                        column: x => x.ProfileImageId,
                        principalTable: "Images",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Patients_Patients_ReferralPatientID",
                        column: x => x.ReferralPatientID,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Patients_Patients_RelativePatientID",
                        column: x => x.RelativePatientID,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "StockLogs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Count = table.Column<int>(type: "integer", nullable: false),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    OperatorId = table.Column<int>(type: "integer", nullable: false),
                    OperatorId1 = table.Column<string>(type: "text", nullable: false),
                    Status = table.Column<string>(type: "text", nullable: false),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StockLogs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StockLogs_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CIA_Complains",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Comment = table.Column<string>(type: "text", nullable: true),
                    PatientID = table.Column<int>(type: "integer", nullable: true),
                    LastDoctorId = table.Column<int>(type: "integer", nullable: true),
                    LastDoctorId1 = table.Column<string>(type: "text", nullable: true),
                    LastSupervisorId = table.Column<int>(type: "integer", nullable: true),
                    LastSupervisorId1 = table.Column<string>(type: "text", nullable: true),
                    LastCandidateId = table.Column<int>(type: "integer", nullable: true),
                    LastCandidateId1 = table.Column<string>(type: "text", nullable: true),
                    MentionedDoctorId = table.Column<int>(type: "integer", nullable: true),
                    MentionedDoctorId1 = table.Column<string>(type: "text", nullable: true),
                    EntryById = table.Column<int>(type: "integer", nullable: true),
                    EntryById1 = table.Column<string>(type: "text", nullable: true),
                    EntryTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Status = table.Column<int>(type: "integer", nullable: true),
                    QueueNotes = table.Column<string>(type: "text", nullable: true),
                    ResolvedById = table.Column<int>(type: "integer", nullable: true),
                    ResolvedById1 = table.Column<string>(type: "text", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false),
                    Discriminator = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CIA_Complains", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CIA_Complains_AspNetUsers_EntryById1",
                        column: x => x.EntryById1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CIA_Complains_AspNetUsers_LastCandidateId1",
                        column: x => x.LastCandidateId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CIA_Complains_AspNetUsers_LastDoctorId1",
                        column: x => x.LastDoctorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CIA_Complains_AspNetUsers_LastSupervisorId1",
                        column: x => x.LastSupervisorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CIA_Complains_AspNetUsers_MentionedDoctorId1",
                        column: x => x.MentionedDoctorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CIA_Complains_AspNetUsers_ResolvedById1",
                        column: x => x.ResolvedById1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CIA_Complains_Patients_PatientID",
                        column: x => x.PatientID,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ClinicPatients",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ClinicPatients", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ClinicPatients_Patients_Id",
                        column: x => x.Id,
                        principalTable: "Patients",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DentalExaminations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    InterarchspaceRT = table.Column<int>(type: "integer", nullable: true),
                    InterarchspaceLT = table.Column<int>(type: "integer", nullable: true),
                    OralHygieneRating = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    OperatorImplantNotes = table.Column<string>(type: "text", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DentalExaminations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DentalExaminations_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_DentalExaminations_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "DentalHistories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    SenstiveHotCold = table.Column<bool>(type: "boolean", nullable: true),
                    SenstiveSweets = table.Column<bool>(type: "boolean", nullable: true),
                    BittingCheweing = table.Column<bool>(type: "boolean", nullable: true),
                    Clench = table.Column<string>(type: "text", nullable: true),
                    Smoke = table.Column<int>(type: "integer", nullable: true),
                    SmokingStatus = table.Column<int>(type: "integer", nullable: true),
                    SeriousInjury = table.Column<string>(type: "text", nullable: true),
                    Satisfied = table.Column<string>(type: "text", nullable: true),
                    CooperationScore = table.Column<int>(type: "integer", nullable: true),
                    WillingForImplantScore = table.Column<int>(type: "integer", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    HasChanges = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DentalHistories", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DentalHistories_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_DentalHistories_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Lab_Requests",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    DeliveryDate = table.Column<DateOnly>(type: "date", nullable: true),
                    EntryById = table.Column<int>(type: "integer", nullable: true),
                    EntryById1 = table.Column<string>(type: "text", nullable: true),
                    AssignedToId = table.Column<int>(type: "integer", nullable: true),
                    AssignedToId1 = table.Column<string>(type: "text", nullable: true),
                    Source = table.Column<int>(type: "integer", nullable: true),
                    CustomerId = table.Column<int>(type: "integer", nullable: true),
                    CustomerId1 = table.Column<string>(type: "text", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    Status = table.Column<int>(type: "integer", nullable: true),
                    Paid = table.Column<bool>(type: "boolean", nullable: true),
                    Cost = table.Column<int>(type: "integer", nullable: true),
                    PaidAmount = table.Column<int>(type: "integer", nullable: true),
                    Notes = table.Column<string>(type: "text", nullable: true),
                    RequiredStep = table.Column<string>(type: "text", nullable: true),
                    FileId = table.Column<int>(type: "integer", nullable: true),
                    Teeth = table.Column<List<int>>(type: "integer[]", nullable: true),
                    InitStatus = table.Column<int>(type: "integer", nullable: true),
                    Fullzireoncrown = table.Column<bool>(name: "Full_zireon_crown", type: "boolean", nullable: true),
                    Porcelainfusedtozircomium = table.Column<bool>(name: "Porcelain_fused_to_zircomium", type: "boolean", nullable: true),
                    Porcelainfusedtometal = table.Column<bool>(name: "Porcelain_fused_to_metal", type: "boolean", nullable: true),
                    PorcelainfusedtometalCADCAMCoCralloy = table.Column<bool>(name: "Porcelain_fused_to_metal_CAD_CAM_Co_Cr_alloy", type: "boolean", nullable: true),
                    Glassceramiccrown = table.Column<bool>(name: "Glass_ceramic_crown", type: "boolean", nullable: true),
                    VisiolignbondedtoPEEK = table.Column<bool>(name: "Visiolign_bonded_to_PEEK", type: "boolean", nullable: true),
                    Laminateveneer = table.Column<bool>(name: "Laminate_veneer", type: "boolean", nullable: true),
                    MilledPMMAtemporarycrown = table.Column<bool>(name: "Milled_PMMA_temporary_crown", type: "boolean", nullable: true),
                    Longtermtemporarycrown = table.Column<bool>(name: "Long_term_temporary_crown", type: "boolean", nullable: true),
                    Screwratainedcrown = table.Column<bool>(name: "Screw_ratained_crown", type: "boolean", nullable: true),
                    SurveycrownforRPD = table.Column<bool>(name: "Survey_crown_for_RPD", type: "boolean", nullable: true),
                    Surveycrownwithextracoronalattahcment = table.Column<bool>(name: "Survey_crown_with_extra_coronal_attahcment", type: "boolean", nullable: true),
                    Castpostcore = table.Column<bool>(name: "Cast_postcore", type: "boolean", nullable: true),
                    Zirconiumpostandcore = table.Column<bool>(name: "Zirconium_post_and_core", type: "boolean", nullable: true),
                    Customcarbonfiberpost = table.Column<bool>(name: "Custom_carbon_fiber_post", type: "boolean", nullable: true),
                    Zirconiuminlayoronlay = table.Column<bool>(name: "Zirconium_inlay_or_onlay", type: "boolean", nullable: true),
                    Glassceramicinlayoronlay = table.Column<bool>(name: "Glass_ceramic_inlay_or_onlay", type: "boolean", nullable: true),
                    CADCAMabutment = table.Column<bool>(name: "CAD_CAM_abutment", type: "boolean", nullable: true),
                    Specialtray = table.Column<bool>(name: "Special_tray", type: "boolean", nullable: true),
                    Occlusionblock = table.Column<bool>(name: "Occlusion_block", type: "boolean", nullable: true),
                    Diagnosticortrailsetup = table.Column<bool>(name: "Diagnostic_or_trail_setup", type: "boolean", nullable: true),
                    FlexibleRPD = table.Column<bool>(name: "Flexible_RPD", type: "boolean", nullable: true),
                    MetallicRPD = table.Column<bool>(name: "Metallic_RPD", type: "boolean", nullable: true),
                    Nightguardvacuumtemplate = table.Column<bool>(name: "Night_guard_vacuum_template", type: "boolean", nullable: true),
                    RadiographicduplicatesforCBCT = table.Column<bool>(name: "Radiographic_duplicates_for_CBCT", type: "boolean", nullable: true),
                    Clearsurgicaltemplates = table.Column<bool>(name: "Clear_surgical_templates", type: "boolean", nullable: true),
                    Diagnosticsurveying = table.Column<bool>(name: "Diagnostic_surveying", type: "boolean", nullable: true),
                    LabRequest = table.Column<int>(name: "Lab_Request", type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lab_Requests", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Lab_Requests_AspNetUsers_AssignedToId1",
                        column: x => x.AssignedToId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Lab_Requests_AspNetUsers_CustomerId1",
                        column: x => x.CustomerId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Lab_Requests_AspNetUsers_EntryById1",
                        column: x => x.EntryById1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Lab_Requests_Lab_Files_FileId",
                        column: x => x.FileId,
                        principalTable: "Lab_Files",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Lab_Requests_Patients_Lab_Request",
                        column: x => x.LabRequest,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Lab_Requests_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "MedicalExaminations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    GeneralHealth = table.Column<int>(type: "integer", nullable: true),
                    PregnancyStatus = table.Column<int>(type: "integer", nullable: true),
                    AreYouTreatedFromAnyThing = table.Column<string>(type: "text", nullable: true),
                    RecentSurgery = table.Column<string>(type: "text", nullable: true),
                    Comment = table.Column<string>(type: "text", nullable: true),
                    Diseases = table.Column<int[]>(type: "integer[]", nullable: true),
                    OtherDiseases = table.Column<string>(type: "text", nullable: true),
                    BloodPressureLastReading = table.Column<string>(name: "BloodPressure_LastReading", type: "text", nullable: true),
                    BloodPressureWhen = table.Column<DateOnly>(name: "BloodPressure_When", type: "date", nullable: true),
                    BloodPressureDrug = table.Column<string>(name: "BloodPressure_Drug", type: "text", nullable: true),
                    BloodPressureReadingInClinic = table.Column<string>(name: "BloodPressure_ReadingInClinic", type: "text", nullable: true),
                    BloodPressureStatus = table.Column<int>(name: "BloodPressure_Status", type: "integer", nullable: true),
                    DiabeticLastReading = table.Column<int>(name: "Diabetic_LastReading", type: "integer", nullable: true),
                    DiabeticWhen = table.Column<DateOnly>(name: "Diabetic_When", type: "date", nullable: true),
                    DiabeticRandomInClinic = table.Column<int>(name: "Diabetic_RandomInClinic", type: "integer", nullable: true),
                    DiabeticStatus = table.Column<int>(name: "Diabetic_Status", type: "integer", nullable: true),
                    DiabeticType = table.Column<int>(name: "Diabetic_Type", type: "integer", nullable: true),
                    Penicillin = table.Column<bool>(type: "boolean", nullable: true),
                    Sulfa = table.Column<bool>(type: "boolean", nullable: true),
                    OtherAllergy = table.Column<bool>(type: "boolean", nullable: true),
                    OtherAllergyComment = table.Column<string>(type: "text", nullable: true),
                    ProlongedBleedingOrAspirin = table.Column<bool>(type: "boolean", nullable: true),
                    ChronicDigestion = table.Column<bool>(type: "boolean", nullable: true),
                    IllegalDrugs = table.Column<string>(type: "text", nullable: true),
                    OperatorComments = table.Column<string>(type: "text", nullable: true),
                    DrugsTaken = table.Column<List<string>>(type: "text[]", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    HasChanges = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MedicalExaminations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_MedicalExaminations_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_MedicalExaminations_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "NonSurgicalTreatment",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Treatment = table.Column<string>(type: "text", nullable: true),
                    OperatorID = table.Column<int>(type: "integer", nullable: true),
                    OperatorId = table.Column<string>(type: "text", nullable: true),
                    SupervisorID = table.Column<int>(type: "integer", nullable: true),
                    SupervisorId = table.Column<string>(type: "text", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    NextVisit = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    HasChanges = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NonSurgicalTreatment", x => x.Id);
                    table.ForeignKey(
                        name: "FK_NonSurgicalTreatment_AspNetUsers_OperatorId",
                        column: x => x.OperatorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_NonSurgicalTreatment_AspNetUsers_SupervisorId",
                        column: x => x.SupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_NonSurgicalTreatment_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "OutSourcePatients",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OutSourcePatients", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OutSourcePatients_Patients_Id",
                        column: x => x.Id,
                        principalTable: "Patients",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProstheticTreatments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeTeeth = table.Column<List<int>>(type: "integer[]", nullable: true),
                    FinalProthesisSingleBridgeHealingCollar = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisSingleBridgeHealingCollarStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeHealingCollarNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeHealingCollarDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProthesisSingleBridgeImpression = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisSingleBridgeImpressionStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeImpressionNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeImpressionDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProthesisSingleBridgeTryIn = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisSingleBridgeTryInStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeTryInNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeTryInDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProthesisSingleBridgeDelivery = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisSingleBridgeDeliveryStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeDeliveryNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisSingleBridgeDeliveryDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProthesisFullArchHealingCollar = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisFullArchHealingCollarStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisFullArchHealingCollarNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisFullArchHealingCollarDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProthesisFullArchImpression = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisFullArchImpressionStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisFullArchImpressionNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisFullArchImpressionDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProthesisFullArchTryIn = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisFullArchTryInStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisFullArchTryInNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisFullArchTryInDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FinalProthesisFullArchDelivery = table.Column<bool>(type: "boolean", nullable: true),
                    FinalProthesisFullArchDeliveryStatus = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisFullArchDeliveryNextVisit = table.Column<int>(type: "integer", nullable: true),
                    FinalProthesisFullArchDeliveryDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProstheticTreatments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "TreatmentPlans",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TreatmentPlans", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TreatmentPlans_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlans_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "VisitsLogs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientID = table.Column<int>(type: "integer", nullable: false),
                    Status = table.Column<int>(type: "integer", nullable: true),
                    ReservationTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    RealVisitTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    EntersClinicTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    From = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    To = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Duration = table.Column<TimeSpan>(type: "interval", nullable: true),
                    Title = table.Column<string>(type: "text", nullable: true),
                    RoomId = table.Column<int>(type: "integer", nullable: true),
                    LeaveTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    DoctorID = table.Column<int>(type: "integer", nullable: true),
                    DoctorId = table.Column<string>(type: "text", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VisitsLogs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_VisitsLogs_AspNetUsers_DoctorId",
                        column: x => x.DoctorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_VisitsLogs_Patients_PatientID",
                        column: x => x.PatientID,
                        principalTable: "Patients",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_VisitsLogs_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalTable: "Rooms",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "DentalExamination",
                columns: table => new
                {
                    DentalExaminationModelId = table.Column<int>(type: "integer", nullable: false),
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Tooth = table.Column<int>(type: "integer", nullable: true),
                    Carious = table.Column<bool>(type: "boolean", nullable: true),
                    Filled = table.Column<bool>(type: "boolean", nullable: true),
                    Missed = table.Column<bool>(type: "boolean", nullable: true),
                    NotSure = table.Column<bool>(type: "boolean", nullable: true),
                    MobilityI = table.Column<bool>(type: "boolean", nullable: true),
                    MobilityII = table.Column<bool>(type: "boolean", nullable: true),
                    MobilityIII = table.Column<bool>(type: "boolean", nullable: true),
                    Hopelessteeth = table.Column<bool>(type: "boolean", nullable: true),
                    ImplantPlaced = table.Column<bool>(type: "boolean", nullable: true),
                    ImplantFailed = table.Column<bool>(type: "boolean", nullable: true),
                    PreviousState = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DentalExamination", x => new { x.DentalExaminationModelId, x.Id });
                    table.ForeignKey(
                        name: "FK_DentalExamination_DentalExaminations_DentalExaminationModel~",
                        column: x => x.DentalExaminationModelId,
                        principalTable: "DentalExaminations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Lab_RequestSteps",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    index = table.Column<int>(type: "integer", nullable: true),
                    StepId = table.Column<int>(type: "integer", nullable: true),
                    TechnicianId = table.Column<int>(type: "integer", nullable: true),
                    TechnicianId1 = table.Column<string>(type: "text", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Status = table.Column<int>(type: "integer", nullable: true),
                    RequestId = table.Column<int>(type: "integer", nullable: true),
                    LabRequestStep = table.Column<int>(name: "Lab_RequestStep", type: "integer", nullable: true),
                    Price = table.Column<int>(type: "integer", nullable: true),
                    Notes = table.Column<string>(type: "text", nullable: true),
                    AskForStepUserId = table.Column<int>(type: "integer", nullable: true),
                    AskForStepUserId1 = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lab_RequestSteps", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Lab_RequestSteps_AspNetUsers_AskForStepUserId1",
                        column: x => x.AskForStepUserId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Lab_RequestSteps_AspNetUsers_TechnicianId1",
                        column: x => x.TechnicianId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Lab_RequestSteps_Lab_DefaultSteps_StepId",
                        column: x => x.StepId,
                        principalTable: "Lab_DefaultSteps",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Lab_RequestSteps_Lab_Requests_Lab_RequestStep",
                        column: x => x.LabRequestStep,
                        principalTable: "Lab_Requests",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Receipts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    Total = table.Column<int>(type: "integer", nullable: false),
                    Paid = table.Column<int>(type: "integer", nullable: false),
                    Unpaid = table.Column<int>(type: "integer", nullable: false),
                    RequestId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Receipts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Receipts_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Receipts_Lab_Requests_RequestId",
                        column: x => x.RequestId,
                        principalTable: "Lab_Requests",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Receipts_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "HBA1cModel",
                columns: table => new
                {
                    MedicalExaminationModelId = table.Column<int>(type: "integer", nullable: false),
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Date = table.Column<DateOnly>(type: "date", nullable: true),
                    Reading = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HBA1cModel", x => new { x.MedicalExaminationModelId, x.Id });
                    table.ForeignKey(
                        name: "FK_HBA1cModel_MedicalExaminations_MedicalExaminationModelId",
                        column: x => x.MedicalExaminationModelId,
                        principalTable: "MedicalExaminations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProstheticTreatments_Bite",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Diagnostic = table.Column<int>(type: "integer", nullable: true),
                    NextStep = table.Column<int>(type: "integer", nullable: true),
                    ProstheticTreatmentId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    NeedsRemake = table.Column<bool>(type: "boolean", nullable: true),
                    Scanned = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProstheticTreatments_Bite", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_Bite_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_Bite_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_Bite_ProstheticTreatments_ProstheticTr~",
                        column: x => x.ProstheticTreatmentId,
                        principalTable: "ProstheticTreatments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProstheticTreatments_DiagnosticImpression",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Diagnostic = table.Column<int>(type: "integer", nullable: true),
                    NextStep = table.Column<int>(type: "integer", nullable: true),
                    ProstheticTreatmentId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    NeedsRemake = table.Column<bool>(type: "boolean", nullable: true),
                    Scanned = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProstheticTreatments_DiagnosticImpression", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_DiagnosticImpression_AspNetUsers_Opera~",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_DiagnosticImpression_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                        column: x => x.ProstheticTreatmentId,
                        principalTable: "ProstheticTreatments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProstheticTreatments_ScanAppliance",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Diagnostic = table.Column<int>(type: "integer", nullable: true),
                    ProstheticTreatmentId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    OperatorId = table.Column<int>(type: "integer", nullable: true),
                    OperatorId1 = table.Column<string>(type: "text", nullable: true),
                    NeedsRemake = table.Column<bool>(type: "boolean", nullable: true),
                    Scanned = table.Column<bool>(type: "boolean", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProstheticTreatments_ScanAppliance", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_ScanAppliance_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_ScanAppliance_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProstheticTreatments_ScanAppliance_ProstheticTreatments_Pro~",
                        column: x => x.ProstheticTreatmentId,
                        principalTable: "ProstheticTreatments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "PaymentLogs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    OperatorId = table.Column<int>(type: "integer", nullable: false),
                    OperatorId1 = table.Column<string>(type: "text", nullable: false),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    ReceiptId = table.Column<int>(type: "integer", nullable: false),
                    PaidAmount = table.Column<int>(type: "integer", nullable: false),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PaymentLogs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PaymentLogs_AspNetUsers_OperatorId1",
                        column: x => x.OperatorId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PaymentLogs_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PaymentLogs_Receipts_ReceiptId",
                        column: x => x.ReceiptId,
                        principalTable: "Receipts",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ToothReceiptData",
                columns: table => new
                {
                    ReceiptId = table.Column<int>(type: "integer", nullable: false),
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Tooth = table.Column<int>(type: "integer", nullable: false),
                    Crown = table.Column<int>(type: "integer", nullable: false),
                    Scaling = table.Column<int>(type: "integer", nullable: false),
                    Restoration = table.Column<int>(type: "integer", nullable: false),
                    RootCanalTreatment = table.Column<int>(type: "integer", nullable: false),
                    Extraction = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ToothReceiptData", x => new { x.ReceiptId, x.Id });
                    table.ForeignKey(
                        name: "FK_ToothReceiptData_Receipts_ReceiptId",
                        column: x => x.ReceiptId,
                        principalTable: "Receipts",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CashFlow",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    ReceiptID = table.Column<int>(type: "integer", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Name = table.Column<string>(type: "text", nullable: true),
                    CategoryId = table.Column<int>(type: "integer", nullable: true),
                    SupplierId = table.Column<int>(type: "integer", nullable: true),
                    CreatedById = table.Column<int>(type: "integer", nullable: true),
                    CreatedById1 = table.Column<string>(type: "text", nullable: true),
                    Price = table.Column<int>(type: "integer", nullable: true),
                    PaymentMethodId = table.Column<int>(type: "integer", nullable: true),
                    Notes = table.Column<string>(type: "text", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    PaymentLogId = table.Column<int>(type: "integer", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false),
                    Discriminator = table.Column<string>(type: "text", nullable: false),
                    LabRequestId = table.Column<int>(type: "integer", nullable: true),
                    Count = table.Column<int>(type: "integer", nullable: true),
                    Size = table.Column<string>(type: "text", nullable: true),
                    ImplantLineId = table.Column<int>(type: "integer", nullable: true),
                    MembraneCompnayId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CashFlow", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CashFlow_AspNetUsers_CreatedById1",
                        column: x => x.CreatedById1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_DropDowns_CategoryId",
                        column: x => x.CategoryId,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_DropDowns_PaymentMethodId",
                        column: x => x.PaymentMethodId,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_DropDowns_SupplierId",
                        column: x => x.SupplierId,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_ImplantLines_ImplantLineId",
                        column: x => x.ImplantLineId,
                        principalTable: "ImplantLines",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_Lab_Requests_LabRequestId",
                        column: x => x.LabRequestId,
                        principalTable: "Lab_Requests",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_MembraneCompanies_MembraneCompnayId",
                        column: x => x.MembraneCompnayId,
                        principalTable: "MembraneCompanies",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_PaymentLogs_PaymentLogId",
                        column: x => x.PaymentLogId,
                        principalTable: "PaymentLogs",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CashFlow_Receipts_ReceiptID",
                        column: x => x.ReceiptID,
                        principalTable: "Receipts",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "CandidateDetails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    CandidateId = table.Column<int>(type: "integer", nullable: true),
                    CandidateId1 = table.Column<string>(type: "text", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Procedure = table.Column<string>(type: "text", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    Tooth = table.Column<int>(type: "integer", nullable: true),
                    ImplantId = table.Column<int>(type: "integer", nullable: true),
                    ImplantCount = table.Column<int>(type: "integer", nullable: true),
                    OtherProcedures = table.Column<List<string>>(type: "text[]", nullable: true),
                    TotalImplantCount = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CandidateDetails", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CandidateDetails_AspNetUsers_CandidateId1",
                        column: x => x.CandidateId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CandidateDetails_CashFlow_ImplantId",
                        column: x => x.ImplantId,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CandidateDetails_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ClinicTreatmentParent",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    Tooth = table.Column<int>(type: "integer", nullable: false),
                    Done = table.Column<bool>(type: "boolean", nullable: false),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    AssistantId = table.Column<int>(type: "integer", nullable: true),
                    DoctorId = table.Column<int>(type: "integer", nullable: true),
                    Price = table.Column<int>(type: "integer", nullable: true),
                    Notes = table.Column<string>(type: "text", nullable: true),
                    Discriminator = table.Column<string>(type: "text", nullable: false),
                    Type = table.Column<int>(type: "integer", nullable: true),
                    ImplantId = table.Column<int>(type: "integer", nullable: true),
                    ImplantCompanyId = table.Column<int>(type: "integer", nullable: true),
                    ImplantLineId = table.Column<int>(type: "integer", nullable: true),
                    FirstStep = table.Column<int>(type: "integer", nullable: true),
                    SecondStep = table.Column<int>(type: "integer", nullable: true),
                    SecondStepPrice = table.Column<int>(type: "integer", nullable: true),
                    FirstStepPrice = table.Column<int>(type: "integer", nullable: true),
                    RestorationType = table.Column<int>(name: "Restoration_Type", type: "integer", nullable: true),
                    Status = table.Column<int>(type: "integer", nullable: true),
                    Class = table.Column<int>(type: "integer", nullable: true),
                    StatusPrice = table.Column<int>(type: "integer", nullable: true),
                    TypePrice = table.Column<int>(type: "integer", nullable: true),
                    ClassPrice = table.Column<int>(type: "integer", nullable: true),
                    CanalNumber = table.Column<int>(type: "integer", nullable: true),
                    RootCanalTreatmentType = table.Column<int>(name: "RootCanalTreatment_Type", type: "integer", nullable: true),
                    Length = table.Column<int>(type: "integer", nullable: true),
                    StepNumber = table.Column<int>(type: "integer", nullable: true),
                    ScalingType = table.Column<int>(name: "Scaling_Type", type: "integer", nullable: true),
                    TMDStepNumber = table.Column<int>(name: "TMD_StepNumber", type: "integer", nullable: true),
                    TMDType = table.Column<int>(name: "TMD_Type", type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ClinicTreatmentParent", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ClinicTreatmentParent_AspNetUsers_AssistantId",
                        column: x => x.AssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ClinicTreatmentParent_AspNetUsers_DoctorId",
                        column: x => x.DoctorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ClinicTreatmentParent_CashFlow_ImplantId",
                        column: x => x.ImplantId,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicTreatmentParent_ImplantCompanies_ImplantCompanyId",
                        column: x => x.ImplantCompanyId,
                        principalTable: "ImplantCompanies",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicTreatmentParent_ImplantLines_ImplantLineId",
                        column: x => x.ImplantLineId,
                        principalTable: "ImplantLines",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicTreatmentParent_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SurgicalTreatments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    GuidedBoneRegeneration = table.Column<bool>(type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraft = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftChin = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Chin", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftRamus = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Ramus", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftTuberosity = table.Column<bool>(name: "GuidedBoneRegeneration_BlockGraft_Tuberosity", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBlockGraftOther = table.Column<string>(name: "GuidedBoneRegeneration_BlockGraft_Other", type: "text", nullable: true),
                    GuidedBoneRegenerationCutBy = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByDisc = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Disc", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByPiezo = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Piezo", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByScrews = table.Column<bool>(name: "GuidedBoneRegeneration_CutBy_Screws", type: "boolean", nullable: true),
                    GuidedBoneRegenerationCutByScrewsNumber = table.Column<int>(name: "GuidedBoneRegeneration_CutBy_ScrewsNumber", type: "integer", nullable: true),
                    GuidedBoneRegenerationBoneParticle = table.Column<bool>(name: "GuidedBoneRegeneration_BoneParticle", type: "boolean", nullable: true),
                    GuidedBoneRegenerationBoneParticle100Autogenous = table.Column<int>(name: "GuidedBoneRegeneration_BoneParticle_100Autogenous", type: "integer", nullable: true),
                    GuidedBoneRegenerationBoneParticle100Xenograft = table.Column<int>(name: "GuidedBoneRegeneration_BoneParticle_100Xenograft", type: "integer", nullable: true),
                    GuidedBoneRegenerationACMBur = table.Column<bool>(name: "GuidedBoneRegeneration_ACMBur", type: "boolean", nullable: true),
                    GuidedBoneRegenerationACMBurArea = table.Column<string>(name: "GuidedBoneRegeneration_ACMBur_Area", type: "text", nullable: true),
                    GuidedBoneRegenerationACMBurNotes = table.Column<string>(name: "GuidedBoneRegeneration_ACMBur_Notes", type: "text", nullable: true),
                    OpenSinusLift = table.Column<bool>(type: "boolean", nullable: true),
                    OpenSinusLiftApproach = table.Column<bool>(name: "OpenSinusLift_Approach", type: "boolean", nullable: true),
                    OpenSinusLiftApproachString = table.Column<string>(name: "OpenSinusLift_Approach_String", type: "text", nullable: true),
                    OpenSinusLiftFillMaterial = table.Column<bool>(name: "OpenSinusLift_FillMaterial", type: "boolean", nullable: true),
                    OpenSinusLiftFillMaterialString = table.Column<string>(name: "OpenSinusLift_FillMaterial_String", type: "text", nullable: true),
                    OpenSinusLiftMembraneID = table.Column<int>(name: "OpenSinusLift_MembraneID", type: "integer", nullable: true),
                    OpenSinusLiftMembraneCompanyID = table.Column<int>(name: "OpenSinusLift_Membrane_CompanyID", type: "integer", nullable: true),
                    OpenSinusLiftTacsNumber = table.Column<int>(type: "integer", nullable: true),
                    OpenSinusLiftTacsCompanyID = table.Column<int>(name: "OpenSinusLift_TacsCompanyID", type: "integer", nullable: true),
                    SoftTissueGraft = table.Column<bool>(type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryType = table.Column<bool>(name: "SoftTissueGraft_SurgeryType", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeSoftTissueGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_SoftTissueGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeAdvanced = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_Advanced", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeFreeGinivalGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_FreeGinivalGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeConnectiveTissueGraft = table.Column<bool>(name: "SoftTissueGraft_SurgeryType_ConnectiveTissueGraft", type: "boolean", nullable: true),
                    SoftTissueGraftSurgeryTypeSurgeryTechnique = table.Column<string>(name: "SoftTissueGraft_SurgeryType_SurgeryTechnique", type: "text", nullable: true),
                    SoftTissueGraftExposure = table.Column<bool>(name: "SoftTissueGraft_Exposure", type: "boolean", nullable: true),
                    SoftTissueGraftExposureCustomizedHealingCollarTeethNumber = table.Column<string>(name: "SoftTissueGraft_Exposure_CustomizedHealingCollarTeethNumber", type: "text", nullable: true),
                    SoftTissueGraftDonorSite = table.Column<bool>(name: "SoftTissueGraft_DonorSite", type: "boolean", nullable: true),
                    SoftTissueGraftDonorSiteNotes = table.Column<string>(name: "SoftTissueGraft_DonorSite_Notes", type: "text", nullable: true),
                    SoftTissueGraftSuture = table.Column<bool>(name: "SoftTissueGraft_Suture", type: "boolean", nullable: true),
                    SoftTissueGraftSutureMaterial = table.Column<string>(name: "SoftTissueGraft_Suture_Material", type: "text", nullable: true),
                    SoftTissueGraftSutureTechnique = table.Column<string>(name: "SoftTissueGraft_Suture_Technique", type: "text", nullable: true),
                    SoftTissueGraftSuturePackType = table.Column<string>(name: "SoftTissueGraft_Suture_PackType", type: "text", nullable: true),
                    SoftTissueGraftRecipientSite = table.Column<bool>(name: "SoftTissueGraft_RecipientSite", type: "boolean", nullable: true),
                    SoftTissueGraftRecipientSiteArea = table.Column<string>(name: "SoftTissueGraft_RecipientSite_Area", type: "text", nullable: true),
                    SoftTissueGraftAugmentation = table.Column<bool>(name: "SoftTissueGraft_Augmentation", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationBuccal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Buccal", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationCrestal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Crestal", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationLingual = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Lingual", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationMesial = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Mesial", type: "boolean", nullable: true),
                    SoftTissueGraftAugmentationDistal = table.Column<bool>(name: "SoftTissueGraft_Augmentation_Distal", type: "boolean", nullable: true),
                    SoftTissueGraftFrenectomy = table.Column<bool>(name: "SoftTissueGraft_Frenectomy", type: "boolean", nullable: true),
                    SoftTissueGraftFrenectomyNotes = table.Column<string>(name: "SoftTissueGraft_Frenectomy_Notes", type: "text", nullable: true),
                    SoftTissueGraftBoneGraft = table.Column<bool>(name: "SoftTissueGraft_BoneGraft", type: "boolean", nullable: true),
                    SoftTissueGraftBoneGraftNotes = table.Column<string>(name: "SoftTissueGraft_BoneGraft_Notes", type: "text", nullable: true),
                    SutureAndTemporizationAndXRay = table.Column<bool>(type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize30 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_3_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize40 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_4_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize50 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_5_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize60 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_6_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSize70 = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_7_0", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = table.Column<bool>(name: "SutureAndTemporizationAndXRay_SutureSize_ImplantSubcrestal", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterial = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialVicryl = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_Vicryl", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialProline = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_Proline", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialXRay = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Material_XRay", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayMaterialSutureTechnique = table.Column<string>(name: "SutureAndTemporizationAndXRay_Material_SutureTechnique", type: "text", nullable: true),
                    SutureAndTemporizationAndXRayTemporary = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryHealingCollar = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_HealingCollar", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryCustomizedHeallingColl = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_CustomizedHeallingColl~", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryCrown = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_Crown", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryMarylandBridge = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_MarylandBridge", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryBridgeOnTeeth = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_BridgeOnTeeth", type: "boolean", nullable: true),
                    SutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber = table.Column<bool>(name: "SutureAndTemporizationAndXRay_Temporary_DentureWithGlassFiber", type: "boolean", nullable: true),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SurgicalTreatments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SurgicalTreatments_CashFlow_OpenSinusLift_MembraneID",
                        column: x => x.OpenSinusLiftMembraneID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_SurgicalTreatments_CashFlow_OpenSinusLift_TacsCompanyID",
                        column: x => x.OpenSinusLiftTacsCompanyID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_SurgicalTreatments_MembraneCompanies_OpenSinusLift_Membrane~",
                        column: x => x.OpenSinusLiftMembraneCompanyID,
                        principalTable: "MembraneCompanies",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_SurgicalTreatments_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ClinicDoctorClinicPercentageModels",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DateTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    DoctorId = table.Column<int>(type: "integer", nullable: true),
                    RestorationId = table.Column<int>(type: "integer", nullable: true),
                    ClinicImplantId = table.Column<int>(type: "integer", nullable: true),
                    OrthoTreatmentId = table.Column<int>(type: "integer", nullable: true),
                    TMDId = table.Column<int>(type: "integer", nullable: true),
                    PedoId = table.Column<int>(type: "integer", nullable: true),
                    RootCanalTreatmentId = table.Column<int>(type: "integer", nullable: true),
                    ScalingId = table.Column<int>(type: "integer", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    OperationFee = table.Column<int>(type: "integer", nullable: false),
                    DoctorsFees = table.Column<int>(type: "integer", nullable: false),
                    DoctorFeesType = table.Column<int>(type: "integer", nullable: true),
                    ClinicFee = table.Column<int>(type: "integer", nullable: false),
                    Paid = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ClinicDoctorClinicPercentageModels", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_AspNetUsers_DoctorId",
                        column: x => x.DoctorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "IdInt",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_ClinicTreatmentParent_Cl~",
                        column: x => x.ClinicImplantId,
                        principalTable: "ClinicTreatmentParent",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_ClinicTreatmentParent_Or~",
                        column: x => x.OrthoTreatmentId,
                        principalTable: "ClinicTreatmentParent",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_ClinicTreatmentParent_Pe~",
                        column: x => x.PedoId,
                        principalTable: "ClinicTreatmentParent",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_ClinicTreatmentParent_Re~",
                        column: x => x.RestorationId,
                        principalTable: "ClinicTreatmentParent",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_ClinicTreatmentParent_Ro~",
                        column: x => x.RootCanalTreatmentId,
                        principalTable: "ClinicTreatmentParent",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_ClinicTreatmentParent_Sc~",
                        column: x => x.ScalingId,
                        principalTable: "ClinicTreatmentParent",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_ClinicTreatmentParent_TM~",
                        column: x => x.TMDId,
                        principalTable: "ClinicTreatmentParent",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ClinicDoctorClinicPercentageModels_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "RequestChanges",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Description = table.Column<string>(type: "text", nullable: false),
                    RequestEnum = table.Column<int>(type: "integer", nullable: false),
                    UserId = table.Column<int>(type: "integer", nullable: true),
                    UserId1 = table.Column<string>(type: "text", nullable: true),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    DataId = table.Column<int>(type: "integer", nullable: true),
                    DataName = table.Column<string>(type: "text", nullable: true),
                    SurgicalTreatmentModelId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RequestChanges", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RequestChanges_AspNetUsers_UserId1",
                        column: x => x.UserId1,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_RequestChanges_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_RequestChanges_SurgicalTreatments_SurgicalTreatmentModelId",
                        column: x => x.SurgicalTreatmentModelId,
                        principalTable: "SurgicalTreatments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "TreatmentPlansSubModels",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: true),
                    Tooth = table.Column<int>(type: "integer", nullable: false),
                    ScalingRequestChangeId = table.Column<int>(name: "Scaling_RequestChangeId", type: "integer", nullable: true),
                    ScalingValue = table.Column<string>(name: "Scaling_Value", type: "text", nullable: true),
                    ScalingStatus = table.Column<bool>(name: "Scaling_Status", type: "boolean", nullable: true),
                    ScalingAssignedToID = table.Column<int>(name: "Scaling_AssignedToID", type: "integer", nullable: true),
                    ScalingPlanPrice = table.Column<int>(name: "Scaling_PlanPrice", type: "integer", nullable: true),
                    ScalingAssignedToId = table.Column<string>(name: "Scaling_AssignedToId", type: "text", nullable: true),
                    ScalingDate = table.Column<DateTime>(name: "Scaling_Date", type: "timestamp with time zone", nullable: true),
                    ScalingDoneByAssistantID = table.Column<int>(name: "Scaling_DoneByAssistantID", type: "integer", nullable: true),
                    ScalingDoneByAssistantId = table.Column<string>(name: "Scaling_DoneByAssistantId", type: "text", nullable: true),
                    ScalingDoneBySupervisorID = table.Column<int>(name: "Scaling_DoneBySupervisorID", type: "integer", nullable: true),
                    ScalingDoneBySupervisorId = table.Column<string>(name: "Scaling_DoneBySupervisorId", type: "text", nullable: true),
                    ScalingDoneByCandidateID = table.Column<int>(name: "Scaling_DoneByCandidateID", type: "integer", nullable: true),
                    ScalingDoneByCandidateId = table.Column<string>(name: "Scaling_DoneByCandidateId", type: "text", nullable: true),
                    ScalingDoneByCandidateBatchID = table.Column<int>(name: "Scaling_DoneByCandidateBatchID", type: "integer", nullable: true),
                    ScalingImplantID = table.Column<int>(name: "Scaling_ImplantID", type: "integer", nullable: true),
                    ScalingImplantIDRequest = table.Column<int>(name: "Scaling_ImplantIDRequest", type: "integer", nullable: true),
                    ScalingWebsite = table.Column<int>(name: "Scaling_Website", type: "integer", nullable: true),
                    CrownRequestChangeId = table.Column<int>(name: "Crown_RequestChangeId", type: "integer", nullable: true),
                    CrownValue = table.Column<string>(name: "Crown_Value", type: "text", nullable: true),
                    CrownStatus = table.Column<bool>(name: "Crown_Status", type: "boolean", nullable: true),
                    CrownAssignedToID = table.Column<int>(name: "Crown_AssignedToID", type: "integer", nullable: true),
                    CrownPlanPrice = table.Column<int>(name: "Crown_PlanPrice", type: "integer", nullable: true),
                    CrownAssignedToId = table.Column<string>(name: "Crown_AssignedToId", type: "text", nullable: true),
                    CrownDate = table.Column<DateTime>(name: "Crown_Date", type: "timestamp with time zone", nullable: true),
                    CrownDoneByAssistantID = table.Column<int>(name: "Crown_DoneByAssistantID", type: "integer", nullable: true),
                    CrownDoneByAssistantId = table.Column<string>(name: "Crown_DoneByAssistantId", type: "text", nullable: true),
                    CrownDoneBySupervisorID = table.Column<int>(name: "Crown_DoneBySupervisorID", type: "integer", nullable: true),
                    CrownDoneBySupervisorId = table.Column<string>(name: "Crown_DoneBySupervisorId", type: "text", nullable: true),
                    CrownDoneByCandidateID = table.Column<int>(name: "Crown_DoneByCandidateID", type: "integer", nullable: true),
                    CrownDoneByCandidateId = table.Column<string>(name: "Crown_DoneByCandidateId", type: "text", nullable: true),
                    CrownDoneByCandidateBatchID = table.Column<int>(name: "Crown_DoneByCandidateBatchID", type: "integer", nullable: true),
                    CrownImplantID = table.Column<int>(name: "Crown_ImplantID", type: "integer", nullable: true),
                    CrownImplantIDRequest = table.Column<int>(name: "Crown_ImplantIDRequest", type: "integer", nullable: true),
                    CrownWebsite = table.Column<int>(name: "Crown_Website", type: "integer", nullable: true),
                    RootCanalTreatmentRequestChangeId = table.Column<int>(name: "RootCanalTreatment_RequestChangeId", type: "integer", nullable: true),
                    RootCanalTreatmentValue = table.Column<string>(name: "RootCanalTreatment_Value", type: "text", nullable: true),
                    RootCanalTreatmentStatus = table.Column<bool>(name: "RootCanalTreatment_Status", type: "boolean", nullable: true),
                    RootCanalTreatmentAssignedToID = table.Column<int>(name: "RootCanalTreatment_AssignedToID", type: "integer", nullable: true),
                    RootCanalTreatmentPlanPrice = table.Column<int>(name: "RootCanalTreatment_PlanPrice", type: "integer", nullable: true),
                    RootCanalTreatmentAssignedToId = table.Column<string>(name: "RootCanalTreatment_AssignedToId", type: "text", nullable: true),
                    RootCanalTreatmentDate = table.Column<DateTime>(name: "RootCanalTreatment_Date", type: "timestamp with time zone", nullable: true),
                    RootCanalTreatmentDoneByAssistantID = table.Column<int>(name: "RootCanalTreatment_DoneByAssistantID", type: "integer", nullable: true),
                    RootCanalTreatmentDoneByAssistantId = table.Column<string>(name: "RootCanalTreatment_DoneByAssistantId", type: "text", nullable: true),
                    RootCanalTreatmentDoneBySupervisorID = table.Column<int>(name: "RootCanalTreatment_DoneBySupervisorID", type: "integer", nullable: true),
                    RootCanalTreatmentDoneBySupervisorId = table.Column<string>(name: "RootCanalTreatment_DoneBySupervisorId", type: "text", nullable: true),
                    RootCanalTreatmentDoneByCandidateID = table.Column<int>(name: "RootCanalTreatment_DoneByCandidateID", type: "integer", nullable: true),
                    RootCanalTreatmentDoneByCandidateId = table.Column<string>(name: "RootCanalTreatment_DoneByCandidateId", type: "text", nullable: true),
                    RootCanalTreatmentDoneByCandidateBatchID = table.Column<int>(name: "RootCanalTreatment_DoneByCandidateBatchID", type: "integer", nullable: true),
                    RootCanalTreatmentImplantID = table.Column<int>(name: "RootCanalTreatment_ImplantID", type: "integer", nullable: true),
                    RootCanalTreatmentImplantIDRequest = table.Column<int>(name: "RootCanalTreatment_ImplantIDRequest", type: "integer", nullable: true),
                    RootCanalTreatmentWebsite = table.Column<int>(name: "RootCanalTreatment_Website", type: "integer", nullable: true),
                    RestorationRequestChangeId = table.Column<int>(name: "Restoration_RequestChangeId", type: "integer", nullable: true),
                    RestorationValue = table.Column<string>(name: "Restoration_Value", type: "text", nullable: true),
                    RestorationStatus = table.Column<bool>(name: "Restoration_Status", type: "boolean", nullable: true),
                    RestorationAssignedToID = table.Column<int>(name: "Restoration_AssignedToID", type: "integer", nullable: true),
                    RestorationPlanPrice = table.Column<int>(name: "Restoration_PlanPrice", type: "integer", nullable: true),
                    RestorationAssignedToId = table.Column<string>(name: "Restoration_AssignedToId", type: "text", nullable: true),
                    RestorationDate = table.Column<DateTime>(name: "Restoration_Date", type: "timestamp with time zone", nullable: true),
                    RestorationDoneByAssistantID = table.Column<int>(name: "Restoration_DoneByAssistantID", type: "integer", nullable: true),
                    RestorationDoneByAssistantId = table.Column<string>(name: "Restoration_DoneByAssistantId", type: "text", nullable: true),
                    RestorationDoneBySupervisorID = table.Column<int>(name: "Restoration_DoneBySupervisorID", type: "integer", nullable: true),
                    RestorationDoneBySupervisorId = table.Column<string>(name: "Restoration_DoneBySupervisorId", type: "text", nullable: true),
                    RestorationDoneByCandidateID = table.Column<int>(name: "Restoration_DoneByCandidateID", type: "integer", nullable: true),
                    RestorationDoneByCandidateId = table.Column<string>(name: "Restoration_DoneByCandidateId", type: "text", nullable: true),
                    RestorationDoneByCandidateBatchID = table.Column<int>(name: "Restoration_DoneByCandidateBatchID", type: "integer", nullable: true),
                    RestorationImplantID = table.Column<int>(name: "Restoration_ImplantID", type: "integer", nullable: true),
                    RestorationImplantIDRequest = table.Column<int>(name: "Restoration_ImplantIDRequest", type: "integer", nullable: true),
                    RestorationWebsite = table.Column<int>(name: "Restoration_Website", type: "integer", nullable: true),
                    PonticRequestChangeId = table.Column<int>(name: "Pontic_RequestChangeId", type: "integer", nullable: true),
                    PonticValue = table.Column<string>(name: "Pontic_Value", type: "text", nullable: true),
                    PonticStatus = table.Column<bool>(name: "Pontic_Status", type: "boolean", nullable: true),
                    PonticAssignedToID = table.Column<int>(name: "Pontic_AssignedToID", type: "integer", nullable: true),
                    PonticPlanPrice = table.Column<int>(name: "Pontic_PlanPrice", type: "integer", nullable: true),
                    PonticAssignedToId = table.Column<string>(name: "Pontic_AssignedToId", type: "text", nullable: true),
                    PonticDate = table.Column<DateTime>(name: "Pontic_Date", type: "timestamp with time zone", nullable: true),
                    PonticDoneByAssistantID = table.Column<int>(name: "Pontic_DoneByAssistantID", type: "integer", nullable: true),
                    PonticDoneByAssistantId = table.Column<string>(name: "Pontic_DoneByAssistantId", type: "text", nullable: true),
                    PonticDoneBySupervisorID = table.Column<int>(name: "Pontic_DoneBySupervisorID", type: "integer", nullable: true),
                    PonticDoneBySupervisorId = table.Column<string>(name: "Pontic_DoneBySupervisorId", type: "text", nullable: true),
                    PonticDoneByCandidateID = table.Column<int>(name: "Pontic_DoneByCandidateID", type: "integer", nullable: true),
                    PonticDoneByCandidateId = table.Column<string>(name: "Pontic_DoneByCandidateId", type: "text", nullable: true),
                    PonticDoneByCandidateBatchID = table.Column<int>(name: "Pontic_DoneByCandidateBatchID", type: "integer", nullable: true),
                    PonticImplantID = table.Column<int>(name: "Pontic_ImplantID", type: "integer", nullable: true),
                    PonticImplantIDRequest = table.Column<int>(name: "Pontic_ImplantIDRequest", type: "integer", nullable: true),
                    PonticWebsite = table.Column<int>(name: "Pontic_Website", type: "integer", nullable: true),
                    ExtractionRequestChangeId = table.Column<int>(name: "Extraction_RequestChangeId", type: "integer", nullable: true),
                    ExtractionValue = table.Column<string>(name: "Extraction_Value", type: "text", nullable: true),
                    ExtractionStatus = table.Column<bool>(name: "Extraction_Status", type: "boolean", nullable: true),
                    ExtractionAssignedToID = table.Column<int>(name: "Extraction_AssignedToID", type: "integer", nullable: true),
                    ExtractionPlanPrice = table.Column<int>(name: "Extraction_PlanPrice", type: "integer", nullable: true),
                    ExtractionAssignedToId = table.Column<string>(name: "Extraction_AssignedToId", type: "text", nullable: true),
                    ExtractionDate = table.Column<DateTime>(name: "Extraction_Date", type: "timestamp with time zone", nullable: true),
                    ExtractionDoneByAssistantID = table.Column<int>(name: "Extraction_DoneByAssistantID", type: "integer", nullable: true),
                    ExtractionDoneByAssistantId = table.Column<string>(name: "Extraction_DoneByAssistantId", type: "text", nullable: true),
                    ExtractionDoneBySupervisorID = table.Column<int>(name: "Extraction_DoneBySupervisorID", type: "integer", nullable: true),
                    ExtractionDoneBySupervisorId = table.Column<string>(name: "Extraction_DoneBySupervisorId", type: "text", nullable: true),
                    ExtractionDoneByCandidateID = table.Column<int>(name: "Extraction_DoneByCandidateID", type: "integer", nullable: true),
                    ExtractionDoneByCandidateId = table.Column<string>(name: "Extraction_DoneByCandidateId", type: "text", nullable: true),
                    ExtractionDoneByCandidateBatchID = table.Column<int>(name: "Extraction_DoneByCandidateBatchID", type: "integer", nullable: true),
                    ExtractionImplantID = table.Column<int>(name: "Extraction_ImplantID", type: "integer", nullable: true),
                    ExtractionImplantIDRequest = table.Column<int>(name: "Extraction_ImplantIDRequest", type: "integer", nullable: true),
                    ExtractionWebsite = table.Column<int>(name: "Extraction_Website", type: "integer", nullable: true),
                    SimpleImplantRequestChangeId = table.Column<int>(name: "SimpleImplant_RequestChangeId", type: "integer", nullable: true),
                    SimpleImplantValue = table.Column<string>(name: "SimpleImplant_Value", type: "text", nullable: true),
                    SimpleImplantStatus = table.Column<bool>(name: "SimpleImplant_Status", type: "boolean", nullable: true),
                    SimpleImplantAssignedToID = table.Column<int>(name: "SimpleImplant_AssignedToID", type: "integer", nullable: true),
                    SimpleImplantPlanPrice = table.Column<int>(name: "SimpleImplant_PlanPrice", type: "integer", nullable: true),
                    SimpleImplantAssignedToId = table.Column<string>(name: "SimpleImplant_AssignedToId", type: "text", nullable: true),
                    SimpleImplantDate = table.Column<DateTime>(name: "SimpleImplant_Date", type: "timestamp with time zone", nullable: true),
                    SimpleImplantDoneByAssistantID = table.Column<int>(name: "SimpleImplant_DoneByAssistantID", type: "integer", nullable: true),
                    SimpleImplantDoneByAssistantId = table.Column<string>(name: "SimpleImplant_DoneByAssistantId", type: "text", nullable: true),
                    SimpleImplantDoneBySupervisorID = table.Column<int>(name: "SimpleImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    SimpleImplantDoneBySupervisorId = table.Column<string>(name: "SimpleImplant_DoneBySupervisorId", type: "text", nullable: true),
                    SimpleImplantDoneByCandidateID = table.Column<int>(name: "SimpleImplant_DoneByCandidateID", type: "integer", nullable: true),
                    SimpleImplantDoneByCandidateId = table.Column<string>(name: "SimpleImplant_DoneByCandidateId", type: "text", nullable: true),
                    SimpleImplantDoneByCandidateBatchID = table.Column<int>(name: "SimpleImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    SimpleImplantImplantID = table.Column<int>(name: "SimpleImplant_ImplantID", type: "integer", nullable: true),
                    SimpleImplantImplantIDRequest = table.Column<int>(name: "SimpleImplant_ImplantIDRequest", type: "integer", nullable: true),
                    SimpleImplantWebsite = table.Column<int>(name: "SimpleImplant_Website", type: "integer", nullable: true),
                    ImmediateImplantRequestChangeId = table.Column<int>(name: "ImmediateImplant_RequestChangeId", type: "integer", nullable: true),
                    ImmediateImplantValue = table.Column<string>(name: "ImmediateImplant_Value", type: "text", nullable: true),
                    ImmediateImplantStatus = table.Column<bool>(name: "ImmediateImplant_Status", type: "boolean", nullable: true),
                    ImmediateImplantAssignedToID = table.Column<int>(name: "ImmediateImplant_AssignedToID", type: "integer", nullable: true),
                    ImmediateImplantPlanPrice = table.Column<int>(name: "ImmediateImplant_PlanPrice", type: "integer", nullable: true),
                    ImmediateImplantAssignedToId = table.Column<string>(name: "ImmediateImplant_AssignedToId", type: "text", nullable: true),
                    ImmediateImplantDate = table.Column<DateTime>(name: "ImmediateImplant_Date", type: "timestamp with time zone", nullable: true),
                    ImmediateImplantDoneByAssistantID = table.Column<int>(name: "ImmediateImplant_DoneByAssistantID", type: "integer", nullable: true),
                    ImmediateImplantDoneByAssistantId = table.Column<string>(name: "ImmediateImplant_DoneByAssistantId", type: "text", nullable: true),
                    ImmediateImplantDoneBySupervisorID = table.Column<int>(name: "ImmediateImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    ImmediateImplantDoneBySupervisorId = table.Column<string>(name: "ImmediateImplant_DoneBySupervisorId", type: "text", nullable: true),
                    ImmediateImplantDoneByCandidateID = table.Column<int>(name: "ImmediateImplant_DoneByCandidateID", type: "integer", nullable: true),
                    ImmediateImplantDoneByCandidateId = table.Column<string>(name: "ImmediateImplant_DoneByCandidateId", type: "text", nullable: true),
                    ImmediateImplantDoneByCandidateBatchID = table.Column<int>(name: "ImmediateImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    ImmediateImplantImplantID = table.Column<int>(name: "ImmediateImplant_ImplantID", type: "integer", nullable: true),
                    ImmediateImplantImplantIDRequest = table.Column<int>(name: "ImmediateImplant_ImplantIDRequest", type: "integer", nullable: true),
                    ImmediateImplantWebsite = table.Column<int>(name: "ImmediateImplant_Website", type: "integer", nullable: true),
                    ExpansionWithImplantRequestChangeId = table.Column<int>(name: "ExpansionWithImplant_RequestChangeId", type: "integer", nullable: true),
                    ExpansionWithImplantValue = table.Column<string>(name: "ExpansionWithImplant_Value", type: "text", nullable: true),
                    ExpansionWithImplantStatus = table.Column<bool>(name: "ExpansionWithImplant_Status", type: "boolean", nullable: true),
                    ExpansionWithImplantAssignedToID = table.Column<int>(name: "ExpansionWithImplant_AssignedToID", type: "integer", nullable: true),
                    ExpansionWithImplantPlanPrice = table.Column<int>(name: "ExpansionWithImplant_PlanPrice", type: "integer", nullable: true),
                    ExpansionWithImplantAssignedToId = table.Column<string>(name: "ExpansionWithImplant_AssignedToId", type: "text", nullable: true),
                    ExpansionWithImplantDate = table.Column<DateTime>(name: "ExpansionWithImplant_Date", type: "timestamp with time zone", nullable: true),
                    ExpansionWithImplantDoneByAssistantID = table.Column<int>(name: "ExpansionWithImplant_DoneByAssistantID", type: "integer", nullable: true),
                    ExpansionWithImplantDoneByAssistantId = table.Column<string>(name: "ExpansionWithImplant_DoneByAssistantId", type: "text", nullable: true),
                    ExpansionWithImplantDoneBySupervisorID = table.Column<int>(name: "ExpansionWithImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    ExpansionWithImplantDoneBySupervisorId = table.Column<string>(name: "ExpansionWithImplant_DoneBySupervisorId", type: "text", nullable: true),
                    ExpansionWithImplantDoneByCandidateID = table.Column<int>(name: "ExpansionWithImplant_DoneByCandidateID", type: "integer", nullable: true),
                    ExpansionWithImplantDoneByCandidateId = table.Column<string>(name: "ExpansionWithImplant_DoneByCandidateId", type: "text", nullable: true),
                    ExpansionWithImplantDoneByCandidateBatchID = table.Column<int>(name: "ExpansionWithImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    ExpansionWithImplantImplantID = table.Column<int>(name: "ExpansionWithImplant_ImplantID", type: "integer", nullable: true),
                    ExpansionWithImplantImplantIDRequest = table.Column<int>(name: "ExpansionWithImplant_ImplantIDRequest", type: "integer", nullable: true),
                    ExpansionWithImplantWebsite = table.Column<int>(name: "ExpansionWithImplant_Website", type: "integer", nullable: true),
                    SplittingWithImplantRequestChangeId = table.Column<int>(name: "SplittingWithImplant_RequestChangeId", type: "integer", nullable: true),
                    SplittingWithImplantValue = table.Column<string>(name: "SplittingWithImplant_Value", type: "text", nullable: true),
                    SplittingWithImplantStatus = table.Column<bool>(name: "SplittingWithImplant_Status", type: "boolean", nullable: true),
                    SplittingWithImplantAssignedToID = table.Column<int>(name: "SplittingWithImplant_AssignedToID", type: "integer", nullable: true),
                    SplittingWithImplantPlanPrice = table.Column<int>(name: "SplittingWithImplant_PlanPrice", type: "integer", nullable: true),
                    SplittingWithImplantAssignedToId = table.Column<string>(name: "SplittingWithImplant_AssignedToId", type: "text", nullable: true),
                    SplittingWithImplantDate = table.Column<DateTime>(name: "SplittingWithImplant_Date", type: "timestamp with time zone", nullable: true),
                    SplittingWithImplantDoneByAssistantID = table.Column<int>(name: "SplittingWithImplant_DoneByAssistantID", type: "integer", nullable: true),
                    SplittingWithImplantDoneByAssistantId = table.Column<string>(name: "SplittingWithImplant_DoneByAssistantId", type: "text", nullable: true),
                    SplittingWithImplantDoneBySupervisorID = table.Column<int>(name: "SplittingWithImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    SplittingWithImplantDoneBySupervisorId = table.Column<string>(name: "SplittingWithImplant_DoneBySupervisorId", type: "text", nullable: true),
                    SplittingWithImplantDoneByCandidateID = table.Column<int>(name: "SplittingWithImplant_DoneByCandidateID", type: "integer", nullable: true),
                    SplittingWithImplantDoneByCandidateId = table.Column<string>(name: "SplittingWithImplant_DoneByCandidateId", type: "text", nullable: true),
                    SplittingWithImplantDoneByCandidateBatchID = table.Column<int>(name: "SplittingWithImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    SplittingWithImplantImplantID = table.Column<int>(name: "SplittingWithImplant_ImplantID", type: "integer", nullable: true),
                    SplittingWithImplantImplantIDRequest = table.Column<int>(name: "SplittingWithImplant_ImplantIDRequest", type: "integer", nullable: true),
                    SplittingWithImplantWebsite = table.Column<int>(name: "SplittingWithImplant_Website", type: "integer", nullable: true),
                    GBRWithImplantRequestChangeId = table.Column<int>(name: "GBRWithImplant_RequestChangeId", type: "integer", nullable: true),
                    GBRWithImplantValue = table.Column<string>(name: "GBRWithImplant_Value", type: "text", nullable: true),
                    GBRWithImplantStatus = table.Column<bool>(name: "GBRWithImplant_Status", type: "boolean", nullable: true),
                    GBRWithImplantAssignedToID = table.Column<int>(name: "GBRWithImplant_AssignedToID", type: "integer", nullable: true),
                    GBRWithImplantPlanPrice = table.Column<int>(name: "GBRWithImplant_PlanPrice", type: "integer", nullable: true),
                    GBRWithImplantAssignedToId = table.Column<string>(name: "GBRWithImplant_AssignedToId", type: "text", nullable: true),
                    GBRWithImplantDate = table.Column<DateTime>(name: "GBRWithImplant_Date", type: "timestamp with time zone", nullable: true),
                    GBRWithImplantDoneByAssistantID = table.Column<int>(name: "GBRWithImplant_DoneByAssistantID", type: "integer", nullable: true),
                    GBRWithImplantDoneByAssistantId = table.Column<string>(name: "GBRWithImplant_DoneByAssistantId", type: "text", nullable: true),
                    GBRWithImplantDoneBySupervisorID = table.Column<int>(name: "GBRWithImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    GBRWithImplantDoneBySupervisorId = table.Column<string>(name: "GBRWithImplant_DoneBySupervisorId", type: "text", nullable: true),
                    GBRWithImplantDoneByCandidateID = table.Column<int>(name: "GBRWithImplant_DoneByCandidateID", type: "integer", nullable: true),
                    GBRWithImplantDoneByCandidateId = table.Column<string>(name: "GBRWithImplant_DoneByCandidateId", type: "text", nullable: true),
                    GBRWithImplantDoneByCandidateBatchID = table.Column<int>(name: "GBRWithImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    GBRWithImplantImplantID = table.Column<int>(name: "GBRWithImplant_ImplantID", type: "integer", nullable: true),
                    GBRWithImplantImplantIDRequest = table.Column<int>(name: "GBRWithImplant_ImplantIDRequest", type: "integer", nullable: true),
                    GBRWithImplantWebsite = table.Column<int>(name: "GBRWithImplant_Website", type: "integer", nullable: true),
                    OpenSinusWithImplantRequestChangeId = table.Column<int>(name: "OpenSinusWithImplant_RequestChangeId", type: "integer", nullable: true),
                    OpenSinusWithImplantValue = table.Column<string>(name: "OpenSinusWithImplant_Value", type: "text", nullable: true),
                    OpenSinusWithImplantStatus = table.Column<bool>(name: "OpenSinusWithImplant_Status", type: "boolean", nullable: true),
                    OpenSinusWithImplantAssignedToID = table.Column<int>(name: "OpenSinusWithImplant_AssignedToID", type: "integer", nullable: true),
                    OpenSinusWithImplantPlanPrice = table.Column<int>(name: "OpenSinusWithImplant_PlanPrice", type: "integer", nullable: true),
                    OpenSinusWithImplantAssignedToId = table.Column<string>(name: "OpenSinusWithImplant_AssignedToId", type: "text", nullable: true),
                    OpenSinusWithImplantDate = table.Column<DateTime>(name: "OpenSinusWithImplant_Date", type: "timestamp with time zone", nullable: true),
                    OpenSinusWithImplantDoneByAssistantID = table.Column<int>(name: "OpenSinusWithImplant_DoneByAssistantID", type: "integer", nullable: true),
                    OpenSinusWithImplantDoneByAssistantId = table.Column<string>(name: "OpenSinusWithImplant_DoneByAssistantId", type: "text", nullable: true),
                    OpenSinusWithImplantDoneBySupervisorID = table.Column<int>(name: "OpenSinusWithImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    OpenSinusWithImplantDoneBySupervisorId = table.Column<string>(name: "OpenSinusWithImplant_DoneBySupervisorId", type: "text", nullable: true),
                    OpenSinusWithImplantDoneByCandidateID = table.Column<int>(name: "OpenSinusWithImplant_DoneByCandidateID", type: "integer", nullable: true),
                    OpenSinusWithImplantDoneByCandidateId = table.Column<string>(name: "OpenSinusWithImplant_DoneByCandidateId", type: "text", nullable: true),
                    OpenSinusWithImplantDoneByCandidateBatchID = table.Column<int>(name: "OpenSinusWithImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    OpenSinusWithImplantImplantID = table.Column<int>(name: "OpenSinusWithImplant_ImplantID", type: "integer", nullable: true),
                    OpenSinusWithImplantImplantIDRequest = table.Column<int>(name: "OpenSinusWithImplant_ImplantIDRequest", type: "integer", nullable: true),
                    OpenSinusWithImplantWebsite = table.Column<int>(name: "OpenSinusWithImplant_Website", type: "integer", nullable: true),
                    ClosedSinusWithImplantRequestChangeId = table.Column<int>(name: "ClosedSinusWithImplant_RequestChangeId", type: "integer", nullable: true),
                    ClosedSinusWithImplantValue = table.Column<string>(name: "ClosedSinusWithImplant_Value", type: "text", nullable: true),
                    ClosedSinusWithImplantStatus = table.Column<bool>(name: "ClosedSinusWithImplant_Status", type: "boolean", nullable: true),
                    ClosedSinusWithImplantAssignedToID = table.Column<int>(name: "ClosedSinusWithImplant_AssignedToID", type: "integer", nullable: true),
                    ClosedSinusWithImplantPlanPrice = table.Column<int>(name: "ClosedSinusWithImplant_PlanPrice", type: "integer", nullable: true),
                    ClosedSinusWithImplantAssignedToId = table.Column<string>(name: "ClosedSinusWithImplant_AssignedToId", type: "text", nullable: true),
                    ClosedSinusWithImplantDate = table.Column<DateTime>(name: "ClosedSinusWithImplant_Date", type: "timestamp with time zone", nullable: true),
                    ClosedSinusWithImplantDoneByAssistantID = table.Column<int>(name: "ClosedSinusWithImplant_DoneByAssistantID", type: "integer", nullable: true),
                    ClosedSinusWithImplantDoneByAssistantId = table.Column<string>(name: "ClosedSinusWithImplant_DoneByAssistantId", type: "text", nullable: true),
                    ClosedSinusWithImplantDoneBySupervisorID = table.Column<int>(name: "ClosedSinusWithImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    ClosedSinusWithImplantDoneBySupervisorId = table.Column<string>(name: "ClosedSinusWithImplant_DoneBySupervisorId", type: "text", nullable: true),
                    ClosedSinusWithImplantDoneByCandidateID = table.Column<int>(name: "ClosedSinusWithImplant_DoneByCandidateID", type: "integer", nullable: true),
                    ClosedSinusWithImplantDoneByCandidateId = table.Column<string>(name: "ClosedSinusWithImplant_DoneByCandidateId", type: "text", nullable: true),
                    ClosedSinusWithImplantDoneByCandidateBatchID = table.Column<int>(name: "ClosedSinusWithImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    ClosedSinusWithImplantImplantID = table.Column<int>(name: "ClosedSinusWithImplant_ImplantID", type: "integer", nullable: true),
                    ClosedSinusWithImplantImplantIDRequest = table.Column<int>(name: "ClosedSinusWithImplant_ImplantIDRequest", type: "integer", nullable: true),
                    ClosedSinusWithImplantWebsite = table.Column<int>(name: "ClosedSinusWithImplant_Website", type: "integer", nullable: true),
                    GuidedImplantRequestChangeId = table.Column<int>(name: "GuidedImplant_RequestChangeId", type: "integer", nullable: true),
                    GuidedImplantValue = table.Column<string>(name: "GuidedImplant_Value", type: "text", nullable: true),
                    GuidedImplantStatus = table.Column<bool>(name: "GuidedImplant_Status", type: "boolean", nullable: true),
                    GuidedImplantAssignedToID = table.Column<int>(name: "GuidedImplant_AssignedToID", type: "integer", nullable: true),
                    GuidedImplantPlanPrice = table.Column<int>(name: "GuidedImplant_PlanPrice", type: "integer", nullable: true),
                    GuidedImplantAssignedToId = table.Column<string>(name: "GuidedImplant_AssignedToId", type: "text", nullable: true),
                    GuidedImplantDate = table.Column<DateTime>(name: "GuidedImplant_Date", type: "timestamp with time zone", nullable: true),
                    GuidedImplantDoneByAssistantID = table.Column<int>(name: "GuidedImplant_DoneByAssistantID", type: "integer", nullable: true),
                    GuidedImplantDoneByAssistantId = table.Column<string>(name: "GuidedImplant_DoneByAssistantId", type: "text", nullable: true),
                    GuidedImplantDoneBySupervisorID = table.Column<int>(name: "GuidedImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    GuidedImplantDoneBySupervisorId = table.Column<string>(name: "GuidedImplant_DoneBySupervisorId", type: "text", nullable: true),
                    GuidedImplantDoneByCandidateID = table.Column<int>(name: "GuidedImplant_DoneByCandidateID", type: "integer", nullable: true),
                    GuidedImplantDoneByCandidateId = table.Column<string>(name: "GuidedImplant_DoneByCandidateId", type: "text", nullable: true),
                    GuidedImplantDoneByCandidateBatchID = table.Column<int>(name: "GuidedImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    GuidedImplantImplantID = table.Column<int>(name: "GuidedImplant_ImplantID", type: "integer", nullable: true),
                    GuidedImplantImplantIDRequest = table.Column<int>(name: "GuidedImplant_ImplantIDRequest", type: "integer", nullable: true),
                    GuidedImplantWebsite = table.Column<int>(name: "GuidedImplant_Website", type: "integer", nullable: true),
                    ExpansionWithoutImplantRequestChangeId = table.Column<int>(name: "ExpansionWithoutImplant_RequestChangeId", type: "integer", nullable: true),
                    ExpansionWithoutImplantValue = table.Column<string>(name: "ExpansionWithoutImplant_Value", type: "text", nullable: true),
                    ExpansionWithoutImplantStatus = table.Column<bool>(name: "ExpansionWithoutImplant_Status", type: "boolean", nullable: true),
                    ExpansionWithoutImplantAssignedToID = table.Column<int>(name: "ExpansionWithoutImplant_AssignedToID", type: "integer", nullable: true),
                    ExpansionWithoutImplantPlanPrice = table.Column<int>(name: "ExpansionWithoutImplant_PlanPrice", type: "integer", nullable: true),
                    ExpansionWithoutImplantAssignedToId = table.Column<string>(name: "ExpansionWithoutImplant_AssignedToId", type: "text", nullable: true),
                    ExpansionWithoutImplantDate = table.Column<DateTime>(name: "ExpansionWithoutImplant_Date", type: "timestamp with time zone", nullable: true),
                    ExpansionWithoutImplantDoneByAssistantID = table.Column<int>(name: "ExpansionWithoutImplant_DoneByAssistantID", type: "integer", nullable: true),
                    ExpansionWithoutImplantDoneByAssistantId = table.Column<string>(name: "ExpansionWithoutImplant_DoneByAssistantId", type: "text", nullable: true),
                    ExpansionWithoutImplantDoneBySupervisorID = table.Column<int>(name: "ExpansionWithoutImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    ExpansionWithoutImplantDoneBySupervisorId = table.Column<string>(name: "ExpansionWithoutImplant_DoneBySupervisorId", type: "text", nullable: true),
                    ExpansionWithoutImplantDoneByCandidateID = table.Column<int>(name: "ExpansionWithoutImplant_DoneByCandidateID", type: "integer", nullable: true),
                    ExpansionWithoutImplantDoneByCandidateId = table.Column<string>(name: "ExpansionWithoutImplant_DoneByCandidateId", type: "text", nullable: true),
                    ExpansionWithoutImplantDoneByCandidateBatchID = table.Column<int>(name: "ExpansionWithoutImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    ExpansionWithoutImplantImplantID = table.Column<int>(name: "ExpansionWithoutImplant_ImplantID", type: "integer", nullable: true),
                    ExpansionWithoutImplantImplantIDRequest = table.Column<int>(name: "ExpansionWithoutImplant_ImplantIDRequest", type: "integer", nullable: true),
                    ExpansionWithoutImplantWebsite = table.Column<int>(name: "ExpansionWithoutImplant_Website", type: "integer", nullable: true),
                    SplittingWithoutImplantRequestChangeId = table.Column<int>(name: "SplittingWithoutImplant_RequestChangeId", type: "integer", nullable: true),
                    SplittingWithoutImplantValue = table.Column<string>(name: "SplittingWithoutImplant_Value", type: "text", nullable: true),
                    SplittingWithoutImplantStatus = table.Column<bool>(name: "SplittingWithoutImplant_Status", type: "boolean", nullable: true),
                    SplittingWithoutImplantAssignedToID = table.Column<int>(name: "SplittingWithoutImplant_AssignedToID", type: "integer", nullable: true),
                    SplittingWithoutImplantPlanPrice = table.Column<int>(name: "SplittingWithoutImplant_PlanPrice", type: "integer", nullable: true),
                    SplittingWithoutImplantAssignedToId = table.Column<string>(name: "SplittingWithoutImplant_AssignedToId", type: "text", nullable: true),
                    SplittingWithoutImplantDate = table.Column<DateTime>(name: "SplittingWithoutImplant_Date", type: "timestamp with time zone", nullable: true),
                    SplittingWithoutImplantDoneByAssistantID = table.Column<int>(name: "SplittingWithoutImplant_DoneByAssistantID", type: "integer", nullable: true),
                    SplittingWithoutImplantDoneByAssistantId = table.Column<string>(name: "SplittingWithoutImplant_DoneByAssistantId", type: "text", nullable: true),
                    SplittingWithoutImplantDoneBySupervisorID = table.Column<int>(name: "SplittingWithoutImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    SplittingWithoutImplantDoneBySupervisorId = table.Column<string>(name: "SplittingWithoutImplant_DoneBySupervisorId", type: "text", nullable: true),
                    SplittingWithoutImplantDoneByCandidateID = table.Column<int>(name: "SplittingWithoutImplant_DoneByCandidateID", type: "integer", nullable: true),
                    SplittingWithoutImplantDoneByCandidateId = table.Column<string>(name: "SplittingWithoutImplant_DoneByCandidateId", type: "text", nullable: true),
                    SplittingWithoutImplantDoneByCandidateBatchID = table.Column<int>(name: "SplittingWithoutImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    SplittingWithoutImplantImplantID = table.Column<int>(name: "SplittingWithoutImplant_ImplantID", type: "integer", nullable: true),
                    SplittingWithoutImplantImplantIDRequest = table.Column<int>(name: "SplittingWithoutImplant_ImplantIDRequest", type: "integer", nullable: true),
                    SplittingWithoutImplantWebsite = table.Column<int>(name: "SplittingWithoutImplant_Website", type: "integer", nullable: true),
                    GBRWithoutImplantRequestChangeId = table.Column<int>(name: "GBRWithoutImplant_RequestChangeId", type: "integer", nullable: true),
                    GBRWithoutImplantValue = table.Column<string>(name: "GBRWithoutImplant_Value", type: "text", nullable: true),
                    GBRWithoutImplantStatus = table.Column<bool>(name: "GBRWithoutImplant_Status", type: "boolean", nullable: true),
                    GBRWithoutImplantAssignedToID = table.Column<int>(name: "GBRWithoutImplant_AssignedToID", type: "integer", nullable: true),
                    GBRWithoutImplantPlanPrice = table.Column<int>(name: "GBRWithoutImplant_PlanPrice", type: "integer", nullable: true),
                    GBRWithoutImplantAssignedToId = table.Column<string>(name: "GBRWithoutImplant_AssignedToId", type: "text", nullable: true),
                    GBRWithoutImplantDate = table.Column<DateTime>(name: "GBRWithoutImplant_Date", type: "timestamp with time zone", nullable: true),
                    GBRWithoutImplantDoneByAssistantID = table.Column<int>(name: "GBRWithoutImplant_DoneByAssistantID", type: "integer", nullable: true),
                    GBRWithoutImplantDoneByAssistantId = table.Column<string>(name: "GBRWithoutImplant_DoneByAssistantId", type: "text", nullable: true),
                    GBRWithoutImplantDoneBySupervisorID = table.Column<int>(name: "GBRWithoutImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    GBRWithoutImplantDoneBySupervisorId = table.Column<string>(name: "GBRWithoutImplant_DoneBySupervisorId", type: "text", nullable: true),
                    GBRWithoutImplantDoneByCandidateID = table.Column<int>(name: "GBRWithoutImplant_DoneByCandidateID", type: "integer", nullable: true),
                    GBRWithoutImplantDoneByCandidateId = table.Column<string>(name: "GBRWithoutImplant_DoneByCandidateId", type: "text", nullable: true),
                    GBRWithoutImplantDoneByCandidateBatchID = table.Column<int>(name: "GBRWithoutImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    GBRWithoutImplantImplantID = table.Column<int>(name: "GBRWithoutImplant_ImplantID", type: "integer", nullable: true),
                    GBRWithoutImplantImplantIDRequest = table.Column<int>(name: "GBRWithoutImplant_ImplantIDRequest", type: "integer", nullable: true),
                    GBRWithoutImplantWebsite = table.Column<int>(name: "GBRWithoutImplant_Website", type: "integer", nullable: true),
                    OpenSinusWithoutImplantRequestChangeId = table.Column<int>(name: "OpenSinusWithoutImplant_RequestChangeId", type: "integer", nullable: true),
                    OpenSinusWithoutImplantValue = table.Column<string>(name: "OpenSinusWithoutImplant_Value", type: "text", nullable: true),
                    OpenSinusWithoutImplantStatus = table.Column<bool>(name: "OpenSinusWithoutImplant_Status", type: "boolean", nullable: true),
                    OpenSinusWithoutImplantAssignedToID = table.Column<int>(name: "OpenSinusWithoutImplant_AssignedToID", type: "integer", nullable: true),
                    OpenSinusWithoutImplantPlanPrice = table.Column<int>(name: "OpenSinusWithoutImplant_PlanPrice", type: "integer", nullable: true),
                    OpenSinusWithoutImplantAssignedToId = table.Column<string>(name: "OpenSinusWithoutImplant_AssignedToId", type: "text", nullable: true),
                    OpenSinusWithoutImplantDate = table.Column<DateTime>(name: "OpenSinusWithoutImplant_Date", type: "timestamp with time zone", nullable: true),
                    OpenSinusWithoutImplantDoneByAssistantID = table.Column<int>(name: "OpenSinusWithoutImplant_DoneByAssistantID", type: "integer", nullable: true),
                    OpenSinusWithoutImplantDoneByAssistantId = table.Column<string>(name: "OpenSinusWithoutImplant_DoneByAssistantId", type: "text", nullable: true),
                    OpenSinusWithoutImplantDoneBySupervisorID = table.Column<int>(name: "OpenSinusWithoutImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    OpenSinusWithoutImplantDoneBySupervisorId = table.Column<string>(name: "OpenSinusWithoutImplant_DoneBySupervisorId", type: "text", nullable: true),
                    OpenSinusWithoutImplantDoneByCandidateID = table.Column<int>(name: "OpenSinusWithoutImplant_DoneByCandidateID", type: "integer", nullable: true),
                    OpenSinusWithoutImplantDoneByCandidateId = table.Column<string>(name: "OpenSinusWithoutImplant_DoneByCandidateId", type: "text", nullable: true),
                    OpenSinusWithoutImplantDoneByCandidateBatchID = table.Column<int>(name: "OpenSinusWithoutImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    OpenSinusWithoutImplantImplantID = table.Column<int>(name: "OpenSinusWithoutImplant_ImplantID", type: "integer", nullable: true),
                    OpenSinusWithoutImplantImplantIDRequest = table.Column<int>(name: "OpenSinusWithoutImplant_ImplantIDRequest", type: "integer", nullable: true),
                    OpenSinusWithoutImplantWebsite = table.Column<int>(name: "OpenSinusWithoutImplant_Website", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantRequestChangeId = table.Column<int>(name: "ClosedSinusWithoutImplant_RequestChangeId", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantValue = table.Column<string>(name: "ClosedSinusWithoutImplant_Value", type: "text", nullable: true),
                    ClosedSinusWithoutImplantStatus = table.Column<bool>(name: "ClosedSinusWithoutImplant_Status", type: "boolean", nullable: true),
                    ClosedSinusWithoutImplantAssignedToID = table.Column<int>(name: "ClosedSinusWithoutImplant_AssignedToID", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantPlanPrice = table.Column<int>(name: "ClosedSinusWithoutImplant_PlanPrice", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantAssignedToId = table.Column<string>(name: "ClosedSinusWithoutImplant_AssignedToId", type: "text", nullable: true),
                    ClosedSinusWithoutImplantDate = table.Column<DateTime>(name: "ClosedSinusWithoutImplant_Date", type: "timestamp with time zone", nullable: true),
                    ClosedSinusWithoutImplantDoneByAssistantID = table.Column<int>(name: "ClosedSinusWithoutImplant_DoneByAssistantID", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantDoneByAssistantId = table.Column<string>(name: "ClosedSinusWithoutImplant_DoneByAssistantId", type: "text", nullable: true),
                    ClosedSinusWithoutImplantDoneBySupervisorID = table.Column<int>(name: "ClosedSinusWithoutImplant_DoneBySupervisorID", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantDoneBySupervisorId = table.Column<string>(name: "ClosedSinusWithoutImplant_DoneBySupervisorId", type: "text", nullable: true),
                    ClosedSinusWithoutImplantDoneByCandidateID = table.Column<int>(name: "ClosedSinusWithoutImplant_DoneByCandidateID", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantDoneByCandidateId = table.Column<string>(name: "ClosedSinusWithoutImplant_DoneByCandidateId", type: "text", nullable: true),
                    ClosedSinusWithoutImplantDoneByCandidateBatchID = table.Column<int>(name: "ClosedSinusWithoutImplant_DoneByCandidateBatchID", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantImplantID = table.Column<int>(name: "ClosedSinusWithoutImplant_ImplantID", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantImplantIDRequest = table.Column<int>(name: "ClosedSinusWithoutImplant_ImplantIDRequest", type: "integer", nullable: true),
                    ClosedSinusWithoutImplantWebsite = table.Column<int>(name: "ClosedSinusWithoutImplant_Website", type: "integer", nullable: true),
                    Website = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TreatmentPlansSubModels", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ClosedSinusWithImplant_~",
                        column: x => x.ClosedSinusWithImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ClosedSinusWithImplant~1",
                        column: x => x.ClosedSinusWithImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ClosedSinusWithImplant~2",
                        column: x => x.ClosedSinusWithImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ClosedSinusWithImplant~3",
                        column: x => x.ClosedSinusWithImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ClosedSinusWithoutImpla~",
                        column: x => x.ClosedSinusWithoutImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ClosedSinusWithoutImpl~1",
                        column: x => x.ClosedSinusWithoutImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ClosedSinusWithoutImpl~2",
                        column: x => x.ClosedSinusWithoutImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ClosedSinusWithoutImpl~3",
                        column: x => x.ClosedSinusWithoutImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Crown_AssignedToId",
                        column: x => x.CrownAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Crown_DoneByAssistantId",
                        column: x => x.CrownDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Crown_DoneByCandidateId",
                        column: x => x.CrownDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Crown_DoneBySupervisorId",
                        column: x => x.CrownDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ExpansionWithImplant_As~",
                        column: x => x.ExpansionWithImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ExpansionWithImplant_Do~",
                        column: x => x.ExpansionWithImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ExpansionWithImplant_D~1",
                        column: x => x.ExpansionWithImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ExpansionWithImplant_D~2",
                        column: x => x.ExpansionWithImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ExpansionWithoutImplant~",
                        column: x => x.ExpansionWithoutImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ExpansionWithoutImplan~1",
                        column: x => x.ExpansionWithoutImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ExpansionWithoutImplan~2",
                        column: x => x.ExpansionWithoutImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ExpansionWithoutImplan~3",
                        column: x => x.ExpansionWithoutImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Extraction_AssignedToId",
                        column: x => x.ExtractionAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Extraction_DoneByAssist~",
                        column: x => x.ExtractionDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Extraction_DoneByCandid~",
                        column: x => x.ExtractionDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Extraction_DoneBySuperv~",
                        column: x => x.ExtractionDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GBRWithImplant_Assigned~",
                        column: x => x.GBRWithImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GBRWithImplant_DoneByAs~",
                        column: x => x.GBRWithImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GBRWithImplant_DoneByCa~",
                        column: x => x.GBRWithImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GBRWithImplant_DoneBySu~",
                        column: x => x.GBRWithImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GBRWithoutImplant_Assig~",
                        column: x => x.GBRWithoutImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GBRWithoutImplant_DoneB~",
                        column: x => x.GBRWithoutImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GBRWithoutImplant_Done~1",
                        column: x => x.GBRWithoutImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GBRWithoutImplant_Done~2",
                        column: x => x.GBRWithoutImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GuidedImplant_AssignedT~",
                        column: x => x.GuidedImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GuidedImplant_DoneByAss~",
                        column: x => x.GuidedImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GuidedImplant_DoneByCan~",
                        column: x => x.GuidedImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_GuidedImplant_DoneBySup~",
                        column: x => x.GuidedImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ImmediateImplant_Assign~",
                        column: x => x.ImmediateImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ImmediateImplant_DoneBy~",
                        column: x => x.ImmediateImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ImmediateImplant_DoneB~1",
                        column: x => x.ImmediateImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_ImmediateImplant_DoneB~2",
                        column: x => x.ImmediateImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_OpenSinusWithImplant_As~",
                        column: x => x.OpenSinusWithImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_OpenSinusWithImplant_Do~",
                        column: x => x.OpenSinusWithImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_OpenSinusWithImplant_D~1",
                        column: x => x.OpenSinusWithImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_OpenSinusWithImplant_D~2",
                        column: x => x.OpenSinusWithImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_OpenSinusWithoutImplant~",
                        column: x => x.OpenSinusWithoutImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_OpenSinusWithoutImplan~1",
                        column: x => x.OpenSinusWithoutImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_OpenSinusWithoutImplan~2",
                        column: x => x.OpenSinusWithoutImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_OpenSinusWithoutImplan~3",
                        column: x => x.OpenSinusWithoutImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Pontic_AssignedToId",
                        column: x => x.PonticAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Pontic_DoneByAssistantId",
                        column: x => x.PonticDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Pontic_DoneByCandidateId",
                        column: x => x.PonticDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Pontic_DoneBySupervisor~",
                        column: x => x.PonticDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Restoration_AssignedToId",
                        column: x => x.RestorationAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Restoration_DoneByAssis~",
                        column: x => x.RestorationDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Restoration_DoneByCandi~",
                        column: x => x.RestorationDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Restoration_DoneBySuper~",
                        column: x => x.RestorationDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_RootCanalTreatment_Assi~",
                        column: x => x.RootCanalTreatmentAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_RootCanalTreatment_Done~",
                        column: x => x.RootCanalTreatmentDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_RootCanalTreatment_Don~1",
                        column: x => x.RootCanalTreatmentDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_RootCanalTreatment_Don~2",
                        column: x => x.RootCanalTreatmentDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Scaling_AssignedToId",
                        column: x => x.ScalingAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Scaling_DoneByAssistant~",
                        column: x => x.ScalingDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Scaling_DoneByCandidate~",
                        column: x => x.ScalingDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_Scaling_DoneBySuperviso~",
                        column: x => x.ScalingDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SimpleImplant_AssignedT~",
                        column: x => x.SimpleImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SimpleImplant_DoneByAss~",
                        column: x => x.SimpleImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SimpleImplant_DoneByCan~",
                        column: x => x.SimpleImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SimpleImplant_DoneBySup~",
                        column: x => x.SimpleImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SplittingWithImplant_As~",
                        column: x => x.SplittingWithImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SplittingWithImplant_Do~",
                        column: x => x.SplittingWithImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SplittingWithImplant_D~1",
                        column: x => x.SplittingWithImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SplittingWithImplant_D~2",
                        column: x => x.SplittingWithImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SplittingWithoutImplant~",
                        column: x => x.SplittingWithoutImplantAssignedToId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SplittingWithoutImplan~1",
                        column: x => x.SplittingWithoutImplantDoneByAssistantId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SplittingWithoutImplan~2",
                        column: x => x.SplittingWithoutImplantDoneByCandidateId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_AspNetUsers_SplittingWithoutImplan~3",
                        column: x => x.SplittingWithoutImplantDoneBySupervisorId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ClosedSinusWithImplant_Imp~",
                        column: x => x.ClosedSinusWithImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ClosedSinusWithImplant_Im~1",
                        column: x => x.ClosedSinusWithImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ClosedSinusWithoutImplant_~",
                        column: x => x.ClosedSinusWithoutImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ClosedSinusWithoutImplant~1",
                        column: x => x.ClosedSinusWithoutImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Crown_ImplantID",
                        column: x => x.CrownImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Crown_ImplantIDRequest",
                        column: x => x.CrownImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ExpansionWithImplant_Impla~",
                        column: x => x.ExpansionWithImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ExpansionWithImplant_Impl~1",
                        column: x => x.ExpansionWithImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ExpansionWithoutImplant_Im~",
                        column: x => x.ExpansionWithoutImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ExpansionWithoutImplant_I~1",
                        column: x => x.ExpansionWithoutImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Extraction_ImplantID",
                        column: x => x.ExtractionImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Extraction_ImplantIDRequest",
                        column: x => x.ExtractionImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_GBRWithImplant_ImplantID",
                        column: x => x.GBRWithImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_GBRWithImplant_ImplantIDRe~",
                        column: x => x.GBRWithImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_GBRWithoutImplant_ImplantID",
                        column: x => x.GBRWithoutImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_GBRWithoutImplant_ImplantI~",
                        column: x => x.GBRWithoutImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_GuidedImplant_ImplantID",
                        column: x => x.GuidedImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_GuidedImplant_ImplantIDReq~",
                        column: x => x.GuidedImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ImmediateImplant_ImplantID",
                        column: x => x.ImmediateImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_ImmediateImplant_ImplantID~",
                        column: x => x.ImmediateImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_OpenSinusWithImplant_Impla~",
                        column: x => x.OpenSinusWithImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_OpenSinusWithImplant_Impl~1",
                        column: x => x.OpenSinusWithImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_OpenSinusWithoutImplant_Im~",
                        column: x => x.OpenSinusWithoutImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_OpenSinusWithoutImplant_I~1",
                        column: x => x.OpenSinusWithoutImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Pontic_ImplantID",
                        column: x => x.PonticImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Pontic_ImplantIDRequest",
                        column: x => x.PonticImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Restoration_ImplantID",
                        column: x => x.RestorationImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Restoration_ImplantIDReque~",
                        column: x => x.RestorationImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_RootCanalTreatment_Implant~",
                        column: x => x.RootCanalTreatmentImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_RootCanalTreatment_Implan~1",
                        column: x => x.RootCanalTreatmentImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Scaling_ImplantID",
                        column: x => x.ScalingImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_Scaling_ImplantIDRequest",
                        column: x => x.ScalingImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_SimpleImplant_ImplantID",
                        column: x => x.SimpleImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_SimpleImplant_ImplantIDReq~",
                        column: x => x.SimpleImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_SplittingWithImplant_Impla~",
                        column: x => x.SplittingWithImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_SplittingWithImplant_Impl~1",
                        column: x => x.SplittingWithImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_SplittingWithoutImplant_Im~",
                        column: x => x.SplittingWithoutImplantImplantID,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_CashFlow_SplittingWithoutImplant_I~1",
                        column: x => x.SplittingWithoutImplantImplantIDRequest,
                        principalTable: "CashFlow",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_ClosedSinusWithImplant_Do~",
                        column: x => x.ClosedSinusWithImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_ClosedSinusWithoutImplant~",
                        column: x => x.ClosedSinusWithoutImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_Crown_DoneByCandidateBatc~",
                        column: x => x.CrownDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_ExpansionWithImplant_Done~",
                        column: x => x.ExpansionWithImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_ExpansionWithoutImplant_D~",
                        column: x => x.ExpansionWithoutImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_Extraction_DoneByCandidat~",
                        column: x => x.ExtractionDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_GBRWithImplant_DoneByCand~",
                        column: x => x.GBRWithImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_GBRWithoutImplant_DoneByC~",
                        column: x => x.GBRWithoutImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_GuidedImplant_DoneByCandi~",
                        column: x => x.GuidedImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_ImmediateImplant_DoneByCa~",
                        column: x => x.ImmediateImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_OpenSinusWithImplant_Done~",
                        column: x => x.OpenSinusWithImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_OpenSinusWithoutImplant_D~",
                        column: x => x.OpenSinusWithoutImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_Pontic_DoneByCandidateBat~",
                        column: x => x.PonticDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_Restoration_DoneByCandida~",
                        column: x => x.RestorationDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_RootCanalTreatment_DoneBy~",
                        column: x => x.RootCanalTreatmentDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_Scaling_DoneByCandidateBa~",
                        column: x => x.ScalingDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_SimpleImplant_DoneByCandi~",
                        column: x => x.SimpleImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_SplittingWithImplant_Done~",
                        column: x => x.SplittingWithImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_DropDowns_SplittingWithoutImplant_D~",
                        column: x => x.SplittingWithoutImplantDoneByCandidateBatchID,
                        principalTable: "DropDowns",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_Patients_PatientId",
                        column: x => x.PatientId,
                        principalTable: "Patients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_ClosedSinusWithImpla~",
                        column: x => x.ClosedSinusWithImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_ClosedSinusWithoutIm~",
                        column: x => x.ClosedSinusWithoutImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_Crown_RequestChangeId",
                        column: x => x.CrownRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_ExpansionWithImplant~",
                        column: x => x.ExpansionWithImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_ExpansionWithoutImpl~",
                        column: x => x.ExpansionWithoutImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_Extraction_RequestCh~",
                        column: x => x.ExtractionRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_GBRWithImplant_Reque~",
                        column: x => x.GBRWithImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_GBRWithoutImplant_Re~",
                        column: x => x.GBRWithoutImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_GuidedImplant_Reques~",
                        column: x => x.GuidedImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_ImmediateImplant_Req~",
                        column: x => x.ImmediateImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_OpenSinusWithImplant~",
                        column: x => x.OpenSinusWithImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_OpenSinusWithoutImpl~",
                        column: x => x.OpenSinusWithoutImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_Pontic_RequestChange~",
                        column: x => x.PonticRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_Restoration_RequestC~",
                        column: x => x.RestorationRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_RootCanalTreatment_R~",
                        column: x => x.RootCanalTreatmentRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_Scaling_RequestChang~",
                        column: x => x.ScalingRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_SimpleImplant_Reques~",
                        column: x => x.SimpleImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_SplittingWithImplant~",
                        column: x => x.SplittingWithImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TreatmentPlansSubModels_RequestChanges_SplittingWithoutImpl~",
                        column: x => x.SplittingWithoutImplantRequestChangeId,
                        principalTable: "RequestChanges",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "3ab751a0-c843-4601-a13e-d0bd2877143f", null, "instructor", "INSTRUCTOR" },
                    { "51fbd5fa-2d92-4107-930a-368afcb79693", null, "assistant", "ASSISTANT" },
                    { "725ee612-7bf9-444c-85ad-162eff90f1c1", null, "outsource", "OUTSOURCE" },
                    { "7976757b-4f45-4d74-8de9-7b2456f16830", null, "technician", "TECHNICIAN" },
                    { "c16a4456-2f2a-4a3d-874e-5aae449835b9", null, "secretary", "SECRETARY" },
                    { "c83449cd-1979-4ea0-b293-227e271fc612", null, "labmoderator", "LABMODERATOR" },
                    { "d43b451c-ad08-4764-ae04-0a929c9151e8", null, "admin", "ADMIN" },
                    { "e1a6928d-ced0-44af-9f25-b844d244ebf3", null, "candidate", "CANDIDATE" }
                });

            migrationBuilder.InsertData(
                table: "ClinicPrices",
                columns: new[] { "Id", "Category", "Price", "Tooth" },
                values: new object[,]
                {
                    { 1, 0, 0, 1 },
                    { 2, 1, 0, 1 },
                    { 3, 2, 0, 1 },
                    { 4, 3, 0, 1 },
                    { 5, 4, 0, 1 },
                    { 6, 5, 0, 1 },
                    { 7, 6, 0, 1 },
                    { 8, 7, 0, 1 },
                    { 9, 8, 0, 1 },
                    { 10, 9, 0, 1 },
                    { 11, 10, 0, 1 },
                    { 12, 11, 0, 1 },
                    { 13, 12, 0, 1 },
                    { 14, 13, 0, 1 },
                    { 15, 14, 0, 1 },
                    { 16, 15, 0, 1 },
                    { 17, 16, 0, 1 },
                    { 18, 17, 0, 1 },
                    { 19, 18, 0, 1 },
                    { 20, 19, 0, 1 },
                    { 21, 20, 0, 1 },
                    { 22, 21, 0, 1 },
                    { 23, 22, 0, 1 },
                    { 24, 23, 0, 1 },
                    { 25, 24, 0, 1 },
                    { 26, 25, 0, 1 },
                    { 27, 26, 0, 1 },
                    { 28, 27, 0, 1 },
                    { 29, 28, 0, 1 },
                    { 30, 29, 0, 1 },
                    { 31, 30, 0, 1 },
                    { 32, 31, 0, 1 },
                    { 33, 32, 0, 1 },
                    { 34, 33, 0, 1 },
                    { 35, 34, 0, 1 },
                    { 36, 35, 0, 1 },
                    { 37, 36, 0, 1 },
                    { 38, 37, 0, 1 },
                    { 39, 38, 0, 1 },
                    { 40, 39, 0, 1 },
                    { 41, 40, 0, 1 },
                    { 42, 41, 0, 1 },
                    { 43, 42, 0, 1 },
                    { 44, 43, 0, 1 },
                    { 45, 44, 0, 1 },
                    { 46, 45, 0, 1 },
                    { 47, 46, 0, 1 },
                    { 48, 0, 0, 2 },
                    { 49, 1, 0, 2 },
                    { 50, 2, 0, 2 },
                    { 51, 3, 0, 2 },
                    { 52, 4, 0, 2 },
                    { 53, 5, 0, 2 },
                    { 54, 6, 0, 2 },
                    { 55, 7, 0, 2 },
                    { 56, 8, 0, 2 },
                    { 57, 9, 0, 2 },
                    { 58, 10, 0, 2 },
                    { 59, 11, 0, 2 },
                    { 60, 12, 0, 2 },
                    { 61, 13, 0, 2 },
                    { 62, 14, 0, 2 },
                    { 63, 15, 0, 2 },
                    { 64, 16, 0, 2 },
                    { 65, 17, 0, 2 },
                    { 66, 18, 0, 2 },
                    { 67, 19, 0, 2 },
                    { 68, 20, 0, 2 },
                    { 69, 21, 0, 2 },
                    { 70, 22, 0, 2 },
                    { 71, 23, 0, 2 },
                    { 72, 24, 0, 2 },
                    { 73, 25, 0, 2 },
                    { 74, 26, 0, 2 },
                    { 75, 27, 0, 2 },
                    { 76, 28, 0, 2 },
                    { 77, 29, 0, 2 },
                    { 78, 30, 0, 2 },
                    { 79, 31, 0, 2 },
                    { 80, 32, 0, 2 },
                    { 81, 33, 0, 2 },
                    { 82, 34, 0, 2 },
                    { 83, 35, 0, 2 },
                    { 84, 36, 0, 2 },
                    { 85, 37, 0, 2 },
                    { 86, 38, 0, 2 },
                    { 87, 39, 0, 2 },
                    { 88, 40, 0, 2 },
                    { 89, 41, 0, 2 },
                    { 90, 42, 0, 2 },
                    { 91, 43, 0, 2 },
                    { 92, 44, 0, 2 },
                    { 93, 45, 0, 2 },
                    { 94, 46, 0, 2 },
                    { 95, 0, 0, 3 },
                    { 96, 1, 0, 3 },
                    { 97, 2, 0, 3 },
                    { 98, 3, 0, 3 },
                    { 99, 4, 0, 3 },
                    { 100, 5, 0, 3 },
                    { 101, 6, 0, 3 },
                    { 102, 7, 0, 3 },
                    { 103, 8, 0, 3 },
                    { 104, 9, 0, 3 },
                    { 105, 10, 0, 3 },
                    { 106, 11, 0, 3 },
                    { 107, 12, 0, 3 },
                    { 108, 13, 0, 3 },
                    { 109, 14, 0, 3 },
                    { 110, 15, 0, 3 },
                    { 111, 16, 0, 3 },
                    { 112, 17, 0, 3 },
                    { 113, 18, 0, 3 },
                    { 114, 19, 0, 3 },
                    { 115, 20, 0, 3 },
                    { 116, 21, 0, 3 },
                    { 117, 22, 0, 3 },
                    { 118, 23, 0, 3 },
                    { 119, 24, 0, 3 },
                    { 120, 25, 0, 3 },
                    { 121, 26, 0, 3 },
                    { 122, 27, 0, 3 },
                    { 123, 28, 0, 3 },
                    { 124, 29, 0, 3 },
                    { 125, 30, 0, 3 },
                    { 126, 31, 0, 3 },
                    { 127, 32, 0, 3 },
                    { 128, 33, 0, 3 },
                    { 129, 34, 0, 3 },
                    { 130, 35, 0, 3 },
                    { 131, 36, 0, 3 },
                    { 132, 37, 0, 3 },
                    { 133, 38, 0, 3 },
                    { 134, 39, 0, 3 },
                    { 135, 40, 0, 3 },
                    { 136, 41, 0, 3 },
                    { 137, 42, 0, 3 },
                    { 138, 43, 0, 3 },
                    { 139, 44, 0, 3 },
                    { 140, 45, 0, 3 },
                    { 141, 46, 0, 3 },
                    { 142, 0, 0, 4 },
                    { 143, 1, 0, 4 },
                    { 144, 2, 0, 4 },
                    { 145, 3, 0, 4 },
                    { 146, 4, 0, 4 },
                    { 147, 5, 0, 4 },
                    { 148, 6, 0, 4 },
                    { 149, 7, 0, 4 },
                    { 150, 8, 0, 4 },
                    { 151, 9, 0, 4 },
                    { 152, 10, 0, 4 },
                    { 153, 11, 0, 4 },
                    { 154, 12, 0, 4 },
                    { 155, 13, 0, 4 },
                    { 156, 14, 0, 4 },
                    { 157, 15, 0, 4 },
                    { 158, 16, 0, 4 },
                    { 159, 17, 0, 4 },
                    { 160, 18, 0, 4 },
                    { 161, 19, 0, 4 },
                    { 162, 20, 0, 4 },
                    { 163, 21, 0, 4 },
                    { 164, 22, 0, 4 },
                    { 165, 23, 0, 4 },
                    { 166, 24, 0, 4 },
                    { 167, 25, 0, 4 },
                    { 168, 26, 0, 4 },
                    { 169, 27, 0, 4 },
                    { 170, 28, 0, 4 },
                    { 171, 29, 0, 4 },
                    { 172, 30, 0, 4 },
                    { 173, 31, 0, 4 },
                    { 174, 32, 0, 4 },
                    { 175, 33, 0, 4 },
                    { 176, 34, 0, 4 },
                    { 177, 35, 0, 4 },
                    { 178, 36, 0, 4 },
                    { 179, 37, 0, 4 },
                    { 180, 38, 0, 4 },
                    { 181, 39, 0, 4 },
                    { 182, 40, 0, 4 },
                    { 183, 41, 0, 4 },
                    { 184, 42, 0, 4 },
                    { 185, 43, 0, 4 },
                    { 186, 44, 0, 4 },
                    { 187, 45, 0, 4 },
                    { 188, 46, 0, 4 },
                    { 189, 0, 0, 5 },
                    { 190, 1, 0, 5 },
                    { 191, 2, 0, 5 },
                    { 192, 3, 0, 5 },
                    { 193, 4, 0, 5 },
                    { 194, 5, 0, 5 },
                    { 195, 6, 0, 5 },
                    { 196, 7, 0, 5 },
                    { 197, 8, 0, 5 },
                    { 198, 9, 0, 5 },
                    { 199, 10, 0, 5 },
                    { 200, 11, 0, 5 },
                    { 201, 12, 0, 5 },
                    { 202, 13, 0, 5 },
                    { 203, 14, 0, 5 },
                    { 204, 15, 0, 5 },
                    { 205, 16, 0, 5 },
                    { 206, 17, 0, 5 },
                    { 207, 18, 0, 5 },
                    { 208, 19, 0, 5 },
                    { 209, 20, 0, 5 },
                    { 210, 21, 0, 5 },
                    { 211, 22, 0, 5 },
                    { 212, 23, 0, 5 },
                    { 213, 24, 0, 5 },
                    { 214, 25, 0, 5 },
                    { 215, 26, 0, 5 },
                    { 216, 27, 0, 5 },
                    { 217, 28, 0, 5 },
                    { 218, 29, 0, 5 },
                    { 219, 30, 0, 5 },
                    { 220, 31, 0, 5 },
                    { 221, 32, 0, 5 },
                    { 222, 33, 0, 5 },
                    { 223, 34, 0, 5 },
                    { 224, 35, 0, 5 },
                    { 225, 36, 0, 5 },
                    { 226, 37, 0, 5 },
                    { 227, 38, 0, 5 },
                    { 228, 39, 0, 5 },
                    { 229, 40, 0, 5 },
                    { 230, 41, 0, 5 },
                    { 231, 42, 0, 5 },
                    { 232, 43, 0, 5 },
                    { 233, 44, 0, 5 },
                    { 234, 45, 0, 5 },
                    { 235, 46, 0, 5 },
                    { 236, 0, 0, 6 },
                    { 237, 1, 0, 6 },
                    { 238, 2, 0, 6 },
                    { 239, 3, 0, 6 },
                    { 240, 4, 0, 6 },
                    { 241, 5, 0, 6 },
                    { 242, 6, 0, 6 },
                    { 243, 7, 0, 6 },
                    { 244, 8, 0, 6 },
                    { 245, 9, 0, 6 },
                    { 246, 10, 0, 6 },
                    { 247, 11, 0, 6 },
                    { 248, 12, 0, 6 },
                    { 249, 13, 0, 6 },
                    { 250, 14, 0, 6 },
                    { 251, 15, 0, 6 },
                    { 252, 16, 0, 6 },
                    { 253, 17, 0, 6 },
                    { 254, 18, 0, 6 },
                    { 255, 19, 0, 6 },
                    { 256, 20, 0, 6 },
                    { 257, 21, 0, 6 },
                    { 258, 22, 0, 6 },
                    { 259, 23, 0, 6 },
                    { 260, 24, 0, 6 },
                    { 261, 25, 0, 6 },
                    { 262, 26, 0, 6 },
                    { 263, 27, 0, 6 },
                    { 264, 28, 0, 6 },
                    { 265, 29, 0, 6 },
                    { 266, 30, 0, 6 },
                    { 267, 31, 0, 6 },
                    { 268, 32, 0, 6 },
                    { 269, 33, 0, 6 },
                    { 270, 34, 0, 6 },
                    { 271, 35, 0, 6 },
                    { 272, 36, 0, 6 },
                    { 273, 37, 0, 6 },
                    { 274, 38, 0, 6 },
                    { 275, 39, 0, 6 },
                    { 276, 40, 0, 6 },
                    { 277, 41, 0, 6 },
                    { 278, 42, 0, 6 },
                    { 279, 43, 0, 6 },
                    { 280, 44, 0, 6 },
                    { 281, 45, 0, 6 },
                    { 282, 46, 0, 6 },
                    { 283, 0, 0, 7 },
                    { 284, 1, 0, 7 },
                    { 285, 2, 0, 7 },
                    { 286, 3, 0, 7 },
                    { 287, 4, 0, 7 },
                    { 288, 5, 0, 7 },
                    { 289, 6, 0, 7 },
                    { 290, 7, 0, 7 },
                    { 291, 8, 0, 7 },
                    { 292, 9, 0, 7 },
                    { 293, 10, 0, 7 },
                    { 294, 11, 0, 7 },
                    { 295, 12, 0, 7 },
                    { 296, 13, 0, 7 },
                    { 297, 14, 0, 7 },
                    { 298, 15, 0, 7 },
                    { 299, 16, 0, 7 },
                    { 300, 17, 0, 7 },
                    { 301, 18, 0, 7 },
                    { 302, 19, 0, 7 },
                    { 303, 20, 0, 7 },
                    { 304, 21, 0, 7 },
                    { 305, 22, 0, 7 },
                    { 306, 23, 0, 7 },
                    { 307, 24, 0, 7 },
                    { 308, 25, 0, 7 },
                    { 309, 26, 0, 7 },
                    { 310, 27, 0, 7 },
                    { 311, 28, 0, 7 },
                    { 312, 29, 0, 7 },
                    { 313, 30, 0, 7 },
                    { 314, 31, 0, 7 },
                    { 315, 32, 0, 7 },
                    { 316, 33, 0, 7 },
                    { 317, 34, 0, 7 },
                    { 318, 35, 0, 7 },
                    { 319, 36, 0, 7 },
                    { 320, 37, 0, 7 },
                    { 321, 38, 0, 7 },
                    { 322, 39, 0, 7 },
                    { 323, 40, 0, 7 },
                    { 324, 41, 0, 7 },
                    { 325, 42, 0, 7 },
                    { 326, 43, 0, 7 },
                    { 327, 44, 0, 7 },
                    { 328, 45, 0, 7 },
                    { 329, 46, 0, 7 },
                    { 330, 0, 0, 8 },
                    { 331, 1, 0, 8 },
                    { 332, 2, 0, 8 },
                    { 333, 3, 0, 8 },
                    { 334, 4, 0, 8 },
                    { 335, 5, 0, 8 },
                    { 336, 6, 0, 8 },
                    { 337, 7, 0, 8 },
                    { 338, 8, 0, 8 },
                    { 339, 9, 0, 8 },
                    { 340, 10, 0, 8 },
                    { 341, 11, 0, 8 },
                    { 342, 12, 0, 8 },
                    { 343, 13, 0, 8 },
                    { 344, 14, 0, 8 },
                    { 345, 15, 0, 8 },
                    { 346, 16, 0, 8 },
                    { 347, 17, 0, 8 },
                    { 348, 18, 0, 8 },
                    { 349, 19, 0, 8 },
                    { 350, 20, 0, 8 },
                    { 351, 21, 0, 8 },
                    { 352, 22, 0, 8 },
                    { 353, 23, 0, 8 },
                    { 354, 24, 0, 8 },
                    { 355, 25, 0, 8 },
                    { 356, 26, 0, 8 },
                    { 357, 27, 0, 8 },
                    { 358, 28, 0, 8 },
                    { 359, 29, 0, 8 },
                    { 360, 30, 0, 8 },
                    { 361, 31, 0, 8 },
                    { 362, 32, 0, 8 },
                    { 363, 33, 0, 8 },
                    { 364, 34, 0, 8 },
                    { 365, 35, 0, 8 },
                    { 366, 36, 0, 8 },
                    { 367, 37, 0, 8 },
                    { 368, 38, 0, 8 },
                    { 369, 39, 0, 8 },
                    { 370, 40, 0, 8 },
                    { 371, 41, 0, 8 },
                    { 372, 42, 0, 8 },
                    { 373, 43, 0, 8 },
                    { 374, 44, 0, 8 },
                    { 375, 45, 0, 8 },
                    { 376, 46, 0, 8 },
                    { 377, 0, 0, 11 },
                    { 378, 1, 0, 11 },
                    { 379, 2, 0, 11 },
                    { 380, 3, 0, 11 },
                    { 381, 4, 0, 11 },
                    { 382, 5, 0, 11 },
                    { 383, 6, 0, 11 },
                    { 384, 7, 0, 11 },
                    { 385, 8, 0, 11 },
                    { 386, 9, 0, 11 },
                    { 387, 10, 0, 11 },
                    { 388, 11, 0, 11 },
                    { 389, 12, 0, 11 },
                    { 390, 13, 0, 11 },
                    { 391, 14, 0, 11 },
                    { 392, 15, 0, 11 },
                    { 393, 16, 0, 11 },
                    { 394, 17, 0, 11 },
                    { 395, 18, 0, 11 },
                    { 396, 19, 0, 11 },
                    { 397, 20, 0, 11 },
                    { 398, 21, 0, 11 },
                    { 399, 22, 0, 11 },
                    { 400, 23, 0, 11 },
                    { 401, 24, 0, 11 },
                    { 402, 25, 0, 11 },
                    { 403, 26, 0, 11 },
                    { 404, 27, 0, 11 },
                    { 405, 28, 0, 11 },
                    { 406, 29, 0, 11 },
                    { 407, 30, 0, 11 },
                    { 408, 31, 0, 11 },
                    { 409, 32, 0, 11 },
                    { 410, 33, 0, 11 },
                    { 411, 34, 0, 11 },
                    { 412, 35, 0, 11 },
                    { 413, 36, 0, 11 },
                    { 414, 37, 0, 11 },
                    { 415, 38, 0, 11 },
                    { 416, 39, 0, 11 },
                    { 417, 40, 0, 11 },
                    { 418, 41, 0, 11 },
                    { 419, 42, 0, 11 },
                    { 420, 43, 0, 11 },
                    { 421, 44, 0, 11 },
                    { 422, 45, 0, 11 },
                    { 423, 46, 0, 11 },
                    { 424, 0, 0, 12 },
                    { 425, 1, 0, 12 },
                    { 426, 2, 0, 12 },
                    { 427, 3, 0, 12 },
                    { 428, 4, 0, 12 },
                    { 429, 5, 0, 12 },
                    { 430, 6, 0, 12 },
                    { 431, 7, 0, 12 },
                    { 432, 8, 0, 12 },
                    { 433, 9, 0, 12 },
                    { 434, 10, 0, 12 },
                    { 435, 11, 0, 12 },
                    { 436, 12, 0, 12 },
                    { 437, 13, 0, 12 },
                    { 438, 14, 0, 12 },
                    { 439, 15, 0, 12 },
                    { 440, 16, 0, 12 },
                    { 441, 17, 0, 12 },
                    { 442, 18, 0, 12 },
                    { 443, 19, 0, 12 },
                    { 444, 20, 0, 12 },
                    { 445, 21, 0, 12 },
                    { 446, 22, 0, 12 },
                    { 447, 23, 0, 12 },
                    { 448, 24, 0, 12 },
                    { 449, 25, 0, 12 },
                    { 450, 26, 0, 12 },
                    { 451, 27, 0, 12 },
                    { 452, 28, 0, 12 },
                    { 453, 29, 0, 12 },
                    { 454, 30, 0, 12 },
                    { 455, 31, 0, 12 },
                    { 456, 32, 0, 12 },
                    { 457, 33, 0, 12 },
                    { 458, 34, 0, 12 },
                    { 459, 35, 0, 12 },
                    { 460, 36, 0, 12 },
                    { 461, 37, 0, 12 },
                    { 462, 38, 0, 12 },
                    { 463, 39, 0, 12 },
                    { 464, 40, 0, 12 },
                    { 465, 41, 0, 12 },
                    { 466, 42, 0, 12 },
                    { 467, 43, 0, 12 },
                    { 468, 44, 0, 12 },
                    { 469, 45, 0, 12 },
                    { 470, 46, 0, 12 },
                    { 471, 0, 0, 13 },
                    { 472, 1, 0, 13 },
                    { 473, 2, 0, 13 },
                    { 474, 3, 0, 13 },
                    { 475, 4, 0, 13 },
                    { 476, 5, 0, 13 },
                    { 477, 6, 0, 13 },
                    { 478, 7, 0, 13 },
                    { 479, 8, 0, 13 },
                    { 480, 9, 0, 13 },
                    { 481, 10, 0, 13 },
                    { 482, 11, 0, 13 },
                    { 483, 12, 0, 13 },
                    { 484, 13, 0, 13 },
                    { 485, 14, 0, 13 },
                    { 486, 15, 0, 13 },
                    { 487, 16, 0, 13 },
                    { 488, 17, 0, 13 },
                    { 489, 18, 0, 13 },
                    { 490, 19, 0, 13 },
                    { 491, 20, 0, 13 },
                    { 492, 21, 0, 13 },
                    { 493, 22, 0, 13 },
                    { 494, 23, 0, 13 },
                    { 495, 24, 0, 13 },
                    { 496, 25, 0, 13 },
                    { 497, 26, 0, 13 },
                    { 498, 27, 0, 13 },
                    { 499, 28, 0, 13 },
                    { 500, 29, 0, 13 },
                    { 501, 30, 0, 13 },
                    { 502, 31, 0, 13 },
                    { 503, 32, 0, 13 },
                    { 504, 33, 0, 13 },
                    { 505, 34, 0, 13 },
                    { 506, 35, 0, 13 },
                    { 507, 36, 0, 13 },
                    { 508, 37, 0, 13 },
                    { 509, 38, 0, 13 },
                    { 510, 39, 0, 13 },
                    { 511, 40, 0, 13 },
                    { 512, 41, 0, 13 },
                    { 513, 42, 0, 13 },
                    { 514, 43, 0, 13 },
                    { 515, 44, 0, 13 },
                    { 516, 45, 0, 13 },
                    { 517, 46, 0, 13 },
                    { 518, 0, 0, 14 },
                    { 519, 1, 0, 14 },
                    { 520, 2, 0, 14 },
                    { 521, 3, 0, 14 },
                    { 522, 4, 0, 14 },
                    { 523, 5, 0, 14 },
                    { 524, 6, 0, 14 },
                    { 525, 7, 0, 14 },
                    { 526, 8, 0, 14 },
                    { 527, 9, 0, 14 },
                    { 528, 10, 0, 14 },
                    { 529, 11, 0, 14 },
                    { 530, 12, 0, 14 },
                    { 531, 13, 0, 14 },
                    { 532, 14, 0, 14 },
                    { 533, 15, 0, 14 },
                    { 534, 16, 0, 14 },
                    { 535, 17, 0, 14 },
                    { 536, 18, 0, 14 },
                    { 537, 19, 0, 14 },
                    { 538, 20, 0, 14 },
                    { 539, 21, 0, 14 },
                    { 540, 22, 0, 14 },
                    { 541, 23, 0, 14 },
                    { 542, 24, 0, 14 },
                    { 543, 25, 0, 14 },
                    { 544, 26, 0, 14 },
                    { 545, 27, 0, 14 },
                    { 546, 28, 0, 14 },
                    { 547, 29, 0, 14 },
                    { 548, 30, 0, 14 },
                    { 549, 31, 0, 14 },
                    { 550, 32, 0, 14 },
                    { 551, 33, 0, 14 },
                    { 552, 34, 0, 14 },
                    { 553, 35, 0, 14 },
                    { 554, 36, 0, 14 },
                    { 555, 37, 0, 14 },
                    { 556, 38, 0, 14 },
                    { 557, 39, 0, 14 },
                    { 558, 40, 0, 14 },
                    { 559, 41, 0, 14 },
                    { 560, 42, 0, 14 },
                    { 561, 43, 0, 14 },
                    { 562, 44, 0, 14 },
                    { 563, 45, 0, 14 },
                    { 564, 46, 0, 14 },
                    { 565, 0, 0, 15 },
                    { 566, 1, 0, 15 },
                    { 567, 2, 0, 15 },
                    { 568, 3, 0, 15 },
                    { 569, 4, 0, 15 },
                    { 570, 5, 0, 15 },
                    { 571, 6, 0, 15 },
                    { 572, 7, 0, 15 },
                    { 573, 8, 0, 15 },
                    { 574, 9, 0, 15 },
                    { 575, 10, 0, 15 },
                    { 576, 11, 0, 15 },
                    { 577, 12, 0, 15 },
                    { 578, 13, 0, 15 },
                    { 579, 14, 0, 15 },
                    { 580, 15, 0, 15 },
                    { 581, 16, 0, 15 },
                    { 582, 17, 0, 15 },
                    { 583, 18, 0, 15 },
                    { 584, 19, 0, 15 },
                    { 585, 20, 0, 15 },
                    { 586, 21, 0, 15 },
                    { 587, 22, 0, 15 },
                    { 588, 23, 0, 15 },
                    { 589, 24, 0, 15 },
                    { 590, 25, 0, 15 },
                    { 591, 26, 0, 15 },
                    { 592, 27, 0, 15 },
                    { 593, 28, 0, 15 },
                    { 594, 29, 0, 15 },
                    { 595, 30, 0, 15 },
                    { 596, 31, 0, 15 },
                    { 597, 32, 0, 15 },
                    { 598, 33, 0, 15 },
                    { 599, 34, 0, 15 },
                    { 600, 35, 0, 15 },
                    { 601, 36, 0, 15 },
                    { 602, 37, 0, 15 },
                    { 603, 38, 0, 15 },
                    { 604, 39, 0, 15 },
                    { 605, 40, 0, 15 },
                    { 606, 41, 0, 15 },
                    { 607, 42, 0, 15 },
                    { 608, 43, 0, 15 },
                    { 609, 44, 0, 15 },
                    { 610, 45, 0, 15 },
                    { 611, 46, 0, 15 },
                    { 612, 0, 0, 16 },
                    { 613, 1, 0, 16 },
                    { 614, 2, 0, 16 },
                    { 615, 3, 0, 16 },
                    { 616, 4, 0, 16 },
                    { 617, 5, 0, 16 },
                    { 618, 6, 0, 16 },
                    { 619, 7, 0, 16 },
                    { 620, 8, 0, 16 },
                    { 621, 9, 0, 16 },
                    { 622, 10, 0, 16 },
                    { 623, 11, 0, 16 },
                    { 624, 12, 0, 16 },
                    { 625, 13, 0, 16 },
                    { 626, 14, 0, 16 },
                    { 627, 15, 0, 16 },
                    { 628, 16, 0, 16 },
                    { 629, 17, 0, 16 },
                    { 630, 18, 0, 16 },
                    { 631, 19, 0, 16 },
                    { 632, 20, 0, 16 },
                    { 633, 21, 0, 16 },
                    { 634, 22, 0, 16 },
                    { 635, 23, 0, 16 },
                    { 636, 24, 0, 16 },
                    { 637, 25, 0, 16 },
                    { 638, 26, 0, 16 },
                    { 639, 27, 0, 16 },
                    { 640, 28, 0, 16 },
                    { 641, 29, 0, 16 },
                    { 642, 30, 0, 16 },
                    { 643, 31, 0, 16 },
                    { 644, 32, 0, 16 },
                    { 645, 33, 0, 16 },
                    { 646, 34, 0, 16 },
                    { 647, 35, 0, 16 },
                    { 648, 36, 0, 16 },
                    { 649, 37, 0, 16 },
                    { 650, 38, 0, 16 },
                    { 651, 39, 0, 16 },
                    { 652, 40, 0, 16 },
                    { 653, 41, 0, 16 },
                    { 654, 42, 0, 16 },
                    { 655, 43, 0, 16 },
                    { 656, 44, 0, 16 },
                    { 657, 45, 0, 16 },
                    { 658, 46, 0, 16 },
                    { 659, 0, 0, 17 },
                    { 660, 1, 0, 17 },
                    { 661, 2, 0, 17 },
                    { 662, 3, 0, 17 },
                    { 663, 4, 0, 17 },
                    { 664, 5, 0, 17 },
                    { 665, 6, 0, 17 },
                    { 666, 7, 0, 17 },
                    { 667, 8, 0, 17 },
                    { 668, 9, 0, 17 },
                    { 669, 10, 0, 17 },
                    { 670, 11, 0, 17 },
                    { 671, 12, 0, 17 },
                    { 672, 13, 0, 17 },
                    { 673, 14, 0, 17 },
                    { 674, 15, 0, 17 },
                    { 675, 16, 0, 17 },
                    { 676, 17, 0, 17 },
                    { 677, 18, 0, 17 },
                    { 678, 19, 0, 17 },
                    { 679, 20, 0, 17 },
                    { 680, 21, 0, 17 },
                    { 681, 22, 0, 17 },
                    { 682, 23, 0, 17 },
                    { 683, 24, 0, 17 },
                    { 684, 25, 0, 17 },
                    { 685, 26, 0, 17 },
                    { 686, 27, 0, 17 },
                    { 687, 28, 0, 17 },
                    { 688, 29, 0, 17 },
                    { 689, 30, 0, 17 },
                    { 690, 31, 0, 17 },
                    { 691, 32, 0, 17 },
                    { 692, 33, 0, 17 },
                    { 693, 34, 0, 17 },
                    { 694, 35, 0, 17 },
                    { 695, 36, 0, 17 },
                    { 696, 37, 0, 17 },
                    { 697, 38, 0, 17 },
                    { 698, 39, 0, 17 },
                    { 699, 40, 0, 17 },
                    { 700, 41, 0, 17 },
                    { 701, 42, 0, 17 },
                    { 702, 43, 0, 17 },
                    { 703, 44, 0, 17 },
                    { 704, 45, 0, 17 },
                    { 705, 46, 0, 17 },
                    { 706, 0, 0, 18 },
                    { 707, 1, 0, 18 },
                    { 708, 2, 0, 18 },
                    { 709, 3, 0, 18 },
                    { 710, 4, 0, 18 },
                    { 711, 5, 0, 18 },
                    { 712, 6, 0, 18 },
                    { 713, 7, 0, 18 },
                    { 714, 8, 0, 18 },
                    { 715, 9, 0, 18 },
                    { 716, 10, 0, 18 },
                    { 717, 11, 0, 18 },
                    { 718, 12, 0, 18 },
                    { 719, 13, 0, 18 },
                    { 720, 14, 0, 18 },
                    { 721, 15, 0, 18 },
                    { 722, 16, 0, 18 },
                    { 723, 17, 0, 18 },
                    { 724, 18, 0, 18 },
                    { 725, 19, 0, 18 },
                    { 726, 20, 0, 18 },
                    { 727, 21, 0, 18 },
                    { 728, 22, 0, 18 },
                    { 729, 23, 0, 18 },
                    { 730, 24, 0, 18 },
                    { 731, 25, 0, 18 },
                    { 732, 26, 0, 18 },
                    { 733, 27, 0, 18 },
                    { 734, 28, 0, 18 },
                    { 735, 29, 0, 18 },
                    { 736, 30, 0, 18 },
                    { 737, 31, 0, 18 },
                    { 738, 32, 0, 18 },
                    { 739, 33, 0, 18 },
                    { 740, 34, 0, 18 },
                    { 741, 35, 0, 18 },
                    { 742, 36, 0, 18 },
                    { 743, 37, 0, 18 },
                    { 744, 38, 0, 18 },
                    { 745, 39, 0, 18 },
                    { 746, 40, 0, 18 },
                    { 747, 41, 0, 18 },
                    { 748, 42, 0, 18 },
                    { 749, 43, 0, 18 },
                    { 750, 44, 0, 18 },
                    { 751, 45, 0, 18 },
                    { 752, 46, 0, 18 },
                    { 753, 0, 0, 21 },
                    { 754, 1, 0, 21 },
                    { 755, 2, 0, 21 },
                    { 756, 3, 0, 21 },
                    { 757, 4, 0, 21 },
                    { 758, 5, 0, 21 },
                    { 759, 6, 0, 21 },
                    { 760, 7, 0, 21 },
                    { 761, 8, 0, 21 },
                    { 762, 9, 0, 21 },
                    { 763, 10, 0, 21 },
                    { 764, 11, 0, 21 },
                    { 765, 12, 0, 21 },
                    { 766, 13, 0, 21 },
                    { 767, 14, 0, 21 },
                    { 768, 15, 0, 21 },
                    { 769, 16, 0, 21 },
                    { 770, 17, 0, 21 },
                    { 771, 18, 0, 21 },
                    { 772, 19, 0, 21 },
                    { 773, 20, 0, 21 },
                    { 774, 21, 0, 21 },
                    { 775, 22, 0, 21 },
                    { 776, 23, 0, 21 },
                    { 777, 24, 0, 21 },
                    { 778, 25, 0, 21 },
                    { 779, 26, 0, 21 },
                    { 780, 27, 0, 21 },
                    { 781, 28, 0, 21 },
                    { 782, 29, 0, 21 },
                    { 783, 30, 0, 21 },
                    { 784, 31, 0, 21 },
                    { 785, 32, 0, 21 },
                    { 786, 33, 0, 21 },
                    { 787, 34, 0, 21 },
                    { 788, 35, 0, 21 },
                    { 789, 36, 0, 21 },
                    { 790, 37, 0, 21 },
                    { 791, 38, 0, 21 },
                    { 792, 39, 0, 21 },
                    { 793, 40, 0, 21 },
                    { 794, 41, 0, 21 },
                    { 795, 42, 0, 21 },
                    { 796, 43, 0, 21 },
                    { 797, 44, 0, 21 },
                    { 798, 45, 0, 21 },
                    { 799, 46, 0, 21 },
                    { 800, 0, 0, 22 },
                    { 801, 1, 0, 22 },
                    { 802, 2, 0, 22 },
                    { 803, 3, 0, 22 },
                    { 804, 4, 0, 22 },
                    { 805, 5, 0, 22 },
                    { 806, 6, 0, 22 },
                    { 807, 7, 0, 22 },
                    { 808, 8, 0, 22 },
                    { 809, 9, 0, 22 },
                    { 810, 10, 0, 22 },
                    { 811, 11, 0, 22 },
                    { 812, 12, 0, 22 },
                    { 813, 13, 0, 22 },
                    { 814, 14, 0, 22 },
                    { 815, 15, 0, 22 },
                    { 816, 16, 0, 22 },
                    { 817, 17, 0, 22 },
                    { 818, 18, 0, 22 },
                    { 819, 19, 0, 22 },
                    { 820, 20, 0, 22 },
                    { 821, 21, 0, 22 },
                    { 822, 22, 0, 22 },
                    { 823, 23, 0, 22 },
                    { 824, 24, 0, 22 },
                    { 825, 25, 0, 22 },
                    { 826, 26, 0, 22 },
                    { 827, 27, 0, 22 },
                    { 828, 28, 0, 22 },
                    { 829, 29, 0, 22 },
                    { 830, 30, 0, 22 },
                    { 831, 31, 0, 22 },
                    { 832, 32, 0, 22 },
                    { 833, 33, 0, 22 },
                    { 834, 34, 0, 22 },
                    { 835, 35, 0, 22 },
                    { 836, 36, 0, 22 },
                    { 837, 37, 0, 22 },
                    { 838, 38, 0, 22 },
                    { 839, 39, 0, 22 },
                    { 840, 40, 0, 22 },
                    { 841, 41, 0, 22 },
                    { 842, 42, 0, 22 },
                    { 843, 43, 0, 22 },
                    { 844, 44, 0, 22 },
                    { 845, 45, 0, 22 },
                    { 846, 46, 0, 22 },
                    { 847, 0, 0, 23 },
                    { 848, 1, 0, 23 },
                    { 849, 2, 0, 23 },
                    { 850, 3, 0, 23 },
                    { 851, 4, 0, 23 },
                    { 852, 5, 0, 23 },
                    { 853, 6, 0, 23 },
                    { 854, 7, 0, 23 },
                    { 855, 8, 0, 23 },
                    { 856, 9, 0, 23 },
                    { 857, 10, 0, 23 },
                    { 858, 11, 0, 23 },
                    { 859, 12, 0, 23 },
                    { 860, 13, 0, 23 },
                    { 861, 14, 0, 23 },
                    { 862, 15, 0, 23 },
                    { 863, 16, 0, 23 },
                    { 864, 17, 0, 23 },
                    { 865, 18, 0, 23 },
                    { 866, 19, 0, 23 },
                    { 867, 20, 0, 23 },
                    { 868, 21, 0, 23 },
                    { 869, 22, 0, 23 },
                    { 870, 23, 0, 23 },
                    { 871, 24, 0, 23 },
                    { 872, 25, 0, 23 },
                    { 873, 26, 0, 23 },
                    { 874, 27, 0, 23 },
                    { 875, 28, 0, 23 },
                    { 876, 29, 0, 23 },
                    { 877, 30, 0, 23 },
                    { 878, 31, 0, 23 },
                    { 879, 32, 0, 23 },
                    { 880, 33, 0, 23 },
                    { 881, 34, 0, 23 },
                    { 882, 35, 0, 23 },
                    { 883, 36, 0, 23 },
                    { 884, 37, 0, 23 },
                    { 885, 38, 0, 23 },
                    { 886, 39, 0, 23 },
                    { 887, 40, 0, 23 },
                    { 888, 41, 0, 23 },
                    { 889, 42, 0, 23 },
                    { 890, 43, 0, 23 },
                    { 891, 44, 0, 23 },
                    { 892, 45, 0, 23 },
                    { 893, 46, 0, 23 },
                    { 894, 0, 0, 24 },
                    { 895, 1, 0, 24 },
                    { 896, 2, 0, 24 },
                    { 897, 3, 0, 24 },
                    { 898, 4, 0, 24 },
                    { 899, 5, 0, 24 },
                    { 900, 6, 0, 24 },
                    { 901, 7, 0, 24 },
                    { 902, 8, 0, 24 },
                    { 903, 9, 0, 24 },
                    { 904, 10, 0, 24 },
                    { 905, 11, 0, 24 },
                    { 906, 12, 0, 24 },
                    { 907, 13, 0, 24 },
                    { 908, 14, 0, 24 },
                    { 909, 15, 0, 24 },
                    { 910, 16, 0, 24 },
                    { 911, 17, 0, 24 },
                    { 912, 18, 0, 24 },
                    { 913, 19, 0, 24 },
                    { 914, 20, 0, 24 },
                    { 915, 21, 0, 24 },
                    { 916, 22, 0, 24 },
                    { 917, 23, 0, 24 },
                    { 918, 24, 0, 24 },
                    { 919, 25, 0, 24 },
                    { 920, 26, 0, 24 },
                    { 921, 27, 0, 24 },
                    { 922, 28, 0, 24 },
                    { 923, 29, 0, 24 },
                    { 924, 30, 0, 24 },
                    { 925, 31, 0, 24 },
                    { 926, 32, 0, 24 },
                    { 927, 33, 0, 24 },
                    { 928, 34, 0, 24 },
                    { 929, 35, 0, 24 },
                    { 930, 36, 0, 24 },
                    { 931, 37, 0, 24 },
                    { 932, 38, 0, 24 },
                    { 933, 39, 0, 24 },
                    { 934, 40, 0, 24 },
                    { 935, 41, 0, 24 },
                    { 936, 42, 0, 24 },
                    { 937, 43, 0, 24 },
                    { 938, 44, 0, 24 },
                    { 939, 45, 0, 24 },
                    { 940, 46, 0, 24 },
                    { 941, 0, 0, 25 },
                    { 942, 1, 0, 25 },
                    { 943, 2, 0, 25 },
                    { 944, 3, 0, 25 },
                    { 945, 4, 0, 25 },
                    { 946, 5, 0, 25 },
                    { 947, 6, 0, 25 },
                    { 948, 7, 0, 25 },
                    { 949, 8, 0, 25 },
                    { 950, 9, 0, 25 },
                    { 951, 10, 0, 25 },
                    { 952, 11, 0, 25 },
                    { 953, 12, 0, 25 },
                    { 954, 13, 0, 25 },
                    { 955, 14, 0, 25 },
                    { 956, 15, 0, 25 },
                    { 957, 16, 0, 25 },
                    { 958, 17, 0, 25 },
                    { 959, 18, 0, 25 },
                    { 960, 19, 0, 25 },
                    { 961, 20, 0, 25 },
                    { 962, 21, 0, 25 },
                    { 963, 22, 0, 25 },
                    { 964, 23, 0, 25 },
                    { 965, 24, 0, 25 },
                    { 966, 25, 0, 25 },
                    { 967, 26, 0, 25 },
                    { 968, 27, 0, 25 },
                    { 969, 28, 0, 25 },
                    { 970, 29, 0, 25 },
                    { 971, 30, 0, 25 },
                    { 972, 31, 0, 25 },
                    { 973, 32, 0, 25 },
                    { 974, 33, 0, 25 },
                    { 975, 34, 0, 25 },
                    { 976, 35, 0, 25 },
                    { 977, 36, 0, 25 },
                    { 978, 37, 0, 25 },
                    { 979, 38, 0, 25 },
                    { 980, 39, 0, 25 },
                    { 981, 40, 0, 25 },
                    { 982, 41, 0, 25 },
                    { 983, 42, 0, 25 },
                    { 984, 43, 0, 25 },
                    { 985, 44, 0, 25 },
                    { 986, 45, 0, 25 },
                    { 987, 46, 0, 25 },
                    { 988, 0, 0, 26 },
                    { 989, 1, 0, 26 },
                    { 990, 2, 0, 26 },
                    { 991, 3, 0, 26 },
                    { 992, 4, 0, 26 },
                    { 993, 5, 0, 26 },
                    { 994, 6, 0, 26 },
                    { 995, 7, 0, 26 },
                    { 996, 8, 0, 26 },
                    { 997, 9, 0, 26 },
                    { 998, 10, 0, 26 },
                    { 999, 11, 0, 26 },
                    { 1000, 12, 0, 26 },
                    { 1001, 13, 0, 26 },
                    { 1002, 14, 0, 26 },
                    { 1003, 15, 0, 26 },
                    { 1004, 16, 0, 26 },
                    { 1005, 17, 0, 26 },
                    { 1006, 18, 0, 26 },
                    { 1007, 19, 0, 26 },
                    { 1008, 20, 0, 26 },
                    { 1009, 21, 0, 26 },
                    { 1010, 22, 0, 26 },
                    { 1011, 23, 0, 26 },
                    { 1012, 24, 0, 26 },
                    { 1013, 25, 0, 26 },
                    { 1014, 26, 0, 26 },
                    { 1015, 27, 0, 26 },
                    { 1016, 28, 0, 26 },
                    { 1017, 29, 0, 26 },
                    { 1018, 30, 0, 26 },
                    { 1019, 31, 0, 26 },
                    { 1020, 32, 0, 26 },
                    { 1021, 33, 0, 26 },
                    { 1022, 34, 0, 26 },
                    { 1023, 35, 0, 26 },
                    { 1024, 36, 0, 26 },
                    { 1025, 37, 0, 26 },
                    { 1026, 38, 0, 26 },
                    { 1027, 39, 0, 26 },
                    { 1028, 40, 0, 26 },
                    { 1029, 41, 0, 26 },
                    { 1030, 42, 0, 26 },
                    { 1031, 43, 0, 26 },
                    { 1032, 44, 0, 26 },
                    { 1033, 45, 0, 26 },
                    { 1034, 46, 0, 26 },
                    { 1035, 0, 0, 27 },
                    { 1036, 1, 0, 27 },
                    { 1037, 2, 0, 27 },
                    { 1038, 3, 0, 27 },
                    { 1039, 4, 0, 27 },
                    { 1040, 5, 0, 27 },
                    { 1041, 6, 0, 27 },
                    { 1042, 7, 0, 27 },
                    { 1043, 8, 0, 27 },
                    { 1044, 9, 0, 27 },
                    { 1045, 10, 0, 27 },
                    { 1046, 11, 0, 27 },
                    { 1047, 12, 0, 27 },
                    { 1048, 13, 0, 27 },
                    { 1049, 14, 0, 27 },
                    { 1050, 15, 0, 27 },
                    { 1051, 16, 0, 27 },
                    { 1052, 17, 0, 27 },
                    { 1053, 18, 0, 27 },
                    { 1054, 19, 0, 27 },
                    { 1055, 20, 0, 27 },
                    { 1056, 21, 0, 27 },
                    { 1057, 22, 0, 27 },
                    { 1058, 23, 0, 27 },
                    { 1059, 24, 0, 27 },
                    { 1060, 25, 0, 27 },
                    { 1061, 26, 0, 27 },
                    { 1062, 27, 0, 27 },
                    { 1063, 28, 0, 27 },
                    { 1064, 29, 0, 27 },
                    { 1065, 30, 0, 27 },
                    { 1066, 31, 0, 27 },
                    { 1067, 32, 0, 27 },
                    { 1068, 33, 0, 27 },
                    { 1069, 34, 0, 27 },
                    { 1070, 35, 0, 27 },
                    { 1071, 36, 0, 27 },
                    { 1072, 37, 0, 27 },
                    { 1073, 38, 0, 27 },
                    { 1074, 39, 0, 27 },
                    { 1075, 40, 0, 27 },
                    { 1076, 41, 0, 27 },
                    { 1077, 42, 0, 27 },
                    { 1078, 43, 0, 27 },
                    { 1079, 44, 0, 27 },
                    { 1080, 45, 0, 27 },
                    { 1081, 46, 0, 27 },
                    { 1082, 0, 0, 28 },
                    { 1083, 1, 0, 28 },
                    { 1084, 2, 0, 28 },
                    { 1085, 3, 0, 28 },
                    { 1086, 4, 0, 28 },
                    { 1087, 5, 0, 28 },
                    { 1088, 6, 0, 28 },
                    { 1089, 7, 0, 28 },
                    { 1090, 8, 0, 28 },
                    { 1091, 9, 0, 28 },
                    { 1092, 10, 0, 28 },
                    { 1093, 11, 0, 28 },
                    { 1094, 12, 0, 28 },
                    { 1095, 13, 0, 28 },
                    { 1096, 14, 0, 28 },
                    { 1097, 15, 0, 28 },
                    { 1098, 16, 0, 28 },
                    { 1099, 17, 0, 28 },
                    { 1100, 18, 0, 28 },
                    { 1101, 19, 0, 28 },
                    { 1102, 20, 0, 28 },
                    { 1103, 21, 0, 28 },
                    { 1104, 22, 0, 28 },
                    { 1105, 23, 0, 28 },
                    { 1106, 24, 0, 28 },
                    { 1107, 25, 0, 28 },
                    { 1108, 26, 0, 28 },
                    { 1109, 27, 0, 28 },
                    { 1110, 28, 0, 28 },
                    { 1111, 29, 0, 28 },
                    { 1112, 30, 0, 28 },
                    { 1113, 31, 0, 28 },
                    { 1114, 32, 0, 28 },
                    { 1115, 33, 0, 28 },
                    { 1116, 34, 0, 28 },
                    { 1117, 35, 0, 28 },
                    { 1118, 36, 0, 28 },
                    { 1119, 37, 0, 28 },
                    { 1120, 38, 0, 28 },
                    { 1121, 39, 0, 28 },
                    { 1122, 40, 0, 28 },
                    { 1123, 41, 0, 28 },
                    { 1124, 42, 0, 28 },
                    { 1125, 43, 0, 28 },
                    { 1126, 44, 0, 28 },
                    { 1127, 45, 0, 28 },
                    { 1128, 46, 0, 28 },
                    { 1129, 0, 0, 31 },
                    { 1130, 1, 0, 31 },
                    { 1131, 2, 0, 31 },
                    { 1132, 3, 0, 31 },
                    { 1133, 4, 0, 31 },
                    { 1134, 5, 0, 31 },
                    { 1135, 6, 0, 31 },
                    { 1136, 7, 0, 31 },
                    { 1137, 8, 0, 31 },
                    { 1138, 9, 0, 31 },
                    { 1139, 10, 0, 31 },
                    { 1140, 11, 0, 31 },
                    { 1141, 12, 0, 31 },
                    { 1142, 13, 0, 31 },
                    { 1143, 14, 0, 31 },
                    { 1144, 15, 0, 31 },
                    { 1145, 16, 0, 31 },
                    { 1146, 17, 0, 31 },
                    { 1147, 18, 0, 31 },
                    { 1148, 19, 0, 31 },
                    { 1149, 20, 0, 31 },
                    { 1150, 21, 0, 31 },
                    { 1151, 22, 0, 31 },
                    { 1152, 23, 0, 31 },
                    { 1153, 24, 0, 31 },
                    { 1154, 25, 0, 31 },
                    { 1155, 26, 0, 31 },
                    { 1156, 27, 0, 31 },
                    { 1157, 28, 0, 31 },
                    { 1158, 29, 0, 31 },
                    { 1159, 30, 0, 31 },
                    { 1160, 31, 0, 31 },
                    { 1161, 32, 0, 31 },
                    { 1162, 33, 0, 31 },
                    { 1163, 34, 0, 31 },
                    { 1164, 35, 0, 31 },
                    { 1165, 36, 0, 31 },
                    { 1166, 37, 0, 31 },
                    { 1167, 38, 0, 31 },
                    { 1168, 39, 0, 31 },
                    { 1169, 40, 0, 31 },
                    { 1170, 41, 0, 31 },
                    { 1171, 42, 0, 31 },
                    { 1172, 43, 0, 31 },
                    { 1173, 44, 0, 31 },
                    { 1174, 45, 0, 31 },
                    { 1175, 46, 0, 31 },
                    { 1176, 0, 0, 32 },
                    { 1177, 1, 0, 32 },
                    { 1178, 2, 0, 32 },
                    { 1179, 3, 0, 32 },
                    { 1180, 4, 0, 32 },
                    { 1181, 5, 0, 32 },
                    { 1182, 6, 0, 32 },
                    { 1183, 7, 0, 32 },
                    { 1184, 8, 0, 32 },
                    { 1185, 9, 0, 32 },
                    { 1186, 10, 0, 32 },
                    { 1187, 11, 0, 32 },
                    { 1188, 12, 0, 32 },
                    { 1189, 13, 0, 32 },
                    { 1190, 14, 0, 32 },
                    { 1191, 15, 0, 32 },
                    { 1192, 16, 0, 32 },
                    { 1193, 17, 0, 32 },
                    { 1194, 18, 0, 32 },
                    { 1195, 19, 0, 32 },
                    { 1196, 20, 0, 32 },
                    { 1197, 21, 0, 32 },
                    { 1198, 22, 0, 32 },
                    { 1199, 23, 0, 32 },
                    { 1200, 24, 0, 32 },
                    { 1201, 25, 0, 32 },
                    { 1202, 26, 0, 32 },
                    { 1203, 27, 0, 32 },
                    { 1204, 28, 0, 32 },
                    { 1205, 29, 0, 32 },
                    { 1206, 30, 0, 32 },
                    { 1207, 31, 0, 32 },
                    { 1208, 32, 0, 32 },
                    { 1209, 33, 0, 32 },
                    { 1210, 34, 0, 32 },
                    { 1211, 35, 0, 32 },
                    { 1212, 36, 0, 32 },
                    { 1213, 37, 0, 32 },
                    { 1214, 38, 0, 32 },
                    { 1215, 39, 0, 32 },
                    { 1216, 40, 0, 32 },
                    { 1217, 41, 0, 32 },
                    { 1218, 42, 0, 32 },
                    { 1219, 43, 0, 32 },
                    { 1220, 44, 0, 32 },
                    { 1221, 45, 0, 32 },
                    { 1222, 46, 0, 32 },
                    { 1223, 0, 0, 33 },
                    { 1224, 1, 0, 33 },
                    { 1225, 2, 0, 33 },
                    { 1226, 3, 0, 33 },
                    { 1227, 4, 0, 33 },
                    { 1228, 5, 0, 33 },
                    { 1229, 6, 0, 33 },
                    { 1230, 7, 0, 33 },
                    { 1231, 8, 0, 33 },
                    { 1232, 9, 0, 33 },
                    { 1233, 10, 0, 33 },
                    { 1234, 11, 0, 33 },
                    { 1235, 12, 0, 33 },
                    { 1236, 13, 0, 33 },
                    { 1237, 14, 0, 33 },
                    { 1238, 15, 0, 33 },
                    { 1239, 16, 0, 33 },
                    { 1240, 17, 0, 33 },
                    { 1241, 18, 0, 33 },
                    { 1242, 19, 0, 33 },
                    { 1243, 20, 0, 33 },
                    { 1244, 21, 0, 33 },
                    { 1245, 22, 0, 33 },
                    { 1246, 23, 0, 33 },
                    { 1247, 24, 0, 33 },
                    { 1248, 25, 0, 33 },
                    { 1249, 26, 0, 33 },
                    { 1250, 27, 0, 33 },
                    { 1251, 28, 0, 33 },
                    { 1252, 29, 0, 33 },
                    { 1253, 30, 0, 33 },
                    { 1254, 31, 0, 33 },
                    { 1255, 32, 0, 33 },
                    { 1256, 33, 0, 33 },
                    { 1257, 34, 0, 33 },
                    { 1258, 35, 0, 33 },
                    { 1259, 36, 0, 33 },
                    { 1260, 37, 0, 33 },
                    { 1261, 38, 0, 33 },
                    { 1262, 39, 0, 33 },
                    { 1263, 40, 0, 33 },
                    { 1264, 41, 0, 33 },
                    { 1265, 42, 0, 33 },
                    { 1266, 43, 0, 33 },
                    { 1267, 44, 0, 33 },
                    { 1268, 45, 0, 33 },
                    { 1269, 46, 0, 33 },
                    { 1270, 0, 0, 34 },
                    { 1271, 1, 0, 34 },
                    { 1272, 2, 0, 34 },
                    { 1273, 3, 0, 34 },
                    { 1274, 4, 0, 34 },
                    { 1275, 5, 0, 34 },
                    { 1276, 6, 0, 34 },
                    { 1277, 7, 0, 34 },
                    { 1278, 8, 0, 34 },
                    { 1279, 9, 0, 34 },
                    { 1280, 10, 0, 34 },
                    { 1281, 11, 0, 34 },
                    { 1282, 12, 0, 34 },
                    { 1283, 13, 0, 34 },
                    { 1284, 14, 0, 34 },
                    { 1285, 15, 0, 34 },
                    { 1286, 16, 0, 34 },
                    { 1287, 17, 0, 34 },
                    { 1288, 18, 0, 34 },
                    { 1289, 19, 0, 34 },
                    { 1290, 20, 0, 34 },
                    { 1291, 21, 0, 34 },
                    { 1292, 22, 0, 34 },
                    { 1293, 23, 0, 34 },
                    { 1294, 24, 0, 34 },
                    { 1295, 25, 0, 34 },
                    { 1296, 26, 0, 34 },
                    { 1297, 27, 0, 34 },
                    { 1298, 28, 0, 34 },
                    { 1299, 29, 0, 34 },
                    { 1300, 30, 0, 34 },
                    { 1301, 31, 0, 34 },
                    { 1302, 32, 0, 34 },
                    { 1303, 33, 0, 34 },
                    { 1304, 34, 0, 34 },
                    { 1305, 35, 0, 34 },
                    { 1306, 36, 0, 34 },
                    { 1307, 37, 0, 34 },
                    { 1308, 38, 0, 34 },
                    { 1309, 39, 0, 34 },
                    { 1310, 40, 0, 34 },
                    { 1311, 41, 0, 34 },
                    { 1312, 42, 0, 34 },
                    { 1313, 43, 0, 34 },
                    { 1314, 44, 0, 34 },
                    { 1315, 45, 0, 34 },
                    { 1316, 46, 0, 34 },
                    { 1317, 0, 0, 35 },
                    { 1318, 1, 0, 35 },
                    { 1319, 2, 0, 35 },
                    { 1320, 3, 0, 35 },
                    { 1321, 4, 0, 35 },
                    { 1322, 5, 0, 35 },
                    { 1323, 6, 0, 35 },
                    { 1324, 7, 0, 35 },
                    { 1325, 8, 0, 35 },
                    { 1326, 9, 0, 35 },
                    { 1327, 10, 0, 35 },
                    { 1328, 11, 0, 35 },
                    { 1329, 12, 0, 35 },
                    { 1330, 13, 0, 35 },
                    { 1331, 14, 0, 35 },
                    { 1332, 15, 0, 35 },
                    { 1333, 16, 0, 35 },
                    { 1334, 17, 0, 35 },
                    { 1335, 18, 0, 35 },
                    { 1336, 19, 0, 35 },
                    { 1337, 20, 0, 35 },
                    { 1338, 21, 0, 35 },
                    { 1339, 22, 0, 35 },
                    { 1340, 23, 0, 35 },
                    { 1341, 24, 0, 35 },
                    { 1342, 25, 0, 35 },
                    { 1343, 26, 0, 35 },
                    { 1344, 27, 0, 35 },
                    { 1345, 28, 0, 35 },
                    { 1346, 29, 0, 35 },
                    { 1347, 30, 0, 35 },
                    { 1348, 31, 0, 35 },
                    { 1349, 32, 0, 35 },
                    { 1350, 33, 0, 35 },
                    { 1351, 34, 0, 35 },
                    { 1352, 35, 0, 35 },
                    { 1353, 36, 0, 35 },
                    { 1354, 37, 0, 35 },
                    { 1355, 38, 0, 35 },
                    { 1356, 39, 0, 35 },
                    { 1357, 40, 0, 35 },
                    { 1358, 41, 0, 35 },
                    { 1359, 42, 0, 35 },
                    { 1360, 43, 0, 35 },
                    { 1361, 44, 0, 35 },
                    { 1362, 45, 0, 35 },
                    { 1363, 46, 0, 35 },
                    { 1364, 0, 0, 36 },
                    { 1365, 1, 0, 36 },
                    { 1366, 2, 0, 36 },
                    { 1367, 3, 0, 36 },
                    { 1368, 4, 0, 36 },
                    { 1369, 5, 0, 36 },
                    { 1370, 6, 0, 36 },
                    { 1371, 7, 0, 36 },
                    { 1372, 8, 0, 36 },
                    { 1373, 9, 0, 36 },
                    { 1374, 10, 0, 36 },
                    { 1375, 11, 0, 36 },
                    { 1376, 12, 0, 36 },
                    { 1377, 13, 0, 36 },
                    { 1378, 14, 0, 36 },
                    { 1379, 15, 0, 36 },
                    { 1380, 16, 0, 36 },
                    { 1381, 17, 0, 36 },
                    { 1382, 18, 0, 36 },
                    { 1383, 19, 0, 36 },
                    { 1384, 20, 0, 36 },
                    { 1385, 21, 0, 36 },
                    { 1386, 22, 0, 36 },
                    { 1387, 23, 0, 36 },
                    { 1388, 24, 0, 36 },
                    { 1389, 25, 0, 36 },
                    { 1390, 26, 0, 36 },
                    { 1391, 27, 0, 36 },
                    { 1392, 28, 0, 36 },
                    { 1393, 29, 0, 36 },
                    { 1394, 30, 0, 36 },
                    { 1395, 31, 0, 36 },
                    { 1396, 32, 0, 36 },
                    { 1397, 33, 0, 36 },
                    { 1398, 34, 0, 36 },
                    { 1399, 35, 0, 36 },
                    { 1400, 36, 0, 36 },
                    { 1401, 37, 0, 36 },
                    { 1402, 38, 0, 36 },
                    { 1403, 39, 0, 36 },
                    { 1404, 40, 0, 36 },
                    { 1405, 41, 0, 36 },
                    { 1406, 42, 0, 36 },
                    { 1407, 43, 0, 36 },
                    { 1408, 44, 0, 36 },
                    { 1409, 45, 0, 36 },
                    { 1410, 46, 0, 36 },
                    { 1411, 0, 0, 37 },
                    { 1412, 1, 0, 37 },
                    { 1413, 2, 0, 37 },
                    { 1414, 3, 0, 37 },
                    { 1415, 4, 0, 37 },
                    { 1416, 5, 0, 37 },
                    { 1417, 6, 0, 37 },
                    { 1418, 7, 0, 37 },
                    { 1419, 8, 0, 37 },
                    { 1420, 9, 0, 37 },
                    { 1421, 10, 0, 37 },
                    { 1422, 11, 0, 37 },
                    { 1423, 12, 0, 37 },
                    { 1424, 13, 0, 37 },
                    { 1425, 14, 0, 37 },
                    { 1426, 15, 0, 37 },
                    { 1427, 16, 0, 37 },
                    { 1428, 17, 0, 37 },
                    { 1429, 18, 0, 37 },
                    { 1430, 19, 0, 37 },
                    { 1431, 20, 0, 37 },
                    { 1432, 21, 0, 37 },
                    { 1433, 22, 0, 37 },
                    { 1434, 23, 0, 37 },
                    { 1435, 24, 0, 37 },
                    { 1436, 25, 0, 37 },
                    { 1437, 26, 0, 37 },
                    { 1438, 27, 0, 37 },
                    { 1439, 28, 0, 37 },
                    { 1440, 29, 0, 37 },
                    { 1441, 30, 0, 37 },
                    { 1442, 31, 0, 37 },
                    { 1443, 32, 0, 37 },
                    { 1444, 33, 0, 37 },
                    { 1445, 34, 0, 37 },
                    { 1446, 35, 0, 37 },
                    { 1447, 36, 0, 37 },
                    { 1448, 37, 0, 37 },
                    { 1449, 38, 0, 37 },
                    { 1450, 39, 0, 37 },
                    { 1451, 40, 0, 37 },
                    { 1452, 41, 0, 37 },
                    { 1453, 42, 0, 37 },
                    { 1454, 43, 0, 37 },
                    { 1455, 44, 0, 37 },
                    { 1456, 45, 0, 37 },
                    { 1457, 46, 0, 37 },
                    { 1458, 0, 0, 38 },
                    { 1459, 1, 0, 38 },
                    { 1460, 2, 0, 38 },
                    { 1461, 3, 0, 38 },
                    { 1462, 4, 0, 38 },
                    { 1463, 5, 0, 38 },
                    { 1464, 6, 0, 38 },
                    { 1465, 7, 0, 38 },
                    { 1466, 8, 0, 38 },
                    { 1467, 9, 0, 38 },
                    { 1468, 10, 0, 38 },
                    { 1469, 11, 0, 38 },
                    { 1470, 12, 0, 38 },
                    { 1471, 13, 0, 38 },
                    { 1472, 14, 0, 38 },
                    { 1473, 15, 0, 38 },
                    { 1474, 16, 0, 38 },
                    { 1475, 17, 0, 38 },
                    { 1476, 18, 0, 38 },
                    { 1477, 19, 0, 38 },
                    { 1478, 20, 0, 38 },
                    { 1479, 21, 0, 38 },
                    { 1480, 22, 0, 38 },
                    { 1481, 23, 0, 38 },
                    { 1482, 24, 0, 38 },
                    { 1483, 25, 0, 38 },
                    { 1484, 26, 0, 38 },
                    { 1485, 27, 0, 38 },
                    { 1486, 28, 0, 38 },
                    { 1487, 29, 0, 38 },
                    { 1488, 30, 0, 38 },
                    { 1489, 31, 0, 38 },
                    { 1490, 32, 0, 38 },
                    { 1491, 33, 0, 38 },
                    { 1492, 34, 0, 38 },
                    { 1493, 35, 0, 38 },
                    { 1494, 36, 0, 38 },
                    { 1495, 37, 0, 38 },
                    { 1496, 38, 0, 38 },
                    { 1497, 39, 0, 38 },
                    { 1498, 40, 0, 38 },
                    { 1499, 41, 0, 38 },
                    { 1500, 42, 0, 38 },
                    { 1501, 43, 0, 38 },
                    { 1502, 44, 0, 38 },
                    { 1503, 45, 0, 38 },
                    { 1504, 46, 0, 38 },
                    { 1505, 0, 0, 41 },
                    { 1506, 1, 0, 41 },
                    { 1507, 2, 0, 41 },
                    { 1508, 3, 0, 41 },
                    { 1509, 4, 0, 41 },
                    { 1510, 5, 0, 41 },
                    { 1511, 6, 0, 41 },
                    { 1512, 7, 0, 41 },
                    { 1513, 8, 0, 41 },
                    { 1514, 9, 0, 41 },
                    { 1515, 10, 0, 41 },
                    { 1516, 11, 0, 41 },
                    { 1517, 12, 0, 41 },
                    { 1518, 13, 0, 41 },
                    { 1519, 14, 0, 41 },
                    { 1520, 15, 0, 41 },
                    { 1521, 16, 0, 41 },
                    { 1522, 17, 0, 41 },
                    { 1523, 18, 0, 41 },
                    { 1524, 19, 0, 41 },
                    { 1525, 20, 0, 41 },
                    { 1526, 21, 0, 41 },
                    { 1527, 22, 0, 41 },
                    { 1528, 23, 0, 41 },
                    { 1529, 24, 0, 41 },
                    { 1530, 25, 0, 41 },
                    { 1531, 26, 0, 41 },
                    { 1532, 27, 0, 41 },
                    { 1533, 28, 0, 41 },
                    { 1534, 29, 0, 41 },
                    { 1535, 30, 0, 41 },
                    { 1536, 31, 0, 41 },
                    { 1537, 32, 0, 41 },
                    { 1538, 33, 0, 41 },
                    { 1539, 34, 0, 41 },
                    { 1540, 35, 0, 41 },
                    { 1541, 36, 0, 41 },
                    { 1542, 37, 0, 41 },
                    { 1543, 38, 0, 41 },
                    { 1544, 39, 0, 41 },
                    { 1545, 40, 0, 41 },
                    { 1546, 41, 0, 41 },
                    { 1547, 42, 0, 41 },
                    { 1548, 43, 0, 41 },
                    { 1549, 44, 0, 41 },
                    { 1550, 45, 0, 41 },
                    { 1551, 46, 0, 41 },
                    { 1552, 0, 0, 42 },
                    { 1553, 1, 0, 42 },
                    { 1554, 2, 0, 42 },
                    { 1555, 3, 0, 42 },
                    { 1556, 4, 0, 42 },
                    { 1557, 5, 0, 42 },
                    { 1558, 6, 0, 42 },
                    { 1559, 7, 0, 42 },
                    { 1560, 8, 0, 42 },
                    { 1561, 9, 0, 42 },
                    { 1562, 10, 0, 42 },
                    { 1563, 11, 0, 42 },
                    { 1564, 12, 0, 42 },
                    { 1565, 13, 0, 42 },
                    { 1566, 14, 0, 42 },
                    { 1567, 15, 0, 42 },
                    { 1568, 16, 0, 42 },
                    { 1569, 17, 0, 42 },
                    { 1570, 18, 0, 42 },
                    { 1571, 19, 0, 42 },
                    { 1572, 20, 0, 42 },
                    { 1573, 21, 0, 42 },
                    { 1574, 22, 0, 42 },
                    { 1575, 23, 0, 42 },
                    { 1576, 24, 0, 42 },
                    { 1577, 25, 0, 42 },
                    { 1578, 26, 0, 42 },
                    { 1579, 27, 0, 42 },
                    { 1580, 28, 0, 42 },
                    { 1581, 29, 0, 42 },
                    { 1582, 30, 0, 42 },
                    { 1583, 31, 0, 42 },
                    { 1584, 32, 0, 42 },
                    { 1585, 33, 0, 42 },
                    { 1586, 34, 0, 42 },
                    { 1587, 35, 0, 42 },
                    { 1588, 36, 0, 42 },
                    { 1589, 37, 0, 42 },
                    { 1590, 38, 0, 42 },
                    { 1591, 39, 0, 42 },
                    { 1592, 40, 0, 42 },
                    { 1593, 41, 0, 42 },
                    { 1594, 42, 0, 42 },
                    { 1595, 43, 0, 42 },
                    { 1596, 44, 0, 42 },
                    { 1597, 45, 0, 42 },
                    { 1598, 46, 0, 42 },
                    { 1599, 0, 0, 43 },
                    { 1600, 1, 0, 43 },
                    { 1601, 2, 0, 43 },
                    { 1602, 3, 0, 43 },
                    { 1603, 4, 0, 43 },
                    { 1604, 5, 0, 43 },
                    { 1605, 6, 0, 43 },
                    { 1606, 7, 0, 43 },
                    { 1607, 8, 0, 43 },
                    { 1608, 9, 0, 43 },
                    { 1609, 10, 0, 43 },
                    { 1610, 11, 0, 43 },
                    { 1611, 12, 0, 43 },
                    { 1612, 13, 0, 43 },
                    { 1613, 14, 0, 43 },
                    { 1614, 15, 0, 43 },
                    { 1615, 16, 0, 43 },
                    { 1616, 17, 0, 43 },
                    { 1617, 18, 0, 43 },
                    { 1618, 19, 0, 43 },
                    { 1619, 20, 0, 43 },
                    { 1620, 21, 0, 43 },
                    { 1621, 22, 0, 43 },
                    { 1622, 23, 0, 43 },
                    { 1623, 24, 0, 43 },
                    { 1624, 25, 0, 43 },
                    { 1625, 26, 0, 43 },
                    { 1626, 27, 0, 43 },
                    { 1627, 28, 0, 43 },
                    { 1628, 29, 0, 43 },
                    { 1629, 30, 0, 43 },
                    { 1630, 31, 0, 43 },
                    { 1631, 32, 0, 43 },
                    { 1632, 33, 0, 43 },
                    { 1633, 34, 0, 43 },
                    { 1634, 35, 0, 43 },
                    { 1635, 36, 0, 43 },
                    { 1636, 37, 0, 43 },
                    { 1637, 38, 0, 43 },
                    { 1638, 39, 0, 43 },
                    { 1639, 40, 0, 43 },
                    { 1640, 41, 0, 43 },
                    { 1641, 42, 0, 43 },
                    { 1642, 43, 0, 43 },
                    { 1643, 44, 0, 43 },
                    { 1644, 45, 0, 43 },
                    { 1645, 46, 0, 43 },
                    { 1646, 0, 0, 44 },
                    { 1647, 1, 0, 44 },
                    { 1648, 2, 0, 44 },
                    { 1649, 3, 0, 44 },
                    { 1650, 4, 0, 44 },
                    { 1651, 5, 0, 44 },
                    { 1652, 6, 0, 44 },
                    { 1653, 7, 0, 44 },
                    { 1654, 8, 0, 44 },
                    { 1655, 9, 0, 44 },
                    { 1656, 10, 0, 44 },
                    { 1657, 11, 0, 44 },
                    { 1658, 12, 0, 44 },
                    { 1659, 13, 0, 44 },
                    { 1660, 14, 0, 44 },
                    { 1661, 15, 0, 44 },
                    { 1662, 16, 0, 44 },
                    { 1663, 17, 0, 44 },
                    { 1664, 18, 0, 44 },
                    { 1665, 19, 0, 44 },
                    { 1666, 20, 0, 44 },
                    { 1667, 21, 0, 44 },
                    { 1668, 22, 0, 44 },
                    { 1669, 23, 0, 44 },
                    { 1670, 24, 0, 44 },
                    { 1671, 25, 0, 44 },
                    { 1672, 26, 0, 44 },
                    { 1673, 27, 0, 44 },
                    { 1674, 28, 0, 44 },
                    { 1675, 29, 0, 44 },
                    { 1676, 30, 0, 44 },
                    { 1677, 31, 0, 44 },
                    { 1678, 32, 0, 44 },
                    { 1679, 33, 0, 44 },
                    { 1680, 34, 0, 44 },
                    { 1681, 35, 0, 44 },
                    { 1682, 36, 0, 44 },
                    { 1683, 37, 0, 44 },
                    { 1684, 38, 0, 44 },
                    { 1685, 39, 0, 44 },
                    { 1686, 40, 0, 44 },
                    { 1687, 41, 0, 44 },
                    { 1688, 42, 0, 44 },
                    { 1689, 43, 0, 44 },
                    { 1690, 44, 0, 44 },
                    { 1691, 45, 0, 44 },
                    { 1692, 46, 0, 44 },
                    { 1693, 0, 0, 45 },
                    { 1694, 1, 0, 45 },
                    { 1695, 2, 0, 45 },
                    { 1696, 3, 0, 45 },
                    { 1697, 4, 0, 45 },
                    { 1698, 5, 0, 45 },
                    { 1699, 6, 0, 45 },
                    { 1700, 7, 0, 45 },
                    { 1701, 8, 0, 45 },
                    { 1702, 9, 0, 45 },
                    { 1703, 10, 0, 45 },
                    { 1704, 11, 0, 45 },
                    { 1705, 12, 0, 45 },
                    { 1706, 13, 0, 45 },
                    { 1707, 14, 0, 45 },
                    { 1708, 15, 0, 45 },
                    { 1709, 16, 0, 45 },
                    { 1710, 17, 0, 45 },
                    { 1711, 18, 0, 45 },
                    { 1712, 19, 0, 45 },
                    { 1713, 20, 0, 45 },
                    { 1714, 21, 0, 45 },
                    { 1715, 22, 0, 45 },
                    { 1716, 23, 0, 45 },
                    { 1717, 24, 0, 45 },
                    { 1718, 25, 0, 45 },
                    { 1719, 26, 0, 45 },
                    { 1720, 27, 0, 45 },
                    { 1721, 28, 0, 45 },
                    { 1722, 29, 0, 45 },
                    { 1723, 30, 0, 45 },
                    { 1724, 31, 0, 45 },
                    { 1725, 32, 0, 45 },
                    { 1726, 33, 0, 45 },
                    { 1727, 34, 0, 45 },
                    { 1728, 35, 0, 45 },
                    { 1729, 36, 0, 45 },
                    { 1730, 37, 0, 45 },
                    { 1731, 38, 0, 45 },
                    { 1732, 39, 0, 45 },
                    { 1733, 40, 0, 45 },
                    { 1734, 41, 0, 45 },
                    { 1735, 42, 0, 45 },
                    { 1736, 43, 0, 45 },
                    { 1737, 44, 0, 45 },
                    { 1738, 45, 0, 45 },
                    { 1739, 46, 0, 45 },
                    { 1740, 0, 0, 46 },
                    { 1741, 1, 0, 46 },
                    { 1742, 2, 0, 46 },
                    { 1743, 3, 0, 46 },
                    { 1744, 4, 0, 46 },
                    { 1745, 5, 0, 46 },
                    { 1746, 6, 0, 46 },
                    { 1747, 7, 0, 46 },
                    { 1748, 8, 0, 46 },
                    { 1749, 9, 0, 46 },
                    { 1750, 10, 0, 46 },
                    { 1751, 11, 0, 46 },
                    { 1752, 12, 0, 46 },
                    { 1753, 13, 0, 46 },
                    { 1754, 14, 0, 46 },
                    { 1755, 15, 0, 46 },
                    { 1756, 16, 0, 46 },
                    { 1757, 17, 0, 46 },
                    { 1758, 18, 0, 46 },
                    { 1759, 19, 0, 46 },
                    { 1760, 20, 0, 46 },
                    { 1761, 21, 0, 46 },
                    { 1762, 22, 0, 46 },
                    { 1763, 23, 0, 46 },
                    { 1764, 24, 0, 46 },
                    { 1765, 25, 0, 46 },
                    { 1766, 26, 0, 46 },
                    { 1767, 27, 0, 46 },
                    { 1768, 28, 0, 46 },
                    { 1769, 29, 0, 46 },
                    { 1770, 30, 0, 46 },
                    { 1771, 31, 0, 46 },
                    { 1772, 32, 0, 46 },
                    { 1773, 33, 0, 46 },
                    { 1774, 34, 0, 46 },
                    { 1775, 35, 0, 46 },
                    { 1776, 36, 0, 46 },
                    { 1777, 37, 0, 46 },
                    { 1778, 38, 0, 46 },
                    { 1779, 39, 0, 46 },
                    { 1780, 40, 0, 46 },
                    { 1781, 41, 0, 46 },
                    { 1782, 42, 0, 46 },
                    { 1783, 43, 0, 46 },
                    { 1784, 44, 0, 46 },
                    { 1785, 45, 0, 46 },
                    { 1786, 46, 0, 46 },
                    { 1787, 0, 0, 47 },
                    { 1788, 1, 0, 47 },
                    { 1789, 2, 0, 47 },
                    { 1790, 3, 0, 47 },
                    { 1791, 4, 0, 47 },
                    { 1792, 5, 0, 47 },
                    { 1793, 6, 0, 47 },
                    { 1794, 7, 0, 47 },
                    { 1795, 8, 0, 47 },
                    { 1796, 9, 0, 47 },
                    { 1797, 10, 0, 47 },
                    { 1798, 11, 0, 47 },
                    { 1799, 12, 0, 47 },
                    { 1800, 13, 0, 47 },
                    { 1801, 14, 0, 47 },
                    { 1802, 15, 0, 47 },
                    { 1803, 16, 0, 47 },
                    { 1804, 17, 0, 47 },
                    { 1805, 18, 0, 47 },
                    { 1806, 19, 0, 47 },
                    { 1807, 20, 0, 47 },
                    { 1808, 21, 0, 47 },
                    { 1809, 22, 0, 47 },
                    { 1810, 23, 0, 47 },
                    { 1811, 24, 0, 47 },
                    { 1812, 25, 0, 47 },
                    { 1813, 26, 0, 47 },
                    { 1814, 27, 0, 47 },
                    { 1815, 28, 0, 47 },
                    { 1816, 29, 0, 47 },
                    { 1817, 30, 0, 47 },
                    { 1818, 31, 0, 47 },
                    { 1819, 32, 0, 47 },
                    { 1820, 33, 0, 47 },
                    { 1821, 34, 0, 47 },
                    { 1822, 35, 0, 47 },
                    { 1823, 36, 0, 47 },
                    { 1824, 37, 0, 47 },
                    { 1825, 38, 0, 47 },
                    { 1826, 39, 0, 47 },
                    { 1827, 40, 0, 47 },
                    { 1828, 41, 0, 47 },
                    { 1829, 42, 0, 47 },
                    { 1830, 43, 0, 47 },
                    { 1831, 44, 0, 47 },
                    { 1832, 45, 0, 47 },
                    { 1833, 46, 0, 47 },
                    { 1834, 0, 0, 48 },
                    { 1835, 1, 0, 48 },
                    { 1836, 2, 0, 48 },
                    { 1837, 3, 0, 48 },
                    { 1838, 4, 0, 48 },
                    { 1839, 5, 0, 48 },
                    { 1840, 6, 0, 48 },
                    { 1841, 7, 0, 48 },
                    { 1842, 8, 0, 48 },
                    { 1843, 9, 0, 48 },
                    { 1844, 10, 0, 48 },
                    { 1845, 11, 0, 48 },
                    { 1846, 12, 0, 48 },
                    { 1847, 13, 0, 48 },
                    { 1848, 14, 0, 48 },
                    { 1849, 15, 0, 48 },
                    { 1850, 16, 0, 48 },
                    { 1851, 17, 0, 48 },
                    { 1852, 18, 0, 48 },
                    { 1853, 19, 0, 48 },
                    { 1854, 20, 0, 48 },
                    { 1855, 21, 0, 48 },
                    { 1856, 22, 0, 48 },
                    { 1857, 23, 0, 48 },
                    { 1858, 24, 0, 48 },
                    { 1859, 25, 0, 48 },
                    { 1860, 26, 0, 48 },
                    { 1861, 27, 0, 48 },
                    { 1862, 28, 0, 48 },
                    { 1863, 29, 0, 48 },
                    { 1864, 30, 0, 48 },
                    { 1865, 31, 0, 48 },
                    { 1866, 32, 0, 48 },
                    { 1867, 33, 0, 48 },
                    { 1868, 34, 0, 48 },
                    { 1869, 35, 0, 48 },
                    { 1870, 36, 0, 48 },
                    { 1871, 37, 0, 48 },
                    { 1872, 38, 0, 48 },
                    { 1873, 39, 0, 48 },
                    { 1874, 40, 0, 48 },
                    { 1875, 41, 0, 48 },
                    { 1876, 42, 0, 48 },
                    { 1877, 43, 0, 48 },
                    { 1878, 44, 0, 48 },
                    { 1879, 45, 0, 48 },
                    { 1880, 46, 0, 48 },
                    { 1881, 0, 0, 51 },
                    { 1882, 1, 0, 51 },
                    { 1883, 2, 0, 51 },
                    { 1884, 3, 0, 51 },
                    { 1885, 4, 0, 51 },
                    { 1886, 5, 0, 51 },
                    { 1887, 6, 0, 51 },
                    { 1888, 7, 0, 51 },
                    { 1889, 8, 0, 51 },
                    { 1890, 9, 0, 51 },
                    { 1891, 10, 0, 51 },
                    { 1892, 11, 0, 51 },
                    { 1893, 12, 0, 51 },
                    { 1894, 13, 0, 51 },
                    { 1895, 14, 0, 51 },
                    { 1896, 15, 0, 51 },
                    { 1897, 16, 0, 51 },
                    { 1898, 17, 0, 51 },
                    { 1899, 18, 0, 51 },
                    { 1900, 19, 0, 51 },
                    { 1901, 20, 0, 51 },
                    { 1902, 21, 0, 51 },
                    { 1903, 22, 0, 51 },
                    { 1904, 23, 0, 51 },
                    { 1905, 24, 0, 51 },
                    { 1906, 25, 0, 51 },
                    { 1907, 26, 0, 51 },
                    { 1908, 27, 0, 51 },
                    { 1909, 28, 0, 51 },
                    { 1910, 29, 0, 51 },
                    { 1911, 30, 0, 51 },
                    { 1912, 31, 0, 51 },
                    { 1913, 32, 0, 51 },
                    { 1914, 33, 0, 51 },
                    { 1915, 34, 0, 51 },
                    { 1916, 35, 0, 51 },
                    { 1917, 36, 0, 51 },
                    { 1918, 37, 0, 51 },
                    { 1919, 38, 0, 51 },
                    { 1920, 39, 0, 51 },
                    { 1921, 40, 0, 51 },
                    { 1922, 41, 0, 51 },
                    { 1923, 42, 0, 51 },
                    { 1924, 43, 0, 51 },
                    { 1925, 44, 0, 51 },
                    { 1926, 45, 0, 51 },
                    { 1927, 46, 0, 51 },
                    { 1928, 0, 0, 52 },
                    { 1929, 1, 0, 52 },
                    { 1930, 2, 0, 52 },
                    { 1931, 3, 0, 52 },
                    { 1932, 4, 0, 52 },
                    { 1933, 5, 0, 52 },
                    { 1934, 6, 0, 52 },
                    { 1935, 7, 0, 52 },
                    { 1936, 8, 0, 52 },
                    { 1937, 9, 0, 52 },
                    { 1938, 10, 0, 52 },
                    { 1939, 11, 0, 52 },
                    { 1940, 12, 0, 52 },
                    { 1941, 13, 0, 52 },
                    { 1942, 14, 0, 52 },
                    { 1943, 15, 0, 52 },
                    { 1944, 16, 0, 52 },
                    { 1945, 17, 0, 52 },
                    { 1946, 18, 0, 52 },
                    { 1947, 19, 0, 52 },
                    { 1948, 20, 0, 52 },
                    { 1949, 21, 0, 52 },
                    { 1950, 22, 0, 52 },
                    { 1951, 23, 0, 52 },
                    { 1952, 24, 0, 52 },
                    { 1953, 25, 0, 52 },
                    { 1954, 26, 0, 52 },
                    { 1955, 27, 0, 52 },
                    { 1956, 28, 0, 52 },
                    { 1957, 29, 0, 52 },
                    { 1958, 30, 0, 52 },
                    { 1959, 31, 0, 52 },
                    { 1960, 32, 0, 52 },
                    { 1961, 33, 0, 52 },
                    { 1962, 34, 0, 52 },
                    { 1963, 35, 0, 52 },
                    { 1964, 36, 0, 52 },
                    { 1965, 37, 0, 52 },
                    { 1966, 38, 0, 52 },
                    { 1967, 39, 0, 52 },
                    { 1968, 40, 0, 52 },
                    { 1969, 41, 0, 52 },
                    { 1970, 42, 0, 52 },
                    { 1971, 43, 0, 52 },
                    { 1972, 44, 0, 52 },
                    { 1973, 45, 0, 52 },
                    { 1974, 46, 0, 52 },
                    { 1975, 0, 0, 53 },
                    { 1976, 1, 0, 53 },
                    { 1977, 2, 0, 53 },
                    { 1978, 3, 0, 53 },
                    { 1979, 4, 0, 53 },
                    { 1980, 5, 0, 53 },
                    { 1981, 6, 0, 53 },
                    { 1982, 7, 0, 53 },
                    { 1983, 8, 0, 53 },
                    { 1984, 9, 0, 53 },
                    { 1985, 10, 0, 53 },
                    { 1986, 11, 0, 53 },
                    { 1987, 12, 0, 53 },
                    { 1988, 13, 0, 53 },
                    { 1989, 14, 0, 53 },
                    { 1990, 15, 0, 53 },
                    { 1991, 16, 0, 53 },
                    { 1992, 17, 0, 53 },
                    { 1993, 18, 0, 53 },
                    { 1994, 19, 0, 53 },
                    { 1995, 20, 0, 53 },
                    { 1996, 21, 0, 53 },
                    { 1997, 22, 0, 53 },
                    { 1998, 23, 0, 53 },
                    { 1999, 24, 0, 53 },
                    { 2000, 25, 0, 53 },
                    { 2001, 26, 0, 53 },
                    { 2002, 27, 0, 53 },
                    { 2003, 28, 0, 53 },
                    { 2004, 29, 0, 53 },
                    { 2005, 30, 0, 53 },
                    { 2006, 31, 0, 53 },
                    { 2007, 32, 0, 53 },
                    { 2008, 33, 0, 53 },
                    { 2009, 34, 0, 53 },
                    { 2010, 35, 0, 53 },
                    { 2011, 36, 0, 53 },
                    { 2012, 37, 0, 53 },
                    { 2013, 38, 0, 53 },
                    { 2014, 39, 0, 53 },
                    { 2015, 40, 0, 53 },
                    { 2016, 41, 0, 53 },
                    { 2017, 42, 0, 53 },
                    { 2018, 43, 0, 53 },
                    { 2019, 44, 0, 53 },
                    { 2020, 45, 0, 53 },
                    { 2021, 46, 0, 53 },
                    { 2022, 0, 0, 54 },
                    { 2023, 1, 0, 54 },
                    { 2024, 2, 0, 54 },
                    { 2025, 3, 0, 54 },
                    { 2026, 4, 0, 54 },
                    { 2027, 5, 0, 54 },
                    { 2028, 6, 0, 54 },
                    { 2029, 7, 0, 54 },
                    { 2030, 8, 0, 54 },
                    { 2031, 9, 0, 54 },
                    { 2032, 10, 0, 54 },
                    { 2033, 11, 0, 54 },
                    { 2034, 12, 0, 54 },
                    { 2035, 13, 0, 54 },
                    { 2036, 14, 0, 54 },
                    { 2037, 15, 0, 54 },
                    { 2038, 16, 0, 54 },
                    { 2039, 17, 0, 54 },
                    { 2040, 18, 0, 54 },
                    { 2041, 19, 0, 54 },
                    { 2042, 20, 0, 54 },
                    { 2043, 21, 0, 54 },
                    { 2044, 22, 0, 54 },
                    { 2045, 23, 0, 54 },
                    { 2046, 24, 0, 54 },
                    { 2047, 25, 0, 54 },
                    { 2048, 26, 0, 54 },
                    { 2049, 27, 0, 54 },
                    { 2050, 28, 0, 54 },
                    { 2051, 29, 0, 54 },
                    { 2052, 30, 0, 54 },
                    { 2053, 31, 0, 54 },
                    { 2054, 32, 0, 54 },
                    { 2055, 33, 0, 54 },
                    { 2056, 34, 0, 54 },
                    { 2057, 35, 0, 54 },
                    { 2058, 36, 0, 54 },
                    { 2059, 37, 0, 54 },
                    { 2060, 38, 0, 54 },
                    { 2061, 39, 0, 54 },
                    { 2062, 40, 0, 54 },
                    { 2063, 41, 0, 54 },
                    { 2064, 42, 0, 54 },
                    { 2065, 43, 0, 54 },
                    { 2066, 44, 0, 54 },
                    { 2067, 45, 0, 54 },
                    { 2068, 46, 0, 54 },
                    { 2069, 0, 0, 55 },
                    { 2070, 1, 0, 55 },
                    { 2071, 2, 0, 55 },
                    { 2072, 3, 0, 55 },
                    { 2073, 4, 0, 55 },
                    { 2074, 5, 0, 55 },
                    { 2075, 6, 0, 55 },
                    { 2076, 7, 0, 55 },
                    { 2077, 8, 0, 55 },
                    { 2078, 9, 0, 55 },
                    { 2079, 10, 0, 55 },
                    { 2080, 11, 0, 55 },
                    { 2081, 12, 0, 55 },
                    { 2082, 13, 0, 55 },
                    { 2083, 14, 0, 55 },
                    { 2084, 15, 0, 55 },
                    { 2085, 16, 0, 55 },
                    { 2086, 17, 0, 55 },
                    { 2087, 18, 0, 55 },
                    { 2088, 19, 0, 55 },
                    { 2089, 20, 0, 55 },
                    { 2090, 21, 0, 55 },
                    { 2091, 22, 0, 55 },
                    { 2092, 23, 0, 55 },
                    { 2093, 24, 0, 55 },
                    { 2094, 25, 0, 55 },
                    { 2095, 26, 0, 55 },
                    { 2096, 27, 0, 55 },
                    { 2097, 28, 0, 55 },
                    { 2098, 29, 0, 55 },
                    { 2099, 30, 0, 55 },
                    { 2100, 31, 0, 55 },
                    { 2101, 32, 0, 55 },
                    { 2102, 33, 0, 55 },
                    { 2103, 34, 0, 55 },
                    { 2104, 35, 0, 55 },
                    { 2105, 36, 0, 55 },
                    { 2106, 37, 0, 55 },
                    { 2107, 38, 0, 55 },
                    { 2108, 39, 0, 55 },
                    { 2109, 40, 0, 55 },
                    { 2110, 41, 0, 55 },
                    { 2111, 42, 0, 55 },
                    { 2112, 43, 0, 55 },
                    { 2113, 44, 0, 55 },
                    { 2114, 45, 0, 55 },
                    { 2115, 46, 0, 55 },
                    { 2116, 0, 0, 61 },
                    { 2117, 1, 0, 61 },
                    { 2118, 2, 0, 61 },
                    { 2119, 3, 0, 61 },
                    { 2120, 4, 0, 61 },
                    { 2121, 5, 0, 61 },
                    { 2122, 6, 0, 61 },
                    { 2123, 7, 0, 61 },
                    { 2124, 8, 0, 61 },
                    { 2125, 9, 0, 61 },
                    { 2126, 10, 0, 61 },
                    { 2127, 11, 0, 61 },
                    { 2128, 12, 0, 61 },
                    { 2129, 13, 0, 61 },
                    { 2130, 14, 0, 61 },
                    { 2131, 15, 0, 61 },
                    { 2132, 16, 0, 61 },
                    { 2133, 17, 0, 61 },
                    { 2134, 18, 0, 61 },
                    { 2135, 19, 0, 61 },
                    { 2136, 20, 0, 61 },
                    { 2137, 21, 0, 61 },
                    { 2138, 22, 0, 61 },
                    { 2139, 23, 0, 61 },
                    { 2140, 24, 0, 61 },
                    { 2141, 25, 0, 61 },
                    { 2142, 26, 0, 61 },
                    { 2143, 27, 0, 61 },
                    { 2144, 28, 0, 61 },
                    { 2145, 29, 0, 61 },
                    { 2146, 30, 0, 61 },
                    { 2147, 31, 0, 61 },
                    { 2148, 32, 0, 61 },
                    { 2149, 33, 0, 61 },
                    { 2150, 34, 0, 61 },
                    { 2151, 35, 0, 61 },
                    { 2152, 36, 0, 61 },
                    { 2153, 37, 0, 61 },
                    { 2154, 38, 0, 61 },
                    { 2155, 39, 0, 61 },
                    { 2156, 40, 0, 61 },
                    { 2157, 41, 0, 61 },
                    { 2158, 42, 0, 61 },
                    { 2159, 43, 0, 61 },
                    { 2160, 44, 0, 61 },
                    { 2161, 45, 0, 61 },
                    { 2162, 46, 0, 61 },
                    { 2163, 0, 0, 62 },
                    { 2164, 1, 0, 62 },
                    { 2165, 2, 0, 62 },
                    { 2166, 3, 0, 62 },
                    { 2167, 4, 0, 62 },
                    { 2168, 5, 0, 62 },
                    { 2169, 6, 0, 62 },
                    { 2170, 7, 0, 62 },
                    { 2171, 8, 0, 62 },
                    { 2172, 9, 0, 62 },
                    { 2173, 10, 0, 62 },
                    { 2174, 11, 0, 62 },
                    { 2175, 12, 0, 62 },
                    { 2176, 13, 0, 62 },
                    { 2177, 14, 0, 62 },
                    { 2178, 15, 0, 62 },
                    { 2179, 16, 0, 62 },
                    { 2180, 17, 0, 62 },
                    { 2181, 18, 0, 62 },
                    { 2182, 19, 0, 62 },
                    { 2183, 20, 0, 62 },
                    { 2184, 21, 0, 62 },
                    { 2185, 22, 0, 62 },
                    { 2186, 23, 0, 62 },
                    { 2187, 24, 0, 62 },
                    { 2188, 25, 0, 62 },
                    { 2189, 26, 0, 62 },
                    { 2190, 27, 0, 62 },
                    { 2191, 28, 0, 62 },
                    { 2192, 29, 0, 62 },
                    { 2193, 30, 0, 62 },
                    { 2194, 31, 0, 62 },
                    { 2195, 32, 0, 62 },
                    { 2196, 33, 0, 62 },
                    { 2197, 34, 0, 62 },
                    { 2198, 35, 0, 62 },
                    { 2199, 36, 0, 62 },
                    { 2200, 37, 0, 62 },
                    { 2201, 38, 0, 62 },
                    { 2202, 39, 0, 62 },
                    { 2203, 40, 0, 62 },
                    { 2204, 41, 0, 62 },
                    { 2205, 42, 0, 62 },
                    { 2206, 43, 0, 62 },
                    { 2207, 44, 0, 62 },
                    { 2208, 45, 0, 62 },
                    { 2209, 46, 0, 62 },
                    { 2210, 0, 0, 63 },
                    { 2211, 1, 0, 63 },
                    { 2212, 2, 0, 63 },
                    { 2213, 3, 0, 63 },
                    { 2214, 4, 0, 63 },
                    { 2215, 5, 0, 63 },
                    { 2216, 6, 0, 63 },
                    { 2217, 7, 0, 63 },
                    { 2218, 8, 0, 63 },
                    { 2219, 9, 0, 63 },
                    { 2220, 10, 0, 63 },
                    { 2221, 11, 0, 63 },
                    { 2222, 12, 0, 63 },
                    { 2223, 13, 0, 63 },
                    { 2224, 14, 0, 63 },
                    { 2225, 15, 0, 63 },
                    { 2226, 16, 0, 63 },
                    { 2227, 17, 0, 63 },
                    { 2228, 18, 0, 63 },
                    { 2229, 19, 0, 63 },
                    { 2230, 20, 0, 63 },
                    { 2231, 21, 0, 63 },
                    { 2232, 22, 0, 63 },
                    { 2233, 23, 0, 63 },
                    { 2234, 24, 0, 63 },
                    { 2235, 25, 0, 63 },
                    { 2236, 26, 0, 63 },
                    { 2237, 27, 0, 63 },
                    { 2238, 28, 0, 63 },
                    { 2239, 29, 0, 63 },
                    { 2240, 30, 0, 63 },
                    { 2241, 31, 0, 63 },
                    { 2242, 32, 0, 63 },
                    { 2243, 33, 0, 63 },
                    { 2244, 34, 0, 63 },
                    { 2245, 35, 0, 63 },
                    { 2246, 36, 0, 63 },
                    { 2247, 37, 0, 63 },
                    { 2248, 38, 0, 63 },
                    { 2249, 39, 0, 63 },
                    { 2250, 40, 0, 63 },
                    { 2251, 41, 0, 63 },
                    { 2252, 42, 0, 63 },
                    { 2253, 43, 0, 63 },
                    { 2254, 44, 0, 63 },
                    { 2255, 45, 0, 63 },
                    { 2256, 46, 0, 63 },
                    { 2257, 0, 0, 64 },
                    { 2258, 1, 0, 64 },
                    { 2259, 2, 0, 64 },
                    { 2260, 3, 0, 64 },
                    { 2261, 4, 0, 64 },
                    { 2262, 5, 0, 64 },
                    { 2263, 6, 0, 64 },
                    { 2264, 7, 0, 64 },
                    { 2265, 8, 0, 64 },
                    { 2266, 9, 0, 64 },
                    { 2267, 10, 0, 64 },
                    { 2268, 11, 0, 64 },
                    { 2269, 12, 0, 64 },
                    { 2270, 13, 0, 64 },
                    { 2271, 14, 0, 64 },
                    { 2272, 15, 0, 64 },
                    { 2273, 16, 0, 64 },
                    { 2274, 17, 0, 64 },
                    { 2275, 18, 0, 64 },
                    { 2276, 19, 0, 64 },
                    { 2277, 20, 0, 64 },
                    { 2278, 21, 0, 64 },
                    { 2279, 22, 0, 64 },
                    { 2280, 23, 0, 64 },
                    { 2281, 24, 0, 64 },
                    { 2282, 25, 0, 64 },
                    { 2283, 26, 0, 64 },
                    { 2284, 27, 0, 64 },
                    { 2285, 28, 0, 64 },
                    { 2286, 29, 0, 64 },
                    { 2287, 30, 0, 64 },
                    { 2288, 31, 0, 64 },
                    { 2289, 32, 0, 64 },
                    { 2290, 33, 0, 64 },
                    { 2291, 34, 0, 64 },
                    { 2292, 35, 0, 64 },
                    { 2293, 36, 0, 64 },
                    { 2294, 37, 0, 64 },
                    { 2295, 38, 0, 64 },
                    { 2296, 39, 0, 64 },
                    { 2297, 40, 0, 64 },
                    { 2298, 41, 0, 64 },
                    { 2299, 42, 0, 64 },
                    { 2300, 43, 0, 64 },
                    { 2301, 44, 0, 64 },
                    { 2302, 45, 0, 64 },
                    { 2303, 46, 0, 64 },
                    { 2304, 0, 0, 65 },
                    { 2305, 1, 0, 65 },
                    { 2306, 2, 0, 65 },
                    { 2307, 3, 0, 65 },
                    { 2308, 4, 0, 65 },
                    { 2309, 5, 0, 65 },
                    { 2310, 6, 0, 65 },
                    { 2311, 7, 0, 65 },
                    { 2312, 8, 0, 65 },
                    { 2313, 9, 0, 65 },
                    { 2314, 10, 0, 65 },
                    { 2315, 11, 0, 65 },
                    { 2316, 12, 0, 65 },
                    { 2317, 13, 0, 65 },
                    { 2318, 14, 0, 65 },
                    { 2319, 15, 0, 65 },
                    { 2320, 16, 0, 65 },
                    { 2321, 17, 0, 65 },
                    { 2322, 18, 0, 65 },
                    { 2323, 19, 0, 65 },
                    { 2324, 20, 0, 65 },
                    { 2325, 21, 0, 65 },
                    { 2326, 22, 0, 65 },
                    { 2327, 23, 0, 65 },
                    { 2328, 24, 0, 65 },
                    { 2329, 25, 0, 65 },
                    { 2330, 26, 0, 65 },
                    { 2331, 27, 0, 65 },
                    { 2332, 28, 0, 65 },
                    { 2333, 29, 0, 65 },
                    { 2334, 30, 0, 65 },
                    { 2335, 31, 0, 65 },
                    { 2336, 32, 0, 65 },
                    { 2337, 33, 0, 65 },
                    { 2338, 34, 0, 65 },
                    { 2339, 35, 0, 65 },
                    { 2340, 36, 0, 65 },
                    { 2341, 37, 0, 65 },
                    { 2342, 38, 0, 65 },
                    { 2343, 39, 0, 65 },
                    { 2344, 40, 0, 65 },
                    { 2345, 41, 0, 65 },
                    { 2346, 42, 0, 65 },
                    { 2347, 43, 0, 65 },
                    { 2348, 44, 0, 65 },
                    { 2349, 45, 0, 65 },
                    { 2350, 46, 0, 65 },
                    { 2351, 0, 0, 71 },
                    { 2352, 1, 0, 71 },
                    { 2353, 2, 0, 71 },
                    { 2354, 3, 0, 71 },
                    { 2355, 4, 0, 71 },
                    { 2356, 5, 0, 71 },
                    { 2357, 6, 0, 71 },
                    { 2358, 7, 0, 71 },
                    { 2359, 8, 0, 71 },
                    { 2360, 9, 0, 71 },
                    { 2361, 10, 0, 71 },
                    { 2362, 11, 0, 71 },
                    { 2363, 12, 0, 71 },
                    { 2364, 13, 0, 71 },
                    { 2365, 14, 0, 71 },
                    { 2366, 15, 0, 71 },
                    { 2367, 16, 0, 71 },
                    { 2368, 17, 0, 71 },
                    { 2369, 18, 0, 71 },
                    { 2370, 19, 0, 71 },
                    { 2371, 20, 0, 71 },
                    { 2372, 21, 0, 71 },
                    { 2373, 22, 0, 71 },
                    { 2374, 23, 0, 71 },
                    { 2375, 24, 0, 71 },
                    { 2376, 25, 0, 71 },
                    { 2377, 26, 0, 71 },
                    { 2378, 27, 0, 71 },
                    { 2379, 28, 0, 71 },
                    { 2380, 29, 0, 71 },
                    { 2381, 30, 0, 71 },
                    { 2382, 31, 0, 71 },
                    { 2383, 32, 0, 71 },
                    { 2384, 33, 0, 71 },
                    { 2385, 34, 0, 71 },
                    { 2386, 35, 0, 71 },
                    { 2387, 36, 0, 71 },
                    { 2388, 37, 0, 71 },
                    { 2389, 38, 0, 71 },
                    { 2390, 39, 0, 71 },
                    { 2391, 40, 0, 71 },
                    { 2392, 41, 0, 71 },
                    { 2393, 42, 0, 71 },
                    { 2394, 43, 0, 71 },
                    { 2395, 44, 0, 71 },
                    { 2396, 45, 0, 71 },
                    { 2397, 46, 0, 71 },
                    { 2398, 0, 0, 72 },
                    { 2399, 1, 0, 72 },
                    { 2400, 2, 0, 72 },
                    { 2401, 3, 0, 72 },
                    { 2402, 4, 0, 72 },
                    { 2403, 5, 0, 72 },
                    { 2404, 6, 0, 72 },
                    { 2405, 7, 0, 72 },
                    { 2406, 8, 0, 72 },
                    { 2407, 9, 0, 72 },
                    { 2408, 10, 0, 72 },
                    { 2409, 11, 0, 72 },
                    { 2410, 12, 0, 72 },
                    { 2411, 13, 0, 72 },
                    { 2412, 14, 0, 72 },
                    { 2413, 15, 0, 72 },
                    { 2414, 16, 0, 72 },
                    { 2415, 17, 0, 72 },
                    { 2416, 18, 0, 72 },
                    { 2417, 19, 0, 72 },
                    { 2418, 20, 0, 72 },
                    { 2419, 21, 0, 72 },
                    { 2420, 22, 0, 72 },
                    { 2421, 23, 0, 72 },
                    { 2422, 24, 0, 72 },
                    { 2423, 25, 0, 72 },
                    { 2424, 26, 0, 72 },
                    { 2425, 27, 0, 72 },
                    { 2426, 28, 0, 72 },
                    { 2427, 29, 0, 72 },
                    { 2428, 30, 0, 72 },
                    { 2429, 31, 0, 72 },
                    { 2430, 32, 0, 72 },
                    { 2431, 33, 0, 72 },
                    { 2432, 34, 0, 72 },
                    { 2433, 35, 0, 72 },
                    { 2434, 36, 0, 72 },
                    { 2435, 37, 0, 72 },
                    { 2436, 38, 0, 72 },
                    { 2437, 39, 0, 72 },
                    { 2438, 40, 0, 72 },
                    { 2439, 41, 0, 72 },
                    { 2440, 42, 0, 72 },
                    { 2441, 43, 0, 72 },
                    { 2442, 44, 0, 72 },
                    { 2443, 45, 0, 72 },
                    { 2444, 46, 0, 72 },
                    { 2445, 0, 0, 73 },
                    { 2446, 1, 0, 73 },
                    { 2447, 2, 0, 73 },
                    { 2448, 3, 0, 73 },
                    { 2449, 4, 0, 73 },
                    { 2450, 5, 0, 73 },
                    { 2451, 6, 0, 73 },
                    { 2452, 7, 0, 73 },
                    { 2453, 8, 0, 73 },
                    { 2454, 9, 0, 73 },
                    { 2455, 10, 0, 73 },
                    { 2456, 11, 0, 73 },
                    { 2457, 12, 0, 73 },
                    { 2458, 13, 0, 73 },
                    { 2459, 14, 0, 73 },
                    { 2460, 15, 0, 73 },
                    { 2461, 16, 0, 73 },
                    { 2462, 17, 0, 73 },
                    { 2463, 18, 0, 73 },
                    { 2464, 19, 0, 73 },
                    { 2465, 20, 0, 73 },
                    { 2466, 21, 0, 73 },
                    { 2467, 22, 0, 73 },
                    { 2468, 23, 0, 73 },
                    { 2469, 24, 0, 73 },
                    { 2470, 25, 0, 73 },
                    { 2471, 26, 0, 73 },
                    { 2472, 27, 0, 73 },
                    { 2473, 28, 0, 73 },
                    { 2474, 29, 0, 73 },
                    { 2475, 30, 0, 73 },
                    { 2476, 31, 0, 73 },
                    { 2477, 32, 0, 73 },
                    { 2478, 33, 0, 73 },
                    { 2479, 34, 0, 73 },
                    { 2480, 35, 0, 73 },
                    { 2481, 36, 0, 73 },
                    { 2482, 37, 0, 73 },
                    { 2483, 38, 0, 73 },
                    { 2484, 39, 0, 73 },
                    { 2485, 40, 0, 73 },
                    { 2486, 41, 0, 73 },
                    { 2487, 42, 0, 73 },
                    { 2488, 43, 0, 73 },
                    { 2489, 44, 0, 73 },
                    { 2490, 45, 0, 73 },
                    { 2491, 46, 0, 73 },
                    { 2492, 0, 0, 74 },
                    { 2493, 1, 0, 74 },
                    { 2494, 2, 0, 74 },
                    { 2495, 3, 0, 74 },
                    { 2496, 4, 0, 74 },
                    { 2497, 5, 0, 74 },
                    { 2498, 6, 0, 74 },
                    { 2499, 7, 0, 74 },
                    { 2500, 8, 0, 74 },
                    { 2501, 9, 0, 74 },
                    { 2502, 10, 0, 74 },
                    { 2503, 11, 0, 74 },
                    { 2504, 12, 0, 74 },
                    { 2505, 13, 0, 74 },
                    { 2506, 14, 0, 74 },
                    { 2507, 15, 0, 74 },
                    { 2508, 16, 0, 74 },
                    { 2509, 17, 0, 74 },
                    { 2510, 18, 0, 74 },
                    { 2511, 19, 0, 74 },
                    { 2512, 20, 0, 74 },
                    { 2513, 21, 0, 74 },
                    { 2514, 22, 0, 74 },
                    { 2515, 23, 0, 74 },
                    { 2516, 24, 0, 74 },
                    { 2517, 25, 0, 74 },
                    { 2518, 26, 0, 74 },
                    { 2519, 27, 0, 74 },
                    { 2520, 28, 0, 74 },
                    { 2521, 29, 0, 74 },
                    { 2522, 30, 0, 74 },
                    { 2523, 31, 0, 74 },
                    { 2524, 32, 0, 74 },
                    { 2525, 33, 0, 74 },
                    { 2526, 34, 0, 74 },
                    { 2527, 35, 0, 74 },
                    { 2528, 36, 0, 74 },
                    { 2529, 37, 0, 74 },
                    { 2530, 38, 0, 74 },
                    { 2531, 39, 0, 74 },
                    { 2532, 40, 0, 74 },
                    { 2533, 41, 0, 74 },
                    { 2534, 42, 0, 74 },
                    { 2535, 43, 0, 74 },
                    { 2536, 44, 0, 74 },
                    { 2537, 45, 0, 74 },
                    { 2538, 46, 0, 74 },
                    { 2539, 0, 0, 75 },
                    { 2540, 1, 0, 75 },
                    { 2541, 2, 0, 75 },
                    { 2542, 3, 0, 75 },
                    { 2543, 4, 0, 75 },
                    { 2544, 5, 0, 75 },
                    { 2545, 6, 0, 75 },
                    { 2546, 7, 0, 75 },
                    { 2547, 8, 0, 75 },
                    { 2548, 9, 0, 75 },
                    { 2549, 10, 0, 75 },
                    { 2550, 11, 0, 75 },
                    { 2551, 12, 0, 75 },
                    { 2552, 13, 0, 75 },
                    { 2553, 14, 0, 75 },
                    { 2554, 15, 0, 75 },
                    { 2555, 16, 0, 75 },
                    { 2556, 17, 0, 75 },
                    { 2557, 18, 0, 75 },
                    { 2558, 19, 0, 75 },
                    { 2559, 20, 0, 75 },
                    { 2560, 21, 0, 75 },
                    { 2561, 22, 0, 75 },
                    { 2562, 23, 0, 75 },
                    { 2563, 24, 0, 75 },
                    { 2564, 25, 0, 75 },
                    { 2565, 26, 0, 75 },
                    { 2566, 27, 0, 75 },
                    { 2567, 28, 0, 75 },
                    { 2568, 29, 0, 75 },
                    { 2569, 30, 0, 75 },
                    { 2570, 31, 0, 75 },
                    { 2571, 32, 0, 75 },
                    { 2572, 33, 0, 75 },
                    { 2573, 34, 0, 75 },
                    { 2574, 35, 0, 75 },
                    { 2575, 36, 0, 75 },
                    { 2576, 37, 0, 75 },
                    { 2577, 38, 0, 75 },
                    { 2578, 39, 0, 75 },
                    { 2579, 40, 0, 75 },
                    { 2580, 41, 0, 75 },
                    { 2581, 42, 0, 75 },
                    { 2582, 43, 0, 75 },
                    { 2583, 44, 0, 75 },
                    { 2584, 45, 0, 75 },
                    { 2585, 46, 0, 75 },
                    { 2586, 0, 0, 81 },
                    { 2587, 1, 0, 81 },
                    { 2588, 2, 0, 81 },
                    { 2589, 3, 0, 81 },
                    { 2590, 4, 0, 81 },
                    { 2591, 5, 0, 81 },
                    { 2592, 6, 0, 81 },
                    { 2593, 7, 0, 81 },
                    { 2594, 8, 0, 81 },
                    { 2595, 9, 0, 81 },
                    { 2596, 10, 0, 81 },
                    { 2597, 11, 0, 81 },
                    { 2598, 12, 0, 81 },
                    { 2599, 13, 0, 81 },
                    { 2600, 14, 0, 81 },
                    { 2601, 15, 0, 81 },
                    { 2602, 16, 0, 81 },
                    { 2603, 17, 0, 81 },
                    { 2604, 18, 0, 81 },
                    { 2605, 19, 0, 81 },
                    { 2606, 20, 0, 81 },
                    { 2607, 21, 0, 81 },
                    { 2608, 22, 0, 81 },
                    { 2609, 23, 0, 81 },
                    { 2610, 24, 0, 81 },
                    { 2611, 25, 0, 81 },
                    { 2612, 26, 0, 81 },
                    { 2613, 27, 0, 81 },
                    { 2614, 28, 0, 81 },
                    { 2615, 29, 0, 81 },
                    { 2616, 30, 0, 81 },
                    { 2617, 31, 0, 81 },
                    { 2618, 32, 0, 81 },
                    { 2619, 33, 0, 81 },
                    { 2620, 34, 0, 81 },
                    { 2621, 35, 0, 81 },
                    { 2622, 36, 0, 81 },
                    { 2623, 37, 0, 81 },
                    { 2624, 38, 0, 81 },
                    { 2625, 39, 0, 81 },
                    { 2626, 40, 0, 81 },
                    { 2627, 41, 0, 81 },
                    { 2628, 42, 0, 81 },
                    { 2629, 43, 0, 81 },
                    { 2630, 44, 0, 81 },
                    { 2631, 45, 0, 81 },
                    { 2632, 46, 0, 81 },
                    { 2633, 0, 0, 82 },
                    { 2634, 1, 0, 82 },
                    { 2635, 2, 0, 82 },
                    { 2636, 3, 0, 82 },
                    { 2637, 4, 0, 82 },
                    { 2638, 5, 0, 82 },
                    { 2639, 6, 0, 82 },
                    { 2640, 7, 0, 82 },
                    { 2641, 8, 0, 82 },
                    { 2642, 9, 0, 82 },
                    { 2643, 10, 0, 82 },
                    { 2644, 11, 0, 82 },
                    { 2645, 12, 0, 82 },
                    { 2646, 13, 0, 82 },
                    { 2647, 14, 0, 82 },
                    { 2648, 15, 0, 82 },
                    { 2649, 16, 0, 82 },
                    { 2650, 17, 0, 82 },
                    { 2651, 18, 0, 82 },
                    { 2652, 19, 0, 82 },
                    { 2653, 20, 0, 82 },
                    { 2654, 21, 0, 82 },
                    { 2655, 22, 0, 82 },
                    { 2656, 23, 0, 82 },
                    { 2657, 24, 0, 82 },
                    { 2658, 25, 0, 82 },
                    { 2659, 26, 0, 82 },
                    { 2660, 27, 0, 82 },
                    { 2661, 28, 0, 82 },
                    { 2662, 29, 0, 82 },
                    { 2663, 30, 0, 82 },
                    { 2664, 31, 0, 82 },
                    { 2665, 32, 0, 82 },
                    { 2666, 33, 0, 82 },
                    { 2667, 34, 0, 82 },
                    { 2668, 35, 0, 82 },
                    { 2669, 36, 0, 82 },
                    { 2670, 37, 0, 82 },
                    { 2671, 38, 0, 82 },
                    { 2672, 39, 0, 82 },
                    { 2673, 40, 0, 82 },
                    { 2674, 41, 0, 82 },
                    { 2675, 42, 0, 82 },
                    { 2676, 43, 0, 82 },
                    { 2677, 44, 0, 82 },
                    { 2678, 45, 0, 82 },
                    { 2679, 46, 0, 82 },
                    { 2680, 0, 0, 83 },
                    { 2681, 1, 0, 83 },
                    { 2682, 2, 0, 83 },
                    { 2683, 3, 0, 83 },
                    { 2684, 4, 0, 83 },
                    { 2685, 5, 0, 83 },
                    { 2686, 6, 0, 83 },
                    { 2687, 7, 0, 83 },
                    { 2688, 8, 0, 83 },
                    { 2689, 9, 0, 83 },
                    { 2690, 10, 0, 83 },
                    { 2691, 11, 0, 83 },
                    { 2692, 12, 0, 83 },
                    { 2693, 13, 0, 83 },
                    { 2694, 14, 0, 83 },
                    { 2695, 15, 0, 83 },
                    { 2696, 16, 0, 83 },
                    { 2697, 17, 0, 83 },
                    { 2698, 18, 0, 83 },
                    { 2699, 19, 0, 83 },
                    { 2700, 20, 0, 83 },
                    { 2701, 21, 0, 83 },
                    { 2702, 22, 0, 83 },
                    { 2703, 23, 0, 83 },
                    { 2704, 24, 0, 83 },
                    { 2705, 25, 0, 83 },
                    { 2706, 26, 0, 83 },
                    { 2707, 27, 0, 83 },
                    { 2708, 28, 0, 83 },
                    { 2709, 29, 0, 83 },
                    { 2710, 30, 0, 83 },
                    { 2711, 31, 0, 83 },
                    { 2712, 32, 0, 83 },
                    { 2713, 33, 0, 83 },
                    { 2714, 34, 0, 83 },
                    { 2715, 35, 0, 83 },
                    { 2716, 36, 0, 83 },
                    { 2717, 37, 0, 83 },
                    { 2718, 38, 0, 83 },
                    { 2719, 39, 0, 83 },
                    { 2720, 40, 0, 83 },
                    { 2721, 41, 0, 83 },
                    { 2722, 42, 0, 83 },
                    { 2723, 43, 0, 83 },
                    { 2724, 44, 0, 83 },
                    { 2725, 45, 0, 83 },
                    { 2726, 46, 0, 83 },
                    { 2727, 0, 0, 84 },
                    { 2728, 1, 0, 84 },
                    { 2729, 2, 0, 84 },
                    { 2730, 3, 0, 84 },
                    { 2731, 4, 0, 84 },
                    { 2732, 5, 0, 84 },
                    { 2733, 6, 0, 84 },
                    { 2734, 7, 0, 84 },
                    { 2735, 8, 0, 84 },
                    { 2736, 9, 0, 84 },
                    { 2737, 10, 0, 84 },
                    { 2738, 11, 0, 84 },
                    { 2739, 12, 0, 84 },
                    { 2740, 13, 0, 84 },
                    { 2741, 14, 0, 84 },
                    { 2742, 15, 0, 84 },
                    { 2743, 16, 0, 84 },
                    { 2744, 17, 0, 84 },
                    { 2745, 18, 0, 84 },
                    { 2746, 19, 0, 84 },
                    { 2747, 20, 0, 84 },
                    { 2748, 21, 0, 84 },
                    { 2749, 22, 0, 84 },
                    { 2750, 23, 0, 84 },
                    { 2751, 24, 0, 84 },
                    { 2752, 25, 0, 84 },
                    { 2753, 26, 0, 84 },
                    { 2754, 27, 0, 84 },
                    { 2755, 28, 0, 84 },
                    { 2756, 29, 0, 84 },
                    { 2757, 30, 0, 84 },
                    { 2758, 31, 0, 84 },
                    { 2759, 32, 0, 84 },
                    { 2760, 33, 0, 84 },
                    { 2761, 34, 0, 84 },
                    { 2762, 35, 0, 84 },
                    { 2763, 36, 0, 84 },
                    { 2764, 37, 0, 84 },
                    { 2765, 38, 0, 84 },
                    { 2766, 39, 0, 84 },
                    { 2767, 40, 0, 84 },
                    { 2768, 41, 0, 84 },
                    { 2769, 42, 0, 84 },
                    { 2770, 43, 0, 84 },
                    { 2771, 44, 0, 84 },
                    { 2772, 45, 0, 84 },
                    { 2773, 46, 0, 84 },
                    { 2774, 0, 0, 85 },
                    { 2775, 1, 0, 85 },
                    { 2776, 2, 0, 85 },
                    { 2777, 3, 0, 85 },
                    { 2778, 4, 0, 85 },
                    { 2779, 5, 0, 85 },
                    { 2780, 6, 0, 85 },
                    { 2781, 7, 0, 85 },
                    { 2782, 8, 0, 85 },
                    { 2783, 9, 0, 85 },
                    { 2784, 10, 0, 85 },
                    { 2785, 11, 0, 85 },
                    { 2786, 12, 0, 85 },
                    { 2787, 13, 0, 85 },
                    { 2788, 14, 0, 85 },
                    { 2789, 15, 0, 85 },
                    { 2790, 16, 0, 85 },
                    { 2791, 17, 0, 85 },
                    { 2792, 18, 0, 85 },
                    { 2793, 19, 0, 85 },
                    { 2794, 20, 0, 85 },
                    { 2795, 21, 0, 85 },
                    { 2796, 22, 0, 85 },
                    { 2797, 23, 0, 85 },
                    { 2798, 24, 0, 85 },
                    { 2799, 25, 0, 85 },
                    { 2800, 26, 0, 85 },
                    { 2801, 27, 0, 85 },
                    { 2802, 28, 0, 85 },
                    { 2803, 29, 0, 85 },
                    { 2804, 30, 0, 85 },
                    { 2805, 31, 0, 85 },
                    { 2806, 32, 0, 85 },
                    { 2807, 33, 0, 85 },
                    { 2808, 34, 0, 85 },
                    { 2809, 35, 0, 85 },
                    { 2810, 36, 0, 85 },
                    { 2811, 37, 0, 85 },
                    { 2812, 38, 0, 85 },
                    { 2813, 39, 0, 85 },
                    { 2814, 40, 0, 85 },
                    { 2815, 41, 0, 85 },
                    { 2816, 42, 0, 85 },
                    { 2817, 43, 0, 85 },
                    { 2818, 44, 0, 85 },
                    { 2819, 45, 0, 85 },
                    { 2820, 46, 0, 85 },
                    { 2821, 42, 0, null },
                    { 2822, 43, 0, null },
                    { 2823, 46, 0, null },
                    { 2824, 44, 0, null },
                    { 2825, 45, 0, null }
                });

            migrationBuilder.InsertData(
                table: "Lab_DefaultSteps",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Scan" },
                    { 2, "Physical" },
                    { 3, "Cast" },
                    { 4, "Remake" },
                    { 5, "Design" },
                    { 6, "3d Scanning" },
                    { 7, "Finishing" },
                    { 8, "Ready to try in" },
                    { 9, "Done" },
                    { 10, "Waiting customer action" },
                    { 11, "Waiting lab approval" }
                });

            migrationBuilder.InsertData(
                table: "TreatmentPrices",
                columns: new[] { "Id", "Crown", "Extraction", "Other", "Restoration", "RootCanalTreatment", "Scaling" },
                values: new object[] { 1, 0, 0, 0, 0, 0, 0 });

            migrationBuilder.CreateIndex(
                name: "IX_AspNetRoleClaims_RoleId",
                table: "AspNetRoleClaims",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "RoleNameIndex",
                table: "AspNetRoles",
                column: "NormalizedName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserClaims_UserId",
                table: "AspNetUserClaims",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserLogins_UserId",
                table: "AspNetUserLogins",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserRoles_RoleId",
                table: "AspNetUserRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "EmailIndex",
                table: "AspNetUsers",
                column: "NormalizedEmail");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_BatchId",
                table: "AspNetUsers",
                column: "BatchId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_ProfileImageId",
                table: "AspNetUsers",
                column: "ProfileImageId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_RegisteredById1",
                table: "AspNetUsers",
                column: "RegisteredById1");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_WorkplaceId",
                table: "AspNetUsers",
                column: "WorkplaceId");

            migrationBuilder.CreateIndex(
                name: "UserNameIndex",
                table: "AspNetUsers",
                column: "NormalizedUserName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CandidateDetails_CandidateId1",
                table: "CandidateDetails",
                column: "CandidateId1");

            migrationBuilder.CreateIndex(
                name: "IX_CandidateDetails_ImplantId",
                table: "CandidateDetails",
                column: "ImplantId");

            migrationBuilder.CreateIndex(
                name: "IX_CandidateDetails_PatientId",
                table: "CandidateDetails",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_CategoryId",
                table: "CashFlow",
                column: "CategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_CreatedById1",
                table: "CashFlow",
                column: "CreatedById1");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_ImplantLineId",
                table: "CashFlow",
                column: "ImplantLineId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_LabRequestId",
                table: "CashFlow",
                column: "LabRequestId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_MembraneCompnayId",
                table: "CashFlow",
                column: "MembraneCompnayId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_PatientId",
                table: "CashFlow",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_PaymentLogId",
                table: "CashFlow",
                column: "PaymentLogId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_PaymentMethodId",
                table: "CashFlow",
                column: "PaymentMethodId");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_ReceiptID",
                table: "CashFlow",
                column: "ReceiptID");

            migrationBuilder.CreateIndex(
                name: "IX_CashFlow_SupplierId",
                table: "CashFlow",
                column: "SupplierId");

            migrationBuilder.CreateIndex(
                name: "IX_CIA_Complains_EntryById1",
                table: "CIA_Complains",
                column: "EntryById1");

            migrationBuilder.CreateIndex(
                name: "IX_CIA_Complains_LastCandidateId1",
                table: "CIA_Complains",
                column: "LastCandidateId1");

            migrationBuilder.CreateIndex(
                name: "IX_CIA_Complains_LastDoctorId1",
                table: "CIA_Complains",
                column: "LastDoctorId1");

            migrationBuilder.CreateIndex(
                name: "IX_CIA_Complains_LastSupervisorId1",
                table: "CIA_Complains",
                column: "LastSupervisorId1");

            migrationBuilder.CreateIndex(
                name: "IX_CIA_Complains_MentionedDoctorId1",
                table: "CIA_Complains",
                column: "MentionedDoctorId1");

            migrationBuilder.CreateIndex(
                name: "IX_CIA_Complains_PatientID",
                table: "CIA_Complains",
                column: "PatientID");

            migrationBuilder.CreateIndex(
                name: "IX_CIA_Complains_ResolvedById1",
                table: "CIA_Complains",
                column: "ResolvedById1");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_ClinicImplantId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "ClinicImplantId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_DoctorId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "DoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_OrthoTreatmentId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "OrthoTreatmentId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_PatientId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_PedoId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "PedoId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_RestorationId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "RestorationId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_RootCanalTreatmentId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "RootCanalTreatmentId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_ScalingId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "ScalingId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicDoctorClinicPercentageModels_TMDId",
                table: "ClinicDoctorClinicPercentageModels",
                column: "TMDId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicTreatmentParent_AssistantId",
                table: "ClinicTreatmentParent",
                column: "AssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicTreatmentParent_DoctorId",
                table: "ClinicTreatmentParent",
                column: "DoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicTreatmentParent_ImplantCompanyId",
                table: "ClinicTreatmentParent",
                column: "ImplantCompanyId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicTreatmentParent_ImplantId",
                table: "ClinicTreatmentParent",
                column: "ImplantId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicTreatmentParent_ImplantLineId",
                table: "ClinicTreatmentParent",
                column: "ImplantLineId");

            migrationBuilder.CreateIndex(
                name: "IX_ClinicTreatmentParent_PatientId",
                table: "ClinicTreatmentParent",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_DentalExaminations_OperatorId1",
                table: "DentalExaminations",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_DentalExaminations_PatientId",
                table: "DentalExaminations",
                column: "PatientId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DentalHistories_OperatorId1",
                table: "DentalHistories",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_DentalHistories_PatientId",
                table: "DentalHistories",
                column: "PatientId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ImplantLines_ImplantCompanyId",
                table: "ImplantLines",
                column: "ImplantCompanyId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_AssignedToId1",
                table: "Lab_Requests",
                column: "AssignedToId1");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_CustomerId1",
                table: "Lab_Requests",
                column: "CustomerId1");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_EntryById1",
                table: "Lab_Requests",
                column: "EntryById1");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_FileId",
                table: "Lab_Requests",
                column: "FileId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_Lab_Request",
                table: "Lab_Requests",
                column: "Lab_Request");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_Requests_PatientId",
                table: "Lab_Requests",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_RequestSteps_AskForStepUserId1",
                table: "Lab_RequestSteps",
                column: "AskForStepUserId1");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_RequestSteps_Lab_RequestStep",
                table: "Lab_RequestSteps",
                column: "Lab_RequestStep");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_RequestSteps_StepId",
                table: "Lab_RequestSteps",
                column: "StepId");

            migrationBuilder.CreateIndex(
                name: "IX_Lab_RequestSteps_TechnicianId1",
                table: "Lab_RequestSteps",
                column: "TechnicianId1");

            migrationBuilder.CreateIndex(
                name: "IX_MedicalExaminations_OperatorId1",
                table: "MedicalExaminations",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_MedicalExaminations_PatientId",
                table: "MedicalExaminations",
                column: "PatientId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_NonSurgicalTreatment_OperatorId",
                table: "NonSurgicalTreatment",
                column: "OperatorId");

            migrationBuilder.CreateIndex(
                name: "IX_NonSurgicalTreatment_PatientId",
                table: "NonSurgicalTreatment",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_NonSurgicalTreatment_SupervisorId",
                table: "NonSurgicalTreatment",
                column: "SupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_UserId1",
                table: "Notifications",
                column: "UserId1");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_DoctorId",
                table: "Patients",
                column: "DoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_IdBackImageId",
                table: "Patients",
                column: "IdBackImageId");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_IdFrontImageId",
                table: "Patients",
                column: "IdFrontImageId");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_ProfileImageId",
                table: "Patients",
                column: "ProfileImageId");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_ReferralDoctorId",
                table: "Patients",
                column: "ReferralDoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_ReferralPatientID",
                table: "Patients",
                column: "ReferralPatientID");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_RegisteredById1",
                table: "Patients",
                column: "RegisteredById1");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_RelativePatientID",
                table: "Patients",
                column: "RelativePatientID");

            migrationBuilder.CreateIndex(
                name: "IX_PaymentLogs_OperatorId1",
                table: "PaymentLogs",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_PaymentLogs_PatientId",
                table: "PaymentLogs",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_PaymentLogs_ReceiptId",
                table: "PaymentLogs",
                column: "ReceiptId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_PatientId",
                table: "ProstheticTreatments",
                column: "PatientId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_Bite_OperatorId1",
                table: "ProstheticTreatments_Bite",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_Bite_PatientId",
                table: "ProstheticTreatments_Bite",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_Bite_ProstheticTreatmentId",
                table: "ProstheticTreatments_Bite",
                column: "ProstheticTreatmentId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_OperatorId1",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_PatientId",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_DiagnosticImpression_ProstheticTreatme~",
                table: "ProstheticTreatments_DiagnosticImpression",
                column: "ProstheticTreatmentId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_OperatorId1",
                table: "ProstheticTreatments_ScanAppliance",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_PatientId",
                table: "ProstheticTreatments_ScanAppliance",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_ProstheticTreatments_ScanAppliance_ProstheticTreatmentId",
                table: "ProstheticTreatments_ScanAppliance",
                column: "ProstheticTreatmentId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_OperatorId1",
                table: "Receipts",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_PatientId",
                table: "Receipts",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_Receipts_RequestId",
                table: "Receipts",
                column: "RequestId");

            migrationBuilder.CreateIndex(
                name: "IX_RequestChanges_PatientId",
                table: "RequestChanges",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_RequestChanges_SurgicalTreatmentModelId",
                table: "RequestChanges",
                column: "SurgicalTreatmentModelId");

            migrationBuilder.CreateIndex(
                name: "IX_RequestChanges_UserId1",
                table: "RequestChanges",
                column: "UserId1");

            migrationBuilder.CreateIndex(
                name: "IX_StockLogs_OperatorId1",
                table: "StockLogs",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_SurgicalTreatments_OpenSinusLift_Membrane_CompanyID",
                table: "SurgicalTreatments",
                column: "OpenSinusLift_Membrane_CompanyID");

            migrationBuilder.CreateIndex(
                name: "IX_SurgicalTreatments_OpenSinusLift_MembraneID",
                table: "SurgicalTreatments",
                column: "OpenSinusLift_MembraneID");

            migrationBuilder.CreateIndex(
                name: "IX_SurgicalTreatments_OpenSinusLift_TacsCompanyID",
                table: "SurgicalTreatments",
                column: "OpenSinusLift_TacsCompanyID");

            migrationBuilder.CreateIndex(
                name: "IX_SurgicalTreatments_PatientId",
                table: "SurgicalTreatments",
                column: "PatientId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlans_OperatorId1",
                table: "TreatmentPlans",
                column: "OperatorId1");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlans_PatientId",
                table: "TreatmentPlans",
                column: "PatientId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithImplant_DoneByAssist~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithImplant_DoneByCandi~1",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithImplant_DoneByCandid~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithImplant_DoneBySuperv~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithImplant_ImplantIDReq~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithImplant_RequestChang~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithoutImplant_AssignedT~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithoutImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithoutImplant_DoneByAss~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithoutImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithoutImplant_DoneByCa~1",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithoutImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithoutImplant_DoneByCan~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithoutImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithoutImplant_DoneBySup~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithoutImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithoutImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithoutImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithoutImplant_ImplantID~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithoutImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ClosedSinusWithoutImplant_RequestCh~",
                table: "TreatmentPlansSubModels",
                column: "ClosedSinusWithoutImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Crown_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "Crown_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Crown_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "Crown_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Crown_DoneByCandidateBatchID",
                table: "TreatmentPlansSubModels",
                column: "Crown_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Crown_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "Crown_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Crown_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "Crown_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Crown_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "Crown_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Crown_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "Crown_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Crown_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "Crown_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithImplant_DoneByAssistan~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithImplant_DoneByCandida~1",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithImplant_DoneByCandidat~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithImplant_DoneBySupervis~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithImplant_ImplantIDReque~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithImplant_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithoutImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithoutImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithoutImplant_DoneByAssis~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithoutImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithoutImplant_DoneByCand~1",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithoutImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithoutImplant_DoneByCandi~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithoutImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithoutImplant_DoneBySuper~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithoutImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithoutImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithoutImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithoutImplant_ImplantIDRe~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithoutImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ExpansionWithoutImplant_RequestChan~",
                table: "TreatmentPlansSubModels",
                column: "ExpansionWithoutImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Extraction_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "Extraction_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Extraction_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "Extraction_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Extraction_DoneByCandidateBatchID",
                table: "TreatmentPlansSubModels",
                column: "Extraction_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Extraction_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "Extraction_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Extraction_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "Extraction_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Extraction_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "Extraction_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Extraction_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "Extraction_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Extraction_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "Extraction_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithImplant_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithImplant_DoneByCandidateBatch~",
                table: "TreatmentPlansSubModels",
                column: "GBRWithImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithImplant_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithImplant_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "GBRWithImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithImplant_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "GBRWithImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithImplant_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithoutImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithoutImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithoutImplant_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithoutImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithoutImplant_DoneByCandidateBa~",
                table: "TreatmentPlansSubModels",
                column: "GBRWithoutImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithoutImplant_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithoutImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithoutImplant_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithoutImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithoutImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "GBRWithoutImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithoutImplant_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "GBRWithoutImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GBRWithoutImplant_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "GBRWithoutImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GuidedImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "GuidedImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GuidedImplant_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "GuidedImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GuidedImplant_DoneByCandidateBatchID",
                table: "TreatmentPlansSubModels",
                column: "GuidedImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GuidedImplant_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "GuidedImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GuidedImplant_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "GuidedImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GuidedImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "GuidedImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GuidedImplant_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "GuidedImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_GuidedImplant_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "GuidedImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ImmediateImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "ImmediateImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ImmediateImplant_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "ImmediateImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ImmediateImplant_DoneByCandidateBat~",
                table: "TreatmentPlansSubModels",
                column: "ImmediateImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ImmediateImplant_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "ImmediateImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ImmediateImplant_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "ImmediateImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ImmediateImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "ImmediateImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ImmediateImplant_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "ImmediateImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_ImmediateImplant_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "ImmediateImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithImplant_DoneByAssistan~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithImplant_DoneByCandida~1",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithImplant_DoneByCandidat~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithImplant_DoneBySupervis~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithImplant_ImplantIDReque~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithImplant_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithoutImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithoutImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithoutImplant_DoneByAssis~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithoutImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithoutImplant_DoneByCand~1",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithoutImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithoutImplant_DoneByCandi~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithoutImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithoutImplant_DoneBySuper~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithoutImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithoutImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithoutImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithoutImplant_ImplantIDRe~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithoutImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_OpenSinusWithoutImplant_RequestChan~",
                table: "TreatmentPlansSubModels",
                column: "OpenSinusWithoutImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_PatientId",
                table: "TreatmentPlansSubModels",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Pontic_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "Pontic_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Pontic_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "Pontic_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Pontic_DoneByCandidateBatchID",
                table: "TreatmentPlansSubModels",
                column: "Pontic_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Pontic_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "Pontic_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Pontic_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "Pontic_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Pontic_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "Pontic_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Pontic_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "Pontic_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Pontic_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "Pontic_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Restoration_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "Restoration_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Restoration_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "Restoration_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Restoration_DoneByCandidateBatchID",
                table: "TreatmentPlansSubModels",
                column: "Restoration_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Restoration_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "Restoration_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Restoration_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "Restoration_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Restoration_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "Restoration_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Restoration_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "Restoration_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Restoration_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "Restoration_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_RootCanalTreatment_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "RootCanalTreatment_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_RootCanalTreatment_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "RootCanalTreatment_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_RootCanalTreatment_DoneByCandidateB~",
                table: "TreatmentPlansSubModels",
                column: "RootCanalTreatment_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_RootCanalTreatment_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "RootCanalTreatment_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_RootCanalTreatment_DoneBySupervisor~",
                table: "TreatmentPlansSubModels",
                column: "RootCanalTreatment_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_RootCanalTreatment_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "RootCanalTreatment_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_RootCanalTreatment_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "RootCanalTreatment_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_RootCanalTreatment_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "RootCanalTreatment_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Scaling_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "Scaling_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Scaling_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "Scaling_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Scaling_DoneByCandidateBatchID",
                table: "TreatmentPlansSubModels",
                column: "Scaling_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Scaling_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "Scaling_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Scaling_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "Scaling_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Scaling_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "Scaling_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Scaling_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "Scaling_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_Scaling_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "Scaling_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SimpleImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "SimpleImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SimpleImplant_DoneByAssistantId",
                table: "TreatmentPlansSubModels",
                column: "SimpleImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SimpleImplant_DoneByCandidateBatchID",
                table: "TreatmentPlansSubModels",
                column: "SimpleImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SimpleImplant_DoneByCandidateId",
                table: "TreatmentPlansSubModels",
                column: "SimpleImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SimpleImplant_DoneBySupervisorId",
                table: "TreatmentPlansSubModels",
                column: "SimpleImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SimpleImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "SimpleImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SimpleImplant_ImplantIDRequest",
                table: "TreatmentPlansSubModels",
                column: "SimpleImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SimpleImplant_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "SimpleImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithImplant_DoneByAssistan~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithImplant_DoneByCandida~1",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithImplant_DoneByCandidat~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithImplant_DoneBySupervis~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithImplant_ImplantIDReque~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithImplant_RequestChangeId",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithoutImplant_AssignedToId",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithoutImplant_AssignedToId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithoutImplant_DoneByAssis~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithoutImplant_DoneByAssistantId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithoutImplant_DoneByCand~1",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithoutImplant_DoneByCandidateId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithoutImplant_DoneByCandi~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithoutImplant_DoneByCandidateBatchID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithoutImplant_DoneBySuper~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithoutImplant_DoneBySupervisorId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithoutImplant_ImplantID",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithoutImplant_ImplantID");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithoutImplant_ImplantIDRe~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithoutImplant_ImplantIDRequest");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentPlansSubModels_SplittingWithoutImplant_RequestChan~",
                table: "TreatmentPlansSubModels",
                column: "SplittingWithoutImplant_RequestChangeId");

            migrationBuilder.CreateIndex(
                name: "IX_VisitsLogs_DoctorId",
                table: "VisitsLogs",
                column: "DoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_VisitsLogs_PatientID",
                table: "VisitsLogs",
                column: "PatientID");

            migrationBuilder.CreateIndex(
                name: "IX_VisitsLogs_RoomId",
                table: "VisitsLogs",
                column: "RoomId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AspNetRoleClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserLogins");

            migrationBuilder.DropTable(
                name: "AspNetUserRoles");

            migrationBuilder.DropTable(
                name: "AspNetUserTokens");

            migrationBuilder.DropTable(
                name: "CandidateDetails");

            migrationBuilder.DropTable(
                name: "CIA_Complains");

            migrationBuilder.DropTable(
                name: "ClinicDoctorClinicPercentageModels");

            migrationBuilder.DropTable(
                name: "ClinicPatients");

            migrationBuilder.DropTable(
                name: "ClinicPrices");

            migrationBuilder.DropTable(
                name: "ConnectionModel");

            migrationBuilder.DropTable(
                name: "DentalExamination");

            migrationBuilder.DropTable(
                name: "DentalHistories");

            migrationBuilder.DropTable(
                name: "HBA1cModel");

            migrationBuilder.DropTable(
                name: "Lab_RequestSteps");

            migrationBuilder.DropTable(
                name: "NonSurgicalTreatment");

            migrationBuilder.DropTable(
                name: "Notifications");

            migrationBuilder.DropTable(
                name: "OutSourcePatients");

            migrationBuilder.DropTable(
                name: "ProstheticTreatments_Bite");

            migrationBuilder.DropTable(
                name: "ProstheticTreatments_DiagnosticImpression");

            migrationBuilder.DropTable(
                name: "ProstheticTreatments_ScanAppliance");

            migrationBuilder.DropTable(
                name: "StockLogs");

            migrationBuilder.DropTable(
                name: "ToothReceiptData");

            migrationBuilder.DropTable(
                name: "TreatmentPlans");

            migrationBuilder.DropTable(
                name: "TreatmentPlansSubModels");

            migrationBuilder.DropTable(
                name: "TreatmentPrices");

            migrationBuilder.DropTable(
                name: "VisitsLogs");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "ClinicTreatmentParent");

            migrationBuilder.DropTable(
                name: "DentalExaminations");

            migrationBuilder.DropTable(
                name: "MedicalExaminations");

            migrationBuilder.DropTable(
                name: "Lab_DefaultSteps");

            migrationBuilder.DropTable(
                name: "ProstheticTreatments");

            migrationBuilder.DropTable(
                name: "RequestChanges");

            migrationBuilder.DropTable(
                name: "Rooms");

            migrationBuilder.DropTable(
                name: "SurgicalTreatments");

            migrationBuilder.DropTable(
                name: "CashFlow");

            migrationBuilder.DropTable(
                name: "ImplantLines");

            migrationBuilder.DropTable(
                name: "MembraneCompanies");

            migrationBuilder.DropTable(
                name: "PaymentLogs");

            migrationBuilder.DropTable(
                name: "ImplantCompanies");

            migrationBuilder.DropTable(
                name: "Receipts");

            migrationBuilder.DropTable(
                name: "Lab_Requests");

            migrationBuilder.DropTable(
                name: "Lab_Files");

            migrationBuilder.DropTable(
                name: "Patients");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "DropDowns");

            migrationBuilder.DropTable(
                name: "Images");

            migrationBuilder.DropTable(
                name: "Lab_CustomerWorkPlaces");
        }
    }
}
