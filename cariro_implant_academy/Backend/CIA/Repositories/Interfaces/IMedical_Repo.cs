using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.TreatmentModels;

namespace CIA.Repositories.Interfaces
{
    public interface IMedical_Repo
    {
        public Task<API_response> ConsumerImplant(int id);
       
    }
}
