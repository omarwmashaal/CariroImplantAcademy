using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels;
using CIA.Models.LAB;
using CIA.Models.TreatmentModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;

namespace CIA.DataBases
{
    public class CIA_dbContext : IdentityDbContext<ApplicationUser>
    {

        public DbSet<ClinicTreatmentParent> ClinicTreatmentParents { get; set; }
        public DbSet<ApplicationUser> Users { get; set; }
        public DbSet<CandidateDetails> CandidateDetails { get; set; }
        public DbSet<RequestChangeModel> RequestChanges { get; set; }
        public DbSet<Patient> Patients { get; set; }
        public DbSet<OutSourcePatient> OutSourePatients { get; set; }
        public DbSet<ClinicPatient> ClinicPatients { get; set; }
        public DbSet<Image> Images { get; set; }
        public DbSet<VisitsLog> VisitsLogs { get; set; }
        public DbSet<TodoList> ToDoLists { get; set; }
        public DbSet<DentalExaminationModel> DentalExaminations { get; set; }
        public DbSet<DentalHistoryModel> DentalHistories { get; set; }
        public DbSet<MedicalExaminationModel> MedicalExaminations { get; set; }
        public DbSet<TreatmentItemModel> TreatmentItems { get; set; }
        public DbSet<TreatmentDetailsModel> TreatmentDetails { get; set; }
        public DbSet<TreatmentPlanSubModel> TreatmentPlansSubModels { get; set; }
        public DbSet<SurgicalTreatmentModel> SurgicalTreatments { get; set; }

        public DbSet<PostSurgeryModel> PostSurgeries { get; set; }
        public DbSet<TreatmentPlanModel> TreatmentPlans { get; set; }
        public DbSet<NonSurgicalTreatmentModel> NonSurgicalTreatment { get; set; }
        public DbSet<ProstheticTreatmentDiagnosticModel> ProstheticTreatments { get; set; }
        public DbSet<ScanApplianceModel> ProstheticTreatments_ScanAppliance { get; set; }
        public DbSet<BiteModel> ProstheticTreatments_Bite { get; set; }
        public DbSet<DiagnosticImpressionModel> ProstheticTreatments_DiagnosticImpression { get; set; }

        public DbSet<ProstheticTreatmentFinalSingleBridge> ProstheticTreatmentFinalSingleBridges { get; set; }
        public DbSet<ProstheticTreatmentFinalFullArch> ProstheticTreatmentFinalFullArchs { get; set; }
        public DbSet<FinalProsthesisHealingCollar> FinalProsthesisHealingCollars { get; set; }
        public DbSet<FinalProsthesisImpression> FinalProsthesisImpressions { get; set; }
        public DbSet<FinalProsthesisTryIn> FinalProsthesisTryIns { get; set; }
        public DbSet<FinalProsthesisDelivery> FinalProsthesisDeliveries { get; set; }

        public DbSet<FinalProsthesisParentModel> FinalProsthesisParents { get; set; }
        public DbSet<ProstheticTreatmentDiagnosticParentModel> DiagnosticProsthesisParents { get; set; }
        public DbSet<StockItem> Stock { get; set; }
        public DbSet<StockLog> StockLogs { get; set; }
        public DbSet<CashFlowModel> CashFlow { get; set; }
        public DbSet<ExpensesModel> Expenses { get; set; }
        public DbSet<IncomeModel> Income { get; set; }
        public DbSet<Receipt> Receipts { get; set; }
        public DbSet<DropDowns> DropDowns { get; set; }
        public DbSet<ExpensesCategoriesModel> ExpensesCategories { get; set; }
        public DbSet<MedicalExpensesModel> MedicalExpenses { get; set; }
        public DbSet<SuppliersModel> Suppliers { get; set; }
        public DbSet<MedicalSuppliersModel> MedicalSuppliers { get; set; }
        public DbSet<NonMedicalSuppliersModel> NonMedicalSuppliers { get; set; }
        public DbSet<IncomeCategoriesModel> IncomeCategories { get; set; }
        public DbSet<PaymentMethodsModel> PaymentMethods { get; set; }
        public DbSet<StockCategoriesModel> StockCategories { get; set; }
        public DbSet<CandidatesBatchesModel> CandidatesBatches { get; set; }

