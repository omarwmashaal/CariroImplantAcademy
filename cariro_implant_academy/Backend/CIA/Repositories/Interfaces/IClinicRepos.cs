using CIA.Models.CIA.TreatmentModels;

namespace CIA.Repositories.Interfaces
{
    public interface IClinicRepos
    {
        public Task UpdateDoctorFeesWithPatientId(int patientId);
        public Task UpdateTreatmentPrice(int patientId);
        public Task UpdateReceipt(int patientId);
    }
}
