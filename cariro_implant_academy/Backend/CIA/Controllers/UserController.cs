using AutoMapper;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.DTOs;
using CIA.Models.TreatmentModels;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing.Matching;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic;
using System.Data;
using System.Xml.Linq;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : BaseController
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly API_response _apiResponse;
        private readonly IHostEnvironment _env;
        private readonly EnumWebsite _site;
        private readonly String secretKey;
        private readonly IMapper _mapper;
        private readonly IPhotosRepo _photosRepo;
        private readonly CIA_dbContext _ciaDbContext;
        private readonly IUserRepo _userRepo;
        public UserController(IUserRepo userRepo, IHttpContextAccessor httpContextAccessor, IHostEnvironment env, IPhotosRepo photosRepo, IConfiguration configuration, UserManager<ApplicationUser> userManager, IMapper mapper, CIA_dbContext cIA_DbContext, RoleManager<IdentityRole> roleManager)
        {
            _userRepo = userRepo;
            _userManager = userManager;
            _apiResponse = new();
            _mapper = mapper;
            _ciaDbContext = cIA_DbContext;
            _photosRepo = photosRepo;
            _roleManager = roleManager;
            _env = env;
            secretKey = configuration.GetValue<String>("API_Settings:SecretKey");
            var site = httpContextAccessor.HttpContext.Request.Headers["Site"].ToString();
            if (site == "")
                _site = EnumWebsite.CIA;
            else
                _site = (EnumWebsite)int.Parse(site);
        }
        [HttpGet("GetUserData")]
        public async Task<ActionResult> GetUserData(int id)
        {
            var user = await _ciaDbContext.Users.FirstOrDefaultAsync(x => x.IdInt == id);
            var role = await _userManager.GetRolesAsync(user);
            user.Role = role[0];
            user.Roles = role.ToList();
            _apiResponse.Result = user;
            return Ok(_apiResponse);
        }

        [HttpDelete("RemoveUser")]
        public async Task<ActionResult> RemoveUser(int id)
        {
            var user = await _ciaDbContext.Users.FirstOrDefaultAsync(x => x.IdInt == id);

            try
            {
                _ciaDbContext.Users.Remove(user);
                _ciaDbContext.SaveChanges();

            }
            catch (Exception e)
            {
                var roles = await _userManager.GetRolesAsync(user);
                foreach (var role in roles)
                {
                    await _userManager.RemoveFromRoleAsync(user, role);
                }
                user.LockoutEnabled = true;
                user.AccessWebsites.Clear();
                _ciaDbContext.Users.Update(user);
                _ciaDbContext.SaveChanges();
            }
            return Ok();
        }

        [HttpGet("GetSessionsDurations")]
        public async Task<ActionResult> GetSessionsDurations(int id, DateOnly? from, DateOnly? to)
        {
            IQueryable<VisitsLog> query = _ciaDbContext.VisitsLogs.Where(x => x.DoctorID == id).
                Include(x => x.Patient).
                Include(x => x.Doctor).
               OrderByDescending(x => x.RealVisitTime);
            if (from != null)
            {
                query = query.Where(x => x.RealVisitTime.Value.Date >= from.Value.ToDateTime(TimeOnly.Parse("12:00 AM")).Date.ToUniversalTime());

            }
            if (to != null)
            {
                query = query.Where(x => x.RealVisitTime.Value.Date <= to.Value.ToDateTime(TimeOnly.Parse("12:00 AM")).Date.ToUniversalTime());

            }

            var res = await query.ToListAsync();

            foreach (var r in res)
            {
                if (r.Duration != null)
                {
                    try
                    {
                        var t = await _ciaDbContext.NonSurgicalTreatment.FirstOrDefaultAsync(x => x.PatientId == r.PatientID && x.OperatorID == id && x.Date.Value.Date == r.RealVisitTime.Value.Date);
                        if (t != null)
                        {
                            r.Treatment = t.Treatment ?? "";
                        }
                    }
                    catch (Exception e) { }
                }
                else
                {
                    r.Duration = new TimeSpan(0);
                }
            }
            _apiResponse.Result = res.Select(x => new
            {
                x.Id,
                x.PatientID,
                patientName = x.Patient.Name,
                status = x.Status.ToString(),
                x.ReservationTime,
                x.RealVisitTime,
                x.EntersClinicTime,
                x.LeaveTime,
                x.Duration,
                x.Treatment,
                doctorName = x.Doctor.Name,

            });
            return Ok(_apiResponse);
        }


        [HttpPost("AddBatch")]
        public async Task<ActionResult> AddBatch(String name)
        {
            if (await _ciaDbContext.CandidatesBatches.FirstOrDefaultAsync(x => x.Name == name) != null)
            {
                _apiResponse.ErrorMessage = "A batch with the same name already exists";
                return BadRequest(_apiResponse);
            }
            await _ciaDbContext.CandidatesBatches.AddAsync(new CandidatesBatchesModel
            {
                Name = name,
            });
            await _ciaDbContext.SaveChangesAsync();
            return Ok(_apiResponse);
        }

        [HttpGet("GetAllDoctors")]
        public async Task<ActionResult> GetAllDoctors()
        {
            var candidates = (await _userManager.GetUsersInRoleAsync("candidate")).ToList();
            var secretaies = (await _userManager.GetUsersInRoleAsync("secretary")).ToList();

            candidates.AddRange(secretaies);

            var users = await _ciaDbContext.Users.ToListAsync();
            _apiResponse .Result = users.Except(candidates).ToList();
            return Ok(_apiResponse);



        }

        [HttpGet("LoadInstructors")]
        public async Task<ActionResult> LoadInstructors()
        {

            var Instructors = await _userManager.GetUsersInRoleAsync("instructor");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");
            List<Object> s = new List<Object>();

            foreach (var c in Instructors.Where(x => x.Website == _site))
            {
                s.Add(new { id = c.IdInt, c.Name });
            }



            _apiResponse.Result = s;

            return Ok(_apiResponse);
        }

        [HttpGet("LoadTechnicians")]
        public async Task<ActionResult> LoadTechnicians()
        {

            var Instructors = await _userManager.GetUsersInRoleAsync("technician");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");
            List<Object> s = new List<Object>();

            foreach (var c in Instructors)
            {
                s.Add(new { id = c.IdInt, c.Name });
            }



            _apiResponse.Result = s;

            return Ok(_apiResponse);
        }

        [HttpGet("LoadAssistants")]
        public async Task<ActionResult> LoadAssistants()
        {

            var Assistants = await _userManager.GetUsersInRoleAsync("assistant");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");
            List<Object> s = new List<Object>();

            foreach (var c in Assistants.Where(x => x.Website == _site))
            {
                s.Add(new { id = c.IdInt, c.Name });
            }



            _apiResponse.Result = s;
            return Ok(_apiResponse);
        }
        [HttpGet("LoadAdmins")]
        public async Task<ActionResult> LoadAdmins()
        {

            var Admins = await _userManager.GetUsersInRoleAsync("admin");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");
            List<Object> s = new List<Object>();

            foreach (var c in Admins)
            {
                s.Add(new { id = c.IdInt, c.Name });
            }


            _apiResponse.Result = s;
            return Ok(_apiResponse);
        }
        [HttpGet("LoadLabDesingers")]
        public async Task<ActionResult> LoadLabDesingers()
        {

            var Admins = await _userManager.GetUsersInRoleAsync("labdesigner");
            List<Object> s = new List<Object>();

            foreach (var c in Admins)
            {
                s.Add(new { id = c.IdInt, c.Name });
            }


            _apiResponse.Result = s;
            return Ok(_apiResponse);
        }
        [HttpGet("LoadInstructorsAndAssistants")]
        public async Task<ActionResult> LoadInstructorsAndAssistants()
        {

            var Assistants = await _userManager.GetUsersInRoleAsync("assistant");
            var Instructors = await _userManager.GetUsersInRoleAsync("instructor");
            List<Object> s = new List<Object>();

            foreach (var c in Assistants.Where(x => x.Website == _site))
            {
                s.Add(new { id = c.IdInt, c.Name });
            }
            foreach (var c in Instructors.Where(x => x.Website == _site))
            {
                s.Add(new { id = c.IdInt, c.Name });
            }




            _apiResponse.Result = s;
            return Ok(_apiResponse);
        }
        [HttpGet("LoadSupervisors")]
        public async Task<ActionResult> LoadSupervisors()
        {

            var Admins = await _userManager.GetUsersInRoleAsync("admin");
            var Instructors = await _userManager.GetUsersInRoleAsync("instructor");
            List<Object> s = new List<Object>();

            foreach (var c in Admins)
            {
                s.Add(new { id = c.IdInt, c.Name });
            }
            foreach (var c in Instructors.Where(x => x.Website == _site).ToList())
            {
                s.Add(new { id = c.IdInt, c.Name });
            }


            _apiResponse.Result = s;
            return Ok(_apiResponse);
        }


        [HttpGet("LoadCandidatesBatches")]
        public async Task<ActionResult> LoadCandidatesBatches()
        {

            var batch = _ciaDbContext.CandidatesBatches.ToList();

            _apiResponse.Result = batch;
            return Ok(_apiResponse);
        }

        [HttpGet("LoadCandidates")]
        public async Task<ActionResult> LoadCandidates()
        {
            var candidates = await _userManager.GetUsersInRoleAsync("candidate");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");
            List<Object> s = new List<Object>();

            foreach (var c in candidates)
            {
                s.Add(new { id = c.IdInt, c.Name });
            }


            _apiResponse.Result = s;
            return Ok(_apiResponse);
        }
        [HttpGet("LoadCandidatesByBatchID")]
        public async Task<ActionResult> LoadCandidatesByBatchID(int id)
        {
            var candidates = await _userManager.GetUsersInRoleAsync("candidate");
            candidates = candidates.Where(x => x.BatchId == id).ToList();
            List<Object> s = new List<Object>();

            foreach (var c in candidates)
            {
                s.Add(new { id = c.IdInt, c.Name, c.BatchId });
            }


            _apiResponse.Result = s;
            return Ok(_apiResponse);

        }

        [HttpGet("GetSecretaries")]
        public async Task<ActionResult> LoadSecretaries()
        {
            var sec = await _userManager.GetUsersInRoleAsync("secretary");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");


            _apiResponse.Result = sec.Where(x => x.Website == _site).ToList();
            return Ok(_apiResponse);

        }


        [HttpGet("GetAdmins")]
        public async Task<ActionResult> GetAdmins()
        {
            var admins = await _userManager.GetUsersInRoleAsync("admin");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");


            _apiResponse.Result = admins;
            return Ok(_apiResponse);

        }


        [HttpGet("GetLabTechnicians")]
        public async Task<ActionResult> GetLabTechnicians()
        {
            var technicians = await _userManager.GetUsersInRoleAsync("technician");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");


            _apiResponse.Result = technicians;
            return Ok(_apiResponse);

        }




        [HttpGet("GetInstructors")]
        public async Task<ActionResult> GetInstructors()
        {

            var Instructors = await _userManager.GetUsersInRoleAsync("instructor");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");


            _apiResponse.Result = Instructors.Where(x => x.Website == _site).ToList();
            return Ok(_apiResponse);
        }

        [HttpGet("GetAssistants")]
        public async Task<ActionResult> GetAssistants()
        {

            var Assistants = await _userManager.GetUsersInRoleAsync("assistant");
            // var Assistants = await _userManager.GetUsersInRoleAsync("assistant");


            _apiResponse.Result = Assistants.Where(x => x.Website == _site).ToList();
            return Ok(_apiResponse);
        }




        [HttpPut("ChangeRole")]
        public async Task<IActionResult> ChangeRole(int id, String role)
        {
            var user = _ciaDbContext.Users.First(x => x.IdInt == id);
            var roles = await _userManager.GetRolesAsync(user);
            await _userManager.RemoveFromRolesAsync(user, roles);
            await _userManager.AddToRoleAsync(user, role);
            return Ok(_apiResponse);
        }

        [HttpGet("GetRoleById")]
        public async Task<IActionResult> GetRoleById(int id)
        {
            var user = _ciaDbContext.Users.First(x => x.IdInt == id);
            _apiResponse.Result = (await _userManager.GetRolesAsync(user)).FirstOrDefault();
            return Ok(_apiResponse);
        }

        [HttpGet("SearchUsersByWorkplace")]
        public async Task<IActionResult> SearchUsersByWorkplace(String? search, EnumWebsite source)
        {
            if (search == null)

                _apiResponse.Result = _ciaDbContext.Users.Where(x =>
                x.WorkPlaceEnum == source).ToList();
            else
                _apiResponse.Result = _ciaDbContext.Users.Where(x =>
                x.WorkPlaceEnum == source && (
                x.Name.ToLower().Contains(search.ToLower()) ||
                x.PhoneNumber.ToLower().Contains(search.ToLower()))
                ).ToList();

            return Ok(_apiResponse);

        }

        [HttpGet("SearchUsersByRole")]
        public async Task<IActionResult> SearcshUsersByRole(String? search, UserRoles role, int? batch, EnumWebsite? accessWebsites)
        {

            String roleString = role.ToString().ToLower();
            var query = (await _userManager.GetUsersInRoleAsync(roleString));
            if (role != UserRoles.OutSource)
                query = query.Where(x => x.AccessWebsites.Contains(accessWebsites ?? _site)).ToList();
            if (search == null)
            {
                _apiResponse.Result = query.ToList();
            }
            else
            {

                _apiResponse.Result = query

                       .Where(x =>
                       x.Name != null && x.Name.ToLower().Contains(search.ToLower()) ||
                       x.Email != null && x.Email.ToLower().Contains(search.ToLower()) ||
                       x.PhoneNumber != null && x.PhoneNumber.ToString().ToLower().Contains(search.ToLower()) ||
                       x.GraduatedFrom != null && x.GraduatedFrom.ToLower().Contains(search.ToLower()) ||
                       x.Speciality != null && x.Speciality.ToLower().Contains(search.ToLower()) ||
                       x.ClassYear != null && x.ClassYear.ToLower().Contains(search.ToLower()) ||
                       x.Batch != null && x.Batch.Name.ToLower().Contains(search.ToLower())
                       ).ToList();
            }

            if (batch != null)
            {
                _apiResponse.Result = ((List<ApplicationUser>)_apiResponse.Result).Where(x => x.BatchId == batch).ToList();
            }
            foreach (var user in (List<ApplicationUser>)_apiResponse.Result)
            {
                user.Roles = (await _userManager.GetRolesAsync(user)).ToList();
            }
            if (role == UserRoles.OutSource)
            {
                var workPlaceIds = ((List<ApplicationUser>)_apiResponse.Result).Select(x => x.WorkplaceId).Distinct().ToList();
                var workPlaces = await _ciaDbContext.Lab_CustomerWorkPlaces.Where(x => workPlaceIds.Contains(x.Id)).ToListAsync();
                foreach (var user in (List<ApplicationUser>)_apiResponse.Result)
                {
                    if (user.WorkplaceId != null)
                    {
                        user.WorkPlace = workPlaces.First(x => x.Id == user.WorkplaceId);
                    }
                }
            }
            return Ok(_apiResponse);

        }

        [HttpPost("RefreshAllCandidatesData")]
        public async Task<IActionResult> RefreshAllCandidatesData(int? batchId)
        {
            var candidates = await _userManager.GetUsersInRoleAsync("candidate");

            if (batchId != null)
                candidates = candidates.Where(x => x.BatchId == batchId).ToList();
            foreach (var candidate in candidates)
            {
                candidate.ImplantCount = await _userRepo.GetCandidateTotalImplantData((int)candidate.IdInt!);
            }
            _ciaDbContext.Users.UpdateRange(candidates);
            _ciaDbContext.SaveChanges();

            return Ok(_apiResponse);

        }


        [HttpPut("UpdateUserInfo")]
        public async Task<IActionResult> UpdateUserInfo(int id, [FromBody] RegisterDTO model)
        {
            var user = await _ciaDbContext.Users.FirstAsync(x => x.IdInt == id);
            user.Name = model.Name;
            user.PhoneNumber = model.PhoneNumber;
            user.GraduatedFrom = model.GraduatedFrom;
            user.Speciality = model.Speciality;
            user.ClassYear = model.ClassYear;
            user.AccessWebsites = model.AccessWebsites;
            _ciaDbContext.Users.Update(user);
            _ciaDbContext.SaveChanges();

            var roles = await _userManager.GetRolesAsync(user);
            await _userManager.RemoveFromRolesAsync(user, roles.ToArray());


            foreach (var role in model.Roles)
            {
                await _userManager.AddToRoleAsync(user, role);
            }
            user.Roles = model.Roles.ToList();
            _apiResponse.Result = await _ciaDbContext.Users.FirstAsync(x => x.IdInt == id);

            return Ok(_apiResponse);

        }

        [HttpGet("GetCandidateDetails")]
        public async Task<IActionResult> GetCandidateDetails(int id, DateOnly? from, DateOnly? to)
        {
            IQueryable<TreatmentDetailsModel> query = _ciaDbContext.TreatmentDetails.
                Where(x => x.DoneByCandidateID == id).
                Include(x => x.Patient).
                Include(x => x.TreatmentItem).
                Include(x => x.Implant)
                ;

            if (from != null)
            {
                query = query.Where(x => x.Date.Value.Date >= from.Value.ToDateTime(TimeOnly.Parse("12:00 AM")).Date.ToUniversalTime());
            }
            if (to != null)
            {
                query = query.Where(x => x.Date.Value.Date <= to.Value.ToDateTime(TimeOnly.Parse("12:00 AM")).Date.ToUniversalTime());
            }

            var treatments = await query.ToListAsync();

            List<CandidateDetails> tempCandidateDetails = new List<CandidateDetails>();
            foreach (var treatment in treatments)
            {


                tempCandidateDetails.Add(new CandidateDetails()
                {

                    Tooth = treatment.Tooth,
                    CandidateId = id,
                    Date = treatment.Date,
                    PatientId = treatment.PatientId,
                    Patient = treatment.Patient,
                    Implant = treatment.Implant,
                    Procedure = treatment.TreatmentItem.Name,
                    ImplantCount = treatment.TreatmentItem.Name.ToLower().Contains("implant") &&
                                  !treatment.TreatmentItem.Name.ToLower().Contains("without") ? 1 : 0,
                    ImplantId = treatment.ImplantID,

                });

            }
            _apiResponse.Result = tempCandidateDetails.OrderByDescending(x => x.Date);
            return Ok(_apiResponse);
        }




        [HttpPost("SaveLogFile")]
        public async Task SaveLogFile([FromBody] String data)
        {
            String path = $"{_env.ContentRootPath}\\UI_logs.log";

            using (StreamWriter s = new StreamWriter(path, false))
            {
                s.Write(data);
            }
        }


    }
}
