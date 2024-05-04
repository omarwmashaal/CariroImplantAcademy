using CIA.Repositories.Interfaces;

namespace CIA.Repositories
{
    public class EnumRepo : IEnumRepo
    {
        public EnumRepo() { }
        public  bool CompareEnums(object one, object two)
        {
            if (one == two)
                return true;
            return false;
        }
    }
}
