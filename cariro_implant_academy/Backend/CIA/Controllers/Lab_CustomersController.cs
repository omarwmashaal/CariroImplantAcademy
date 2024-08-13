using AutoMapper;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.DTOs;
using CIA.Models.LAB;
using CIA.Repositories;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Lab_CustomersController : BaseController
    {

        private readonly API_response _apiResponse;
        private readonly CIA_dbContext _dbContext;
        private readonly IMedical_Repo _iMedicalRepo;
        private readonly IMapper _mapper;
        private readonly IUserRepo _iUserRepo;
        private readonly UserManager<ApplicationUser> _userManager;

        public Lab_CustomersController(UserManager<ApplicationUser> userManager, CIA_dbContext cIA_DbContext, IMapper mapper, IMedical_Repo medical_Repo, IUserRepo iUserRepo)
        {
            _apiResponse = new API_response();
            _dbContext = cIA_DbContext;
            _mapper = mapper;
            _iMedicalRepo = medical_Repo;
            _iUserRepo = iUserRepo;
            _userManager = userManager;
        }

        [HttpPost("AddCustomer")]
        public async Task<ActionResult> AddCustomer([FromBody] AddCustomerDTO customer)
        {
            ApplicationUser user = new ApplicationUser();
            user.PhoneNumber = customer.PhoneNumber;
            user.Name = customer.Name;
            user.WorkPlace = customer.WorkPlace;
            user.WorkplaceId = customer.WorkplaceId;
            user.WorkPlaceEnum = customer.WorkPlaceEnum;
            user.RegisterationDate = DateTime.UtcNow;
            var u = await _iUserRepo.GetUser();
            user.RegisteredBy = u;
            user.RegisteredById = u.IdInt;


            if (user.WorkplaceId != null)
            {
                var workPlace = _dbContext.Lab_CustomerWorkPlaces.FirstOrDefault(x => x.Id == user.WorkplaceId);
                if (workPlace != null)
                {
                    var c = await _dbContext.Users.Include(x => x.WorkPlace).FirstOrDefaultAsync(x => x.Name == user.Name && x.WorkplaceId == user.WorkplaceId);
                    if (c != null)
                    {
                        _apiResponse.ErrorMessage = "Customer with same name and same work place already exists";
                        return BadRequest(_apiResponse);
                    }

                }
            }
            if (user.WorkPlace != null && user.WorkplaceId == null)
            {
                var workPlace = _dbContext.Lab_CustomerWorkPlaces.FirstOrDefault(x => x.Name == user.WorkPlace.Name);
                if (workPlace != null)
                {
                    _apiResponse.ErrorMessage = "Workplace with the same name already exists";
                    return BadRequest(_apiResponse);
                }
            }

            if (user.WorkplaceId == null && user.WorkPlace != null)
            {
                var workPlace = new Lab_CustomerWorkPlace
                {
                    Name = user.WorkPlace.Name
                };
                await _dbContext.Lab_CustomerWorkPlaces.AddAsync(workPlace);
                await _dbContext.SaveChangesAsync();
                user.WorkPlace = workPlace;
                user.WorkPlace.Id = workPlace.Id;
            }

            user.UserName = user.Name.ToLower().Replace(" ", "");
            var response = await _userManager.CreateAsync(user, "Pa$$word1");
            if (response.Succeeded)
            {
                await _userManager.AddToRoleAsync(user, "outsource");
                _apiResponse.Result = user;
                return Ok(_apiResponse);
            }

            _apiResponse.ErrorMessage = response.ToString();
            return BadRequest(_apiResponse);
        }



        [HttpGet("GetAllCusomters")]
        public async Task<IActionResult> GetAllCusomters()
        {
            _apiResponse.Result = await _dbContext.Users.Include(x => x.WorkPlace).ToListAsync();
            return Ok(_apiResponse);

        }

        [HttpGet("GetCusomter")]
        public async Task<IActionResult> GetCusomter(int id)
        {
            _apiResponse.Result = await _dbContext.Users.Include(x => x.WorkPlace).FirstOrDefaultAsync(x => x.IdInt == id);
            return Ok(_apiResponse);

        }

        [HttpGet("GetAllWorkPlaces")]
        public async Task<IActionResult> GetAllWorkPlaces()
        {
            _apiResponse.Result = await _dbContext.Lab_CustomerWorkPlaces.ToListAsync();
            return Ok(_apiResponse);

        }

        [HttpGet("SearchPatientsByType")]
        public async Task<IActionResult> GetOutSourcePatients(String? search, EnumWebsite type)
        {

            if (search == null)

                _apiResponse.Result = _dbContext.Patients.Where(x => x.Website == type).ToList();
            else
                _apiResponse.Result = _dbContext.Patients.Where(x => x.Website == type && x.Name.ToLower().Contains(search.ToLower()) ||  x.SecondaryId.ToLower().Contains(search.ToLower())).ToList();

            return Ok(_apiResponse);

        }










    }
}
