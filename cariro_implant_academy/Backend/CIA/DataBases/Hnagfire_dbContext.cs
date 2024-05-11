using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels;
using CIA.Models.LAB;
using CIA.Models.TreatmentModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;

namespace CIA.DataBases
{
    public class Hangfire_dbContext : DbContext
    {

        public Hangfire_dbContext(DbContextOptions<Hangfire_dbContext> options) : base(options)
        {
        }




       
    }
}
