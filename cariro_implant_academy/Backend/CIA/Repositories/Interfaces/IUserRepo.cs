using CIA.Models.CIA;

namespace CIA.Repositories.Interfaces
{
    public interface IUserRepo
    {
        public Task<ApplicationUser?> GetUser();
        public Task<int> GetCandidateTotalImplantData(int id);
        
    }
}
