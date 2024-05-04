using CIA.Models;

namespace CIA.Repositories.Interfaces
{
    public interface IPhotosRepo
    {
        public Task<int?> Save(IFormFile image, EnumImageType type);
        public Task<String?> Get(int? id);
    }
}
