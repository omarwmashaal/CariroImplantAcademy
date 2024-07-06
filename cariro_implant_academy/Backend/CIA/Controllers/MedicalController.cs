using AutoMapper;
using CIA.DataBases;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using static CIA.Models.CIA.TreatmentModels.DentalExaminationModel;
using System.Collections.Generic;
using System.Xml.Linq;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.CIA;
using CIA.Models.TreatmentModels;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;
using CIA.Models;
using System.Reflection;
using CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels;
using System.Collections;
using CIA.Models.CIA.DTOs;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Routing.Matching;
using System.Linq;
using System;
using CIA.Migrations;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MedicalController : BaseController
    {
        private readonly API_response _aPI_Response;
        private readonly CIA_dbContext _cia_DbContext;
        private readonly IMedical_Repo _iMedicalRepo;
        private readonly IMapper _mapper;
        private readonly IUserRepo _iUserRepo;
        private readonly INotificationRepo _notificationRepo;
        private readonly EnumWebsite _site;
        public MedicalController(IHttpContextAccessor httpContextAccessor, CIA_dbContext cIA_DbContext, IMapper mapper, IMedical_Repo medical_Repo, IUserRepo iUserRepo, INotificationRepo notificationRepo)
        {
            _aPI_Response = new API_response();
            _cia_DbContext = cIA_DbContext;
            _mapper = mapper;
            _iMedicalRepo = medical_Repo;
            _iUserRepo = iUserRepo;
            _notificationRepo = notificationRepo;
            var site = httpContextAccessor.HttpContext.Request.Headers["Site"].ToString();
            if (site == "")
                _site = EnumWebsite.CIA;
            else
                _site = (EnumWebsite)int.Parse(site);
        }

        [HttpGet("GetPatientMedicalExamination")]
        public async Task<ActionResult> GetPatientMedicalExamination(int id)
        {
            //var medicalExamination = await _mapper.ProjectTo<MedicalHistoryDTO>(_cia_DbContext.MedicalExaminations.AsNoTracking(), null).FirstOrDefaultAsync(x => x.PatientId == id);
            var medicalExaminationFromDB = await _cia_DbContext.MedicalExaminations.AsNoTracking().FirstOrDefaultAsync(x => x.PatientId == id);
            MedicalHistoryDTO medicalExamination = new MedicalHistoryDTO();
            if (medicalExaminationFromDB != null)
            {
                medicalExaminationFromDB.Operator = await _cia_DbContext.Users.FirstOrDefaultAsync(x => x.IdInt == medicalExaminationFromDB.OperatorId);
                medicalExamination = _mapper.Map<MedicalHistoryDTO>(medicalExaminationFromDB);
            }
            _aPI_Response.Result = medicalExamination;
            return Ok(_aPI_Response);
        }
        [HttpGet("GetPatientDentalExamination")]
        public async Task<ActionResult> GetPatientDentalExamination(int id)
        {
            var patient = await _cia_DbContext.Patients.Include(x => x.DentalExamination).FirstOrDefaultAsync(x => x.Id == id);
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Couldn't find patient!";
                return BadRequest(_aPI_Response);
            }

            var d = await _cia_DbContext.DentalExaminations.Include(x => x.Operator).FirstOrDefaultAsync(x => x.Id == patient.DentalExamination.Id);

            _aPI_Response.Result = d ?? new DentalExaminationModel();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetPatientDentalHistory")]
        public async Task<ActionResult> GetPatientDentalHistory(int id)
        {
            var patient = await _cia_DbContext.Patients.Include(x => x.DentalHistory).Include(x => x.DentalHistory.Operator).FirstOrDefaultAsync(x => x.Id == id);
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Couldn't find patient!";
                return BadRequest(_aPI_Response);
            }
            _aPI_Response.Result = patient.DentalHistory ?? new DentalHistoryModel();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetPatientNonSurgicalTreatment")]
        public async Task<ActionResult> GetPatientNonSurgicalTreatment(int id)
        {
            var user = await _iUserRepo.GetUser();
            var nonSurgical = await _cia_DbContext.NonSurgicalTreatment

                .Include(x => x.Operator)
                .Include(x => x.Supervisor)
                .FirstOrDefaultAsync(
                    x => x.PatientId == id && x.OperatorID == user.IdInt && x.Date.Value.Date == DateTime.UtcNow.Date
                    );


            if (nonSurgical != null && nonSurgical.Treatment != null)
            {
                nonSurgical.Treatment = nonSurgical.Treatment.Replace("\n\n", "\n");
            }
            _aPI_Response.Result = nonSurgical;






            return Ok(_aPI_Response);
        }
        [HttpGet("GetPatientAllNonSurgicalTreatments")]
        public async Task<ActionResult> GetPatientAllNonSurgicalTreatments(int id)
        {
            var patient = await _cia_DbContext.Patients.Include(x => x.NonSurgicalTreatment).ThenInclude(x => x.Operator).Include(x => x.NonSurgicalTreatment).ThenInclude(x => x.Supervisor).FirstOrDefaultAsync(x => x.Id == id);
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Couldn't find patient!";
                return BadRequest(_aPI_Response);
            }
            List<int> ids = new List<int>();
            foreach (var s in patient.NonSurgicalTreatment)
            {
                if (s.Id != null)
                    ids.Add((int)s.Id);
            }

            _aPI_Response.Result = patient.NonSurgicalTreatment.OrderByDescending(x => x.Date);
            return Ok(_aPI_Response);
        }
        [HttpGet("GetPatientTreatmentDetails")]
        public async Task<ActionResult> GetPatientTreatmentDetails(int id)
        {

            var treatmentDetails = await _cia_DbContext.TreatmentDetails.
                Where(x => x.PatientId == id).
                Include(x => x.RequestChangeModel).
                Include(x => x.AssignedTo).
                Include(x => x.DoneByAssistant).
                Include(x => x.DoneBySupervisor).
                Include(x => x.DoneByCandidate).
                Include(x => x.DoneByCandidateBatch).
                Include(x => x.Implant).
                Include(x => x.ImplantRequest).
                Include(x => x.TreatmentItem).
                ToListAsync();




            var donePlansWithouPostSurgery = treatmentDetails.Where(x => x.Status == true && x.PostSurgeryModelId == null).ToList();

            if (!donePlansWithouPostSurgery.IsNullOrEmpty())
            {
                foreach (var done in donePlansWithouPostSurgery)
                {
                    var postSurgery = new PostSurgeryModel
                    {
                        PatientId = id,
                        TreatmentDetailsModelId = done.Id,
                    };
                    _cia_DbContext.PostSurgeries.Add(postSurgery);
                    _cia_DbContext.SaveChanges();
                    done.PostSurgeryModelId = postSurgery.Id;


                }
                _cia_DbContext.TreatmentDetails.UpdateRange(donePlansWithouPostSurgery);
                _cia_DbContext.SaveChanges();
            }

            _aPI_Response.Result = treatmentDetails;

            return Ok(_aPI_Response);
        }

        [HttpGet("GetPatientTreatmentPlan")]
        public async Task<ActionResult> GetPatientTreatmentPlan(int id)
        {

            var treatmentPlan = await _cia_DbContext.TreatmentPlans.FirstOrDefaultAsync(x => x.PatientId == id);
            if (treatmentPlan == null)
            {
                treatmentPlan = new TreatmentPlanModel()
                {
                    PatientId = id,

                };
                _cia_DbContext.TreatmentPlans.Add(treatmentPlan);
                await _cia_DbContext.SaveChangesAsync();
            }

            var patient = await _cia_DbContext.Patients.Where(x => x.Id == id).Select(x => new
            {
                x.DoctorID,
                x.Doctor.Name
            }).FirstOrDefaultAsync();

            _aPI_Response.Result = _mapper.Map<TreatmentPlansModelDTO>(treatmentPlan);
            ((TreatmentPlansModelDTO)(_aPI_Response.Result)).Doctor = new DropDowns
            {
                Name = patient.Name,
                Id = patient.DoctorID,
            };


            return Ok(_aPI_Response);
        }
        [HttpGet("GetPatientPostSurgery")]
        public async Task<ActionResult> GetPatientPostSurgery(int id)
        {


            _aPI_Response.Result = _cia_DbContext.PostSurgeries
                .Include(x => x.OpenSinusLift_TacsCompany)
                .Include(x => x.OpenSinusLift_Membrane_Company)
                .Include(x => x.OpenSinusLift_Membrane)

                .FirstOrDefault(x => x.Id == id);
            return Ok(_aPI_Response);
        }


        [HttpGet("GetPatientProstheticTreatmentDiagnostic")]
        public async Task<ActionResult> GetPatientProstheticTreatmentDiagnostic(int id)
        {

            _aPI_Response.Result = await _cia_DbContext.DiagnosticSteps
               .Where(x => x.PatientId == id)
               .OrderBy(x => x.Date)
               .Include(x => x.DiagnosticItem)
               .Include(x => x.DiagnosticStatusItem)
               .Include(x => x.DiagnosticNextVisitItem)
               .Include(x => x.Operator)
               .ToListAsync();
            return Ok(_aPI_Response);
        }


        [HttpGet("GetPatientProstheticTreatmentFinalProthesis")]
        public async Task<ActionResult> GetPatientProstheticTreatmentFinalProthesisSingleBridge(int id, bool single)
        {
            if (single)
                _aPI_Response.Result = await _cia_DbContext.FinalSteps
                    .Where(x =>
                    (x.FullArchUpper != true && x.FullArchLower != true) &&
                    x.PatientId == id)
                    .OrderBy(x => x.Date)
                    .Include(x => x.FinalItem)
                    .Include(x => x.FinalStatusItem)
                    .Include(x => x.FinalNextVisitItem)
                    .Include(x => x.Operator)
                    .ToListAsync();
            else
                _aPI_Response.Result = await _cia_DbContext.FinalSteps
                    .Where(x =>
                    (x.FullArchUpper == true || x.FullArchLower == true) &&
                    x.PatientId == id)
                    .OrderBy(x => x.Date)
                    .Include(x => x.FinalItem)
                    .Include(x => x.FinalStatusItem)
                    .Include(x => x.FinalNextVisitItem)
                    .Include(x => x.Operator)
                    .ToListAsync();
            return Ok(_aPI_Response);

        }



        [HttpGet("GetComplicationsAfterSurgery")]
        public async Task<ActionResult> GetComplicationsAfterSurgery(int id)
        {

            _aPI_Response.Result = await _cia_DbContext.ComplicationsAfterSurgery.Include(x => x.DefaultSurgicalComplication).Include(x => x.Operator).Where(x => x.PatientId == id).ToListAsync();

            return Ok(_aPI_Response);
        }
        [HttpGet("GetSurgeryTeethForComplications")]
        public async Task<ActionResult> GetSurgeryTeethForComplications(int id)
        {

            _aPI_Response.Result = await _cia_DbContext.TreatmentDetails.Where(x =>
            x.PatientId == id &&
            x.Status == true
            ).Select(x => x.Tooth).ToListAsync();

            return Ok(_aPI_Response);
        }

        [HttpGet("GetComplicationsAfterProsthesis")]
        public async Task<ActionResult> GetComplicationsAfterProsthesis(int id)
        {
            _aPI_Response.Result = await _cia_DbContext.ComplicationsAfterProsthesis.Include(x => x.DefaultProstheticComplication).Include(x => x.Operator).Where(x => x.PatientId == id).ToListAsync();


            return Ok(_aPI_Response);
        }




        [HttpPut("UpdatePatientMedicalExamination")]
        public async Task<ActionResult> UpdatePatientMedicalExamination([FromQuery] int id, [FromBody] MedicalExaminationModel model)
        {

            var patient = await _cia_DbContext.Patients.Include(x => x.MedicalExamination).ThenInclude(x => x.Operator).FirstOrDefaultAsync(x => x.Id == id);
            var user = await _iUserRepo.GetUser();
            var todoList = await _cia_DbContext.ToDoLists.FirstOrDefaultAsync(x => x.PatientId == id && (x.Data ?? "").StartsWith("HBA1C is "));
            if (todoList != null)
            {
                todoList.DueDate = todoList.CreateDate.Value.AddMonths(3);
                _cia_DbContext.Update(todoList);
            }
            if (!patient.MedicalExamination.HBA1c.IsNullOrEmpty() && !model.HBA1c.IsNullOrEmpty() && patient.MedicalExamination.HBA1c.Last()?.Reading != model.HBA1c.Last()?.Reading)
            {
                if ((model.HBA1c.Last().Reading ?? 0) >= 7.5)
                {
                    if (todoList == null)
                    {
                        todoList = new TodoList
                        {
                            CreateDate = DateTime.UtcNow,
                            Data = $"HBA1C is {model.HBA1c.Last().Reading}",
                            Done = false,
                            DueDate = DateTime.UtcNow.AddMonths(3),
                            OperatorId = user.IdInt,
                            Operator = user,
                            PatientId = id,
                        };
                        _cia_DbContext.ToDoLists.Add(todoList);
                    }
                    else
                    {
                        todoList.CreateDate = DateTime.UtcNow;
                        todoList.Data = $"HBA1C is {model.HBA1c.Last().Reading}";
                        todoList.Done = false;
                        todoList.DueDate = DateTime.UtcNow.AddMonths(3);
                        todoList.OperatorId = user.IdInt;
                        todoList.Operator = user;
                        todoList.PatientId = id;
                        _cia_DbContext.ToDoLists.Update(todoList);
                    }

                }
                else
                {
                    if (todoList != null)
                    {
                        _cia_DbContext.ToDoLists.Remove(todoList);
                    }
                }
            }
            if (patient.MedicalExamination.Operator == null)
            {
                patient.MedicalExamination.Operator = user;
            }

            else
            {
                patient.MedicalExamination.Operator = patient.MedicalExamination.Operator;
            }
            patient.MedicalExamination.Date = model.Date ?? DateTime.UtcNow;
            patient.MedicalExamination.GeneralHealth = model.GeneralHealth;
            patient.MedicalExamination.PregnancyStatus = model.PregnancyStatus;
            patient.MedicalExamination.AreYouTreatedFromAnyThing = model.AreYouTreatedFromAnyThing;
            patient.MedicalExamination.RecentSurgery = model.RecentSurgery;
            patient.MedicalExamination.Comment = model.Comment;
            patient.MedicalExamination.Diseases = model.Diseases;
            patient.MedicalExamination.OtherDiseases = model.OtherDiseases;
            patient.MedicalExamination.BloodPressure = model.BloodPressure;
            patient.MedicalExamination.Diabetic = model.Diabetic;
            patient.MedicalExamination.HBA1c = model.HBA1c;
            patient.MedicalExamination.Penicillin = model.Penicillin;
            patient.MedicalExamination.Sulfa = model.Sulfa;
            patient.MedicalExamination.OtherAllergy = model.OtherAllergy;
            patient.MedicalExamination.OtherAllergyComment = model.OtherAllergyComment;
            patient.MedicalExamination.ProlongedBleedingOrAspirin = model.ProlongedBleedingOrAspirin;
            patient.MedicalExamination.ChronicDigestion = model.ChronicDigestion;
            patient.MedicalExamination.IllegalDrugs = model.IllegalDrugs;
            patient.MedicalExamination.OperatorComments = model.OperatorComments;
            patient.MedicalExamination.DrugsTaken = model.DrugsTaken;



            _cia_DbContext.Patients.Update(patient);
            await _cia_DbContext.SaveChangesAsync();


            return Ok(_aPI_Response);
        }


        [HttpPut("UpdatePatientDentalExamination")]
        public async Task<ActionResult> UpdatePatientDentalExamination([FromQuery] int id, [FromBody] DentalExaminationModel model)
        {
            var patient = await _cia_DbContext.Patients.Include(x => x.DentalExamination).ThenInclude(x => x.Operator).FirstOrDefaultAsync(x => x.Id == id);
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Couldn't find patient!";
                return BadRequest(_aPI_Response);
            }

            var user = await _iUserRepo.GetUser();
            if (patient.DentalExamination.Operator == null)
            {
                patient.DentalExamination.Operator = user;
            }
            else
            {
                patient.DentalExamination.Operator = patient.MedicalExamination.Operator;
            }


            patient.DentalExamination.DentalExaminations = model.DentalExaminations;
            patient.DentalExamination.Date = model.Date;
            patient.DentalExamination.OperatorImplantNotes = model.OperatorImplantNotes;
            patient.DentalExamination.Date = model.Date ?? DateTime.UtcNow;
            patient.DentalExamination.Operator = user;
            patient.DentalExamination.OralHygieneRating = model.OralHygieneRating;
            _cia_DbContext.Patients.Update(patient);
            await _cia_DbContext.SaveChangesAsync();

            var failedTeeth = patient.DentalExamination.DentalExaminations.Where(x => x.ImplantFailed == true).Select(x => x.Tooth).ToList();
            var treatmentDetails = await _cia_DbContext.TreatmentDetails.Where(x => x.PatientId == id).ToListAsync();
            foreach (var item in treatmentDetails)
            {
                if (failedTeeth.Contains(item.Tooth))
                {
                    item.FailedImplant = true;
                }
                else item.FailedImplant = false;
            }
            _cia_DbContext.TreatmentDetails.UpdateRange(treatmentDetails);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }


        [HttpPut("UpdatePatientDentalHistory")]
        public async Task<ActionResult> UpdatePatientDentalHistory([FromQuery] int id, [FromBody] DentalHistoryModel model)
        {
            var patient = await _cia_DbContext.Patients.Include(x => x.DentalHistory).ThenInclude(x => x.Operator).FirstOrDefaultAsync(x => x.Id == id);
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Couldn't find patient!";
                return BadRequest(_aPI_Response);
            }

            patient.DentalHistory.Date = model.Date ?? DateTime.UtcNow;
            var user = await _iUserRepo.GetUser();
            if (patient.DentalHistory.Operator == null)
            {
                patient.DentalHistory.Operator = user;
            }
            else
            {
                patient.DentalHistory.Operator = patient.DentalHistory.Operator;
            }


            patient.DentalHistory.SenstiveHotCold = model.SenstiveHotCold;
            patient.DentalHistory.SenstiveSweets = model.SenstiveSweets;
            patient.DentalHistory.BittingCheweing = model.BittingCheweing;
            patient.DentalHistory.Clench = model.Clench;
            patient.DentalHistory.Smoke = model.Smoke;
            patient.DentalHistory.SmokingStatus = model.SmokingStatus;
            patient.DentalHistory.SeriousInjury = model.SeriousInjury;
            patient.DentalHistory.Satisfied = model.Satisfied;
            patient.DentalHistory.CooperationScore = model.CooperationScore;
            patient.DentalHistory.WillingForImplantScore = model.WillingForImplantScore;
            patient.DentalHistory.CBCT = model.CBCT;



            _cia_DbContext.Patients.Update(patient);
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }

        [HttpPut("AddPatientNonSurgicalTreatment")]
        public async Task<ActionResult> UpdatePatientNonSurgicalTreatment([FromQuery] int id, [FromBody] NonSurgicalTreatmentModel model, bool delete = false)
        {
            if (delete == true)
            {
                var treatment_ = await _cia_DbContext.NonSurgicalTreatment.FirstAsync(x => x.Id == model.Id);

                _cia_DbContext.NonSurgicalTreatment.Remove(treatment_);
                _cia_DbContext.SaveChanges();
                return Ok();

            }
            var user = await _iUserRepo.GetUser();
            var patient = await _cia_DbContext.Patients.Include(x => x.NonSurgicalTreatment).ThenInclude(x => x.Operator).FirstOrDefaultAsync(x => x.Id == id);
            var visitLog = await _cia_DbContext.
                VisitsLogs.
                Where(x => x.PatientID == id).
                Include(x => x.Doctor).
                OrderByDescending(x => x.RealVisitTime).
                FirstOrDefaultAsync(x => x.EntersClinicTime.Value.Date == DateTime.UtcNow.Date);
            if (visitLog != null)
            {
                visitLog.Doctor = user;
                visitLog.Treatment = model.Treatment;
                _cia_DbContext.VisitsLogs.Update(visitLog);
            }
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Couldn't find patient!";
                return BadRequest(_aPI_Response);
            }
            model.Date = model.Date ?? DateTime.UtcNow;
            if (model.NextVisit != null)
                model.NextVisit = model.NextVisit.Value.ToUniversalTime();


            model.OperatorID = model.OperatorID ?? user.IdInt;
            model.Operator = await _cia_DbContext.Users.FirstAsync(x => x.IdInt == model.OperatorID);


            if (patient.NonSurgicalTreatment == null)
                patient.NonSurgicalTreatment = new List<NonSurgicalTreatmentModel>();

            model.Supervisor = _cia_DbContext.Users.FirstOrDefault(x => x.IdInt == model.SupervisorID);
            NonSurgicalTreatmentModel treatment;
            if (model.Id != null)
                treatment = _cia_DbContext.NonSurgicalTreatment.FirstOrDefault(x => x.Id == model.Id);
            else
                treatment = _cia_DbContext.NonSurgicalTreatment.FirstOrDefault(x => x.Date.Value.Date == DateTime.UtcNow.Date && x.Operator == user && x.PatientId == id);

            if (treatment != null)
            {

                treatment.Date = model.Date;
                treatment.Treatment = model.Treatment ?? "";
                treatment.NextVisit = model.NextVisit;
                treatment.Supervisor = model.Supervisor;
                treatment.Operator = model.Operator;
                _cia_DbContext.NonSurgicalTreatment.Update(treatment);

            }
            else
            {
                patient.NonSurgicalTreatment.Add(model);
                _cia_DbContext.Patients.Update(patient);

            }



            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }

        [HttpPut("UpdatePatientNonSurgicalTreatmentNotes")]
        public async Task<ActionResult> UpdatePatientNonSurgicalTreatmentNotes([FromQuery] int id, String notes)
        {
            var nonSurgicalTreatment = await _cia_DbContext.NonSurgicalTreatment.FirstAsync(x => x.Id == id);
            nonSurgicalTreatment.Treatment = notes;
            _cia_DbContext.NonSurgicalTreatment.Update(nonSurgicalTreatment);

            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }


        [HttpGet("CheckNonSurgicalTreatmentTeethStatus")]
        public async Task<IActionResult> CheckNonSurgicalTreatementTeethStatus(String treatment)
        {
            List<String> _DetnalExaminationTeeth = new List<String>() {
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
  };
            List<int> containedTeeth = new List<int>();
            foreach (var tooth in _DetnalExaminationTeeth)
            {
                if (treatment.Contains(tooth))
                {
                    containedTeeth.Add(int.Parse(tooth));
                }
            }
            return Ok(new API_response()
            {
                Result = containedTeeth
            });

        }

        [HttpPut("UpdatePatientTreatmentPlan")]
        public async Task<ActionResult> UpdatePatientTreatmentPlan([FromQuery] int id, [FromBody] TreatmentPlanModel model)
        {

            var user = await _iUserRepo.GetUser();


            model.Date = model.Date ?? DateTime.UtcNow;
            model.OperatorId = (int)user.IdInt;
            model.Operator = user;
            model.PatientId = id;

            _cia_DbContext.TreatmentPlans.Update(model);


            await _cia_DbContext.SaveChangesAsync();

            return Ok(_aPI_Response);
        }

        [HttpPut("UpdatePatientTreatmentDetails")]
        public async Task<ActionResult> UpdatePatientTreatmentDetails([FromQuery] int id, [FromBody] List<TreatmentDetailsModel> model)
        {

            // Get User and Treatment From Database
            var user = await _iUserRepo.GetUser();
            var treatmentDetails = await _cia_DbContext.TreatmentDetails.Where(x => x.PatientId == id).ToListAsync();

            //Get Missing Data to delete it from database
            var missings = treatmentDetails.Except(model).ToList();

            //Get assigned plans to notify users
            var notificationAssignedToPlans = model.Where(x => x.AssignedToID != null).ToList();

            // Send notifications to assigned users
            foreach (var t in notificationAssignedToPlans)
            {

                if (t.Id != null && t.AssignedToID != null)
                {
                    var currentTreatmentFromDatabase = treatmentDetails.FirstOrDefault(x => x.Id == t.Id);

                    //making sure this is the first time user is assigned that assigned in database is not equal to the new value

                    if (t.AssignedToID != currentTreatmentFromDatabase.AssignedToID)
                    {
                        //   await _notificationRepo.TreatmentAssigned(id, (int)t.AssignedToID, (int)t.TreatmentItemId);

                    }
                }
                else if (t.AssignedToID != null)
                {
                    //assign users when model id is null , first time add to database
                    //  await _notificationRepo.TreatmentAssigned(id, (int)t.AssignedToID, (int)t.TreatmentItemId);
                }
            }


            //remove deleted and update existing

            _cia_DbContext.TreatmentDetails.RemoveRange(missings);

            _cia_DbContext.TreatmentDetails.UpdateRange(model);

            _cia_DbContext.SaveChanges();


            // Getting done plans without post surgery
            // null post surgery means this is the first time it's done

            var donePlansInThisSave = model.Where(x => x.Status == true && x.PostSurgeryModelId == null).ToList();




            if (!donePlansInThisSave.IsNullOrEmpty())
            {
                //Get Detnal Examinations if there is new done items in this save

                var dentalExamination = await _cia_DbContext.DentalExaminations.Include(x => x.DentalExaminations).FirstOrDefaultAsync(x => x.PatientId == id);

                if (dentalExamination == null)
                {
                    dentalExamination = new DentalExaminationModel()
                    {
                        Date = DateTime.UtcNow,
                        DentalExaminations = new List<DentalExamination>(),
                        PatientId = id,
                        OperatorId = user.IdInt,
                        Operator = user
                    };

                    _cia_DbContext.DentalExaminations.Update(dentalExamination);
                    _cia_DbContext.SaveChanges();
                }


                foreach (var done in donePlansInThisSave)
                {
                    var treatmentPlanItem = await _cia_DbContext.TreatmentItems.FirstAsync(x => x.Id == done.TreatmentItemId);

                    //adding post surgery data, marks this plan is done
                    // not null postsurgery means it was assinged done in the past 
                    // not this save

                    var postSurgery = new PostSurgeryModel
                    {
                        PatientId = id,
                        TreatmentDetailsModelId = done.Id,
                    };
                    _cia_DbContext.PostSurgeries.Add(postSurgery);


                    //updating dental examination data implant
                    if (treatmentPlanItem.Name.ToLower().Replace(" ", "").Contains("implant") && !treatmentPlanItem.Name.ToLower().Replace(" ", "").Contains("without"))
                    {
                        var dentalExaminationOfThisTooth = dentalExamination.DentalExaminations.FirstOrDefault(x => x.Tooth == done.Tooth);


                        if (dentalExaminationOfThisTooth != null)
                        {
                            if (dentalExaminationOfThisTooth.NotSure == true) dentalExaminationOfThisTooth.PreviousState = "notSure";
                            if (dentalExaminationOfThisTooth.Hopelessteeth == true) dentalExaminationOfThisTooth.PreviousState = "hopelessteeth";
                            if (dentalExaminationOfThisTooth.Missed == true) dentalExaminationOfThisTooth.PreviousState = "missed";
                            if (dentalExaminationOfThisTooth.MobilityII == true) dentalExaminationOfThisTooth.PreviousState = "mobilityII";
                            if (dentalExaminationOfThisTooth.MobilityIII == true) dentalExaminationOfThisTooth.PreviousState = "mobilityIII";
                            if (dentalExaminationOfThisTooth.MobilityI == true) dentalExaminationOfThisTooth.PreviousState = "mobilityI";
                            if (dentalExaminationOfThisTooth.Carious == true) dentalExaminationOfThisTooth.PreviousState = "carious";
                            if (dentalExaminationOfThisTooth.Filled == true) dentalExaminationOfThisTooth.PreviousState = "filled";
                            if (dentalExaminationOfThisTooth.ImplantFailed == true) dentalExaminationOfThisTooth.PreviousState = "implantFailed";


                        }
                        else
                        {
                            dentalExaminationOfThisTooth = new DentalExamination() { Tooth = done.Tooth };
                            dentalExamination.DentalExaminations.Add(dentalExaminationOfThisTooth);
                        }
                        dentalExaminationOfThisTooth.ImplantPlaced = true;
                        dentalExaminationOfThisTooth.NotSure = false;
                        dentalExaminationOfThisTooth.Hopelessteeth = false;
                        dentalExaminationOfThisTooth.Missed = false;
                        dentalExaminationOfThisTooth.MobilityII = false;
                        dentalExaminationOfThisTooth.MobilityIII = false;
                        dentalExaminationOfThisTooth.MobilityI = false;
                        dentalExaminationOfThisTooth.Carious = false;
                        dentalExaminationOfThisTooth.Filled = false;
                        dentalExaminationOfThisTooth.ImplantFailed = false;
                        _cia_DbContext.DentalExaminations.Update(dentalExamination);

                    }






                    _cia_DbContext.SaveChanges();
                    done.PostSurgeryModelId = postSurgery.Id;


                }
            }

            _cia_DbContext.TreatmentDetails.UpdateRange(donePlansInThisSave);


            //updating request changes
            //fetching candidate data

            List<int> candidatesIds = new List<int>();

            foreach (var item in model)
            {
                //Update Request Changes
                if (item.RequestChangeModel != null)
                {
                    item.RequestChangeModel.User = user;
                    await _cia_DbContext.RequestChanges.AddAsync(item.RequestChangeModel);
                    await _notificationRepo.AddChangeRequest(item.RequestChangeModel);

                }

                if (item.DoneByCandidateID != null)
                    candidatesIds.Add((int)item.DoneByCandidateID);
            }

            //update candidates implant count
            candidatesIds = candidatesIds.Distinct().ToList();

            var candidates = await _cia_DbContext.Users.Where(x => candidatesIds.Contains((int)x.IdInt)).ToListAsync();

            foreach (var candidate in candidates)
            {
                candidate.ImplantCount = await _iUserRepo.GetCandidateTotalImplantData((int)candidate.IdInt);
            }
            _cia_DbContext.Users.UpdateRange(candidates);
            _cia_DbContext.SaveChanges();


            var doneInThisSaveFromDatabase = await _cia_DbContext.TreatmentDetails
                .Include(x => x.TreatmentItem)
                .Include(x => x.Patient)
                .Where(x => x.PatientId == id)
                .Where(x => donePlansInThisSave.Select(y => y.Id).Contains((int)x.Id))
                .Where(x => x.TreatmentItem.Name.ToLower().Contains("implant") && !x.TreatmentItem.Name.ToLower().Contains("without"))
                .ToListAsync();
            List<TodoList> todolists = new List<TodoList>();

            foreach (var item in doneInThisSaveFromDatabase)
            {
                todolists.Add(new TodoList
                {
                    CreateDate = DateTime.UtcNow,
                    DueDate = DateTime.UtcNow.AddMonths(3),
                    Data = $"Patient {item.Patient.Name} tooth {item.Tooth} waiting exposure",
                    Done = false,
                    Operator = user,
                    OperatorId = user.IdInt,
                    PatientId = item.PatientId,

                });
            }
            _cia_DbContext.ToDoLists.AddRange(todolists);
            _cia_DbContext.SaveChanges();

            var dentalEx = await _cia_DbContext.DentalExaminations.FirstOrDefaultAsync(x => x.PatientId == id);
            var failedTeeth = dentalEx.DentalExaminations.Where(x => x.ImplantFailed == true).Select(x => x.Tooth).ToList();
            treatmentDetails = await _cia_DbContext.TreatmentDetails.Where(x => x.PatientId == id).ToListAsync();
            foreach (var item in treatmentDetails)
            {
                if (failedTeeth.Contains(item.Tooth))
                {
                    item.FailedImplant = true;
                }
                else item.FailedImplant = false;
            }
            _cia_DbContext.TreatmentDetails.UpdateRange(treatmentDetails);
            _cia_DbContext.SaveChanges();

            return Ok(_aPI_Response);
        }


        [HttpPut("UpdatePatientPostSurgeryData")]
        public async Task<ActionResult> UpdatePatientPostSurgeryData([FromBody] PostSurgeryModel model)
        {

            _cia_DbContext.PostSurgeries.Update(model);
            _cia_DbContext.SaveChanges();


            return Ok(_aPI_Response);

        }


        [HttpPut("UpdatePatientProstheticTreatmentDiagnostic")]
        public async Task<ActionResult> UpdatePatientProstheticTreatmentDiagnostic([FromQuery] int id, [FromBody] List<DiagnosticStepModel> steps)
        {
            var user = await _iUserRepo.GetUser();
            foreach (var step in steps)
            {
                step.Date = step.Date ?? DateTime.UtcNow;
            }

            var stepsFromDb = await _cia_DbContext.DiagnosticSteps.Where(x => x.PatientId == id).ToListAsync();

            var missings = stepsFromDb.Except(steps);

            _cia_DbContext.DiagnosticSteps.RemoveRange(missings);
            _cia_DbContext.DiagnosticSteps.UpdateRange(steps);
            _cia_DbContext.SaveChanges();

            var nonSurgicalTreatment = await _cia_DbContext.NonSurgicalTreatment.FirstOrDefaultAsync(x =>
                    x.PatientId == id &&
                    x.Date.Value.Date == DateTime.UtcNow.Date &&
                    x.OperatorID == user.IdInt);
            if (nonSurgicalTreatment == null)
            {
                nonSurgicalTreatment = new NonSurgicalTreatmentModel()
                {
                    Date = DateTime.UtcNow,
                    Operator = user,
                    OperatorID = user.IdInt,
                    PatientId = id,


                };
                await _cia_DbContext.NonSurgicalTreatment.AddAsync(nonSurgicalTreatment);
                await _cia_DbContext.SaveChangesAsync();
            }
            if (nonSurgicalTreatment.Treatment == null) nonSurgicalTreatment.Treatment = "";

            steps = await _cia_DbContext.DiagnosticSteps
                .Include(x => x.DiagnosticItem)
                .Include(x => x.DiagnosticStatusItem)
                .Include(x => x.DiagnosticNextVisitItem)
                .Where(x => x.PatientId == id && x.Date.Value.Date == DateTime.UtcNow.Date).ToListAsync();

            foreach (var step in steps)
            {
                var tempNote = $"{step?.DiagnosticItem?.Name ?? ""}: {step?.DiagnosticStatusItem?.Name ?? ""} || {step?.DiagnosticNextVisitItem?.Name ?? ""} || {(step.Scanned == true ? "Scanned" : "")} {(step.NeedsRemake == true ? "Needs Remake" : "")}";
                tempNote.Replace("  ", " ");
                tempNote.Replace("|| ||", "||");
                tempNote.Replace("||\n", "\n");
                tempNote.Replace("|| \n", "\n");
                tempNote.Replace("||  \n", "\n");
                if (!nonSurgicalTreatment.Treatment.Contains(tempNote))
                    nonSurgicalTreatment.Treatment += $"\n {tempNote}";
            }

            _cia_DbContext.NonSurgicalTreatment.Update(nonSurgicalTreatment);
            _cia_DbContext.SaveChanges();


            return Ok(_aPI_Response);
        }


        [HttpPut("UpdatePatientProstheticTreatmentFinalProthesis")]
        public async Task<ActionResult> UpdatePatientProstheticTreatmentFinalProthesisSingleBridge([FromQuery] int id, bool fullArch, [FromBody] List<FinalStepModel> steps)
        {
            var user = await _iUserRepo.GetUser();
            foreach (var step in steps)
            {
                step.Date = step.Date ?? DateTime.UtcNow;
            }

            List<FinalStepModel> stepsFromDb = new List<FinalStepModel>();
            if (fullArch)
                stepsFromDb = await _cia_DbContext.FinalSteps.Where(x =>
                x.PatientId == id &&
                (x.FullArchLower == true ||
                x.FullArchUpper == true)
                ).ToListAsync();
            else
                stepsFromDb = await _cia_DbContext.FinalSteps.Where(x =>
                x.PatientId == id &&
                (x.FullArchLower != true &&
                x.FullArchUpper != true)
                ).ToListAsync();

            var missings = stepsFromDb.Except(steps);

            _cia_DbContext.FinalSteps.RemoveRange(missings);
            _cia_DbContext.FinalSteps.UpdateRange(steps);
            _cia_DbContext.SaveChanges();

            var nonSurgicalTreatment = await _cia_DbContext.NonSurgicalTreatment.FirstOrDefaultAsync(x =>
                    x.PatientId == id &&
                    x.Date.Value.Date == DateTime.UtcNow.Date &&
                    x.OperatorID == user.IdInt);
            if (nonSurgicalTreatment == null)
            {
                nonSurgicalTreatment = new NonSurgicalTreatmentModel()
                {
                    Date = DateTime.UtcNow,
                    Operator = user,
                    OperatorID = user.IdInt,
                    PatientId = id,


                };
                await _cia_DbContext.NonSurgicalTreatment.AddAsync(nonSurgicalTreatment);
                await _cia_DbContext.SaveChangesAsync();
            }
            if (nonSurgicalTreatment.Treatment == null) nonSurgicalTreatment.Treatment = "";

            steps = await _cia_DbContext.FinalSteps
                .Include(x => x.FinalItem)
                .Include(x => x.FinalStatusItem)
                .Include(x => x.FinalNextVisitItem)
                .Where(x => x.PatientId == id && x.Date.Value.Date == DateTime.UtcNow.Date).ToListAsync();

            foreach (var step in steps)
            {
                var tempNote = $"{step?.FinalItem?.Name ?? ""}: ";
                if (!step.Teeth.IsNullOrEmpty())
                    tempNote += String.Join(",", step.Teeth!.ToArray()) + " ";
                if (step.FullArchLower == true)
                    tempNote += "Lower Arch ";
                if (step.FullArchUpper == true)
                    tempNote += "Upper Arch ";
                if (step.Bridge == true)
                    tempNote += "Bridge ";
                else if (step.Single == true)
                    tempNote += "Single ";
                if (step.CementRetained == true)
                    tempNote += "Cement Retained ";
                else if (step.ScrewRetained == true)
                    tempNote += "Screw Retained ";

                tempNote += $"{step?.FinalStatusItem?.Name ?? ""} || {step?.FinalNextVisitItem?.Name ?? ""} || {(step.Scanned == true ? "Scanned" : "")} {(step.NeedsRemake == true ? "Needs Remake" : "")}";
                tempNote.Replace("  ", " ");
                tempNote.Replace("|| ||", "||");
                tempNote.Replace("||\n", "\n");
                tempNote.Replace("|| \n", "\n");
                tempNote.Replace("||  \n", "\n");
                if (!nonSurgicalTreatment.Treatment.Contains(tempNote))
                    nonSurgicalTreatment.Treatment += $"\n {tempNote}";
            }

            _cia_DbContext.NonSurgicalTreatment.Update(nonSurgicalTreatment);
            _cia_DbContext.SaveChanges();


            return Ok(_aPI_Response);


        }

        [HttpPut("updateComplicationsAfterProsthesis")]
        public async Task<ActionResult> updateComplicationsAfterProsthesis([FromBody] List<ComplicationsAfterProsthesisModel> data, int id)
        {

            _cia_DbContext.ComplicationsAfterProsthesis.UpdateRange(data);
            await _cia_DbContext.SaveChangesAsync();
            var missings = (await _cia_DbContext.ComplicationsAfterProsthesis.Where(x => x.PatientId == id).ToListAsync()).Except(data);

            _cia_DbContext.ComplicationsAfterProsthesis.RemoveRange(missings);
            await _cia_DbContext.SaveChangesAsync();
            return Ok();
        }

        [HttpPut("updateComplicationsAfterSurgery")]
        public async Task<ActionResult> updateComplicationsAfterSurgery([FromBody] List<ComplicationsAfterSurgeryModel> data, int id)
        {


            _cia_DbContext.ComplicationsAfterSurgery.UpdateRange(data);
            await _cia_DbContext.SaveChangesAsync();
            var missings = (await _cia_DbContext.ComplicationsAfterSurgery.Where(x => x.PatientId == id).ToListAsync()).Except(data);

            _cia_DbContext.ComplicationsAfterSurgery.RemoveRange(missings);
            await _cia_DbContext.SaveChangesAsync();

            List<int> teeth = data.Select(x => (int)x.Tooth).Distinct().ToList();
            foreach (var tooth in teeth)
            {
                var parent = await _cia_DbContext.ComplicationsAfterSurgeryParents.FirstOrDefaultAsync(x => x.PatientId == id && tooth == x.Tooth);
                if (parent == null)
                {
                    parent = new ComplicationsAfterSurgeryParentModel
                    {
                        PatientId = id,
                        Tooth = tooth,
                    };

                }
                parent.Complications = data.Where(x => x.Tooth == tooth).ToList();
                _cia_DbContext.ComplicationsAfterSurgeryParents.Update(parent);
                _cia_DbContext.SaveChanges();

            }

            var parents = await _cia_DbContext.ComplicationsAfterSurgeryParents.Where(x => x.PatientId == id && !teeth.Contains((int)x.Tooth)).ToListAsync();

            _cia_DbContext.ComplicationsAfterSurgeryParents.RemoveRange(parents);
            _cia_DbContext.SaveChanges();


            var todaysImplantFailedComplication = data.Where(x => x.Date.Value.Date == DateTime.Now.Date && x.DefaultSurgicalComplicationsId == 9).ToList();

            if (!todaysImplantFailedComplication.IsNullOrEmpty())
            {
                var dentalExamination = await _cia_DbContext.DentalExaminations
                                                .FirstAsync(x => x.PatientId == id)
                                                ;

                foreach (var com in todaysImplantFailedComplication)
                {
                    var toothExamination = dentalExamination.DentalExaminations.FirstOrDefault(x => x.Tooth == com.Tooth);
                    if (toothExamination == null)
                    {
                        toothExamination = new DentalExamination
                        {
                            Tooth = com.Tooth,
                            ImplantFailed = true,
                            Missed = true,
                        };
                        dentalExamination.DentalExaminations.Add(toothExamination);
                    }
                    else if (toothExamination.ImplantFailed != true)
                    {
                        toothExamination.ImplantFailed = true;
                        toothExamination.Missed = true;
                        toothExamination.PreviousState =
                            (toothExamination.ImplantPlaced ?? false) ? "ImplantPlaced" :
                            (toothExamination.Carious ?? false) ? "Carious" :
                            (toothExamination.Filled ?? false) ? "Filled" :
                            (toothExamination.NotSure ?? false) ? "NotSure" :
                            (toothExamination.MobilityI ?? false) ? "MobilityI" :
                            (toothExamination.MobilityII ?? false) ? "MobilityII" :
                            (toothExamination.MobilityIII ?? false) ? "MobilityIII" :
                            (toothExamination.Hopelessteeth ?? false) ? "Hopelessteeth" : "";

                        toothExamination.ImplantPlaced = false;
                        toothExamination.Carious = false;
                        toothExamination.Filled = false;
                        toothExamination.NotSure = false;
                        toothExamination.MobilityI = false;
                        toothExamination.MobilityII = false;
                        toothExamination.MobilityIII = false;
                        toothExamination.Hopelessteeth = false;
                    }


                }

                _cia_DbContext.DentalExaminations.Update(dentalExamination);
                _cia_DbContext.SaveChanges();
            }
            var dentalEx = await _cia_DbContext.DentalExaminations.FirstOrDefaultAsync(x => x.PatientId == id);
            var failedTeeth = dentalEx.DentalExaminations.Where(x => x.ImplantFailed == true).Select(x => x.Tooth).ToList();
            var treatmentDetails = await _cia_DbContext.TreatmentDetails.Where(x => x.PatientId == id).ToListAsync();
            foreach (var item in treatmentDetails)
            {
                if (failedTeeth.Contains(item.Tooth))
                {
                    item.FailedImplant = true;
                }
                else item.FailedImplant = false;
            }
            _cia_DbContext.TreatmentDetails.UpdateRange(treatmentDetails);
            _cia_DbContext.SaveChanges();
            return Ok();
        }
        //[HttpPut("UpdatePatientProstheticTreatmentFinalProthesisFullArch")]
        //public async Task<ActionResult> UpdatePatientProstheticTreatmentFinalProthesisFullArch(int id, ProstheticTreatmentDiagnosticModel model)
        //{
        //    var user = await _iUserRepo.GetUser();
        //    var nonSurgicalTreatment = await _cia_DbContext.NonSurgicalTreatment.FirstOrDefaultAsync(x =>
        //            x.PatientId == id &&
        //            x.Date.Value.Date == DateTime.UtcNow.Date &&
        //            x.OperatorID == user.IdInt);
        //    var patient = await _cia_DbContext.Patients.
        //        Include(x => x.ProstheticTreatment).
        //        FirstAsync(x => x.Id == id);

        //    if (patient.ProstheticTreatment == null)
        //        patient.ProstheticTreatment = new ProstheticTreatmentDiagnosticModel();
        //    patient.ProstheticTreatment.FinalProthesisFullArchHealingCollar = model.FinalProthesisFullArchHealingCollar;
        //    patient.ProstheticTreatment.FinalProthesisFullArchHealingCollarStatus = model.FinalProthesisFullArchHealingCollarStatus;
        //    patient.ProstheticTreatment.FinalProthesisFullArchHealingCollarNextVisit = model.FinalProthesisFullArchHealingCollarNextVisit;
        //    patient.ProstheticTreatment.FinalProthesisFullArchImpression = model.FinalProthesisFullArchImpression;
        //    patient.ProstheticTreatment.FinalProthesisFullArchImpressionStatus = model.FinalProthesisFullArchImpressionStatus;
        //    patient.ProstheticTreatment.FinalProthesisFullArchImpressionNextVisit = model.FinalProthesisFullArchImpressionNextVisit;
        //    patient.ProstheticTreatment.FinalProthesisFullArchTryIn = model.FinalProthesisFullArchTryIn;
        //    patient.ProstheticTreatment.FinalProthesisFullArchTryInStatus = model.FinalProthesisFullArchTryInStatus;
        //    patient.ProstheticTreatment.FinalProthesisFullArchTryInNextVisit = model.FinalProthesisFullArchTryInNextVisit;
        //    patient.ProstheticTreatment.FinalProthesisFullArchDelivery = model.FinalProthesisFullArchDelivery;
        //    patient.ProstheticTreatment.FinalProthesisFullArchDeliveryStatus = model.FinalProthesisFullArchDeliveryStatus;
        //    patient.ProstheticTreatment.FinalProthesisFullArchDeliveryNextVisit = model.FinalProthesisFullArchDeliveryNextVisit;

        //    var notes1 = "";
        //    var notes2 = "";
        //    var notes3 = "";
        //    var notes4 = "";
        //    if (model.FinalProthesisFullArchHealingCollar == true &&
        //        patient.ProstheticTreatment.FinalProthesisFullArchHealingCollarDate == null)
        //    {
        //        patient.ProstheticTreatment.FinalProthesisFullArchHealingCollarDate = DateTime.UtcNow;
        //        notes1 +=
        //            $"Full arch Healing Collar: {(model.FinalProthesisFullArchHealingCollarStatus == null ?
        //            "," :
        //            model.FinalProthesisFullArchHealingCollarStatus.ToString())}";
        //    }
        //    if (model.FinalProthesisFullArchImpression == true &&
        //        patient.ProstheticTreatment.FinalProthesisFullArchImpressionDate == null)
        //    {
        //        patient.ProstheticTreatment.FinalProthesisFullArchImpressionDate = DateTime.UtcNow;
        //        notes2 += $"{(notes1 != "" ? "\n" : "")}Full arch Impression: {(model.FinalProthesisFullArchImpressionStatus == null ?
        //                            "," :
        //                            model.FinalProthesisFullArchImpressionStatus.ToString())}," +
        //                            $"{(model.FinalProthesisFullArchImpressionNextVisit != null ?
        //                            $" and Next Visit: {model.FinalProthesisFullArchImpressionNextVisit.ToString()}" :
        //                            "")}";

        //    }
        //    if (model.FinalProthesisFullArchTryIn == true &&
        //        patient.ProstheticTreatment.FinalProthesisFullArchTryInDate == null)
        //    {
        //        patient.ProstheticTreatment.FinalProthesisFullArchTryInDate = DateTime.UtcNow;
        //        notes3 += $"{(notes2 != "" ? "\n" : "")}Full arch Try In: {(model.FinalProthesisFullArchTryInStatus == null ?
        //                            "," :
        //                            model.FinalProthesisFullArchTryInStatus.ToString())}," +
        //                            $"{(model.FinalProthesisFullArchTryInNextVisit != null ?
        //                            $" and Next Visit: {model.FinalProthesisFullArchTryInNextVisit.ToString()}" :
        //                            "")}";
        //    }
        //    if (model.FinalProthesisFullArchDelivery == true &&
        //        patient.ProstheticTreatment.FinalProthesisFullArchDeliveryDate == null)
        //    {
        //        patient.ProstheticTreatment.FinalProthesisFullArchDeliveryDate = DateTime.UtcNow;
        //        notes4 += $"{(notes3 != "" ? "\n" : "")}Full arch Delivery: {(model.FinalProthesisFullArchDeliveryStatus == null ?
        //                            "," :
        //                            model.FinalProthesisFullArchDeliveryStatus.ToString())}," +
        //                            $"{(model.FinalProthesisFullArchDeliveryNextVisit != null ?
        //                            $" and Next Visit: {model.FinalProthesisFullArchDeliveryNextVisit.ToString()}" :
        //                            "")}";
        //    }
        //    if (nonSurgicalTreatment == null)
        //    {
        //        nonSurgicalTreatment = new NonSurgicalTreatmentModel()
        //        {
        //            Operator = user,
        //            OperatorID = user.IdInt,
        //            PatientId = id,
        //            Date = DateTime.UtcNow,
        //            Treatment = notes1 + notes2 + notes3 + notes4
        //        };
        //        _cia_DbContext.NonSurgicalTreatment.Add(nonSurgicalTreatment);

        //    }
        //    else
        //    {
        //        if (!nonSurgicalTreatment.Treatment.Contains(notes1))
        //            nonSurgicalTreatment.Treatment += $"\n{notes1}";
        //        if (!nonSurgicalTreatment.Treatment.Contains(notes2))
        //            nonSurgicalTreatment.Treatment += $"\n{notes2}";
        //        if (!nonSurgicalTreatment.Treatment.Contains(notes3))
        //            nonSurgicalTreatment.Treatment += $"\n{notes3}";
        //        if (!nonSurgicalTreatment.Treatment.Contains(notes4))
        //            nonSurgicalTreatment.Treatment += $"\n{notes4}";
        //        _cia_DbContext.NonSurgicalTreatment.Update(nonSurgicalTreatment);

        //    }

        //    _cia_DbContext.Patients.Update(patient);
        //    _cia_DbContext.SaveChanges();
        //    _aPI_Response.Result = patient;
        //    return Ok(_aPI_Response);
        //}


        [HttpPost("ConsumeImplant")]
        public async Task<IActionResult> ConsumeImplant(int id)
        {
            var result = await _iMedicalRepo.ConsumerImplant(id);
            if (result.ErrorMessage != "" && result.ErrorMessage != null) return BadRequest(result);
            return Ok(result);
        }


        [HttpDelete]
        public async Task<ActionResult> delete(int id)
        {

            _cia_DbContext.Patients.Remove(_cia_DbContext.Patients.FirstOrDefault(x => x.Id == id));
            _cia_DbContext.SaveChanges();
            return Ok();
        }
        [HttpGet("GetPaidPlanItem")]
        public async Task<IActionResult> GetPaidPlanItem(int id, int tooth)
        {
            if (tooth == 0)
            {
                var scalingItem = await _cia_DbContext.TreatmentItems.FirstAsync(x => x.Name == "Scaling");

                var plan = await _cia_DbContext.TreatmentDetails.Where(x =>
               x.PatientId == id &&
               x.Tooth == tooth &&
               x.TreatmentItemId == scalingItem.Id).ToListAsync();

                if (plan.Count > 0)
                {
                    foreach (var item in plan)
                    {
                        item.PlanPrice = scalingItem.Price;
                    }
                }
                _aPI_Response.Result = plan;

            }


            else
            {
                _aPI_Response.Result = await _cia_DbContext.TreatmentDetails.Include(x => x.TreatmentItem).Where(x =>
                x.PatientId == id &&
                x.Tooth == tooth &&
                (x.TreatmentItem.Name.ToLower().Replace(" ", "") == "crown" ||
                x.TreatmentItem.Name.ToLower().Replace(" ", "") == "rootcanaltreatment" ||
                x.TreatmentItem.Name.ToLower().Replace(" ", "") == "restoration" ||
                x.TreatmentItem.Name.ToLower().Replace(" ", "") == "extraction" ||
                x.TreatmentItem.Name.ToLower().Replace(" ", "") == "scaling")


                ).ToListAsync();
            }
            return Ok(_aPI_Response);
        }

        [HttpGet("GetTreatmentItems")]
        public async Task<IActionResult> GetTreatmentItems()
        {
            _aPI_Response.Result = await _cia_DbContext.TreatmentItems.Where(x => x.Website == _site).OrderBy(x => x.Id).ToListAsync();
            return Ok(_aPI_Response);
        }

        [HttpPut("AddPatientReceipt")]
        public async Task<IActionResult> AddPatientReceipt(int id, int tooth, String action, int? price)
        {
            var user = await _iUserRepo.GetUser();
            action = action.ToLower();

            var treatmentPlanForTooth = await _cia_DbContext.TreatmentDetails
                .Include(x => x.TreatmentItem)
                .FirstOrDefaultAsync(x =>
                                        x.PatientId == id &&
                                        x.Tooth == tooth &&
                                        x.TreatmentItem.Name.ToLower().Replace(" ", "") == action
                                        );



            if (treatmentPlanForTooth == null)
            {
                treatmentPlanForTooth = new TreatmentDetailsModel
                {
                    PatientId = id,
                    Tooth = 0,
                };
                _cia_DbContext.TreatmentDetails.Add(treatmentPlanForTooth);
                _cia_DbContext.SaveChanges();


            }




            var receipt = await _cia_DbContext.Receipts.Include(x => x.ToothReceiptData).FirstOrDefaultAsync(x => x.Date.ToUniversalTime().Date == DateTime.UtcNow.Date && x.PatientId == id && x.Website == EnumWebsite.CIA);
            if (receipt == null)
            {
                receipt = new Receipt()
                {
                    Operator = user,
                    OperatorId = user.IdInt,
                    PatientId = id,
                    Date = DateTime.UtcNow,
                    Website = EnumWebsite.CIA
                };
                _cia_DbContext.Receipts.Add(receipt);
                _cia_DbContext.SaveChanges();
            }


            receipt.ToothReceiptData.Add(new ToothReceiptData
            {
                Name = treatmentPlanForTooth.TreatmentItem.Name,
                Price = treatmentPlanForTooth.PlanPrice ?? treatmentPlanForTooth.TreatmentItem.Price,
                Tooth = tooth,
            });
            treatmentPlanForTooth.DoneByAssistant = treatmentPlanForTooth.DoneByAssistant ?? user;
            treatmentPlanForTooth.Date = treatmentPlanForTooth.Date ?? DateTime.UtcNow;
            treatmentPlanForTooth.Status = true;


            receipt.Total = 0;
            receipt.Website = EnumWebsite.CIA;
            foreach (var item in receipt.ToothReceiptData)
            {
                receipt.Total += item.Price;
            }

            receipt.Unpaid = receipt.Total - receipt.Paid;
            _cia_DbContext.Receipts.Update(receipt);
            _cia_DbContext.TreatmentDetails.Update(treatmentPlanForTooth);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }

        [HttpPost("AddChangeRequest")]
        public async Task<IActionResult> AddChangeRequest([FromBody] RequestChangeModel request)
        {
            var user = await _iUserRepo.GetUser();

            request.User = user;
            await _cia_DbContext.RequestChanges.AddAsync(request);
            await _cia_DbContext.SaveChangesAsync();
            _notificationRepo.AddChangeRequest(request);

            _aPI_Response.Result = request;
            return Ok(_aPI_Response);
        }

        [HttpPost("AcceptChangeRequest")]
        public async Task<IActionResult> AcceptChangeRequest([FromBody] RequestChangeModel request)
        {
            var user = await _iUserRepo.GetUser();

            if (request.RequestEnum == RequestChangeEnum.ImplantChange)
            {
                var treatment = await _cia_DbContext.TreatmentDetails.FirstAsync(x => x.PatientId == request.PatientId && x.RequestChangeId == request.Id);

                treatment.RequestChangeId = null;
                treatment.RequestChangeModel = null;
                treatment.ImplantID = request.DataId;

                _cia_DbContext.TreatmentDetails.Update(treatment);
                _cia_DbContext.SaveChanges();

            }
            else
            {
                var surgicalTreatment = await _cia_DbContext.PostSurgeries.FirstAsync(x => x.PatientId == request.PatientId);

                if (request.RequestEnum == RequestChangeEnum.MembraneChange)
                {
                    surgicalTreatment.OpenSinusLift_MembraneID = request.DataId;
                    surgicalTreatment.OpenSinusLift_Membrane_CompanyID = (await _cia_DbContext.Membranes.FirstAsync(x => x.Id == request.DataId)).MembraneCompnayId;

                }
                else if (request.RequestEnum == RequestChangeEnum.TacsChange)
                {
                    surgicalTreatment.OpenSinusLift_TacsCompanyID = request.DataId;
                }

                _cia_DbContext.PostSurgeries.Update(surgicalTreatment);
                _cia_DbContext.SaveChanges();

            }



            return Ok();
        }


    }
}
