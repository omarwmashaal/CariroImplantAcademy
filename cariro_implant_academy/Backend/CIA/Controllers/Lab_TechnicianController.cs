using AutoMapper;
using CIA.DataBases;
using CIA.Models.CIA;
using CIA.Models;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Lab_TechnicianController : BaseController
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly API_response _apiResponse;
        private readonly String secretKey;
        private readonly IMapper _mapper;
        private readonly CIA_dbContext _ciaDbContext;
        private readonly IUserRepo _userRepo;
        private readonly EnumWebsite _site;
        public Lab_TechnicianController(IUserRepo userRepo, IHttpContextAccessor httpContextAccessor, IConfiguration configuration, UserManager<ApplicationUser> userManager, IMapper mapper, CIA_dbContext cIA_DbContext, RoleManager<IdentityRole> roleManager)
        {

            _userManager = userManager;
            _apiResponse = new();
            _mapper = mapper;
            _ciaDbContext = cIA_DbContext;
            _roleManager = roleManager;
            secretKey = configuration.GetValue<String>("API_Settings:SecretKey");
            var site = httpContextAccessor.HttpContext.Request.Headers["Site"].ToString();
            _site = (EnumWebsite)int.Parse(site);
            _userRepo = userRepo;
        }

    }
}
