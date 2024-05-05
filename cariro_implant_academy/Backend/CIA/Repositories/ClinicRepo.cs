using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA.DTOs;
using CIA.Models.CIA;
using CIA.Models.CIA.TreatmentModels;
using CIA.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using AutoMapper;
using Microsoft.IdentityModel.Tokens;

namespace CIA.Repositories
{
    public class ClinicRepo : IClinicRepos
    {
        private readonly CIA_dbContext _ciaDbContext;
        private readonly IMapper _mapper;
        public ClinicRepo(CIA_dbContext cIA_DbContext, IMapper mapper)
        {
            this._ciaDbContext = cIA_DbContext;
            _mapper = mapper;
        }
        public async Task UpdateDoctorFeesWithPatientId(int patientId)
        {

            List<ClinicTreatmentParent> clinicTreatment = await _ciaDbContext.ClinicTreatmentParents

              .Where(x =>
                        x.PatientId == patientId
                        && x.Done == true

                    )

              .ToListAsync();


            var patient = await _ciaDbContext.Patients.FirstAsync(x => x.Id == patientId);
            var prices = await _ciaDbContext.ClinicPrices.Where(x =>

                x.Category == EnumClinicPrices.DoctorsPatientDoctorsOperation_DoctorPercent ||
                 x.Category == EnumClinicPrices.DoctorsPatientDoctorsOperation_ClinicPercent ||
                 x.Category == EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_DoctorPercent ||
                 x.Category == EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_OperatorPercent ||
                 x.Category == EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_ClinicPercent
            ).ToListAsync();


            var doctorsPercentages = await _ciaDbContext.ClinicDoctorClinicPercentageModels.Where(x => x.PatientId == patientId).ToListAsync();

            _ciaDbContext.ClinicDoctorClinicPercentageModels.RemoveRange(doctorsPercentages);
            _ciaDbContext.SaveChanges();

            foreach (var treatment in clinicTreatment)
            {
                if (patient.DoctorID != treatment.DoctorId)
                {


                    _ciaDbContext.ClinicDoctorClinicPercentageModels.Add(
                                           new ClinicDoctorClinicPercentageModel()
                                           {
                                               ClinicTreatmentId = treatment.Id,
                                               DateTime = (DateTime)treatment.Date,
                                               DoctorId = treatment.DoctorId,
                                               OperationFee = (int)treatment.Price,
                                               RestorationId = treatment.GetType() == typeof(Restoration) ? treatment.Id : null,
                                               TMDId = treatment.GetType() == typeof(TMD) ? treatment.Id : null,
                                               ScalingId = treatment.GetType() == typeof(Scaling) ? treatment.Id : null,
                                               RootCanalTreatmentId = treatment.GetType() == typeof(RootCanalTreatment) ? treatment.Id : null,
                                               ClinicImplantId = treatment.GetType() == typeof(ClinicImplant) ? treatment.Id : null,
                                               OrthoTreatmentId = treatment.GetType() == typeof(OrthoTreatment) ? treatment.Id : null,
                                               PedoId = treatment.GetType() == typeof(Pedo) ? treatment.Id : null,
                                               PatientId = patientId,
                                               DoctorFeesType = EnumDortorsPercentageEnum.Operator,
                                               DoctorsFees = ((int)treatment.Price) * prices.First(x => x.Category == EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_OperatorPercent).Price / 100,
                                               ClinicFee = ((int)treatment.Price) * prices.First(x => x.Category == EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_ClinicPercent).Price / 100,

                                           }
                                           );
                    _ciaDbContext.ClinicDoctorClinicPercentageModels.Add(
                        new ClinicDoctorClinicPercentageModel()
                        {
                            ClinicTreatmentId = treatment.Id,
                            DateTime = (DateTime)treatment.Date,
                            DoctorId = patient.DoctorID,
                            OperationFee = (int)treatment.Price,
                            RestorationId = treatment.GetType() == typeof(Restoration) ? treatment.Id : null,
                            TMDId = treatment.GetType() == typeof(TMD) ? treatment.Id : null,
                            ScalingId = treatment.GetType() == typeof(Scaling) ? treatment.Id : null,
                            RootCanalTreatmentId = treatment.GetType() == typeof(RootCanalTreatment) ? treatment.Id : null,
                            ClinicImplantId = treatment.GetType() == typeof(ClinicImplant) ? treatment.Id : null,
                            OrthoTreatmentId = treatment.GetType() == typeof(OrthoTreatment) ? treatment.Id : null,
                            PedoId = treatment.GetType() == typeof(Pedo) ? treatment.Id : null,
                            PatientId = patientId,
                            DoctorsFees = ((int)treatment.Price) * prices.First(x => x.Category == EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_DoctorPercent).Price / 100,
                            DoctorFeesType = EnumDortorsPercentageEnum.Main,
                            ClinicFee = ((int)treatment.Price) * prices.First(x => x.Category == EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_ClinicPercent).Price / 100,

                        }
                        );



                }
                else
                {

                    _ciaDbContext.ClinicDoctorClinicPercentageModels.Add(
                       new ClinicDoctorClinicPercentageModel()
                       {
                           ClinicTreatmentId = treatment.Id,
                           DateTime = (DateTime)treatment.Date,
                           DoctorId = treatment.DoctorId,
                           OperationFee = (int)treatment.Price,
                           RestorationId = treatment.GetType() == typeof(Restoration) ? treatment.Id : null,
                           TMDId = treatment.GetType() == typeof(TMD) ? treatment.Id : null,
                           ScalingId = treatment.GetType() == typeof(Scaling) ? treatment.Id : null,
                           RootCanalTreatmentId = treatment.GetType() == typeof(RootCanalTreatment) ? treatment.Id : null,
                           ClinicImplantId = treatment.GetType() == typeof(ClinicImplant) ? treatment.Id : null,
                           OrthoTreatmentId = treatment.GetType() == typeof(OrthoTreatment) ? treatment.Id : null,
                           PedoId = treatment.GetType() == typeof(Pedo) ? treatment.Id : null,
                           PatientId = patientId,
                           DoctorFeesType = EnumDortorsPercentageEnum.OperatorAndMain,
                           DoctorsFees = ((int)treatment.Price) * prices.First(x => x.Category == EnumClinicPrices.DoctorsPatientDoctorsOperation_DoctorPercent).Price / 100,
                           ClinicFee = ((int)treatment.Price) * prices.First(x => x.Category == EnumClinicPrices.DoctorsPatientDoctorsOperation_ClinicPercent).Price / 100,

                       }
                       );

                }
            }

            _ciaDbContext.SaveChanges();





        }

