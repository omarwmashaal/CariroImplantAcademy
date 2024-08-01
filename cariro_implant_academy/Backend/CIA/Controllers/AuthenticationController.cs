using AutoMapper;
using CIA.AutoMappers;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels;
using CIA.Models.DTOs;
using CIA.Models.LAB;
using CIA.Models.TreatmentModels;
using CIA.Repositories;
using CIA.Repositories.Interfaces;
using Hardware.Info;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Portable.Licensing;
using Portable.Licensing.Validation;
using System;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.NetworkInformation;
using System.Security.Claims;
using System.Text;
using static CIA.Models.TreatmentModels.MedicalExaminationModel;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;


namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : BaseController
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly API_response _apiResponse;
        private readonly IAuthenticator _iAuthenticator;
        private readonly String secretKey;
        private readonly IMapper _mapper;
        private readonly CIA_dbContext _ciaDbContext;
        private readonly IUserRepo _userRepo;
        private readonly EnumWebsite _site;

        public AuthenticationController(IUserRepo userRepo, IHttpContextAccessor httpContextAccessor, IConfiguration configuration, UserManager<ApplicationUser> userManager, IMapper mapper, CIA_dbContext cIA_DbContext, RoleManager<IdentityRole> roleManager, IAuthenticator iAuthenticator)
        {

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
            _iAuthenticator = iAuthenticator;
        }


        [HttpPost("Register")]
        public async Task<ActionResult> Register([FromBody] RegisterDTO registerDTO)
        {

            String password = "Pa$$word1";

            if (registerDTO.Roles.Contains("candidate") || registerDTO.Roles.Contains("instructor"))
            {
                password += DateTime.Now.Millisecond.ToString() + (new Random().Next(102).ToString());
                if (registerDTO.Roles.Contains("instructor"))
                    registerDTO.Email = DateTime.Now.Millisecond.ToString() + "@cia.com";
                if (registerDTO.Roles.Contains("candidate") && registerDTO.BatchId == null && registerDTO.Batch == null)
                {
                    _apiResponse.ErrorMessage = "Batch is required";
                    return BadRequest(_apiResponse);
                }

            }
            else if (registerDTO.Email.IsNullOrEmpty())
            {
                _apiResponse.ErrorMessage = "Email field is required";
                return BadRequest(_apiResponse);
            }
            if (registerDTO == null || password == null)
            {
                _apiResponse.ErrorMessage = "Register Information mustn't be null";
                return BadRequest(_apiResponse);
            }
            if (await _ciaDbContext.Users.FirstOrDefaultAsync(x => x.Email.ToLower() == registerDTO.Email.ToLower()) != null)
            {
                _apiResponse.ErrorMessage = "Email address already exists!";
                return BadRequest(_apiResponse);
            }
            foreach (var role in registerDTO.Roles)
            {

                if (!await _roleManager.RoleExistsAsync(role))
                {
                    _apiResponse.ErrorMessage = "Invalid Role";
                    return BadRequest(_apiResponse);
                }
            }


            ApplicationUser user = _mapper.Map<ApplicationUser>(registerDTO);

            user.RegisterationDate = DateTime.UtcNow;


            var u = await _userRepo.GetUser();
            if (u != null && !_userManager.GetRolesAsync(u).Result.Contains("admin"))
            {
                _apiResponse.ErrorMessage = "UnAuthorized";
                return BadRequest(_apiResponse);
            }

            if (!registerDTO.Roles.Contains("admin"))
            {
                user.RegisteredBy = u;
                user.RegisteredById = u.IdInt;
            }

            user.UserName = registerDTO.Name.ToLower().Replace(" ", "");
            if (registerDTO.Roles.Contains("labmoderator") || registerDTO.Roles.Contains("technician"))
            {
                user.Website = EnumWebsite.Lab;
                user.AccessWebsites = new List<EnumWebsite>() { EnumWebsite.Lab };
            }

            else
                user.Website = _site;
            if (registerDTO.Roles.Contains("admin"))
            {
                user.AccessWebsites = new List<EnumWebsite>() { EnumWebsite.Lab, EnumWebsite.CIA, EnumWebsite.Clinic, };
            }

            var response = await _userManager.CreateAsync(user, password);
            if (response.Succeeded)
            {

                foreach (var role in registerDTO.Roles)
                {

                    await _userManager.AddToRoleAsync(user, role);
                }
                _apiResponse.Result = await _ciaDbContext.Users.FirstOrDefaultAsync(x => x.Email.ToLower() == registerDTO.Email.ToLower());
                return Ok(_apiResponse);
            }

            _apiResponse.ErrorMessage = response.ToString();
            return BadRequest(_apiResponse);
        }

        [AllowAnonymous]
        [HttpPost("Login")]
        [ProducesResponseType(typeof(LoginResponseDTO), StatusCodes.Status200OK)]
        public async Task<ActionResult> Login([FromBody] LoginDTO loginDTO)
        {

            IList<String> roles;
            ApplicationUser user = new ApplicationUser();


            // try login using token
            user = await _userRepo.GetUser();
            // token incorrect so we check email and password
            if (user == null)
            {
                //Check empty email or password
                if (loginDTO.Email == null || loginDTO.Password == null)
                {
                    _apiResponse.ErrorMessage = "Invalid Login Information";
                    BadRequest(_apiResponse);
                }

                //check email validity
                user = await _ciaDbContext.Users.FirstOrDefaultAsync(x => x.Email.ToLower() == loginDTO.Email);
                //check passowrd validity
                var isValid = await _userManager.CheckPasswordAsync(user, loginDTO.Password);
                if (user == null || !isValid)
                {
                    _apiResponse.ErrorMessage = "Invalid email or password!";
                    return BadRequest(_apiResponse);
                }

            }


            //check website access
            roles = await _userManager.GetRolesAsync(user);

            //check that only app users can use it
            if (roles.IsNullOrEmpty())
            {
                _apiResponse.ErrorMessage = "Invalid email or password!";
                return BadRequest(_apiResponse);
            }
            if (!user.AccessWebsites.Contains(_site))
            {
                _apiResponse.ErrorMessage = "User doesn't have access to this website!";
                return BadRequest(_apiResponse);
            }
            var tokenhandler = new JwtSecurityTokenHandler();
            var key = Encoding.UTF8.GetBytes(secretKey);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim("Id", user.Id),
                    new Claim(ClaimTypes.Role, roles.FirstOrDefault())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256)
            };
            var token = tokenhandler.CreateToken(tokenDescriptor);

            var Instructors = await _userManager.GetUsersInRoleAsync("instructor");
            var Assistants = await _userManager.GetUsersInRoleAsync("assistant");

            user.Token = tokenhandler.WriteToken(token);
            user.Role = roles.FirstOrDefault();
            user.Roles = roles.ToList();
            var _user = _mapper.Map<UserDTO>(user);
            _apiResponse.Result = _user;

            _user.Roles.ForEach(x =>
            {
                Console.WriteLine($"Roles {x}");
            });

            return Ok(_apiResponse);
        }

        

        [AllowAnonymous]
        [HttpGet("MigrateToImplantFailed")]
        public async Task<IActionResult> MigrateToImplantFailed()
        {
            var patientIds = await _ciaDbContext.Patients.Select(X => X.Id).ToListAsync();
            foreach (var id in patientIds)
            {
                var dentalEx = await _ciaDbContext.DentalExaminations.FirstOrDefaultAsync(x => x.PatientId == id);
                var failedTeeth = dentalEx.DentalExaminations.Where(x => x.ImplantFailed == true).Select(x => x.Tooth).ToList();
                var treatmentDetails = await _ciaDbContext.TreatmentDetails.Where(x => x.PatientId == id).ToListAsync();
                foreach (var item in treatmentDetails)
                {
                    if (failedTeeth.Contains(item.Tooth))
                    {
                        item.FailedImplant = true;
                    }
                    else item.FailedImplant = false;
                }
                _ciaDbContext.TreatmentDetails.UpdateRange(treatmentDetails);
            }
            _ciaDbContext.SaveChanges();
            return Ok();


        }
        [AllowAnonymous]
        [HttpGet("MigrateToNewReceiptSystem")]
        public async Task<IActionResult> MigrateToNewReceiptSystem()
        {
            var receipt = await _ciaDbContext.Receipts.
                Include(x => x.WaxUp).
                Include(x => x.ZirconUnit).
                Include(x => x.PFM).
                Include(x => x.CompositeInlay).
                Include(x => x.EmaxVeneer).
                Include(x => x.MilledPMMA).
                Include(x => x.PrintedPMMA).
                Include(x => x.TiAbutment).
                Include(x => x.TiBar).
                Include(x => x.ThreeDPrinting).
                ToListAsync();

            foreach (var r in receipt)
            {
                List<ToothReceiptData> newReceipt = new();

                if (r.ToothReceiptData != null)
                {

                    foreach (var t in r.ToothReceiptData)
                    {
                        newReceipt.Add(new ToothReceiptData
                        {
                            Name = "Extraction",
                            Price = t.Extraction,
                            Tooth = t.Tooth,
                        });
                        newReceipt.Add(new ToothReceiptData
                        {
                            Name = "Crown",
                            Price = t.Crown,
                            Tooth = t.Tooth,
                        });
                        newReceipt.Add(new ToothReceiptData
                        {
                            Name = "Implant",
                            Price = t.Implant,
                            Tooth = t.Tooth,
                        });
                        newReceipt.Add(new ToothReceiptData
                        {
                            Name = "Restoration",
                            Price = t.Restoration,
                            Tooth = t.Tooth,
                        });
                        newReceipt.Add(new ToothReceiptData
                        {
                            Name = "Scaling",
                            Price = t.Scaling,
                            Tooth = t.Tooth,
                        });
                        newReceipt.Add(new ToothReceiptData
                        {
                            Name = "Root Canal Treatment",
                            Price = t.RootCanalTreatment,
                            Tooth = t.Tooth,
                        });
                    }

                }

                if (r.WaxUp != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "Wax Up",
                        Price = r.WaxUp.TotalPrice ?? 0,
                    });

                if (r.ZirconUnit != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "Zircon Unit",
                        Price = r.ZirconUnit.TotalPrice ?? 0,
                    });
                if (r.PFM != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "PFM",
                        Price = r.PFM.TotalPrice ?? 0,
                    });
                if (r.CompositeInlay != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "Composite Inlay",
                        Price = r.CompositeInlay.TotalPrice ?? 0,
                    });
                if (r.EmaxVeneer != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "Emax Veneer",
                        Price = r.EmaxVeneer.TotalPrice ?? 0,
                    });
                if (r.MilledPMMA != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "Milled PMMA",
                        Price = r.MilledPMMA.TotalPrice ?? 0,
                    });
                if (r.PrintedPMMA != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "Printed PMMA",
                        Price = r.PrintedPMMA.TotalPrice ?? 0,
                    });
                if (r.TiAbutment != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "Ti Abutment",
                        Price = r.TiAbutment.TotalPrice ?? 0,
                    });
                if (r.TiBar != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "Ti Bar",
                        Price = r.TiBar.TotalPrice ?? 0,
                    });
                if (r.ThreeDPrinting != null)
                    newReceipt.Add(new ToothReceiptData
                    {
                        Name = "3D Printing",
                        Price = r.ThreeDPrinting.TotalPrice ?? 0,
                    });




                r.ToothReceiptData = newReceipt.Where(x => x.Price != 0).ToList();
                var tempTotal = r.Total;
                r.Total = r.LabFees ?? 0;
                foreach (var t in r.ToothReceiptData)
                {
                    r.Total += t.Price;
                }
                if (tempTotal != r.Total)
                    Console.WriteLine($"Id = {r.Id} Old Total = {tempTotal} new Total = {r.Total}    {r.Website}");




            }

            _ciaDbContext.Receipts.UpdateRange(receipt);
            _ciaDbContext.SaveChanges();
            return Ok();
        }
        [AllowAnonymous]
        [HttpGet("MigrateToNewComplicationsSystem")]
        public async Task<IActionResult> MigrateToNewComplicationsSystem()
        {
            var defautlCOmSurgical = _ciaDbContext.DefaultSurgicalComplications.ToList();
            var comsSurgical = _ciaDbContext.ComplicationsAfterSurgery.ToList();
            foreach (var com in comsSurgical)
            {
                try
                {
                    com.DefaultSurgicalComplicationsId = defautlCOmSurgical.First(x => x.Name.ToLower().Replace(" ", "") == com.Name.ToLower().Replace(" ", "")).Id;

                }
                catch (Exception e)
                {
                    Console.WriteLine("");
                }
            }
            _ciaDbContext.ComplicationsAfterSurgery.UpdateRange(comsSurgical);
            _ciaDbContext.SaveChanges();

            var defautlCOmProsth = _ciaDbContext.DefaultProstheticComplications.ToList();
            var comsProsthetci = _ciaDbContext.ComplicationsAfterProsthesis.ToList();
            foreach (var com in comsProsthetci)
            {
                try
                {
                    com.DefaultProstheticComplicationsId = defautlCOmProsth.First(x => x.Name.ToLower().Replace(" ", "") == com.Name.ToLower().Replace(" ", "")).Id;

                }
                catch (Exception e)
                {
                    Console.WriteLine("");
                }
            }
            _ciaDbContext.ComplicationsAfterProsthesis.UpdateRange(comsProsthetci);
            _ciaDbContext.SaveChanges();

            return Ok(await _ciaDbContext.ComplicationsAfterProsthesis.Include(x => x.DefaultProstheticComplication).ToListAsync());
        }

        [AllowAnonymous]
        [HttpGet("MigrateToNewProstheticSystem")]
        public async Task<IActionResult> MigrateToNewProstheticSystem()
        {
            //_ciaDbContext.FinalItems.Add(new FinalItemModel { Id = 1, Name = "Healing Collar" });
            //_ciaDbContext.FinalItems.Add(new FinalItemModel { Id = 2, Name = "Impression" });
            //_ciaDbContext.FinalItems.Add(new FinalItemModel { Id = 3, Name = "Try In" });
            //_ciaDbContext.FinalItems.Add(new FinalItemModel { Id = 4, Name = "Delivery" });
            //_ciaDbContext.SaveChanges();
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 1, FinaltemId = 1, Name = "With Customization" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 2, FinaltemId = 1, Name = "Without Customization" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 3, FinaltemId = 2, Name = "Scan by scan body" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 4, FinaltemId = 2, Name = "Scan by abutment" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 5, FinaltemId = 2, Name = "Physical Impression open tray" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 6, FinaltemId = 2, Name = "Physical Impression closed tray" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 7, FinaltemId = 3, Name = "Try in abutment + scan abutment" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 8, FinaltemId = 3, Name = "Try In PMMA" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 9, FinaltemId = 3, Name = "Try In On Scan Abutment PMMA" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 10, FinaltemId = 3, Name = "Physical Impression Closed Tray" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 11, FinaltemId = 4, Name = "Done" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 12, FinaltemId = 4, Name = "Redesign" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 13, FinaltemId = 4, Name = "Reimpression" });
            //_ciaDbContext.FinalStatusItems.Add(new FinalStatusItemModel { Id = 14, FinaltemId = 4, Name = "ReTry in" });
            //_ciaDbContext.SaveChanges();
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 1, FinalItemId = 2, Name = "Custom Abutment" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 2, FinalItemId = 2, Name = "Try In" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 3, FinalItemId = 2, Name = "Delivery" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 4, FinalItemId = 3, Name = "Delivery" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 5, FinalItemId = 3, Name = "Try In PMMA" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 6, FinalItemId = 3, Name = "Reimpression" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 7, FinalItemId = 4, Name = "Done" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 8, FinalItemId = 4, Name = "Redesign" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 9, FinalItemId = 4, Name = "Reimpression" });
            //_ciaDbContext.FinalNextVisitItems.Add(new FinalNextVisitItemModel { Id = 10, FinalItemId = 4, Name = "ReTry in" });
            //_ciaDbContext.SaveChanges();


            //_ciaDbContext.DiagnosticItems.Add(
            //    new DiagnosticItemModel
            //    {
            //        Id = 1,
            //        Name = "Diagnostic Impression"
            //    }
            //    );
            //_ciaDbContext.DiagnosticItems.Add(
            //    new DiagnosticItemModel
            //    {
            //        Id = 2,
            //        Name = "Bite"
            //    }
            //    );
            //_ciaDbContext.DiagnosticItems.Add(
            // new DiagnosticItemModel
            // {
            //     Id = 3,
            //     Name = "Scan Appliance"
            // }
            // );

            //_ciaDbContext.SaveChanges();

            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 1,
            //    DiagnosticItemId = 1,
            //    Name = "Physical"
            //});
            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 2,
            //    DiagnosticItemId = 1,
            //    Name = "Digital"
            //});
            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 3,
            //    DiagnosticItemId = 1,
            //    Name = "Secondary Impression"
            //});
            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 4,
            //    DiagnosticItemId = 1,
            //    Name = "Direct Impression"
            //});

            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 5,
            //    DiagnosticItemId = 2,
            //    Name = "Done"
            //});
            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 6,
            //    DiagnosticItemId = 2,
            //    Name = "Needs Rescan"
            //});
            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 7,
            //    DiagnosticItemId = 2,
            //    Name = "Needs Reimpression"
            //});



            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 8,
            //    DiagnosticItemId = 3,
            //    Name = "Done"
            //});
            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 9,
            //    DiagnosticItemId = 3,
            //    Name = "Needs Reimpression"
            //});
            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 10,
            //    DiagnosticItemId = 3,
            //    Name = "Needs Rebite"
            //});
            //_ciaDbContext.DiagnosticStatusItems.Add(new DiagnosticStatusItemModel
            //{
            //    Id = 11,
            //    DiagnosticItemId = 3,
            //    Name = "Needs Rescan"
            //});
            //_ciaDbContext.DiagnosticNextVisitItems.Add(new DiagnosticNextVisitItemModel
            //{
            //    DiagnosticItemId = 2,
            //    Name = "Scan Appliance"
            //});

            //_ciaDbContext.DiagnosticNextVisitItems.Add(new DiagnosticNextVisitItemModel
            //{
            //    DiagnosticItemId = 2,
            //    Name = "Reimpression"
            //});

            //_ciaDbContext.DiagnosticNextVisitItems.Add(new DiagnosticNextVisitItemModel
            //{
            //    DiagnosticItemId = 2,
            //    Name = "Rebite"
            //});
            //_ciaDbContext.DiagnosticNextVisitItems.Add(new DiagnosticNextVisitItemModel
            //{
            //    DiagnosticItemId = 1,
            //    Name = "Ready For Implant"
            //});
            //_ciaDbContext.DiagnosticNextVisitItems.Add(new DiagnosticNextVisitItemModel
            //{
            //    DiagnosticItemId = 1,
            //    Name = "Bite"
            //});
            //_ciaDbContext.DiagnosticNextVisitItems.Add(new DiagnosticNextVisitItemModel
            //{
            //    DiagnosticItemId = 1,
            //    Name = "Needs New Impression"
            //});
            //_ciaDbContext.DiagnosticNextVisitItems.Add(new DiagnosticNextVisitItemModel
            //{
            //    DiagnosticItemId = 1,
            //    Name = "Needs Scan PPT"
            //});
            //_ciaDbContext.SaveChanges();


            var diagnosticItems = await _ciaDbContext.DiagnosticItems.ToListAsync();
            var diagnosticStatus = await _ciaDbContext.DiagnosticStatusItems.ToListAsync();
            var diagnosticNextVisit = await _ciaDbContext.DiagnosticNextVisitItems.ToListAsync();


            var fullArchItems = await _ciaDbContext.FinalItems.ToListAsync();
            var finalStatus = await _ciaDbContext.FinalStatusItems.ToListAsync();
            var finalNextVisit = await _ciaDbContext.FinalNextVisitItems.ToListAsync();


            var diagnosticImpression = await _ciaDbContext.ProstheticTreatments_DiagnosticImpression.ToListAsync();
            var bite = await _ciaDbContext.ProstheticTreatments_Bite.ToListAsync();
            var scanAppliance = await _ciaDbContext.ProstheticTreatments_ScanAppliance.ToListAsync();

            var deliveries = await _ciaDbContext.FinalProsthesisDeliveries.ToListAsync();
            var heallingColalrs = await _ciaDbContext.FinalProsthesisHealingCollars.ToListAsync();
            var tryIns = await _ciaDbContext.FinalProsthesisTryIns.ToListAsync();
            var finalImpresion = await _ciaDbContext.FinalProsthesisImpressions.ToListAsync();

            foreach (var item in diagnosticImpression)
            {
                var statusOld = item.Diagnostic?.ToString();
                var nextOld = item.NextStep?.ToString();
                var toAdd = new DiagnosticStepModel
                {
                    Date = item.Date,
                    DiagnosticItemId = 1,
                    NeedsRemake = item.NeedsRemake,
                    Scanned = item.Scanned,
                    OperatorId = item.OperatorId,
                    DiagnosticStatusItemId = item.Diagnostic == null ? null : diagnosticStatus.First(x => x.DiagnosticItemId == 1 && x.Name.ToLower().Replace(" ", "") == Enum.GetName<EnumProstheticDiagnosticDiagnosticImpressionDiagnostic>((EnumProstheticDiagnosticDiagnosticImpressionDiagnostic)item.Diagnostic!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    DiagnosticNextVisitItemId = item.NextStep == null ? null : diagnosticNextVisit.First(x => x.DiagnosticItemId == 1 && x.Name.ToLower().Replace(" ", "") == Enum.GetName<EnumProstheticDiagnosticDiagnosticImpressionNextStep>((EnumProstheticDiagnosticDiagnosticImpressionNextStep)item.NextStep!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    PatientId = item.PatientId,

                };
                var statusNew = diagnosticStatus.FirstOrDefault(x => x.Id == toAdd.DiagnosticStatusItemId)?.Name;
                var nextNew = diagnosticNextVisit.FirstOrDefault(x => x.Id == toAdd.DiagnosticNextVisitItemId)?.Name;
                if (statusOld != null && statusNew.Replace(" ", "").Replace("+", "").ToLower() != statusOld.Replace("_", "").Replace("+", "").Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Status {statusOld} {statusNew}==============================================================");

                }
                else if (nextOld != null && nextOld.Replace(" ", "").Replace("_", "").ToLower() != nextNew.Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Next : {nextOld} {nextNew}==============================================================");

                }
                else
                {
                    Console.WriteLine($"{statusOld} {statusNew} {nextOld} {nextNew}");
                }
                _ciaDbContext.DiagnosticSteps.Add(toAdd);
            }
            foreach (var item in bite)
            {
                var statusOld = item.Diagnostic?.ToString();
                var nextOld = item.NextStep?.ToString();

                try
                {
                    var toAdd = new DiagnosticStepModel
                    {
                        Date = item.Date,
                        DiagnosticItemId = 2,
                        NeedsRemake = item.NeedsRemake,
                        Scanned = item.Scanned,
                        OperatorId = item.OperatorId,
                        DiagnosticStatusItemId = item.Diagnostic == null ? null : diagnosticStatus.First(x => x.DiagnosticItemId == 2 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumProstheticDiagnosticBiteDiagnostic)item.Diagnostic!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                        DiagnosticNextVisitItemId = item.NextStep == null ? null : diagnosticNextVisit.First(x => x.DiagnosticItemId == 2 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumProstheticDiagnosticBiteNextStep)item.NextStep!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                        PatientId = item.PatientId,

                    };
                    var statusNew = diagnosticStatus.FirstOrDefault(x => x.Id == toAdd.DiagnosticStatusItemId)?.Name;
                    var nextNew = diagnosticNextVisit.FirstOrDefault(x => x.Id == toAdd.DiagnosticNextVisitItemId)?.Name;
                    if (statusOld != null && statusNew.Replace(" ", "").Replace("+", "").ToLower() != statusOld.Replace("_", "").Replace("+", "").Replace(" ", "").ToLower())
                    {
                        Console.WriteLine($"Status {statusOld} {statusNew}==============================================================");

                    }
                    else if (nextOld != null && nextOld.Replace(" ", "").Replace("_", "").ToLower() != nextNew.Replace(" ", "").ToLower())
                    {
                        Console.WriteLine($"Next : {nextOld} {nextNew}==============================================================");

                    }
                    else
                    {
                        Console.WriteLine($"{statusOld} {statusNew} {nextOld} {nextNew}");
                    }
                    _ciaDbContext.DiagnosticSteps.Add(toAdd);
                }
                catch (Exception e)
                {
                    Console.WriteLine($"{statusOld} {nextOld}");
                }
            }
            foreach (var item in scanAppliance)
            {
                var statusOld = item.Diagnostic?.ToString();

                try
                {
                    var toAdd = new DiagnosticStepModel
                    {
                        Date = item.Date,
                        DiagnosticItemId = 3,
                        NeedsRemake = item.NeedsRemake,
                        Scanned = item.Scanned,
                        OperatorId = item.OperatorId,
                        DiagnosticStatusItemId = item.Diagnostic == null ? null : diagnosticStatus.First(x => x.DiagnosticItemId == 3 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumProstheticDiagnosticScanApplianceDiagnostic)item.Diagnostic!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                        PatientId = item.PatientId,

                    };
                    var statusNew = diagnosticStatus.FirstOrDefault(x => x.Id == toAdd.DiagnosticStatusItemId)?.Name;
                    if (statusOld != null && statusNew.Replace(" ", "").Replace("+", "").ToLower() != statusOld.Replace("_", "").Replace("+", "").Replace(" ", "").ToLower())
                    {
                        Console.WriteLine($"Status {statusOld} {statusNew}==============================================================");

                    }

                    else
                    {
                        Console.WriteLine($"{statusOld} {statusNew} ");
                    }
                    _ciaDbContext.DiagnosticSteps.Add(toAdd);
                }
                catch (Exception e)
                {
                    Console.WriteLine($"{statusOld}");
                }
            }

            foreach (var item in finalImpresion)
            {
                var statusOld = item.FinalProthesisImpressionStatus?.ToString();
                var nextOld = item.FinalProthesisImpressionNextVisit?.ToString();
                var toAdd = new FinalStepModel
                {
                    Date = item.Date,
                    FinalItemId = 2,
                    OperatorId = item.OperatorId,
                    FinalStatusItemId = item.FinalProthesisImpressionStatus == null ? null : finalStatus.First(x => x.FinaltemId == 2 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumFinalProthesisImpressionStatus)item.FinalProthesisImpressionStatus!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    FinalNextVisitItemId = item.FinalProthesisImpressionNextVisit == null ? null : finalNextVisit.First(x => x.FinalItemId == 2 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumFinalProthesisImpressionNextVisit)item.FinalProthesisImpressionNextVisit!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    PatientId = item.PatientId,
                    Teeth = item.FinalProthesisTeeth,
                    ScrewRetained = item.FinalProthesisTeeth == null,
                    FullArchLower = item.FinalProthesisTeeth == null,
                    FullArchUpper = item.FinalProthesisTeeth == null,
                    Single = (item.FinalProthesisTeeth?.Count ?? 0) == 1,
                    Bridge = (item.FinalProthesisTeeth?.Count ?? 0) > 1,

                };
                var statusNew = finalStatus.FirstOrDefault(x => x.Id == toAdd.FinalStatusItemId)?.Name;
                var nextNew = finalNextVisit.FirstOrDefault(x => x.Id == toAdd.FinalNextVisitItemId)?.Name;
                if (statusOld != null && statusNew.Replace(" ", "").Replace("+", "").ToLower() != statusOld.Replace("_", "").Replace("+", "").Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Status {statusOld} {statusNew}==============================================================");

                }
                else if (nextOld != null && nextOld.Replace(" ", "").Replace("_", "").ToLower() != nextNew.Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Next : {nextOld} {nextNew}==============================================================");

                }
                else
                {
                    Console.WriteLine($"{statusOld} {statusNew} {nextOld} {nextNew}");
                }
                _ciaDbContext.FinalSteps.Add(toAdd);



            }

            foreach (var item in heallingColalrs)
            {
                var statusOld = item.FinalProthesisHealingCollarStatus?.ToString();
                var nextOld = item.FinalProthesisHealingCollarNextVisit?.ToString();

                var toAdd = new FinalStepModel
                {
                    Date = item.Date,
                    FinalItemId = 1,
                    OperatorId = item.OperatorId,
                    FinalStatusItemId = item.FinalProthesisHealingCollarStatus == null ? null : finalStatus.First(x => x.FinaltemId == 1 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumFinalProthesisHealingCollarStatus)item.FinalProthesisHealingCollarStatus!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    FinalNextVisitItemId = item.FinalProthesisHealingCollarNextVisit == null ? null : finalNextVisit.First(x => x.FinalItemId == 1 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumFinalProthesisHealingCollarNextVisit)item.FinalProthesisHealingCollarNextVisit!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    PatientId = item.PatientId,
                    Teeth = item.FinalProthesisTeeth,
                    ScrewRetained = item.FinalProthesisTeeth == null,
                    FullArchLower = item.FinalProthesisTeeth == null,
                    FullArchUpper = item.FinalProthesisTeeth == null,
                    Single = (item.FinalProthesisTeeth?.Count ?? 0) == 1,
                    Bridge = (item.FinalProthesisTeeth?.Count ?? 0) > 1,

                };
                var statusNew = finalStatus.FirstOrDefault(x => x.Id == toAdd.FinalStatusItemId)?.Name;
                var nextNew = finalNextVisit.FirstOrDefault(x => x.Id == toAdd.FinalNextVisitItemId)?.Name;
                if (statusOld != null && statusNew.Replace(" ", "").Replace("+", "").ToLower() != statusOld.Replace("_", "").Replace("+", "").Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Status {statusOld} {statusNew}==============================================================");

                }
                else if (nextOld != null && nextOld.Replace(" ", "").Replace("_", "").ToLower() != nextNew.Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Next : {nextOld} {nextNew}==============================================================");

                }
                else
                {
                    Console.WriteLine($"{statusOld} {statusNew} {nextOld} {nextNew}");
                }
                _ciaDbContext.FinalSteps.Add(toAdd);


            }

            foreach (var item in tryIns)
            {

                var statusOld = item.FinalProthesisTryInStatus?.ToString();
                var nextOld = item.FinalProthesisTryInNextVisit?.ToString();
                var newTryInCheckList = new TryInCheckListModel()
                {
                    Teeth = item.FinalProthesisTeeth,
                    BuccalContour = item.BuccalContour,
                    PatientId = item.PatientId,
                    Satisfied = item.Satisfied,
                    NonSatisfiedNewScan = item.NonSatisfiedNewScan,
                    NonSatisfiedDescription = item.NonSatisfiedDescription,
                    Seating = item.Seating,
                    NonSeatingType = item.NonSeatingType,
                    NonSeatingOtherNotes = item.NonSeatingOtherNotes,
                    MesialContacts = item.MesialContacts,
                    DistalContacts = item.DistalContacts,
                    Occlusion = item.Occlusion,
                    Passive = item.Passive,
                    Retention = item.Retention,
                    OcclusionNotes = item.OcclusionNotes,
                    OcclusalPlanAndMidline = item.OcclusalPlanAndMidline,
                    CentricRelation = item.CentricRelation,
                    VerticalDimension = item.VerticalDimension,
                    LipSupport = item.LipSupport,
                    SizeAndShapeOfTeeth = item.SizeAndShapeOfTeeth,
                    Canting = item.Canting,
                    FrontalSmilingAndLateralPhotos = item.FrontalSmilingAndLateralPhotos,
                    Evaluation = item.Evaluation,
                    ExplainWhy = item.ExplainWhy,
                };
                _ciaDbContext.TryInCheckLists.Add(newTryInCheckList);
                _ciaDbContext.SaveChanges();

                var toAdd = new FinalStepModel
                {
                    Date = item.Date,
                    FinalItemId = 3,
                    OperatorId = item.OperatorId,
                    FinalStatusItemId = item.FinalProthesisTryInStatus == null ? null : finalStatus.First(x => x.FinaltemId == 3 && x.Name.ToLower().Replace(" ", "").Replace("+", "") == Enum.GetName((EnumFinalProthesisTryInStatus)item.FinalProthesisTryInStatus!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    FinalNextVisitItemId = item.FinalProthesisTryInNextVisit == null ? null : finalNextVisit.First(x => x.FinalItemId == 3 && x.Name.ToLower().Replace(" ", "").Replace("+", "") == Enum.GetName((EnumFinalProthesisTryInNextVisit)item.FinalProthesisTryInNextVisit!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    PatientId = item.PatientId,
                    Teeth = item.FinalProthesisTeeth,
                    FullArchLower = item.FinalProthesisTeeth == null,
                    FullArchUpper = item.FinalProthesisTeeth == null,
                    ScrewRetained = item.FinalProthesisTeeth == null,
                    Single = (item.FinalProthesisTeeth?.Count ?? 0) == 1,
                    Bridge = (item.FinalProthesisTeeth?.Count ?? 0) > 1,
                    TryInCheckListId = newTryInCheckList.Id,

                };
                var statusNew = finalStatus.FirstOrDefault(x => x.Id == toAdd.FinalStatusItemId)?.Name;
                var nextNew = finalNextVisit.FirstOrDefault(x => x.Id == toAdd.FinalNextVisitItemId)?.Name;
                if (statusOld != null && statusNew.Replace(" ", "").Replace("+", "").ToLower() != statusOld.Replace("_", "").Replace("+", "").Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Status {statusOld} {statusNew}==============================================================");

                }
                else if (nextOld != null && nextOld.Replace(" ", "").Replace("_", "").ToLower() != nextNew.Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Next : {nextOld} {nextNew}==============================================================");

                }
                else
                {
                    Console.WriteLine($"{statusOld} {statusNew} {nextOld} {nextNew}");
                }
                _ciaDbContext.FinalSteps.Add(toAdd);


            }

            foreach (var item in deliveries)
            {
                var statusOld = item.FinalProthesisDeliveryStatus?.ToString();
                var nextOld = item.FinalProthesisDeliveryNextVisit?.ToString();

                var toAdd = new FinalStepModel
                {
                    Date = item.Date,
                    FinalItemId = 4,
                    OperatorId = item.OperatorId,
                    FinalStatusItemId = item.FinalProthesisDeliveryStatus == null ? null : finalStatus.First(x => x.FinaltemId == 4 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumFinalProthesisDeliveryStatus)item.FinalProthesisDeliveryStatus!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    FinalNextVisitItemId = item.FinalProthesisDeliveryNextVisit == null ? null : finalNextVisit.First(x => x.FinalItemId == 4 && x.Name.ToLower().Replace(" ", "") == Enum.GetName((EnumFinalProthesisDeliveryNextVisit)item.FinalProthesisDeliveryNextVisit!)!.ToLower().Replace(" ", "").Replace("_", "")).Id,
                    PatientId = item.PatientId,
                    Teeth = item.FinalProthesisTeeth,
                    ScrewRetained = item.FinalProthesisTeeth == null,
                    FullArchLower = item.FinalProthesisTeeth == null,
                    FullArchUpper = item.FinalProthesisTeeth == null,
                    Single = (item.FinalProthesisTeeth?.Count ?? 0) == 1,
                    Bridge = (item.FinalProthesisTeeth?.Count ?? 0) > 1,

                };
                var statusNew = finalStatus.FirstOrDefault(x => x.Id == toAdd.FinalStatusItemId)?.Name;
                var nextNew = finalNextVisit.FirstOrDefault(x => x.Id == toAdd.FinalNextVisitItemId)?.Name;
                if (statusOld != null && statusNew.Replace(" ", "").Replace("+", "").ToLower() != statusOld.Replace("_", "").Replace("+", "").Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Status {statusOld} {statusNew}==============================================================");

                }
                else if (nextOld != null && nextOld.Replace(" ", "").Replace("_", "").ToLower() != nextNew.Replace(" ", "").ToLower())
                {
                    Console.WriteLine($"Next : {nextOld} {nextNew}==============================================================");

                }
                else
                {
                    Console.WriteLine($"{statusOld} {statusNew} {nextOld} {nextNew}");
                }


                _ciaDbContext.FinalSteps.Add(toAdd);

            }

            _ciaDbContext.SaveChanges();
            var resultDiagnostic = await _ciaDbContext.DiagnosticSteps
                .Include(x => x.DiagnosticItem)
                .Include(x => x.DiagnosticStatusItem)
                .Include(x => x.DiagnosticNextVisitItem)
                .ToListAsync();
            var resultFinal = await _ciaDbContext.FinalSteps
                .Include(x => x.FinalItem)
                .Include(x => x.FinalStatusItem)
                .Include(x => x.FinalNextVisitItem)
                .ToListAsync();

            foreach (var r in resultDiagnostic)
            {
                Console.WriteLine($"{r.DiagnosticItem?.Name} {r.DiagnosticStatusItem?.Name} {r.DiagnosticNextVisitItem?.Name}");
            }
            foreach (var r in resultFinal)
            {
                Console.WriteLine($"{r.FinalItem?.Name} {r.FinalStatusItem?.Name} {r.FinalNextVisitItem?.Name}");
            }
            return Ok();
        }


        [AllowAnonymous]
        [HttpGet("DeletePros")]
        public async Task<IActionResult> DeletePros()
        {
            var result = await _ciaDbContext.FinalSteps.ToListAsync();
            var diresult = await _ciaDbContext.DiagnosticSteps.ToListAsync();
            _ciaDbContext.FinalSteps.RemoveRange(result);
            _ciaDbContext.DiagnosticSteps.RemoveRange(diresult);
            _ciaDbContext.SaveChanges();
            return Ok();
        }


        //[AllowAnonymous]
        //[HttpGet("MigrateToNewTreatment")]

        //public async Task<ActionResult> MigrateToNewTreatment()
        //{


        //    var treatmentPlanItems = await _ciaDbContext.TreatmentPlansSubModels.
        //            Include(x => x.Scaling).
        //            Include(x => x.Crown).
        //            Include(x => x.RootCanalTreatment).
        //            Include(x => x.Restoration).
        //            Include(x => x.Pontic).
        //            Include(x => x.Extraction).
        //            Include(x => x.SimpleImplant).
        //            Include(x => x.ImmediateImplant).
        //            Include(x => x.ExpansionWithImplant).
        //            Include(x => x.SplittingWithImplant).
        //            Include(x => x.GBRWithImplant).
        //            Include(x => x.OpenSinusWithImplant).
        //            Include(x => x.ClosedSinusWithImplant).
        //            Include(x => x.GuidedImplant).
        //            Include(x => x.ExpansionWithoutImplant).
        //            Include(x => x.SplittingWithoutImplant).
        //            Include(x => x.GBRWithoutImplant).
        //            Include(x => x.OpenSinusWithoutImplant).
        //            Include(x => x.ClosedSinusWithoutImplant).
        //            OrderBy(x => x.Tooth).ToListAsync();

        //    foreach (var item in treatmentPlanItems)
        //    {
        //        if (item.Crown != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Crown",
        //                AssignedToID = item.Crown.AssignedToID,
        //                Date = item.Crown.Date,
        //                DoneByAssistantID = item.Crown.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.Crown.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.Crown.DoneByCandidateID,
        //                DoneBySupervisorID = item.Crown.DoneBySupervisorID,
        //                ImplantID = item.Crown.ImplantID,
        //                ImplantIDRequest = item.Crown.ImplantIDRequest,
        //                PlanPrice = item.Crown.PlanPrice,
        //                RequestChangeId = item.Crown.RequestChangeId,
        //                Status = item.Crown.Status,
        //                Value = item.Crown.Value,
        //                Website = item.Crown.Website,
        //            });
        //        }
        //        // Root Canal Treatment
        //        if (item.RootCanalTreatment != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Root Canal Treatment",
        //                AssignedToID = item.RootCanalTreatment.AssignedToID,
        //                Date = item.RootCanalTreatment.Date,
        //                DoneByAssistantID = item.RootCanalTreatment.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.RootCanalTreatment.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.RootCanalTreatment.DoneByCandidateID,
        //                DoneBySupervisorID = item.RootCanalTreatment.DoneBySupervisorID,
        //                ImplantID = item.RootCanalTreatment.ImplantID,
        //                ImplantIDRequest = item.RootCanalTreatment.ImplantIDRequest,
        //                PlanPrice = item.RootCanalTreatment.PlanPrice,
        //                RequestChangeId = item.RootCanalTreatment.RequestChangeId,
        //                Status = item.RootCanalTreatment.Status,
        //                Value = item.RootCanalTreatment.Value,
        //                Website = item.RootCanalTreatment.Website,
        //            });

        //        }
        //        // Restoration
        //        if (item.Restoration != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Restoration",
        //                AssignedToID = item.Restoration.AssignedToID,
        //                Date = item.Restoration.Date,
        //                DoneByAssistantID = item.Restoration.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.Restoration.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.Restoration.DoneByCandidateID,
        //                DoneBySupervisorID = item.Restoration.DoneBySupervisorID,
        //                ImplantID = item.Restoration.ImplantID,
        //                ImplantIDRequest = item.Restoration.ImplantIDRequest,
        //                PlanPrice = item.Restoration.PlanPrice,
        //                RequestChangeId = item.Restoration.RequestChangeId,
        //                Status = item.Restoration.Status,
        //                Value = item.Restoration.Value,
        //                Website = item.Restoration.Website,
        //            });
        //        }

        //        // Pontic
        //        if (item.Pontic != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Pontic",
        //                AssignedToID = item.Pontic.AssignedToID,
        //                Date = item.Pontic.Date,
        //                DoneByAssistantID = item.Pontic.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.Pontic.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.Pontic.DoneByCandidateID,
        //                DoneBySupervisorID = item.Pontic.DoneBySupervisorID,
        //                ImplantID = item.Pontic.ImplantID,
        //                ImplantIDRequest = item.Pontic.ImplantIDRequest,
        //                PlanPrice = item.Pontic.PlanPrice,
        //                RequestChangeId = item.Pontic.RequestChangeId,
        //                Status = item.Pontic.Status,
        //                Value = item.Pontic.Value,
        //                Website = item.Pontic.Website,
        //            });
        //        }

        //        // Extraction
        //        if (item.Extraction != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Extraction",
        //                AssignedToID = item.Extraction.AssignedToID,
        //                Date = item.Extraction.Date,
        //                DoneByAssistantID = item.Extraction.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.Extraction.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.Extraction.DoneByCandidateID,
        //                DoneBySupervisorID = item.Extraction.DoneBySupervisorID,
        //                ImplantID = item.Extraction.ImplantID,
        //                ImplantIDRequest = item.Extraction.ImplantIDRequest,
        //                PlanPrice = item.Extraction.PlanPrice,
        //                RequestChangeId = item.Extraction.RequestChangeId,
        //                Status = item.Extraction.Status,
        //                Value = item.Extraction.Value,
        //                Website = item.Extraction.Website,
        //            });
        //        }

        //        // Simple Implant
        //        if (item.SimpleImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Simple Implant",
        //                AssignedToID = item.SimpleImplant.AssignedToID,
        //                Date = item.SimpleImplant.Date,
        //                DoneByAssistantID = item.SimpleImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.SimpleImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.SimpleImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.SimpleImplant.DoneBySupervisorID,
        //                ImplantID = item.SimpleImplant.ImplantID,
        //                ImplantIDRequest = item.SimpleImplant.ImplantIDRequest,
        //                PlanPrice = item.SimpleImplant.PlanPrice,
        //                RequestChangeId = item.SimpleImplant.RequestChangeId,
        //                Status = item.SimpleImplant.Status,
        //                Value = item.SimpleImplant.Value,
        //                Website = item.SimpleImplant.Website,
        //            });
        //        }
        //        // Immediate Implant
        //        if (item.ImmediateImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Immediate Implant",
        //                AssignedToID = item.ImmediateImplant.AssignedToID,
        //                Date = item.ImmediateImplant.Date,
        //                DoneByAssistantID = item.ImmediateImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.ImmediateImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.ImmediateImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.ImmediateImplant.DoneBySupervisorID,
        //                ImplantID = item.ImmediateImplant.ImplantID,
        //                ImplantIDRequest = item.ImmediateImplant.ImplantIDRequest,
        //                PlanPrice = item.ImmediateImplant.PlanPrice,
        //                RequestChangeId = item.ImmediateImplant.RequestChangeId,
        //                Status = item.ImmediateImplant.Status,
        //                Value = item.ImmediateImplant.Value,
        //                Website = item.ImmediateImplant.Website,
        //            });
        //        }

        //        // Expansion with Implant
        //        if (item.ExpansionWithImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Expansion with Implant",
        //                AssignedToID = item.ExpansionWithImplant.AssignedToID,
        //                Date = item.ExpansionWithImplant.Date,
        //                DoneByAssistantID = item.ExpansionWithImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.ExpansionWithImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.ExpansionWithImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.ExpansionWithImplant.DoneBySupervisorID,
        //                ImplantID = item.ExpansionWithImplant.ImplantID,
        //                ImplantIDRequest = item.ExpansionWithImplant.ImplantIDRequest,
        //                PlanPrice = item.ExpansionWithImplant.PlanPrice,
        //                RequestChangeId = item.ExpansionWithImplant.RequestChangeId,
        //                Status = item.ExpansionWithImplant.Status,
        //                Value = item.ExpansionWithImplant.Value,
        //                Website = item.ExpansionWithImplant.Website,
        //            });
        //        }

        //        // Splitting with Implant
        //        if (item.SplittingWithImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Splitting with Implant",
        //                AssignedToID = item.SplittingWithImplant.AssignedToID,
        //                Date = item.SplittingWithImplant.Date,
        //                DoneByAssistantID = item.SplittingWithImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.SplittingWithImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.SplittingWithImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.SplittingWithImplant.DoneBySupervisorID,
        //                ImplantID = item.SplittingWithImplant.ImplantID,
        //                ImplantIDRequest = item.SplittingWithImplant.ImplantIDRequest,
        //                PlanPrice = item.SplittingWithImplant.PlanPrice,
        //                RequestChangeId = item.SplittingWithImplant.RequestChangeId,
        //                Status = item.SplittingWithImplant.Status,
        //                Value = item.SplittingWithImplant.Value,
        //                Website = item.SplittingWithImplant.Website,
        //            });
        //        }

        //        // GBR with Implant
        //        if (item.GBRWithImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "GBR with Implant",
        //                AssignedToID = item.GBRWithImplant.AssignedToID,
        //                Date = item.GBRWithImplant.Date,
        //                DoneByAssistantID = item.GBRWithImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.GBRWithImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.GBRWithImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.GBRWithImplant.DoneBySupervisorID,
        //                ImplantID = item.GBRWithImplant.ImplantID,
        //                ImplantIDRequest = item.GBRWithImplant.ImplantIDRequest,
        //                PlanPrice = item.GBRWithImplant.PlanPrice,
        //                RequestChangeId = item.GBRWithImplant.RequestChangeId,
        //                Status = item.GBRWithImplant.Status,
        //                Value = item.GBRWithImplant.Value,
        //                Website = item.GBRWithImplant.Website,
        //            });
        //        }

        //        // Open Sinus with Implant
        //        if (item.OpenSinusWithImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Open Sinus with Implant",
        //                AssignedToID = item.OpenSinusWithImplant.AssignedToID,
        //                Date = item.OpenSinusWithImplant.Date,
        //                DoneByAssistantID = item.OpenSinusWithImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.OpenSinusWithImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.OpenSinusWithImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.OpenSinusWithImplant.DoneBySupervisorID,
        //                ImplantID = item.OpenSinusWithImplant.ImplantID,
        //                ImplantIDRequest = item.OpenSinusWithImplant.ImplantIDRequest,
        //                PlanPrice = item.OpenSinusWithImplant.PlanPrice,
        //                RequestChangeId = item.OpenSinusWithImplant.RequestChangeId,
        //                Status = item.OpenSinusWithImplant.Status,
        //                Value = item.OpenSinusWithImplant.Value,
        //                Website = item.OpenSinusWithImplant.Website,
        //            });
        //        }

        //        // Closed Sinus with Implant
        //        if (item.ClosedSinusWithImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Closed Sinus with Implant",
        //                AssignedToID = item.ClosedSinusWithImplant.AssignedToID,
        //                Date = item.ClosedSinusWithImplant.Date,
        //                DoneByAssistantID = item.ClosedSinusWithImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.ClosedSinusWithImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.ClosedSinusWithImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.ClosedSinusWithImplant.DoneBySupervisorID,
        //                ImplantID = item.ClosedSinusWithImplant.ImplantID,
        //                ImplantIDRequest = item.ClosedSinusWithImplant.ImplantIDRequest,
        //                PlanPrice = item.ClosedSinusWithImplant.PlanPrice,
        //                RequestChangeId = item.ClosedSinusWithImplant.RequestChangeId,
        //                Status = item.ClosedSinusWithImplant.Status,
        //                Value = item.ClosedSinusWithImplant.Value,
        //                Website = item.ClosedSinusWithImplant.Website,
        //            });
        //        }

        //        // Guided Implant
        //        if (item.GuidedImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Guided Implant",
        //                AssignedToID = item.GuidedImplant.AssignedToID,
        //                Date = item.GuidedImplant.Date,
        //                DoneByAssistantID = item.GuidedImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.GuidedImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.GuidedImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.GuidedImplant.DoneBySupervisorID,
        //                ImplantID = item.GuidedImplant.ImplantID,
        //                ImplantIDRequest = item.GuidedImplant.ImplantIDRequest,
        //                PlanPrice = item.GuidedImplant.PlanPrice,
        //                RequestChangeId = item.GuidedImplant.RequestChangeId,
        //                Status = item.GuidedImplant.Status,
        //                Value = item.GuidedImplant.Value,
        //                Website = item.GuidedImplant.Website,
        //            });
        //        }

        //        // Expansion without Implant
        //        if (item.ExpansionWithoutImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Expansion without Implant",
        //                AssignedToID = item.ExpansionWithoutImplant.AssignedToID,
        //                Date = item.ExpansionWithoutImplant.Date,
        //                DoneByAssistantID = item.ExpansionWithoutImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.ExpansionWithoutImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.ExpansionWithoutImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.ExpansionWithoutImplant.DoneBySupervisorID,
        //                ImplantID = item.ExpansionWithoutImplant.ImplantID,
        //                ImplantIDRequest = item.ExpansionWithoutImplant.ImplantIDRequest,
        //                PlanPrice = item.ExpansionWithoutImplant.PlanPrice,
        //                RequestChangeId = item.ExpansionWithoutImplant.RequestChangeId,
        //                Status = item.ExpansionWithoutImplant.Status,
        //                Value = item.ExpansionWithoutImplant.Value,
        //                Website = item.ExpansionWithoutImplant.Website,
        //            });
        //        }

        //        // Splitting without Implant
        //        if (item.SplittingWithoutImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Splitting without Implant",
        //                AssignedToID = item.SplittingWithoutImplant.AssignedToID,
        //                Date = item.SplittingWithoutImplant.Date,
        //                DoneByAssistantID = item.SplittingWithoutImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.SplittingWithoutImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.SplittingWithoutImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.SplittingWithoutImplant.DoneBySupervisorID,
        //                ImplantID = item.SplittingWithoutImplant.ImplantID,
        //                ImplantIDRequest = item.SplittingWithoutImplant.ImplantIDRequest,
        //                PlanPrice = item.SplittingWithoutImplant.PlanPrice,
        //                RequestChangeId = item.SplittingWithoutImplant.RequestChangeId,
        //                Status = item.SplittingWithoutImplant.Status,
        //                Value = item.SplittingWithoutImplant.Value,
        //                Website = item.SplittingWithoutImplant.Website,
        //            });
        //        }

        //        // GBR without Implant
        //        if (item.GBRWithoutImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "GBR without Implant",
        //                AssignedToID = item.GBRWithoutImplant.AssignedToID,
        //                Date = item.GBRWithoutImplant.Date,
        //                DoneByAssistantID = item.GBRWithoutImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.GBRWithoutImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.GBRWithoutImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.GBRWithoutImplant.DoneBySupervisorID,
        //                ImplantID = item.GBRWithoutImplant.ImplantID,
        //                ImplantIDRequest = item.GBRWithoutImplant.ImplantIDRequest,
        //                PlanPrice = item.GBRWithoutImplant.PlanPrice,
        //                RequestChangeId = item.GBRWithoutImplant.RequestChangeId,
        //                Status = item.GBRWithoutImplant.Status,
        //                Value = item.GBRWithoutImplant.Value,
        //                Website = item.GBRWithoutImplant.Website,
        //            });
        //        }


        //        // Open Sinus without Implant
        //        if (item.OpenSinusWithoutImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Open Sinus without Implant",
        //                AssignedToID = item.OpenSinusWithoutImplant.AssignedToID,
        //                Date = item.OpenSinusWithoutImplant.Date,
        //                DoneByAssistantID = item.OpenSinusWithoutImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.OpenSinusWithoutImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.OpenSinusWithoutImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.OpenSinusWithoutImplant.DoneBySupervisorID,
        //                ImplantID = item.OpenSinusWithoutImplant.ImplantID,
        //                ImplantIDRequest = item.OpenSinusWithoutImplant.ImplantIDRequest,
        //                PlanPrice = item.OpenSinusWithoutImplant.PlanPrice,
        //                RequestChangeId = item.OpenSinusWithoutImplant.RequestChangeId,
        //                Status = item.OpenSinusWithoutImplant.Status,
        //                Value = item.OpenSinusWithoutImplant.Value,
        //                Website = item.OpenSinusWithoutImplant.Website,
        //            });
        //        }

        //        // Closed Sinus without Implant
        //        if (item.ClosedSinusWithoutImplant != null)
        //        {
        //            _ciaDbContext.TreatmentDetails.Add(new TreatmentDetailsModel
        //            {
        //                PatientId = item.PatientId,
        //                Tooth = item.Tooth,
        //                Name = "Closed Sinus without Implant",
        //                AssignedToID = item.ClosedSinusWithoutImplant.AssignedToID,
        //                Date = item.ClosedSinusWithoutImplant.Date,
        //                DoneByAssistantID = item.ClosedSinusWithoutImplant.DoneByAssistantID,
        //                DoneByCandidateBatchID = item.ClosedSinusWithoutImplant.DoneByCandidateBatchID,
        //                DoneByCandidateID = item.ClosedSinusWithoutImplant.DoneByCandidateID,
        //                DoneBySupervisorID = item.ClosedSinusWithoutImplant.DoneBySupervisorID,
        //                ImplantID = item.ClosedSinusWithoutImplant.ImplantID,
        //                ImplantIDRequest = item.ClosedSinusWithoutImplant.ImplantIDRequest,
        //                PlanPrice = item.ClosedSinusWithoutImplant.PlanPrice,
        //                RequestChangeId = item.ClosedSinusWithoutImplant.RequestChangeId,
        //                Status = item.ClosedSinusWithoutImplant.Status,
        //                Value = item.ClosedSinusWithoutImplant.Value,
        //                Website = item.ClosedSinusWithoutImplant.Website,
        //            });
        //        }







        //    }

        //    _ciaDbContext.SaveChanges();


        //    return Ok();
        //}

        //[AllowAnonymous]
        //[HttpGet("MigrateToNewTreatmentItemSystem")]

        //public async Task<ActionResult> MigrateToNewTreatmentItemSystem()
        //{

        //    var prices = await _ciaDbContext.TreatmentPrices.FirstAsync();

        //    var treatments = await _ciaDbContext.TreatmentDetails.ToListAsync();


        //    _ciaDbContext.TreatmentItems.RemoveRange(_ciaDbContext.TreatmentItems.ToList());
        //    _ciaDbContext.SaveChanges();

        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id=1,
        //        Name = "Simple Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 2,
        //        Name = "Immediate Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 3,
        //        Name = "Guided Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 4,
        //        Name = "Expansion with Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 5,
        //        Name = "Splitting with Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 6,
        //        Name = "GBR with Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 7,
        //        Name = "Open Sinus with Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 8,
        //        Name = "Closed Sinus with Implant",
        //    });

        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 9,
        //        Name = "Expansion without Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 10,
        //        Name = "Splitting without Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 11,
        //        Name = "GBR without Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 12,
        //        Name = "Open Sinus without Implant",
        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 13,
        //        Name = "Closed Sinus without Implant",
        //    });

        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 14,
        //        Name = "Crown",
        //        Price = prices.Crown,
        //        PriceAction = "filled"

        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 15,
        //        Name = "Extraction",
        //        Price = prices.Extraction,
        //        PriceAction = "missed"

        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 16,
        //        Name = "Restoration",
        //        Price = prices.Restoration,
        //        PriceAction = "filled"

        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 17,
        //        Name = "Root Canal Treatment",
        //        Price = prices.RootCanalTreatment,
        //        PriceAction = "filled"

        //    });
        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 18,
        //        Name = "Pontic",

        //    });

        //    _ciaDbContext.TreatmentItems.Add(new TreatmentItemModel
        //    {
        //        Id = 19,
        //        Name = "Scaling",
        //        Price = prices.Scaling,
        //        PriceAction = "scaling"

        //    });


        //    _ciaDbContext.SaveChanges();

        //    var treatmentItems = await _ciaDbContext.TreatmentItems.ToListAsync();

        //    foreach (var treatment in treatments)
        //    {

        //            var tempTreatmentItem = treatmentItems.First(x => x.Name.ToLower() == treatment.Name.ToLower());
        //            treatment.TreatmentItemId = tempTreatmentItem.Id;


        //    }
        //    _ciaDbContext.TreatmentDetails.UpdateRange(treatments);
        //    _ciaDbContext.SaveChanges();

        //    var returnedTreatments = await _ciaDbContext.TreatmentDetails.Include(x => x.TreatmentItem).Select(x => new
        //    {
        //        x.Name,
        //        TreatmentItemName = x.TreatmentItem.Name,
        //        TreatmentItemId = x.TreatmentItemId,
        //    }).ToListAsync();

        //    return Ok(returnedTreatments);
        //}




        [HttpGet("Omar")]
        public async Task<ActionResult> Omar()
        {
            var r = await _ciaDbContext.Users.ToListAsync();

            return Ok();
        }



        [HttpGet("LoginWithToken")]
        public async Task<ActionResult> LoginWithToken()
        {

            // try login using token
            var user = await _userRepo.GetUser();
            // token incorrect
            if (user == null)
            {
                return BadRequest();
            }
            //check website access
            var roles = await _userManager.GetRolesAsync(user);
            user.Role = roles[0];
            user.Roles = roles.ToList();
            _apiResponse.Result = _mapper.Map<LoginResponseDTO>(user);
            return Ok(_apiResponse);

        }


        [HttpPost("ResetPassword")]
        public async Task<IActionResult> ResetPassword(String oldPassword, String newPassword1, String newPassword2)
        {
            var user = await _userRepo.GetUser();
            if (user == null)
            {
                return Unauthorized();
            }
            var isValid = await _userManager.CheckPasswordAsync(user, oldPassword);
            if (!isValid)
            {
                _apiResponse.ErrorMessage = "Wrong Password";
                return BadRequest(_apiResponse);
            }

            if (newPassword1 != newPassword2)
            {
                _apiResponse.ErrorMessage = "Passwords don't match";
                return BadRequest(_apiResponse);
            }
            var token = await _userManager.GeneratePasswordResetTokenAsync(user);

            var result = await _userManager.ResetPasswordAsync(user, token, newPassword1);
            if (result.Succeeded)
            {

                return Ok(_apiResponse);
            }
            else
            {
                _apiResponse.ErrorMessage = result.Errors.First().Description.ToString();
                return BadRequest(_apiResponse);
            }
        }

        [HttpPost("ResetPasswordForUser")]
        public async Task<IActionResult> ResetPasswordForUser(int id)
        {
            var user = await _ciaDbContext.Users.FirstOrDefaultAsync(x => x.IdInt == id);
            if (user == null)
            {
                return Unauthorized();
            }

            var token = await _userManager.GeneratePasswordResetTokenAsync(user);

            var result = await _userManager.ResetPasswordAsync(user, token, "Pa$$word1");
            if (result.Succeeded)
            {

                return Ok();
            }
            else
            {
                _apiResponse.ErrorMessage = result.Errors.First().Description.ToString();
                return BadRequest(_apiResponse);
            }
        }

        //        [HttpGet("SeedUsers")]
        //        public async Task<ActionResult> SeedUsers(int number)
        //        {
        //            List<String> names = new List<String>(){"Mohamed",
        //"Ahmed",
        //"Ali",
        //"Hassan",
        //"Mahmoud",
        //"Ibrahim",
        //"Salah",
        //"Mostafa",
        //"Adel",
        //"Gamal",
        //"Saad",
        //"Sayed",
        //"Samir",
        //"Omar",
        //"Hussein",
        //"Kamal",
        //"Magdy",
        //"Salem",
        //"Saleh",
        //"Ramadan",
        //"Hamdy",
        //"Elsayed",
        //"Khaled",
        //"Saeed",
        //"Ashraf",
        //"Yousef",
        //"Fathy",
        //"Said",
        //"Soliman",
        //"Mansour",
        //"Kamel",
        //"Taha",
        //"Mustafa",
        //"Abdo",
        //"Khalil",
        //"Ismail",
        //"Nabil",
        //"Samy",
        //"Ragab",
        //"Fouad",
        //"Youssef",
        //"Amin",
        //"Amer",
        //"Osman",
        //"Awad",
        //"Fawzy",
        //"Aly",
        //"Atef",
        //"Alaa",
        //"Abdullah",
        //"Essam",
        //"Eid",
        //"Hamed",
        //"Zaki",
        //"Sabry",
        //"Maher",
        //"Abdallah",
        //"Abdel",
        //"Salama",
        //"Ana",
        //"Osama",
        //"Tarek",
        //"Nasr",
        //"Alasid",
        //"Badr",
        //"Mohsen",
        //"Farouk",
        //"Saber",
        //"Emad",
        //"Reda",
        //"Helmy",
        //"Ayman",
        //"Fahmy",
        //"Ezzat",
        //"Galal",
        //"Sherif",
        //"Attia",
        //"Rahman",
        //"Fathi",
        //"Shawky",
        //"Khalifa",
        //"Radwan",
        //"Jamal",
        //"Mousa",
        //"Hegazy",
        //"Allam",
        //"Hany",
        //"Hamada",
        //"Farag",
        //"Mamdouh",
        //"Abbas",
        //"Shaaban",
        //"Hussien",
        //"Yasser",
        //"Gad",
        //"Hesham",
        //"Shehata",
        //"Elmasry",
        //"Mido",
        //"Hossam",
        //"Hosny",
        //"Emam",
        //"Sobhy",
        //"Gaber",
        //"Anwar",
        //"Moustafa",
        //"Nasser",
        //"Yehia",
        //"Gomaa",
        //"Hamza",
        //"Hafez",
        //"Rashad",
        //"Mokhtar",
        //"ElMisri",
        //"Alalah",
        //"Adam",
        //"Diab",
        //"Nassar",
        //"Darwish",
        //"Nour",
        //"Khalid",
        //"Ebrahim",
        //"Aziz",
        //"Ahmad",
        //"Auljunh",
        //"Hamdi",
        //"Shaheen",
        //"Talaat",
        //"Lotfy",
        //"Shalaby",
        //"Amr",
        //"Habib",
        //"Islam",
        //"Mohammed",
        //"Tawfik",
        //"Zakaria",
        //"Barakat",
        //"Lalh",
        //"Ashour",
        //"Bakr",
        //"Sami",
        //"Refaat",
        //"Ammar",
        //"Medhat",
        //"Najjar",
        //"Selim",
        //"Rabie",
        //"Nagy",
        //"Shaker",
        //"Sakr",
        //"Badh",
        //"Mohmed",
        //"Sadek",
        //"ElMsra",
        //"Abo",
        //"Arafa",
        //"Ailhiyah",
        //"Hashem",
        //"Helal",
        //"Sultan",
        //"Shaban",
        //"Zidan",
        //"Zagazig",
        //"Abdalla",
        //"Badawy",
        //"Afifi",
        //"Sameh",
        //"Hammad",
        //"Morsy",
        //"Abdelaziz",
        //"Farid",
        //"Raafat",
        //"Ibrahem",
        //"Salim",
        //"Ghanem",
        //"Ezz",
        //"Sharaf",
        //"Fares",
        //"Ehab",
        //"Khattab",
        //"Nada",
        //"Saied",
        //"Karim",
        //"Sharqawi",
        //"Safwat",
        //"Hamid",
        //"Hasan",
        //"Taher",
        //"Wael",
        //"Zahran",
        //"Khalaf",
        //"Elgendy",
        //"Zayed",
        //"Khairy",
        //"Moussa",
        //"Basha",
        //"Metwally",
        //"Medo",
        //"Yousry",
        //"Rashed",
        //"Fouda",
        //"Yassin",
        //"Shams",
        //"Kassem",
        //"Kandil",
        //"Fawzi",
        //"Sallam",
        //"Mounir",
        //"Badawi",
        //"Fayed",
        //"Elkady",
        //"Emara",
        //"Tamer",
        //"Azab",
        //"Kotb",
        //"Suleiman",
        //"Amir",
        //"AbdElaziz",
        //"Mahrous",
        //"Negm",
        //"Adly",
        //"Karam",
        //"ElSayed",
        //"Eissa",
        //"Walid",
        //"Sheikh",
        //"Wahba",
        //"Abdelrahman",
        //"Salam",
        //"Ayad",
        //"Naguib",
        //"Omran",
        //"Shahin",
        //"Yasin",
        //"Hosni",
        //"Seif",
        //"Maged",
        //"Deeb",
        //"Eldeeb",
        //"Hamad",
        //"Elsaid",
        //"Shehab",
        //"Faraj",
        //"Mahdy",
        //"Sharif",
        //"Elkholy",
        //"Abou",
        //"Hazem",
        //"Ghoneim",
        //"Ramzy",
        //"Fayez",
        //"Tito",
        //"Amal",
        //"Hatem",
        //"Hanna",
        //"Salameh",
        //"Khamis",
        //"Mody",
        //"Rezk",
        //"Esmail",
        //"Rady",
        //"Tharwat",
        //"Sarhan",
        //"Hashim",
        //"Zaky",
        //"Roshdy",
        //"Gabr",
        //"Rizk",
        //"AbuAhmed",
        //"Khater",
        //"Elnagar",
        //"Abdou",
        //"Fekry",
        //"Rada",
        //"Essa",
        //"Othman",
        //"Fadel",
        //"Isa",
        //"Mahfouz",
        //"Yahia",
        //"Yahya",
        //"AbuZaid",
        //"Khedr",
        //"Hanafy",
        //"Shokry",
        //"Labib",
        //"deAna",
        //"Abdulrahman",
        //"Gharib",
        //"Younis",
        //"Yarb",
        //"AbdelFattah",
        //"Riad",
        //"Mourad",
        //"Jaber",
        //"Mohamad",
        //"Elsharkawy",
        //"AbuMuhammad",
        //"Mabrouk",
        //"Zaghloul",
        //"Rashwan",
        //"Abu",
        //"Elshazly",
        //"Tayeb",
        //"Mazen",
        //"Elshamy",
        //"Ghaly",
        //"Thabet",
        //"Gamil",
        //"Badran",
        //"Abed",
        //"Nawr",
        //"ElJazzar",
        //"Nader",
        //"Atta",
        //"Azzam",
        //"Samer",
        //"Alahyat",
        //"Elgohary",
        //"Hisham",
        //"Marw",
        //"Naser",
        //"AbuYoussef",
        //"Salman",
        //"Bahaa",
        //"Tota",
        //"Wagdy",
        //"Elgamal",
        //"Elsawy",
        //"Mero",
        //"Eldin",
        //"Shafie",
        //"Atia",
        //"Abdelsalam",
        //"Pasha",
        //"Waleed",
        //"AbuAli",
        //"Bayoumi",
        //"Masoud",
        //"Saif",
        //"Muhammad",
        //"Adham",
        //"Halim",
        //"Hassanein",
        //"El-Khouly",
        //"Tantawy",
        //"Dawood",
        //"Abdulaziz",
        //"Sabri",
        //"Tolba",
        //"Magdi",
        //"Farrag",
        //"Esam",
        //"Zain",
        //"Okasha",
        //"Sobhi",
        //"Elsherif",
        //"Goda",
        //"Ebrahem",
        //"Zaher",
        //"AbdElAziz",
        //"Elsheikh",
        //"Saidi",
        //"AbdelMoneim",
        //"Malak",
        //"Bassiouni"};
        //            List<String> roles = new List<string>() {
        //               "admin",
        //                "secretary",
        //                "candidate",
        //               "instructor",
        //                "outsource",
        //                "assistant",
        //                "technician"
        //            };

        //            List<String> universities = new List<string>() {
        //                "Cairo University",
        //                "Ain Shams University",
        //                "MSA",
        //                "MUST",
        //                "Modern Academy",
        //                "Alexandria University"
        //            };

        //            List<String> specialities = new List<string>() {
        //                "Spec1",
        //                "Spec2",
        //                "Spec3",
        //                "Spec4",
        //                "Spec5",
        //                "Spec6"
        //            };


        //            RegisterDTO registerDTO = new RegisterDTO();

        //            var batches = new List<CandidatesBatchesModel>();

        //            for (int i = 0; i < 10; i++)
        //            {
        //                batches.Add(new CandidatesBatchesModel()
        //                {
        //                    Name = $"batch {i}"
        //                });
        //            }
        //            _ciaDbContext.CandidatesBatches.AddRange(batches);
        //            _ciaDbContext.SaveChanges();
        //            string password = "Pa$$word1";
        //            for (int i = 0; i < number; i++)
        //            {
        //                try
        //                {
        //                    String role = roles[new Random().Next(roles.Count)];
        //                    String name = names[new Random().Next(names.Count)] + " " + names[new Random().Next(names.Count)];
        //                    registerDTO = new RegisterDTO()
        //                    {
        //                        ClassYear = i == 0 ? "2015" : new Random().Next(2010, 2023).ToString(),
        //                        Gender = i == 0 ? "Male" : new Random().Next(2) == 0 ? "Male" : "Female",
        //                        DateOfBirth = new DateOnly(new Random().Next(1980, 2005), new Random().Next(1, 13), new Random().Next(1, 29)),
        //                        Email = i == 0 ? "admin@cia.com" : name.Replace(" ", "") + "@cia.com",
        //                        Role = i == 0 ? "admin" : role,
        //                        Name = i == 0 ? "Admin" : name,
        //                        GraduatedFrom = universities[new Random().Next(universities.Count)],
        //                        PhoneNumber = $"01{new Random().Next(1, 3)}{new Random().Next(10)}{new Random().Next(10)}{new Random().Next(10)}{new Random().Next(10)}{new Random().Next(10)}{new Random().Next(10)}{new Random().Next(10)}{new Random().Next(10)}",
        //                        Speciality = specialities[new Random().Next(specialities.Count)],
        //                        WorkPlaceEnum = 0,




        //                    };

        //                    CandidatesBatchesModel batch = new CandidatesBatchesModel();


        //                    if (registerDTO.Roles.Contains("candidate"))
        //                    {
        //                        registerDTO.Email = DateTime.Now.Millisecond.ToString() + "@cia.com";
        //                        // registerDTO.BatchId = batches[new Random().Next(batches.Count)].Id;

        //                    }

        //                    ApplicationUser user = _mapper.Map<ApplicationUser>(registerDTO);


        //                    user.RegisterationDate = DateTime.UtcNow;


        //                    var users = await _ciaDbContext.Users.ToListAsync();
        //                    ApplicationUser u = new ApplicationUser();
        //                    if (users.Count > 0)
        //                    {
        //                        Random rnd = new Random();
        //                        int num = rnd.Next(0, users.Count);
        //                        u = users[num];
        //                    }
        //                    if (registerDTO.Role != "admin")
        //                    {
        //                        user.RegisteredBy = u;
        //                        user.RegisteredById = u.IdInt;
        //                    }

        //                    user.UserName = registerDTO.Name.ToLower().Replace(" ", "");

        //                    user.Website = (new Random()).Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic;
        //                    var response = await _userManager.CreateAsync(user, password);
        //                    if (response.Succeeded)
        //                    {
        //                        await _userManager.AddToRoleAsync(user, registerDTO.Role);


        //                        if (registerDTO.Roles.Contains("candidate"))
        //                        {


        //                            user.BatchId = batches[new Random().Next(batches.Count)].Id;
        //                            _ciaDbContext.Users.Update(user);
        //                            await _ciaDbContext.SaveChangesAsync();



        //                        }
        //                        //_apiResponse.Result = _ciaDbContext.Users.FirstOrDefaultAsync(x => x.Email.ToLower() == registerDTO.Email.ToLower());
        //                        // return Ok();
        //                    }
        //                }
        //                catch (Exception e) { }

        //            }
        //            //_apiResponse.ErrorMessage = response.ToString();
        //            var tech = await _userManager.GetUsersInRoleAsync("technician");
        //            foreach (var t in tech)
        //                t.Website = EnumWebsite.Lab;
        //            _ciaDbContext.Users.UpdateRange(tech);
        //            _ciaDbContext.SaveChanges();
        //            return BadRequest(_apiResponse);
        //        }

        [HttpGet("GenerateMedicalStock")]
        public async Task<IActionResult> GenerateMedicalStock()
        {

            List<ImplantCompany> implantCompanies = new List<ImplantCompany>();
            List<ImplantLine> implantLines = new List<ImplantLine>();
            List<Implant> implants = new List<Implant>();
            List<TacCompany> tacCompanies = new List<TacCompany>();
            List<MembraneCompany> membraneCompanies = new List<MembraneCompany>();
            List<Membrane> membranes = new List<Membrane>();
            Random rnd = new Random();

            var em = await _ciaDbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Implants");
            var tacsCat = await _ciaDbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Tacs");
            var membraneCat = await _ciaDbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Membranes");
            if (tacsCat == null)
            {
                tacsCat = new MedicalExpensesModel()
                {

                    Name = "Tacs",
                    Website = (new Random()).Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,
                };
                await _ciaDbContext.MedicalExpenses.AddAsync(tacsCat);
                await _ciaDbContext.SaveChangesAsync();
            }
            if (membraneCat == null)
            {
                membraneCat = new MedicalExpensesModel()
                {

                    Name = "Membranes",
                    Website = (new Random()).Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,

                };
                await _ciaDbContext.MedicalExpenses.AddAsync(membraneCat);
                await _ciaDbContext.SaveChangesAsync();
            }
            if (em == null)
            {
                em = new MedicalExpensesModel()
                {

                    Name = "Implants",
                    Website = (new Random()).Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,
                };
                await _ciaDbContext.MedicalExpenses.AddAsync(em);
                await _ciaDbContext.SaveChangesAsync();
            }

            for (int i = 0; i < 4; i++)
            {
                implantCompanies.Add(new ImplantCompany
                {
                    Name = $"I Comp {i}",
                });
            }
            await _ciaDbContext.ImplantCompanies.AddRangeAsync(implantCompanies);
            await _ciaDbContext.SaveChangesAsync();

            int oo = 0;
            foreach (var c in implantCompanies)
            {

                for (int i = 0; i < 5; i++)
                {
                    implantLines.Add(new ImplantLine
                    {
                        Name = $"I Line {oo}{i}",
                        ImplantCompany = c
                    });
                }
                oo++;
            }

            await _ciaDbContext.ImplantLines.AddRangeAsync(implantLines);
            await _ciaDbContext.SaveChangesAsync();



            foreach (var l in implantLines)
            {
                for (int i = 0; i < 30; i++)
                {
                    var size = $"{new Random().Next(9)}*{new Random().Next(9)}";
                    implants.Add(new Implant
                    {
                        Count = new Random().Next(100),
                        Date = DateTime.UtcNow,
                        Name = $"{l.ImplantCompany.Name}_{l.Name}_{size}",
                        Size = size,
                        ImplantLineId = l.Id,
                        Category = em,
                        Price = (int)(new Random().Next(10, 1000) / 10),
                        Website = rnd.Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,
                    });
                }
            }
            await _ciaDbContext.Implants.AddRangeAsync(implants);
            await _ciaDbContext.SaveChangesAsync();



            for (int i = 0; i < 10; i++)
            {
                tacCompanies.Add(new TacCompany
                {
                    Name = $"Tac {i}",
                    Count = new Random().Next(100),
                    Category = tacsCat,
                    Price = (int)(new Random().Next(10, 1000) / 10),
                    Website = rnd.Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,

                });
            }

            await _ciaDbContext.TacCompanies.AddRangeAsync(tacCompanies);
            await _ciaDbContext.SaveChangesAsync();

            for (int i = 0; i < 10; i++)
            {
                membraneCompanies.Add(new MembraneCompany
                {
                    Name = $"Membrane Company {i}",
                });
            }

            await _ciaDbContext.MembraneCompanies.AddRangeAsync(membraneCompanies);
            await _ciaDbContext.SaveChangesAsync();

            for (int i = 0; i < 10; i++)
            {
                membranes.Add(new Membrane
                {
                    Name = $"Membrane {i}",
                    Count = new Random().Next(100),
                    MembraneCompnayId = membraneCompanies[new Random().Next(membraneCompanies.Count)].Id,
                    Category = membraneCat,
                    Price = (int)(new Random().Next(10, 1000) / 10),
                    Website = rnd.Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,
                });
            }

            await _ciaDbContext.Membranes.AddRangeAsync(membranes);
            await _ciaDbContext.SaveChangesAsync();

            await _ciaDbContext.Screws.AddAsync(new ScrewsModel
            {
                Count = new Random().Next(100),
                Price = (int)(new Random().Next(10, 1000) / 10),
                Website = rnd.Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,
            });
            await _ciaDbContext.SaveChangesAsync();

            return Ok();

        }

        [HttpGet("GeneratePatientsWithBasicInfo")]
        public async Task<IActionResult> GeneratePatientsWithBasicInfo(int number)
        {
            Random rnd = new Random();
            List<String> bloodpresDrugs = new List<string>(){"Amlodipine besylate",
"Clevidipine",
"Diltiazem hydrochloride",
"Felodipine",
"Isradipine",
"Nicardipine",
"Nifedipine",
"Nimodipine"};
            List<String> names = new List<String>(){"Mohamed",
"Ahmed",
"Ali",
"Hassan",
"Mahmoud",
"Ibrahim",
"Salah",
"Mostafa",
"Adel",
"Gamal",
"Saad",
"Sayed",
"Samir",
"Omar",
"Hussein",
"Kamal",
"Magdy",
"Salem",
"Saleh",
"Ramadan",
"Hamdy",
"Elsayed",
"Khaled",
"Saeed",
"Ashraf",
"Yousef",
"Fathy",
"Said",
"Soliman",
"Mansour",
"Kamel",
"Taha",
"Mustafa",
"Abdo",
"Khalil",
"Ismail",
"Nabil",
"Samy",
"Ragab",
"Fouad",
"Youssef",
"Amin",
"Amer",
"Osman",
"Awad",
"Fawzy",
"Aly",
"Atef",
"Alaa",
"Abdullah",
"Essam",
"Eid",
"Hamed",
"Zaki",
"Sabry",
"Maher",
"Abdallah",
"Abdel",
"Salama",
"Ana",
"Osama",
"Tarek",
"Nasr",
"Alasid",
"Badr",
"Mohsen",
"Farouk",
"Saber",
"Emad",
"Reda",
"Helmy",
"Ayman",
"Fahmy",
"Ezzat",
"Galal",
"Sherif",
"Attia",
"Rahman",
"Fathi",
"Shawky",
"Khalifa",
"Radwan",
"Jamal",
"Mousa",
"Hegazy",
"Allam",
"Hany",
"Hamada",
"Farag",
"Mamdouh",
"Abbas",
"Shaaban",
"Hussien",
"Yasser",
"Gad",
"Hesham",
"Shehata",
"Elmasry",
"Mido",
"Hossam",
"Hosny",
"Emam",
"Sobhy",
"Gaber",
"Anwar",
"Moustafa",
"Nasser",
"Yehia",
"Gomaa",
"Hamza",
"Hafez",
"Rashad",
"Mokhtar",
"ElMisri",
"Alalah",
"Adam",
"Diab",
"Nassar",
"Darwish",
"Nour",
"Khalid",
"Ebrahim",
"Aziz",
"Ahmad",
"Auljunh",
"Hamdi",
"Shaheen",
"Talaat",
"Lotfy",
"Shalaby",
"Amr",
"Habib",
"Islam",
"Mohammed",
"Tawfik",
"Zakaria",
"Barakat",
"Lalh",
"Ashour",
"Bakr",
"Sami",
"Refaat",
"Ammar",
"Medhat",
"Najjar",
"Selim",
"Rabie",
"Nagy",
"Shaker",
"Sakr",
"Badh",
"Mohmed",
"Sadek",
"ElMsra",
"Abo",
"Arafa",
"Ailhiyah",
"Hashem",
"Helal",
"Sultan",
"Shaban",
"Zidan",
"Zagazig",
"Abdalla",
"Badawy",
"Afifi",
"Sameh",
"Hammad",
"Morsy",
"Abdelaziz",
"Farid",
"Raafat",
"Ibrahem",
"Salim",
"Ghanem",
"Ezz",
"Sharaf",
"Fares",
"Ehab",
"Khattab",
"Nada",
"Saied",
"Karim",
"Sharqawi",
"Safwat",
"Hamid",
"Hasan",
"Taher",
"Wael",
"Zahran",
"Khalaf",
"Elgendy",
"Zayed",
"Khairy",
"Moussa",
"Basha",
"Metwally",
"Medo",
"Yousry",
"Rashed",
"Fouda",
"Yassin",
"Shams",
"Kassem",
"Kandil",
"Fawzi",
"Sallam",
"Mounir",
"Badawi",
"Fayed",
"Elkady",
"Emara",
"Tamer",
"Azab",
"Kotb",
"Suleiman",
"Amir",
"AbdElaziz",
"Mahrous",
"Negm",
"Adly",
"Karam",
"ElSayed",
"Eissa",
"Walid",
"Sheikh",
"Wahba",
"Abdelrahman",
"Salam",
"Ayad",
"Naguib",
"Omran",
"Shahin",
"Yasin",
"Hosni",
"Seif",
"Maged",
"Deeb",
"Eldeeb",
"Hamad",
"Elsaid",
"Shehab",
"Faraj",
"Mahdy",
"Sharif",
"Elkholy",
"Abou",
"Hazem",
"Ghoneim",
"Ramzy",
"Fayez",
"Tito",
"Amal",
"Hatem",
"Hanna",
"Salameh",
"Khamis",
"Mody",
"Rezk",
"Esmail",
"Rady",
"Tharwat",
"Sarhan",
"Hashim",
"Zaky",
"Roshdy",
"Gabr",
"Rizk",
"AbuAhmed",
"Khater",
"Elnagar",
"Abdou",
"Fekry",
"Rada",
"Essa",
"Othman",
"Fadel",
"Isa",
"Mahfouz",
"Yahia",
"Yahya",
"AbuZaid",
"Khedr",
"Hanafy",
"Shokry",
"Labib",
"deAna",
"Abdulrahman",
"Gharib",
"Younis",
"Yarb",
"AbdelFattah",
"Riad",
"Mourad",
"Jaber",
"Mohamad",
"Elsharkawy",
"AbuMuhammad",
"Mabrouk",
"Zaghloul",
"Rashwan",
"Abu",
"Elshazly",
"Tayeb",
"Mazen",
"Elshamy",
"Ghaly",
"Thabet",
"Gamil",
"Badran",
"Abed",
"Nawr",
"ElJazzar",
"Nader",
"Atta",
"Azzam",
"Samer",
"Alahyat",
"Elgohary",
"Hisham",
"Marw",
"Naser",
"AbuYoussef",
"Salman",
"Bahaa",
"Tota",
"Wagdy",
"Elgamal",
"Elsawy",
"Mero",
"Eldin",
"Shafie",
"Atia",
"Abdelsalam",
"Pasha",
"Waleed",
"AbuAli",
"Bayoumi",
"Masoud",
"Saif",
"Muhammad",
"Adham",
"Halim",
"Hassanein",
"El-Khouly",
"Tantawy",
"Dawood",
"Abdulaziz",
"Sabri",
"Tolba",
"Magdi",
"Farrag",
"Esam",
"Zain",
"Okasha",
"Sobhi",
"Elsherif",
"Goda",
"Ebrahem",
"Zaher",
"AbdElAziz",
"Elsheikh",
"Saidi",
"AbdelMoneim",
"Malak",
"Bassiouni"};
            List<String> citis = new List<String>(){
"Cairo",
"Giza",
"Shubra El Kheima",
"Port Said",
"Suez",
"El Mahalla El Kubra",
"Luxor",
"Mansoura",
"Tanta",
"Asyut",
"Ismaïlia",
"Faiyum",
"Zagazig",
"Damietta",
"Aswan",
"Minya",
"Damanhur",
"Beni Suef",
"Hurghada",
"Qena",
"Sohag",
"Shibin El Kom",
"Banha",
"Arish"};

            for (int i = 0; i < number; i++)
            {
                List<DiseasesEnum> diseases = new List<DiseasesEnum>();
                for (int x = 0; x < rnd.Next(12); x++)
                {
                    diseases.Add((DiseasesEnum)rnd.Next(12));
                }

                List<HBA1cModel> hba1c = new List<HBA1cModel>();
                for (int x = 0; x < rnd.Next(6); x++)
                {
                    hba1c.Add(new HBA1cModel()
                    {
                        Date = new DateOnly(rnd.Next(1970, 2015), rnd.Next(1, 13), rnd.Next(1, 28)),
                        Reading = rnd.Next(4, 9)
                    });
                }

                await _ciaDbContext.Patients.AddAsync(new Patient()
                {
                    Id = 10000 + i,
                    SecondaryId = $"{10000 + i}",
                    DateOfBirth = new DateOnly(rnd.Next(1970, 2015), rnd.Next(1, 13), rnd.Next(1, 28)),
                    Gender = rnd.Next(2) == 0 ? EnumGender.Male : EnumGender.Female,
                    Address = citis[rnd.Next(citis.Count)],
                    City = citis[rnd.Next(citis.Count)],
                    Name = names[rnd.Next(names.Count)] + " " + names[rnd.Next(names.Count)],
                    MaritalStatus = "Married",
                    // PatientType = EnumPatientType.CIA,
                    Phone = $"01{rnd.Next(3)}{rnd.Next(10)}{rnd.Next(10)}{rnd.Next(10)}{rnd.Next(10)}{rnd.Next(10)}{rnd.Next(10)}{rnd.Next(10)}{rnd.Next(10)}",
                    MedicalExamination = new MedicalExaminationModel()
                    {
                        Diseases = diseases,
                        BloodPressure = new BloodPressureModel()
                        {
                            Drug = bloodpresDrugs[rnd.Next(bloodpresDrugs.Count)],
                            LastReading = $"{rnd.Next(90, 180)}/{rnd.Next(40, 120)}",
                            ReadingInClinic = $"{rnd.Next(90, 180)}/{rnd.Next(40, 120)}",
                            When = new DateOnly(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 28)),
                            Status = (BloodPressureEnum)rnd.Next(5)
                        },
                        Diabetic = new Diabetes()
                        {
                            LastReading = rnd.Next(50, 200),
                            RandomInClinic = rnd.Next(50, 200),
                            When = new DateOnly(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 28)),
                            Status = (DiabetesEnum)rnd.Next(3),
                            Type = (DiabetesType)rnd.Next(2)
                        },
                        HBA1c = hba1c,
                        Penicillin = rnd.Next(2) == 0,
                        IllegalDrugs = rnd.Next(2) == 0 ? "Yes" : null,
                        PregnancyStatus = (PregnancyEnum)rnd.Next(3),

                    },
                    DentalHistory = new DentalHistoryModel()
                    {
                        BittingCheweing = rnd.Next(2) == 0,
                        SmokingStatus = (SmokingStatus)rnd.Next(4),
                        CooperationScore = rnd.Next(11),
                    },
                    DentalExamination = new DentalExaminationModel()
                    {
                        OralHygieneRating = (EnumOralHygieneRating)rnd.Next(4)
                    },

                    Website = rnd.Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,


                });
                Console.WriteLine(i);
            }
            await _ciaDbContext.SaveChangesAsync();

            return Ok();
        }

        //[HttpGet("GenerateRandomTreatments")]
        //public async Task<IActionResult> GenerateRandomTreatments()
        //{
        //    var patients = await _ciaDbContext.Patients.ToListAsync();
        //    var candidates = await _userManager.GetUsersInRoleAsync("candidate");
        //    var instructors = await _userManager.GetUsersInRoleAsync("instructor");
        //    var assistants = await _userManager.GetUsersInRoleAsync("assistant");
        //    var implants = await _ciaDbContext.Implants.ToListAsync();
        //    Random rnd = new Random();
        //    List<TreatmentPlanModel> treatmentPlans = new List<TreatmentPlanModel>();
        //    List<SurgicalTreatmentModel> surgicalTreatments = new List<SurgicalTreatmentModel>();
        //    List<TreatmentPlanSubModel> treatmentPlanSubModels = new List<TreatmentPlanSubModel>();
        //    _ciaDbContext.SurgicalTreatments.RemoveRange(_ciaDbContext.SurgicalTreatments.ToList());
        //    _ciaDbContext.TreatmentPlansSubModels.RemoveRange(_ciaDbContext.TreatmentPlansSubModels.ToList());
        //    _ciaDbContext.TreatmentPlans.RemoveRange(_ciaDbContext.TreatmentPlans.ToList());
        //    _ciaDbContext.SaveChanges();

        //    foreach (var patient in patients)
        //    {

        //        var Operator = rnd.Next(2) == 0 ? assistants[rnd.Next(assistants.Count)] : instructors[rnd.Next(instructors.Count)];
        //        List<int> teeth = new List<int>();
        //        for (int i = 0; i < rnd.Next(20); i++)
        //        {

        //            if (rnd.Next(2) == 0 && teeth.Count < 5) teeth.Add(rnd.Next(11, 19));
        //            if (rnd.Next(2) == 0 && teeth.Count < 5) teeth.Add(rnd.Next(21, 29));
        //            if (rnd.Next(2) == 0 && teeth.Count < 5) teeth.Add(rnd.Next(31, 39));
        //            if (rnd.Next(2) == 0 && teeth.Count < 5) teeth.Add(rnd.Next(41, 49));
        //        }
        //        teeth = teeth.Distinct().ToList();
        //        foreach (var tooth in teeth)
        //        {

        //            int randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            int randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            int randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            int randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            int plansCounter = 0;


        //            TreatmentPlanFieldsModel? Scaling = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null

        //            };
        //            if (Scaling != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);

        //            TreatmentPlanFieldsModel? Crown = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null


        //            };
        //            if (Crown != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? RootCanalTreatment = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null


        //            };
        //            if (RootCanalTreatment != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? Restoration = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null


        //            };
        //            if (Restoration != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? Pontic = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null,



        //            };
        //            if (Pontic != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? Extraction = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null


        //            };
        //            if (Extraction != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? SimpleImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = randomAssistant == 0 ? null : implants[rnd.Next(implants.Count)]


        //            };
        //            if (SimpleImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? ImmediateImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = randomAssistant == 0 ? null : implants[rnd.Next(implants.Count)]



        //            };
        //            if (ImmediateImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? ExpansionWithImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = randomAssistant == 0 ? null : implants[rnd.Next(implants.Count)]



        //            };
        //            if (ExpansionWithImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? SplittingWithImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = randomAssistant == 0 ? null : implants[rnd.Next(implants.Count)]


        //            };
        //            if (SplittingWithImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? GBRWithImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = randomAssistant == 0 ? null : implants[rnd.Next(implants.Count)]


        //            };
        //            if (GBRWithImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? OpenSinusWithImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = randomAssistant == 0 ? null : implants[rnd.Next(implants.Count)]


        //            };
        //            if (OpenSinusWithImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? ClosedSinusWithImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = randomAssistant == 0 ? null : implants[rnd.Next(implants.Count)]


        //            };
        //            if (ClosedSinusWithImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? GuidedImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = randomAssistant == 0 ? null : implants[rnd.Next(implants.Count)]


        //            };
        //            if (GuidedImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? ExpansionWithoutImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null


        //            };
        //            if (ExpansionWithoutImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? SplittingWithoutImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null


        //            };
        //            if (SplittingWithoutImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? GBRWithoutImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null


        //            };
        //            if (GBRWithoutImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? OpenSinusWithoutImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {
        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null


        //            };
        //            if (OpenSinusWithoutImplant != null) plansCounter++;
        //            randomAssigned = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomAssistant = rnd.Next(2) == 0 ? 0 : rnd.Next(assistants.Count);
        //            randomCandidate = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(candidates.Count);
        //            randomInstructor = rnd.Next(2) == 0 || randomAssistant == 0 ? 0 : rnd.Next(instructors.Count);
        //            TreatmentPlanFieldsModel? ClosedSinusWithoutImplant = rnd.Next(2) == 0 || plansCounter > 3 ? null : new TreatmentPlanFieldsModel()
        //            {

        //                AssignedTo = randomAssigned == 0 ? null : assistants[randomAssigned],
        //                AssignedToID = randomAssigned == 0 ? null : assistants[randomAssigned].IdInt,
        //                DoneByAssistant = randomAssistant == 0 ? null : assistants[randomAssistant],
        //                DoneByAssistantID = randomAssistant == 0 ? null : assistants[randomAssistant].IdInt,
        //                DoneByCandidate = randomCandidate == 0 ? null : candidates[randomCandidate],
        //                DoneByCandidateID = randomCandidate == 0 ? null : candidates[randomCandidate].IdInt,
        //                DoneBySupervisor = randomInstructor == 0 ? null : instructors[randomInstructor],
        //                DoneBySupervisorID = randomInstructor == 0 ? null : instructors[randomInstructor].IdInt,
        //                Status = randomAssistant != 0,
        //                DoneByCandidateBatchID = randomCandidate == 0 ? null : candidates[randomCandidate].BatchId,
        //                Date = new DateTime(rnd.Next(2015, 2023), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //                Implant = null,




        //            };

        //            treatmentPlanSubModels.Add(new TreatmentPlanSubModel
        //            {
        //                Tooth = tooth,
        //                PatientId = patient.Id,
        //                Scaling = Scaling,
        //                Crown = Crown,
        //                RootCanalTreatment = RootCanalTreatment,
        //                Restoration = Restoration,
        //                Pontic = Pontic,
        //                Extraction = Extraction,
        //                SimpleImplant = SimpleImplant,
        //                ImmediateImplant = ImmediateImplant,
        //                ExpansionWithImplant = ExpansionWithImplant,
        //                SplittingWithImplant = SplittingWithImplant,
        //                GBRWithImplant = GBRWithImplant,
        //                OpenSinusWithImplant = OpenSinusWithImplant,
        //                ClosedSinusWithImplant = ClosedSinusWithImplant,
        //                GuidedImplant = GuidedImplant,
        //                ExpansionWithoutImplant = ExpansionWithoutImplant,
        //                SplittingWithoutImplant = SplittingWithoutImplant,
        //                GBRWithoutImplant = GBRWithoutImplant,
        //                OpenSinusWithoutImplant = OpenSinusWithoutImplant,
        //                ClosedSinusWithoutImplant = ClosedSinusWithoutImplant
        //            });
        //        }
        //        treatmentPlans.Add(new TreatmentPlanModel()
        //        {

        //            Date = new DateTime(rnd.Next(2015, 2024), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime(),
        //            Operator = Operator,
        //            OperatorId = Operator.IdInt,
        //            PatientId = patient.Id,

        //        });
        //        surgicalTreatments.Add(new SurgicalTreatmentModel() { PatientId = patient.Id });

        //    }
        //    await _ciaDbContext.TreatmentPlans.AddRangeAsync(treatmentPlans);
        //    await _ciaDbContext.SurgicalTreatments.AddRangeAsync(surgicalTreatments);
        //    await _ciaDbContext.TreatmentPlansSubModels.AddRangeAsync(treatmentPlanSubModels);
        //    await _ciaDbContext.SaveChangesAsync();

        //    return Ok();
        //}

        [HttpPost("GenerateRandomVisits")]
        public async Task<IActionResult> GenerateRandomVisits()
        {
            var patients = await _ciaDbContext.Patients.ToListAsync();
            var instructors = await _userManager.GetUsersInRoleAsync("instructor");
            var assistants = await _userManager.GetUsersInRoleAsync("assistant");
            var admins = await _userManager.GetUsersInRoleAsync("admins");
            Random rnd = new Random();
            for (int i = 0; i < 2000; i++)
            {
                var d = new Random().Next(3);
                var user = assistants[rnd.Next(assistants.Count)];
                var visitTime = new DateTime(rnd.Next(2019, 2024), rnd.Next(1, 13), rnd.Next(1, 29)).ToUniversalTime();
                var duration = new TimeSpan(rnd.Next(6), rnd.Next(59), rnd.Next(59));
                await _ciaDbContext.VisitsLogs.AddAsync(new VisitsLog
                {

                    Doctor = user,
                    DoctorID = user.IdInt,
                    From = visitTime,
                    To = visitTime.Add(duration),
                    Duration = duration,
                    EntersClinicTime = visitTime,
                    LeaveTime = visitTime.Add(duration),
                    PatientID = patients[rnd.Next(patients.Count)].Id,
                    RealVisitTime = visitTime,
                    Status = VisitsStatus.Visited,
                    Website = rnd.Next(1000) % 5 == 0 ? EnumWebsite.CIA : EnumWebsite.Clinic,

                });
            }
            await _ciaDbContext.SaveChangesAsync();

            return Ok();
        }
        [AllowAnonymous]
        [HttpGet("Test")]
        public async Task<IActionResult> Test()
        {
            return Ok("Connected");

        }
        [AllowAnonymous]
        [HttpGet("MigrateToCashFlowLabCategory")]
        public async Task<IActionResult> MigrateToCashFlowLabCategory()
        {
            var incomes = await _ciaDbContext.Income.Where(x => x.Website == EnumWebsite.Lab).ToListAsync();

            var categoryCIA ="CIA Lab Request";
            var categoryClinic ="Clinic Lab Request";
            var categoryPrivate="Private Lab Request";

            await _ciaDbContext.IncomeCategories.AddAsync(new IncomeCategoriesModel()
            {
                Website = EnumWebsite.Lab,
                Name = categoryCIA
            }); 
            await _ciaDbContext.IncomeCategories.AddAsync(new IncomeCategoriesModel()
            {
                Website = EnumWebsite.Lab,
                Name = categoryClinic
            }); 
            await _ciaDbContext.IncomeCategories.AddAsync(new IncomeCategoriesModel()
            {
                Website = EnumWebsite.Lab,
                Name = categoryPrivate
            });
            await _ciaDbContext.SaveChangesAsync();

            foreach(var income in incomes)
            {
                var request = await _ciaDbContext.Lab_Requests.FirstAsync(x => x.Id == income.LabRequestId);
                var categoryRequest = request.Source + " Lab Request";
                var cat = await _ciaDbContext.IncomeCategories.FirstOrDefaultAsync(x => x.Name == categoryRequest && x.Website == EnumWebsite.Lab);
                income.CategoryId = cat.Id;
                income.Category = cat;
                _ciaDbContext.Update(income);
            }
            _ciaDbContext.SaveChanges();


            return Ok();
        }
        [AllowAnonymous]
        [HttpGet("MigrateToTreatmentBridge")]
        public async Task<IActionResult> MigrateToTreatmentBridge()
        {
            var details = await _ciaDbContext.TreatmentDetails.ToListAsync();
            foreach(var d in details)
            {
                d.Bridge = false;
            }
            _ciaDbContext.TreatmentDetails.UpdateRange(details);
            _ciaDbContext.SaveChanges();
            return Ok();
        }



        [HttpPost("GenerateClinicPrices")]
        public async Task<IActionResult> GenerateClinicPrices()
        {
            var prices = await _ciaDbContext.ClinicPrices.ToListAsync();
            var rnd = new Random();
            foreach (var price in prices)
            {
                price.Price = (int)Math.Round((float)rnd.Next(100, 1000) / 10) * 10;
            }
            _ciaDbContext.ClinicPrices.UpdateRange(prices);
            _ciaDbContext.SaveChanges();
            return Ok();
        }

        [HttpGet("GeneratePatientComplications")]
        public async Task<IActionResult> GeneratePatientComplications()
        {
            var patients = await _ciaDbContext.Patients.Select(x => x.Id).ToListAsync();

            var rnd = new Random();
            List<ComplicationsAfterSurgeryModel> comps = new List<ComplicationsAfterSurgeryModel>();
            foreach (var id in patients)
            {
                for (int i = 0; i < rnd.Next(3, 10); i++)
                {
                    comps.Add(new ComplicationsAfterSurgeryModel()
                    {
                        //Name = Enum.GetName(typeof(EunumComplicationsAfterSurgery), rnd.Next(0, 7)),
                        Date = DateTime.UtcNow,
                        Tooth = rnd.Next(1, 40),
                        PatientId = id,
                    });
                }

            }
            _ciaDbContext.ComplicationsAfterSurgery.AddRange(comps);
            _ciaDbContext.SaveChanges();
            foreach (var comp in comps)
            {
                var parent = await _ciaDbContext.ComplicationsAfterSurgeryParents.FirstOrDefaultAsync(x => x.PatientId == comp.PatientId && comp.Tooth == x.Tooth);
                if (parent == null)
                {
                    parent = new ComplicationsAfterSurgeryParentModel
                    {
                        PatientId = comp.PatientId,
                        Tooth = comp.Tooth,
                    };

                }
                parent.Complications = comps.Where(x => x.PatientId == comp.PatientId && x.Tooth == comp.Tooth).ToList();
                _ciaDbContext.ComplicationsAfterSurgeryParents.Update(parent);

            }
            _ciaDbContext.SaveChanges();

            return Ok();
        }


        [HttpGet("GenerateProsthetics")]
        public async Task<IActionResult> GenerateProsthetics()
        {
            var patients = await _ciaDbContext.Patients.Select(x => x.Id).ToListAsync();
            var users = await _ciaDbContext.Users.ToListAsync();

            _ciaDbContext.FinalProsthesisParents.RemoveRange(_ciaDbContext.FinalProsthesisParents);
            _ciaDbContext.ProstheticTreatmentFinalSingleBridges.RemoveRange(_ciaDbContext.ProstheticTreatmentFinalSingleBridges);
            _ciaDbContext.ProstheticTreatmentFinalFullArchs.RemoveRange(_ciaDbContext.ProstheticTreatmentFinalFullArchs);
            _ciaDbContext.SaveChanges();
            Random rnd = new Random();



            foreach (var p in patients)
            {
                var prosDiagnostic = await _ciaDbContext.ProstheticTreatments.FirstOrDefaultAsync(x => x.PatientId == p);
                var prosSingle = await _ciaDbContext.ProstheticTreatmentFinalSingleBridges.FirstOrDefaultAsync(x => x.PatientId == p);
                var prosFull = await _ciaDbContext.ProstheticTreatmentFinalFullArchs.FirstOrDefaultAsync(x => x.PatientId == p);

                prosDiagnostic ??= new ProstheticTreatmentDiagnosticModel()
                {
                    PatientId = p,
                    Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),

                };

                prosSingle ??= new ProstheticTreatmentFinalSingleBridge
                {
                    PatientId = p,
                    Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),

                };


                prosFull ??= new ProstheticTreatmentFinalFullArch
                {
                    PatientId = p,
                    Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),

                };


                for (int i = 0; i < rnd.Next(1, 10); i++)
                {
                    var op = users[rnd.Next(users.Count - 1)];
                    var temp = new DiagnosticImpressionModel
                    {
                        Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                        Diagnostic = Enum.GetValues<EnumProstheticDiagnosticDiagnosticImpressionDiagnostic>()[rnd.Next(0, Enum.GetValues<EnumProstheticDiagnosticDiagnosticImpressionDiagnostic>().Length - 1)],
                        NextStep = Enum.GetValues<EnumProstheticDiagnosticDiagnosticImpressionNextStep>()[rnd.Next(0, Enum.GetValues<EnumProstheticDiagnosticDiagnosticImpressionNextStep>().Length - 1)],
                        NeedsRemake = rnd.Next(1) == 0,
                        Scanned = rnd.Next(1) == 0,
                        PatientId = p,
                        Operator = op,
                        OperatorId = op.IdInt,
                    };
                    _ciaDbContext.ProstheticTreatments_DiagnosticImpression.Add(temp);

                    prosDiagnostic.ProstheticDiagnostic_DiagnosticImpression ??= new List<DiagnosticImpressionModel>();
                    prosDiagnostic.ProstheticDiagnostic_DiagnosticImpression.Add(temp);

                }
                for (int i = 0; i < rnd.Next(1, 10); i++)
                {
                    var op = users[rnd.Next(users.Count - 1)];

                    var temp = new BiteModel
                    {
                        Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                        Diagnostic = Enum.GetValues<EnumProstheticDiagnosticBiteDiagnostic>()[rnd.Next(0, Enum.GetValues<EnumProstheticDiagnosticBiteDiagnostic>().Length - 1)],
                        NextStep = Enum.GetValues<EnumProstheticDiagnosticBiteNextStep>()[rnd.Next(0, Enum.GetValues<EnumProstheticDiagnosticBiteNextStep>().Length - 1)],
                        NeedsRemake = rnd.Next(1) == 0,
                        Scanned = rnd.Next(1) == 0,
                        PatientId = p,
                        Operator = op,
                        OperatorId = op.IdInt,
                    };
                    _ciaDbContext.ProstheticTreatments_Bite.Add(temp);

                    prosDiagnostic.ProstheticDiagnostic_Bite ??= new List<BiteModel>();
                    prosDiagnostic.ProstheticDiagnostic_Bite.Add(temp);

                }
                for (int i = 0; i < rnd.Next(1, 10); i++)
                {
                    var op = users[rnd.Next(users.Count - 1)];

                    var temp = new ScanApplianceModel
                    {
                        Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                        Diagnostic = Enum.GetValues<EnumProstheticDiagnosticScanApplianceDiagnostic>()[rnd.Next(0, Enum.GetValues<EnumProstheticDiagnosticScanApplianceDiagnostic>().Length - 1)],
                        NeedsRemake = rnd.Next(1) == 0,
                        Scanned = rnd.Next(1) == 0,
                        PatientId = p,
                        Operator = op,
                        OperatorId = op.IdInt,
                    };
                    _ciaDbContext.ProstheticTreatments_ScanAppliance.Add(temp);

                    prosDiagnostic.ProstheticDiagnostic_ScanAppliance ??= new List<ScanApplianceModel>();
                    prosDiagnostic.ProstheticDiagnostic_ScanAppliance.Add(temp);

                }
                for (int y = 0; y < rnd.Next(1, 10); y++)
                {
                    List<int> teeth = new List<int>();
                    for (int index = 0; index < rnd.Next(1, 6); index++)
                    {
                        teeth.Add(rnd.Next(1, 40));
                    }
                    teeth.Remove(10);
                    teeth.Remove(20);
                    teeth.Remove(30);
                    teeth.Remove(40);
                    teeth = teeth.Distinct().ToList();
                    if (teeth.IsNullOrEmpty())
                        teeth.Add(rnd.Next(1, 9));
                    for (int i = 0; i < rnd.Next(1, 5); i++)
                    {
                        var op = users[rnd.Next(users.Count - 1)];

                        var temp = new FinalProsthesisHealingCollar
                        {
                            Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                            FinalProthesisHealingCollarNextVisit = Enum.GetValues<EnumFinalProthesisHealingCollarNextVisit>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisHealingCollarNextVisit>().Length - 1)],
                            FinalProthesisHealingCollarStatus = Enum.GetValues<EnumFinalProthesisHealingCollarStatus>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisHealingCollarStatus>().Length - 1)],
                            PatientId = p,
                            Operator = op,
                            OperatorId = op.IdInt,
                            FinalProthesisTeeth = teeth,
                        };
                        _ciaDbContext.FinalProsthesisHealingCollars.Add(temp);
                        prosSingle.HealingCollars ??= new List<FinalProsthesisHealingCollar>();
                        prosSingle.HealingCollars.Add(temp);

                    }
                    for (int i = 0; i < rnd.Next(1, 5); i++)
                    {
                        var op = users[rnd.Next(users.Count - 1)];

                        var temp = new FinalProsthesisImpression
                        {
                            Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                            FinalProthesisImpressionNextVisit = Enum.GetValues<EnumFinalProthesisImpressionNextVisit>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisImpressionNextVisit>().Length - 1)],
                            FinalProthesisImpressionStatus = Enum.GetValues<EnumFinalProthesisImpressionStatus>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisImpressionStatus>().Length - 1)],
                            PatientId = p,

                            Operator = op,
                            OperatorId = op.IdInt,
                            FinalProthesisTeeth = teeth,
                        };
                        _ciaDbContext.FinalProsthesisImpressions.Add(temp);
                        prosSingle.Impressions ??= new List<FinalProsthesisImpression>();
                        prosSingle.Impressions.Add(temp);

                    }
                    for (int i = 0; i < rnd.Next(1, 5); i++)
                    {
                        var op = users[rnd.Next(users.Count - 1)];

                        var temp = new FinalProsthesisDelivery
                        {
                            Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                            FinalProthesisDeliveryNextVisit = Enum.GetValues<EnumFinalProthesisDeliveryNextVisit>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisDeliveryNextVisit>().Length - 1)],
                            FinalProthesisDeliveryStatus = Enum.GetValues<EnumFinalProthesisDeliveryStatus>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisDeliveryStatus>().Length - 1)],
                            PatientId = p,

                            Operator = op,
                            OperatorId = op.IdInt,
                            FinalProthesisTeeth = teeth,
                        };
                        _ciaDbContext.FinalProsthesisDeliveries.Add(temp);
                        prosSingle.Delivery ??= new List<FinalProsthesisDelivery>();
                        prosSingle.Delivery.Add(temp);

                    }
                    for (int i = 0; i < rnd.Next(1, 5); i++)
                    {
                        var op = users[rnd.Next(users.Count - 1)];

                        var temp = new FinalProsthesisTryIn
                        {
                            Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                            FinalProthesisTryInNextVisit = Enum.GetValues<EnumFinalProthesisTryInNextVisit>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisTryInNextVisit>().Length - 1)],
                            FinalProthesisTryInStatus = Enum.GetValues<EnumFinalProthesisTryInStatus>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisTryInStatus>().Length - 1)],
                            Operator = op,
                            PatientId = p,

                            OperatorId = op.IdInt,
                            FinalProthesisTeeth = teeth,
                        };
                        _ciaDbContext.FinalProsthesisTryIns.Add(temp);
                        prosSingle.TryIns ??= new List<FinalProsthesisTryIn>();
                        prosSingle.TryIns.Add(temp);

                    }
                }


                for (int i = 0; i < rnd.Next(1, 5); i++)
                {
                    var op = users[rnd.Next(users.Count - 1)];

                    var temp = new FinalProsthesisHealingCollar
                    {
                        Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                        FinalProthesisHealingCollarNextVisit = Enum.GetValues<EnumFinalProthesisHealingCollarNextVisit>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisHealingCollarNextVisit>().Length - 1)],
                        FinalProthesisHealingCollarStatus = Enum.GetValues<EnumFinalProthesisHealingCollarStatus>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisHealingCollarStatus>().Length - 1)],
                        PatientId = p,
                        Operator = op,
                        OperatorId = op.IdInt,
                    };
                    _ciaDbContext.FinalProsthesisHealingCollars.Add(temp);
                    prosFull.HealingCollars ??= new List<FinalProsthesisHealingCollar>();
                    prosFull.HealingCollars.Add(temp);

                }
                for (int i = 0; i < rnd.Next(1, 5); i++)
                {
                    var op = users[rnd.Next(users.Count - 1)];

                    var temp = new FinalProsthesisImpression
                    {
                        Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                        FinalProthesisImpressionNextVisit = Enum.GetValues<EnumFinalProthesisImpressionNextVisit>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisImpressionNextVisit>().Length - 1)],
                        FinalProthesisImpressionStatus = Enum.GetValues<EnumFinalProthesisImpressionStatus>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisImpressionStatus>().Length - 1)],
                        PatientId = p,
                        Operator = op,
                        OperatorId = op.IdInt,
                    };
                    _ciaDbContext.FinalProsthesisImpressions.Add(temp);
                    prosFull.Impressions ??= new List<FinalProsthesisImpression>();
                    prosFull.Impressions.Add(temp);

                }
                for (int i = 0; i < rnd.Next(1, 5); i++)
                {
                    var op = users[rnd.Next(users.Count - 1)];

                    var temp = new FinalProsthesisDelivery
                    {
                        Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                        FinalProthesisDeliveryNextVisit = Enum.GetValues<EnumFinalProthesisDeliveryNextVisit>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisDeliveryNextVisit>().Length - 1)],
                        FinalProthesisDeliveryStatus = Enum.GetValues<EnumFinalProthesisDeliveryStatus>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisDeliveryStatus>().Length - 1)],
                        PatientId = p,
                        Operator = op,
                        OperatorId = op.IdInt,
                    };
                    _ciaDbContext.FinalProsthesisDeliveries.Add(temp);
                    prosFull.Delivery ??= new List<FinalProsthesisDelivery>();
                    prosFull.Delivery.Add(temp);

                }
                for (int i = 0; i < rnd.Next(1, 5); i++)
                {
                    var op = users[rnd.Next(users.Count - 1)];

                    var temp = new FinalProsthesisTryIn
                    {
                        Date = new DateTime(rnd.Next(2020, 2023), rnd.Next(1, 12), rnd.Next(1, 28), rnd.Next(24), rnd.Next(59), rnd.Next(59)).ToUniversalTime(),
                        FinalProthesisTryInNextVisit = Enum.GetValues<EnumFinalProthesisTryInNextVisit>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisTryInNextVisit>().Length - 1)],
                        FinalProthesisTryInStatus = Enum.GetValues<EnumFinalProthesisTryInStatus>()[rnd.Next(0, Enum.GetValues<EnumFinalProthesisTryInStatus>().Length - 1)],
                        PatientId = p,
                        Operator = op,
                        OperatorId = op.IdInt,
                    };
                    _ciaDbContext.FinalProsthesisTryIns.Add(temp);
                    prosFull.TryIns ??= new List<FinalProsthesisTryIn>();
                    prosFull.TryIns.Add(temp);

                }



                _ciaDbContext.ProstheticTreatments.Update(prosDiagnostic);
                _ciaDbContext.ProstheticTreatmentFinalSingleBridges.Update(prosSingle);
                _ciaDbContext.ProstheticTreatmentFinalFullArchs.Update(prosFull);
            }


            var di = await _ciaDbContext.ProstheticTreatments_DiagnosticImpression.ToListAsync();
            var b = await _ciaDbContext.ProstheticTreatments_Bite.ToListAsync();
            var ss = await _ciaDbContext.ProstheticTreatments_ScanAppliance.ToListAsync();


            foreach (var temp in di.GetRange(0, di.Count / 2))
            {
                temp.Scanned = false;
            }
            foreach (var temp in b.GetRange(0, di.Count / 2))
            {
                temp.Scanned = false;
            }
            foreach (var temp in ss.GetRange(0, di.Count / 2))
            {
                temp.Scanned = false;
            }

            _ciaDbContext.ProstheticTreatments_DiagnosticImpression.UpdateRange(di);
            _ciaDbContext.ProstheticTreatments_Bite.UpdateRange(b);
            _ciaDbContext.ProstheticTreatments_ScanAppliance.UpdateRange(ss);
            _ciaDbContext.SaveChanges();




            return Ok();
        }




        //[HttpGet("RandomData")]
        //public async Task<IActionResult> RandomData()
        //{
        //    var t = await _ciaDbContext.TreatmentPlansSubModels.Where(

        //        x =>
        //        x.GBRWithImplant.Status == true
        //        || x.GuidedImplant.Status == true
        //        || x.ImmediateImplant.Status == true
        //        || x.SimpleImplant.Status == true
        //        || x.SplittingWithImplant.Status == true
        //        || x.OpenSinusWithImplant.Status == true
        //        || x.ClosedSinusWithImplant.Status == true
        //        || x.ExpansionWithImplant.Status == true
        //        || x.SimpleImplant.Status == true

        //        ).ToListAsync();
        //    var ts = t.GetRange(0, t.Count / 2);



        //    var dentals = await _ciaDbContext.DentalExaminations.Include(x => x.DentalExaminations).ToListAsync();

        //    foreach (var x in ts)
        //    {
        //        if (x.GBRWithImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //        else if (x.GuidedImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //        else if (x.ImmediateImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //        else if (x.SimpleImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //        else if (x.SplittingWithImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //        else if (x.OpenSinusWithImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //        else if (x.ClosedSinusWithImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //        else if (x.ExpansionWithImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //        else if (x.SimpleImplant?.Status == true)
        //        {
        //            var ddd = dentals.FirstOrDefault(y => y.PatientId == x.PatientId)?.DentalExaminations?.FirstOrDefault(y => y.Tooth == x.Tooth);
        //            if (ddd != null)
        //                ddd.ImplantFailed = true;
        //        }
        //    }

        //    _ciaDbContext.DentalExaminations.UpdateRange(dentals);


        //    var di = await _ciaDbContext.ProstheticTreatments_DiagnosticImpression.ToListAsync();
        //    var b = await _ciaDbContext.ProstheticTreatments_Bite.ToListAsync();
        //    var ss = await _ciaDbContext.ProstheticTreatments_ScanAppliance.ToListAsync();


        //    foreach (var temp in di.GetRange(0, di.Count / 2))
        //    {
        //        temp.Scanned = false;
        //    }
        //    foreach (var temp in b.GetRange(0, di.Count / 2))
        //    {
        //        temp.Scanned = false;
        //    }
        //    foreach (var temp in ss.GetRange(0, di.Count / 2))
        //    {
        //        temp.Scanned = false;
        //    }

        //    _ciaDbContext.ProstheticTreatments_DiagnosticImpression.UpdateRange(di);
        //    _ciaDbContext.ProstheticTreatments_Bite.UpdateRange(b);
        //    _ciaDbContext.ProstheticTreatments_ScanAppliance.UpdateRange(ss);
        //    _ciaDbContext.SaveChanges();
        //    return Ok();
        //}
    }
}
