using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.TreatmentModels;
using CIA.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;

namespace CIA.Repositories
{
    public class UserRepo : IUserRepo
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly CIA_dbContext _ciaDbContext;
        public UserRepo(IHttpContextAccessor httpContextAccessor, CIA_dbContext cIA_Db)
        {
            _httpContextAccessor = httpContextAccessor;
            _ciaDbContext = cIA_Db;
        }

        public async Task<int> GetCandidateTotalImplantData(int id)
        {
            var treatments = await _ciaDbContext.TreatmentDetails.
                 Include(x => x.TreatmentItem).
                 Include(x => x.Implant).
                 Where(x =>
                 x.TreatmentItem.Name.ToLower().Contains("implant") &&
                 !x.TreatmentItem.Name.ToLower().Contains("without") &&
                 x.DoneByCandidateID == id
                 ).ToListAsync();

            ;



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
            int total = 0;
            foreach (var data in tempCandidateDetails)
            {
                total += data.ImplantCount ?? 0;
            }
            return total;
        }

        public async Task<ApplicationUser?> GetUser()
        {
            var id = _httpContextAccessor.HttpContext.User.FindFirstValue("Id");
            var user = await _ciaDbContext.Users.FirstOrDefaultAsync(x => x.Id == id);
            return user;
        }


    }
}
