using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.TreatmentModels;
using CIA.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace CIA.Repositories
{


    public class Medical_Repo : IMedical_Repo
    {
        private readonly CIA_dbContext _cia_DbContext;
        private readonly IUserRepo _iUserRepo;
        private readonly EnumWebsite _site;
        public Medical_Repo(IHttpContextAccessor httpContextAccessor, CIA_dbContext cIA_DbContext,  IUserRepo iUserRepo, INotificationRepo notificationRepo)
        {
            _cia_DbContext = cIA_DbContext;
            _iUserRepo = iUserRepo;
            var site = httpContextAccessor.HttpContext.Request.Headers["Site"].ToString();
            if (site == "")
                _site = EnumWebsite.CIA;
            else
                _site = (EnumWebsite)int.Parse(site);

        }
        public async Task<API_response> ConsumerImplant(int id)
        {
            API_response _aPI_Response = new API_response();
            var user = await _iUserRepo.GetUser();
            var implant = await _cia_DbContext.Implants.Include(x => x.Category).FirstOrDefaultAsync(x => x.Id == id);
            if (implant.Count == null ) { _aPI_Response.ErrorMessage = "This implant is not currently available"; return _aPI_Response; }
            var category = await _cia_DbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Implants" && x.Website == EnumWebsite.CIA);
            if (category == null)
            {
                category = new MedicalExpensesModel()
                {
                    Name = "Implants",
                    Website = _site
                };
                _cia_DbContext.MedicalExpenses.Add(category);
                _cia_DbContext.SaveChanges();

            }

            implant.Count -= 1;
            StockLog stockLog = new StockLog()
            {
                Count = 1,
                Date = DateTime.UtcNow,
                Name = implant.Name,
                OperatorId = (int)user.IdInt,
                Operator = user,
                Status = "Consumed",
                Website = _site
            };
            _cia_DbContext.Implants.Update(implant);
            _cia_DbContext.StockLogs.Add(stockLog);
            _cia_DbContext.SaveChanges();

            return _aPI_Response;
        }
    }
}