        public async Task UpdateReceipt(int patientId)
        {
            var receipt = await _ciaDbContext.ClinicReceipts.Include(x => x.Prices).FirstOrDefaultAsync(x => x.PatientId == patientId);
            var treatments = await _ciaDbContext
                .ClinicTreatmentParents
                .Where(x => x.PatientId == patientId && x.Done == true)
                .ToListAsync();

            if (receipt == null)
            {
                receipt = new ClinicReceiptModel
                {
                    Date = DateTime.UtcNow,
                    IsPaid = false,
                    PatientId = patientId,
                    Website = EnumWebsite.Clinic


                };
                _ciaDbContext.ClinicReceipts.Add(receipt);


            }


            var firstNotSecond = treatments.Except(receipt.Prices).ToList();
            var secondNotFirst = receipt.Prices.Except(treatments).ToList();
            if (!(firstNotSecond.IsNullOrEmpty() && secondNotFirst.IsNullOrEmpty()))
            {
                receipt.Date= DateTime.UtcNow;
            }
            foreach (var p in receipt.Prices)
            {
                p.ClinicReceiptModelId = null;
                
            }
            _ciaDbContext.ClinicTreatmentParents.UpdateRange(receipt.Prices);
            _ciaDbContext.SaveChanges();


            receipt.Prices = treatments;
            receipt.Total = 0;
            foreach (var p in receipt.Prices)
            {
                receipt.Total += p.Price ?? 0;
            }
            receipt.Unpaid = receipt.Total - receipt.Paid;
            _ciaDbContext.ClinicReceipts.Update(receipt);
            _ciaDbContext.SaveChanges();
        }

