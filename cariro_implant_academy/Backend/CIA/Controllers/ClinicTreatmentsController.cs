using AutoMapper;
using CIA.AutoMappers;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.DTOs;
using CIA.Models.LAB;
using CIA.Models.TreatmentModels;
using CIA.Repositories;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;
using static CIA.Models.TreatmentModels.MedicalExaminationModel;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClinicTreatmentsController : BaseController
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly API_response _apiResponse;
        private readonly String secretKey;
        private readonly IMapper _mapper;
        private readonly CIA_dbContext _ciaDbContext;
        private readonly IUserRepo _userRepo;
        private readonly EnumWebsite _site;
        private readonly IClinicRepos _clinicRepos;
        public ClinicTreatmentsController(IClinicRepos clinicRepos, IUserRepo userRepo, IHttpContextAccessor httpContextAccessor, IConfiguration configuration, UserManager<ApplicationUser> userManager, IMapper mapper, CIA_dbContext cIA_DbContext, RoleManager<IdentityRole> roleManager)
        {
            _clinicRepos = clinicRepos;

            _userManager = userManager;
            _apiResponse = new();
            _mapper = mapper;
            _ciaDbContext = cIA_DbContext;
            _roleManager = roleManager;
            secretKey = configuration.GetValue<String>("API_Settings:SecretKey");
            var site = httpContextAccessor.HttpContext.Request.Headers["Site"].ToString();
            if (site == "")
                _site = EnumWebsite.CIA;
            else
                _site = (EnumWebsite)int.Parse(site);
            _userRepo = userRepo;
        }

        [HttpPost("UpdateTreatment")]
        public async Task<IActionResult> UpdateTreatment([FromQuery] int id, [FromBody] ClinicTreatmentDTO treatment)
        {
            treatment.Restorations.RemoveAll(x => x.Status == null || x.Status == EnumClinicRestorationStatus.NotSelected);
            treatment.ClinicImplants.RemoveAll(x => x.Type == null || x.Type == EnumClinicImplantTypes.NotSelected);
            treatment.TMDs.RemoveAll(x => x.Type == null || x.Type == EnumClinicTMDtypes.NotSelected || x.StepNumber == 0 || x.StepNumber == null);
            treatment.RootCanalTreatments.RemoveAll(x => x.CanalNumber == 0 || x.CanalNumber == null);
            treatment.Scalings.RemoveAll(x => x.StepNumber == 0 || x.StepNumber == null);

            var treatmentModel = _mapper.Map<ClinicTreatment>(treatment);

            List<ClinicTreatmentParent> clinicTreatmentParentsFromQuery = new List<ClinicTreatmentParent>();
            clinicTreatmentParentsFromQuery.AddRange(treatmentModel.TMDs);
            clinicTreatmentParentsFromQuery.AddRange(treatmentModel.ClinicImplants);
            clinicTreatmentParentsFromQuery.AddRange(treatmentModel.OrthoTreatments);
            clinicTreatmentParentsFromQuery.AddRange(treatmentModel.Pedos);
            clinicTreatmentParentsFromQuery.AddRange(treatmentModel.RootCanalTreatments);
            clinicTreatmentParentsFromQuery.AddRange(treatmentModel.Restorations);
            clinicTreatmentParentsFromQuery.AddRange(treatmentModel.Scalings);

            var undoneOperations =

                 await _ciaDbContext.ClinicTreatmentParents.Where(x => x.PatientId == id && x.Done == false).AsNoTracking().ToListAsync();




            _ciaDbContext.ClinicTreatmentParents.UpdateRange(clinicTreatmentParentsFromQuery);
            _ciaDbContext.SaveChanges();




            var missingTreatmentsFromQuery = _ciaDbContext.ClinicTreatmentParents.Where(x => x.PatientId == id)
                .Except(_ciaDbContext.ClinicTreatmentParents.Where(x => clinicTreatmentParentsFromQuery.Select(x => x.Id).Contains(x.Id)));

            if (!missingTreatmentsFromQuery.ToList().IsNullOrEmpty())
            {
                var missingIdS = missingTreatmentsFromQuery.Select(x => x.Id).ToList();
                var toBeDeleted = _ciaDbContext.ClinicDoctorClinicPercentageModels
                    .Where(x =>
                    x.ClinicTreatmentId != null && missingIdS.Contains((int)x.ClinicTreatmentId)

                    )
                    .ToList();
                _ciaDbContext.ClinicDoctorClinicPercentageModels.RemoveRange(toBeDeleted);
                _ciaDbContext.SaveChanges();
            }

            _ciaDbContext.ClinicTreatmentParents.RemoveRange(missingTreatmentsFromQuery);
            _ciaDbContext.SaveChanges();



            await _clinicRepos.UpdateTreatmentPrice(id);
            await _clinicRepos.UpdateDoctorFeesWithPatientId(id);
            await _clinicRepos.UpdateReceipt(id);


            return Ok();
        }
        [HttpGet("GetTreatment")]
        public async Task<IActionResult> GetTreatment(int id)
        {
            await _clinicRepos.UpdateTreatmentPrice(id);
            _apiResponse.Result = new ClinicTreatmentDTO()
            {
                PatientId = id,
                ClinicImplants = await _mapper.ProjectTo<ClinicImplantDTO>(_ciaDbContext.ClinicImplants.Where(x => x.PatientId == id)).ToListAsync(),
                OrthoTreatments = await _mapper.ProjectTo<OrthoTreatmentDTO>(_ciaDbContext.OrthoTreatments.Where(x => x.PatientId == id)).ToListAsync(),
                Pedos = await _mapper.ProjectTo<PedoDTO>(_ciaDbContext.Pedos.Where(x => x.PatientId == id)).ToListAsync(),
                RootCanalTreatments = await _mapper.ProjectTo<RootCanalTreatmentDTO>(_ciaDbContext.RootCanalTreatments.Where(x => x.PatientId == id)).ToListAsync(),
                TMDs = await _mapper.ProjectTo<TMDDTO>(_ciaDbContext.TMDs.Where(x => x.PatientId == id)).ToListAsync(),
                Restorations = await _mapper.ProjectTo<RestorationDTO>(_ciaDbContext.Restorations.Where(x => x.PatientId == id)).ToListAsync(),
                Scalings = await _mapper.ProjectTo<ScalingDTO>(_ciaDbContext.Scalings.Where(x => x.PatientId == id)).ToListAsync(),
                PatientsDoctor = await _ciaDbContext.Patients.Select(x => new DropDowns()
                {
                    Id = x.Doctor.IdInt,
                    Name = x.Doctor.Name,

                }).FirstOrDefaultAsync(x => x.Id == id)


            };


            return Ok(_apiResponse);
        }


        [HttpGet("GetDoctorPercentageForPatient")]
        public async Task<IActionResult> GetDoctorPercentageForPatient(int id)
        {
            _apiResponse.Result = await _mapper.ProjectTo<ClinicDoctorClinicPercentageDTO>(_ciaDbContext.ClinicDoctorClinicPercentageModels.Where(x => x.PatientId == id)).OrderBy(x => x.Id).ToListAsync();

            return Ok(_apiResponse);
        }




    }
}
