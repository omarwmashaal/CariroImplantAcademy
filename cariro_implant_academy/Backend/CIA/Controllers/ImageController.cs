using AutoMapper;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImageController : BaseController
    {
        private readonly API_response _apiResponse;
        private readonly CIA_dbContext _ciaDbContext;
        private readonly IPhotosRepo _photosRepo;
        private readonly IMapper _mapper;
        private readonly IUserRepo _userRepo;
        private readonly IEnumRepo _enumRepo;
        private readonly INotificationRepo _notificationRepo;
        public ImageController(INotificationRepo notificationRepo, IEnumRepo enumRepo, CIA_dbContext cIA_DbContext, IMapper mapper, IPhotosRepo photosRepo, IUserRepo userRepo)
        {
            _apiResponse = new API_response();
            _ciaDbContext = cIA_DbContext;
            _photosRepo = photosRepo;
            _userRepo = userRepo;
            _mapper = mapper;
            _enumRepo = enumRepo;
            _notificationRepo = notificationRepo;
        }

        [HttpPut("UploadImage")]
        public async Task<IActionResult> UploadImage([FromForm] IFormFile FileUpload, EnumImageType type, int id)
        {
            ApplicationUser user;
            Patient patient;




            var status = await _photosRepo.Save(FileUpload, type);
            if (status != null)
            {
                if (type == EnumImageType.UserProfile)
                {
                    user = _ciaDbContext.Users
                .Include(x => x.ProfileImage)
                .FirstOrDefault(x => x.IdInt == id);
                    if (user.ProfileImage != null && user.ProfileImageId != null) _ciaDbContext.Images.Remove(user.ProfileImage);
                    user.ProfileImageId = status;
                    _ciaDbContext.Users.Update(user);
                    _ciaDbContext.SaveChanges();
                }
                else
                {
                    patient = _ciaDbContext.Patients
                        .Include(x => x.ProfileImage)
                        .Include(x => x.IdBackImage)
                        .Include(x => x.IdFrontImage)
                        .FirstOrDefault(x => x.Id == id);
                    if (type == EnumImageType.PatientProfile)
                    {
                        //patient.ProfilePhoto = FileUpload.FileName;
                        if (patient.ProfileImage != null && patient.ProfileImageId != null) _ciaDbContext.Images.Remove(patient.ProfileImage);
                        patient.ProfileImageId = status;

                    }
                    else if (type == EnumImageType.IdBack)
                    {
                        //patient.IdBackPhoto = FileUpload.FileName;
                        if (patient.IdBackImage != null && patient.IdBackImage != null) _ciaDbContext.Images.Remove(patient.IdBackImage);
                        patient.IdBackImageId = status;
                    }
                    else if (type == EnumImageType.IdFront)
                    {
                        //patient.IdFrontPhoto = FileUpload.FileName;
                        if (patient.IdFrontImage != null && patient.IdFrontImage != null) _ciaDbContext.Images.Remove(patient.IdFrontImage);
                        patient.IdFrontImageId = status;
                    }
                    _ciaDbContext.Patients.Update(patient);
                    _ciaDbContext.SaveChanges();
                }


            }
            return status != null ? Ok(_apiResponse) : BadRequest(new API_response { ErrorMessage = "Failed to save photo" });

        }

        [HttpGet("DownloadImage")]
        public async Task<IActionResult> DownloadImage(int id)
        {
            // Check if the request contains multipart/form-data.
            var status = await _photosRepo.Get(id);
            return status != null ?
                Ok(
                    new API_response
                    {
                        Result = status
                    }
                    ) : BadRequest(new API_response { ErrorMessage = "Failed to get photo" });


        }


      

    }
}