        public async Task UpdateTreatmentPrice(int patientId)
        {
            var clinicTreatment = new ClinicTreatment()
            {
                PatientId = patientId,
                ClinicImplants = await _ciaDbContext.ClinicImplants.Where(x => x.PatientId == patientId).ToListAsync(),
                OrthoTreatments = await _ciaDbContext.OrthoTreatments.Where(x => x.PatientId == patientId).ToListAsync(),
                Pedos = await _ciaDbContext.Pedos.Where(x => x.PatientId == patientId).ToListAsync(),
                RootCanalTreatments = await _ciaDbContext.RootCanalTreatments.Where(x => x.PatientId == patientId).ToListAsync(),
                TMDs = await _ciaDbContext.TMDs.Where(x => x.PatientId == patientId).ToListAsync(),
                Restorations = await _ciaDbContext.Restorations.Where(x => x.PatientId == patientId).ToListAsync(),
                Scalings = await _ciaDbContext.Scalings.Where(x => x.PatientId == patientId).ToListAsync(),
            };

            List<ClinicTreatmentParent> treatments = new List<ClinicTreatmentParent>();
            treatments.AddRange(clinicTreatment.Restorations);
            treatments.AddRange(clinicTreatment.TMDs);
            treatments.AddRange(clinicTreatment.Scalings);
            treatments.AddRange(clinicTreatment.RootCanalTreatments);
            treatments.AddRange(clinicTreatment.ClinicImplants);
            treatments.AddRange(clinicTreatment.OrthoTreatments);
            treatments.AddRange(clinicTreatment.Pedos);

            var teeth = treatments.Select(x => x.Tooth).Distinct().ToList();

            var prices = await _ciaDbContext.ClinicPrices.Where(x => teeth.Contains((int)x.Tooth)).ToListAsync();
            var restorationPrices = prices.Where(x =>

          x.Category == EnumClinicPrices.RestorationStatusDone ||
         x.Category == EnumClinicPrices.RestorationStatusTemp ||
         x.Category == EnumClinicPrices.RestorationTypeComposite ||
         x.Category == EnumClinicPrices.RestorationTypeReinforcedGlassIonomer ||
         x.Category == EnumClinicPrices.RestorationTypeTemp ||
         x.Category == EnumClinicPrices.RestorationTypeIndirectRestoration ||
         x.Category == EnumClinicPrices.RestorationClassI ||
         x.Category == EnumClinicPrices.RestorationClassII ||
         x.Category == EnumClinicPrices.RestorationClassIII ||
         x.Category == EnumClinicPrices.RestorationClassIV ||
         x.Category == EnumClinicPrices.RestorationClassV ||
         x.Category == EnumClinicPrices.RestorationClassVI
            ).ToList();
            var pedoPrices = prices.Where(x =>

              x.Category == EnumClinicPrices.PedoPulpotomy ||
          x.Category == EnumClinicPrices.PedoPulpectomy ||
          x.Category == EnumClinicPrices.PedoCastStanlessSteelZirconia ||
          x.Category == EnumClinicPrices.PedoFinalRestoration ||
          x.Category == EnumClinicPrices.PedoTempFilling
            ).ToList();
            var tmdPrices = prices.Where(x => x.Category == EnumClinicPrices.TMDTypeDiagnosis ||
          x.Category == EnumClinicPrices.TMDTypeInjection ||
          x.Category == EnumClinicPrices.TMDTypeSRS ||
          x.Category == EnumClinicPrices.TMDTypeNightGuardHard ||
          x.Category == EnumClinicPrices.TMDTypeNightGuardSoft).ToList();
            var implantPrices = prices.Where(x => x.Category == EnumClinicPrices.ImplantTypeSimple ||
          x.Category == EnumClinicPrices.ImplantTypeImmediate ||
          x.Category == EnumClinicPrices.ImplantTypeGuided ||
          x.Category == EnumClinicPrices.ImplantTypeExpansion ||
          x.Category == EnumClinicPrices.ImplantTypeSplitting ||
          x.Category == EnumClinicPrices.ImplantTypeGBR ||
          x.Category == EnumClinicPrices.ImplantTypeOpenSinus ||
          x.Category == EnumClinicPrices.ImplantTypeClosedSinus).ToList();
            var rootPrices = prices.Where(x => x.Category == EnumClinicPrices.RootCanalTreatmentTypeSingleCanal ||
          x.Category == EnumClinicPrices.RootCanalTreatmentTypeB ||
          x.Category == EnumClinicPrices.RootCanalTreatmentTypeL ||
          x.Category == EnumClinicPrices.RootCanalTreatmentTypeMB ||
          x.Category == EnumClinicPrices.RootCanalTreatmentTypeDB ||
          x.Category == EnumClinicPrices.RootCanalTreatmentTypeDL ||
          x.Category == EnumClinicPrices.RootCanalTreatmentTypeMB2 ||
          x.Category == EnumClinicPrices.RootCanalTreatmentTypeP ||
         x.Category == EnumClinicPrices.RootCanalTreatmentTypeOther).ToList();
            var scalingPrices = prices.Where(x =>
            x.Category == EnumClinicPrices.ScalingDeep ||
          x.Category == EnumClinicPrices.ScalingRegular).ToList();
            var orthoPrices = prices.Where(x => x.Category == EnumClinicPrices.Ortho).ToList();

            foreach (var treatment in treatments)
            {
                if (treatment is Restoration)
                {
                    ((Restoration)treatment).TypePrice = ((Restoration)treatment).TypePrice ?? restorationPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"RestorationType{Enum.GetName(((Restoration)treatment).Type)}")?.Price;
                    ((Restoration)treatment).StatusPrice = ((Restoration)treatment).StatusPrice ?? restorationPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"RestorationStatus{Enum.GetName(((Restoration)treatment).Status)}")?.Price;
                    ((Restoration)treatment).ClassPrice = ((Restoration)treatment).ClassPrice ?? restorationPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"Restoration{Enum.GetName(((Restoration)treatment).Class)}")?.Price;
                    ((Restoration)treatment).Price = ((Restoration)treatment).TypePrice + ((Restoration)treatment).StatusPrice + ((Restoration)treatment).ClassPrice;
                }
                else if (treatment is TMD)
                {
                    ((TMD)treatment).Price = ((TMD)treatment).Price ?? tmdPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"TMDType{Enum.GetName(((TMD)treatment).Type)}")?.Price;
                }
                else if (treatment is OrthoTreatment)
                {
                    ((OrthoTreatment)treatment).Price = ((OrthoTreatment)treatment).Price ?? orthoPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && x.Category == EnumClinicPrices.Ortho)?.Price;
                }
                else if (treatment is Scaling)
                {
                    ((Scaling)treatment).Price = ((Scaling)treatment).Price ?? scalingPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"Scaling{Enum.GetName(((Scaling)treatment).Type)}")?.Price;
                }
                else if (treatment is RootCanalTreatment)
                {
                    ((RootCanalTreatment)treatment).Price = ((RootCanalTreatment)treatment).Price ?? rootPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"RootCanalTreatmentType{Enum.GetName(((RootCanalTreatment)treatment).Type)}")?.Price;
                }
                else if (treatment is ClinicImplant)
                {
                    ((ClinicImplant)treatment).Price = ((ClinicImplant)treatment).Price ?? implantPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"ImplantType{Enum.GetName(((ClinicImplant)treatment).Type)}")?.Price;
                }
                else if (treatment is Pedo)
                {
                    ((Pedo)treatment).FirstStepPrice = ((Pedo)treatment).FirstStepPrice ?? pedoPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"Pedo{Enum.GetName(((Pedo)treatment).FirstStep)}")?.Price;
                    ((Pedo)treatment).SecondStepPrice = ((Pedo)treatment).SecondStepPrice ?? pedoPrices.FirstOrDefault(x => x.Tooth == treatment.Tooth && Enum.GetName(x.Category) == $"Pedo{Enum.GetName(((Pedo)treatment).SecondStep)}")?.Price;
                    ((Pedo)treatment).Price = ((Pedo)treatment).FirstStepPrice + ((Pedo)treatment).SecondStepPrice;
                }
            }
            _ciaDbContext.SaveChanges();
        }
    }
}