        public DbSet<Implant> Implants { get; set; }
        public DbSet<Membrane> Membranes { get; set; }
        public DbSet<ScrewsModel> Screws { get; set; }
        public DbSet<MembraneCompany> MembraneCompanies { get; set; }
        public DbSet<CIA_Complains> CIA_Complains { get; set; }
        public DbSet<ComplicationsAfterProsthesisModel> ComplicationsAfterProsthesis { get; set; }
        public DbSet<ComplicationsAfterProsthesisParentModel> ComplicationsAfterProsthesisParents { get; set; }
        public DbSet<ComplicationsAfterSurgeryModel> ComplicationsAfterSurgery { get; set; }
        public DbSet<ComplicationsAfterSurgeryParentModel> ComplicationsAfterSurgeryParents { get; set; }
        public DbSet<Clinic_Complains> Clinic_Complains { get; set; }
        public DbSet<TacCompany> TacCompanies { get; set; }
        public DbSet<ImplantCompany> ImplantCompanies { get; set; }
        public DbSet<ImplantLine> ImplantLines { get; set; }
        public DbSet<RoomModel> Rooms { get; set; }
        public DbSet<Lab_File> Lab_Files { get; set; }
        public DbSet<Lab_Request> Lab_Requests { get; set; }
        public DbSet<Lab_RequestStep> Lab_RequestSteps { get; set; }
        public DbSet<Lab_DefaultStep> Lab_DefaultSteps { get; set; }
        public DbSet<Lab_CustomerWorkPlace> Lab_CustomerWorkPlaces { get; set; }
        public DbSet<PaymentLog> PaymentLogs { get; set; }
        public DbSet<NotificationModel> Notifications { get; set; }
        public DbSet<Restoration> Restorations { get; set; }
        public DbSet<ClinicImplant> ClinicImplants { get; set; }
        public DbSet<OrthoTreatment> OrthoTreatments { get; set; }
        public DbSet<TMD> TMDs { get; set; }
        public DbSet<Pedo> Pedos { get; set; }
        public DbSet<RootCanalTreatment> RootCanalTreatments { get; set; }
        public DbSet<Scaling> Scalings { get; set; }
        public DbSet<ClinicPricesModel> ClinicPrices { get; set; }
        public DbSet<ClinicReceiptModel> ClinicReceipts { get; set; }
        public DbSet<ClinicDoctorClinicPercentageModel> ClinicDoctorClinicPercentageModels { get; set; }
        public DbSet<LabItem_WaxUp> LabItem_WaxUps { get; set; }
        public DbSet<LabItem_ZirconUnit> LabItem_ZirconUnits { get; set; }

        public DbSet<LabItem_PFM> LabItem_PFMs { get; set; }

        public DbSet<LabItem_CompositeInlay> LabItem_CompositeInlays { get; set; }

        public DbSet<LabItem_EmaxVeneer> LabItem_EmaxVeneers { get; set; }

        public DbSet<LabItem_MilledPMMA> LabItem_MilledPMMA { get; set; }

        public DbSet<LabItem_PrintedPMMA> LabItem_PrintedPMMA { get; set; }

        public DbSet<LabItem_TiAbutment> LabItem_TiAbutments { get; set; }

        public DbSet<LabItem_TiBar> LabItem_TiBars { get; set; }

        public DbSet<LabItem_ThreeDPrinting> LabItem_ThreeDPrintings { get; set; }
        public DbSet<LabItemCompany> LabItemCompanies { get; set; }
        public DbSet<LabItemShade> LabItemShades { get; set; }
        public DbSet<LabItem> LabItems { get; set; }
        public DbSet<LabItemParent> LabItemParents { get; set; }





