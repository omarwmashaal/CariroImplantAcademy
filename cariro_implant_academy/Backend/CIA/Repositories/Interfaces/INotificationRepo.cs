using CIA.Models;

namespace CIA.Repositories.Interfaces
{
    public interface INotificationRepo
    {
        public Task PatientEntersClinic(int patientId,int doctorId, int? roomId);
        public Task VisitScheduled(int patientId,int doctorId,DateTime date);
        public Task TreatmentAssigned(int patientId, int assignedUserId, int treatmentItemId);
        public Task NewComplain(CIA_Complains complain);
        public Task LAB_WaitingCustomerAction(int requestId, int userId, int patientId);
        public Task LAB_RequestUpdate(int requestId, int userId);
        public Task LAB_RequestAssigned(int requestId, int userId);
        public Task LAB_RequestReady(int requestId);
        public Task LAB_RequestFinishedDesign(int requestId);
        public Task LAB_RequestAdded(int requestId);
        public  Task AddChangeRequest(RequestChangeModel request);
        public  Task HighHBA1C(int patientId,double hba1c);
        public  Task ToDoList(int patientId,int operatorId);
        public  Task LabItemsLessThanThreshold(int parentId);
    }
}
