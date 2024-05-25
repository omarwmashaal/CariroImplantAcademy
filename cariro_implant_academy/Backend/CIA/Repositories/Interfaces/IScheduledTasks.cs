namespace CIA.Repositories.Interfaces
{
    public interface IScheduledTasks
    {
        public Task RemindHBA1CIn3Month();
        public Task PatientToDoListCheck();
    }
}