        public CIA_dbContext(DbContextOptions<CIA_dbContext> options) : base(options)
        {
        }




        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {



            modelBuilder.Entity<ApplicationUser>().Navigation(e => e.Batch).AutoInclude();


            List<IdentityRole> roles = new List<IdentityRole> {
                new IdentityRole{ Id ="d43b451c-ad08-4764-ae04-0a929c9151e8" , Name = "admin", NormalizedName= "ADMIN"},
                new IdentityRole{Id = "3ab751a0-c843-4601-a13e-d0bd2877143f", Name = "instructor",NormalizedName = "INSTRUCTOR"},
                new IdentityRole{Id = "51fbd5fa-2d92-4107-930a-368afcb79693", Name = "assistant", NormalizedName="ASSISTANT"},
                new IdentityRole{Id = "c16a4456-2f2a-4a3d-874e-5aae449835b9", Name = "secretary",NormalizedName="SECRETARY"},
                new IdentityRole{Id ="7976757b-4f45-4d74-8de9-7b2456f16830" , Name = "technician",NormalizedName="TECHNICIAN"},
                new IdentityRole{ Id = "725ee612-7bf9-444c-85ad-162eff90f1c1" ,Name = "outsource",NormalizedName="OUTSOURCE"},
                new IdentityRole{Id = "e1a6928d-ced0-44af-9f25-b844d244ebf3", Name = "candidate",NormalizedName="CANDIDATE"},
                new IdentityRole{Id = "c83449cd-1979-4ea0-b293-227e271fc612", Name = "labmoderator",NormalizedName="LABMODERATOR"},
                new IdentityRole{Id= "4999dc08-005d-4e4d-a99d-3150b0e75f1d", Name = "labdesigner",NormalizedName="LABDESIGNER"},

            };
            modelBuilder.Entity<IdentityRole>().HasData(roles);




            //List<TreatmentPrice> treatmentPrices = new List<TreatmentPrice> {
            //    new TreatmentPrice{
            //        Id = 1,
            //        Crown = 0,
            //        Extraction = 0,
            //        Restoration = 0,
            //        Scaling = 0,
            //        RootCanalTreatment = 0,
            //        Implant = 0,
            //        Other = 0,

            //    },

            //};
            //modelBuilder.Entity<TreatmentPrice>().HasData(treatmentPrices);

            List<ClinicPricesModel> clinicPricesModels = new List<ClinicPricesModel>();
            int clinicPriceId = 1;
            for (int tooth = 1; tooth < 90; tooth++)
            {
                if (
                    tooth == 9
                    || tooth == 10
                    || tooth == 19
                    || tooth == 20
                    || tooth == 29
                    || tooth == 30
                    || tooth == 39
                    || tooth == 40
                    || tooth == 49
                    || tooth == 50
                    || tooth == 59
                    || tooth == 58
                    || tooth == 57
                    || tooth == 56
                    || tooth == 60
                    || tooth == 69
                    || tooth == 68
                    || tooth == 67
                    || tooth == 66
                    || tooth == 70
                    || tooth == 79
                    || tooth == 78
                    || tooth == 77
                    || tooth == 76
                    || tooth == 80
                    || tooth == 89
                    || tooth == 88
                    || tooth == 87
                    || tooth == 86
                    ) continue;

                foreach (EnumClinicPrices cat in Enum.GetValues(typeof(EnumClinicPrices)))
                {

                    clinicPricesModels.Add(new ClinicPricesModel()
                    {
                        Id = clinicPriceId,
                        Category = cat,
                        Tooth = tooth,
                        Price = 0
                    });
                    clinicPriceId++;
                }


            }

            clinicPricesModels.Add(new ClinicPricesModel()
            {
                Id = clinicPriceId,
                Category = EnumClinicPrices.DoctorsPatientDoctorsOperation_DoctorPercent,
                Price = 0
            });
            clinicPriceId++;
            clinicPricesModels.Add(new ClinicPricesModel()
            {
                Id = clinicPriceId,
                Category = EnumClinicPrices.DoctorsPatientDoctorsOperation_ClinicPercent,
                Price = 0
            });
            clinicPriceId++;
            clinicPricesModels.Add(new ClinicPricesModel()
            {
                Id = clinicPriceId,
                Category = EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_ClinicPercent,
                Price = 0
            });
            clinicPriceId++;
            clinicPricesModels.Add(new ClinicPricesModel()
            {
                Id = clinicPriceId,
                Category = EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_DoctorPercent,
                Price = 0
            });
            clinicPriceId++;
            clinicPricesModels.Add(new ClinicPricesModel()
            {
                Id = clinicPriceId,
                Category = EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_OperatorPercent,
                Price = 0
            });
            modelBuilder.Entity<ClinicPricesModel>().HasData(clinicPricesModels);




            List<Lab_DefaultStep> Lab_DefaultSteps = new List<Lab_DefaultStep> {

                new Lab_DefaultStep{
                    Id = 1,
                    Name = "Scan",
                },
                new Lab_DefaultStep{
                    Id = 2,
                    Name = "Physical",
                },
                new Lab_DefaultStep{
                    Id = 3,
                    Name = "Cast",
                },
                new Lab_DefaultStep{
                    Id = 4,
                    Name = "Remake",
                },
                new Lab_DefaultStep{
                    Id = 5,
                    Name = "Design",
                },
                new Lab_DefaultStep{
                    Id = 6,
                    Name = "3d Scanning",
                },
                new Lab_DefaultStep{
                    Id = 7,
                    Name = "Finishing",
                },
                new Lab_DefaultStep{
                    Id = 8,
                    Name = "Ready to try in",
                },
                new Lab_DefaultStep{
                    Id = 9,
                    Name = "Done",
                },
                new Lab_DefaultStep{
                    Id = 10,
                    Name = "Waiting customer action",
                },
                new Lab_DefaultStep{
                    Id = 11,
                    Name = "Waiting lab approval",
                },

            };
            modelBuilder.Entity<Lab_DefaultStep>().HasData(Lab_DefaultSteps);

            modelBuilder.Entity<ClinicDoctorClinicPercentageModel>()
                .HasOne<ApplicationUser>(x => x.Doctor)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);


            modelBuilder.Entity<Restoration>()

                .HasOne<ApplicationUser>(x => x.Assistant)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Restoration>()
                .HasOne<ApplicationUser>(x => x.Doctor)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<ClinicImplant>()

