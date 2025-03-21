﻿using CIA.DataBases;
using CIA.Models;
using CIA.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace CIA.Repositories
{
    public class ScheduledTasks : IScheduledTasks
    {
        private readonly CIA_dbContext _dbContext;
        private readonly INotificationRepo _iNotification;
        public ScheduledTasks(CIA_dbContext dbContext, INotificationRepo iNotification)
        {
            _dbContext = dbContext;
            _iNotification = iNotification;
        }

        public async Task PatientToDoListCheck()
        {
            var toDoLists = await _dbContext.ToDoLists.Where(x => x.DueDate.Value.Date <= DateTime.UtcNow.Date && x.Done != true).Select(x => new
            {
                x.PatientId,
                x.OperatorId,
            }).Distinct().ToListAsync();

            foreach (var toDoList in toDoLists)
            {
                await _iNotification.ToDoList((int)toDoList.PatientId,toDoList.OperatorId??0);
            }
        }

        public async Task RemindHBA1CIn3Month()
        {
            //var patients = await _dbContext.Patients.Include(x => x.MedicalExamination)
            //    .Where(x => (x.MedicalExamination!.Notification_Hba1c != null) && x.MedicalExamination!.Notification_Hba1c <= DateTime.UtcNow)
            //    .ToListAsync();



            //foreach (var patient in patients)
            //{
            //    if (patient.MedicalExamination?.HBA1c != null)
            //    {
            //        if ((patient.MedicalExamination?.HBA1c.Last().Reading ?? 0) >= 7.5)
            //        {
            //            await _iNotification.HighHBA1C((int)patient.Id, (double)patient.MedicalExamination!.HBA1c!.Last()!.Reading!);
            //        }
            //    }
            //}
        }
    }
}