                .HasOne<ApplicationUser>(x => x.Assistant)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<ClinicImplant>()
                .HasOne<ApplicationUser>(x => x.Doctor)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<OrthoTreatment>()

                .HasOne<ApplicationUser>(x => x.Assistant)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<OrthoTreatment>()
                .HasOne<ApplicationUser>(x => x.Doctor)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);
            modelBuilder.Entity<TMD>()

                .HasOne<ApplicationUser>(x => x.Assistant)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<TMD>()
                .HasOne<ApplicationUser>(x => x.Doctor)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);
            modelBuilder.Entity<Pedo>()

                .HasOne<ApplicationUser>(x => x.Assistant)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Pedo>()
                .HasOne<ApplicationUser>(x => x.Doctor)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);
            modelBuilder.Entity<RootCanalTreatment>()
                .HasOne<ApplicationUser>(x => x.Assistant)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<RootCanalTreatment>()
                .HasOne<ApplicationUser>(x => x.Doctor)
                .WithMany().HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);
            modelBuilder.Entity<Scaling>()
                .HasOne<ApplicationUser>(x => x.Assistant)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Scaling>()
                .HasOne<ApplicationUser>(x => x.Doctor)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);


            modelBuilder.Entity<Lab_Request>()
                .HasOne<ApplicationUser>(x => x.Customer)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Lab_Request>()
                .HasOne<ApplicationUser>(x => x.EntryBy)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Lab_Request>()
                .HasOne<ApplicationUser>(x => x.AssignedTo)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<ComplicationsAfterSurgeryModel>()
                .HasOne<ApplicationUser>(x => x.Operator)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);


            modelBuilder.Entity<ComplicationsAfterProsthesisModel>()
                .HasOne<ApplicationUser>(x => x.Operator)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<TodoList>()
                .HasOne<ApplicationUser>(x => x.Operator)
                .WithMany()
                .HasPrincipalKey(x => x.IdInt)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<TreatmentDetailsModel>()
              .HasOne<ApplicationUser>(x => x.AssignedTo)
              .WithMany()
              .HasPrincipalKey(x => x.IdInt)
              .OnDelete(DeleteBehavior.Cascade);

             modelBuilder.Entity<TreatmentDetailsModel>()
              .HasOne<ApplicationUser>(x => x.DoneByAssistant)
              .WithMany()
              .HasPrincipalKey(x => x.IdInt)
              .OnDelete(DeleteBehavior.Cascade);
            
            modelBuilder.Entity<TreatmentDetailsModel>()
              .HasOne<ApplicationUser>(x => x.DoneBySupervisor)
              .WithMany()
              .HasPrincipalKey(x => x.IdInt)
              .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<TreatmentDetailsModel>()
              .HasOne<ApplicationUser>(x => x.DoneByCandidate)
              .WithMany()
              .HasPrincipalKey(x => x.IdInt)
              .OnDelete(DeleteBehavior.Cascade);






            modelBuilder.Entity<LabItem_WaxUp>().HasData(new LabItem_WaxUp
            {
                Id = 10,
                Name = "Wax Up",
            });
            modelBuilder.Entity<LabItem_ZirconUnit>().HasData(new LabItem_ZirconUnit
            {
                Id = 1,
                Name = "Zircon Unit",
            });

            modelBuilder.Entity<LabItem_PFM>().HasData(new LabItem_PFM
            {
                Id = 2,
                Name = "PFM",
            });

            modelBuilder.Entity<LabItem_CompositeInlay>().HasData(new LabItem_CompositeInlay
            {
                Id = 3,
                Name = "Composite Inlay",
            });

            modelBuilder.Entity<LabItem_EmaxVeneer>().HasData(new LabItem_EmaxVeneer
            {
                Id = 4,
                Name = "Emax Veneer",
            });

            modelBuilder.Entity<LabItem_MilledPMMA>().HasData(new LabItem_MilledPMMA
            {
                Id = 5,
                Name = "Milled PMMA",
            });

            modelBuilder.Entity<LabItem_PrintedPMMA>().HasData(new LabItem_PrintedPMMA
            {
                Id = 6,
                Name = "Printed PMMA",
            });

            modelBuilder.Entity<LabItem_TiAbutment>().HasData(new LabItem_TiAbutment
            {
                Id = 7,
                Name = "Ti Abutment",
            });

            modelBuilder.Entity<LabItem_TiBar>().HasData(new LabItem_TiBar
            {
                Id = 8,
                Name = "Ti Bar",
            });

            modelBuilder.Entity<LabItem_ThreeDPrinting>().HasData(new LabItem_ThreeDPrinting
            {
                Id = 9,
                Name = "3D Printing",
            });


            base.OnModelCreating(modelBuilder);
        }
    }
}
