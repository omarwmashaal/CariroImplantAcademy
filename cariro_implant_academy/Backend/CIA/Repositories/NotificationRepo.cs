﻿using AutoMapper;
using CIA.Controllers;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.LAB.DTO;
using CIA.Repositories.Interfaces;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using System.Numerics;

namespace CIA.Repositories
{
    public class NotificationRepo : INotificationRepo
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly CIA_dbContext _dbContext;
        private readonly IHubContext<NotificationHub> _hubContext;
        private readonly IUserRepo _userRepo;
        private readonly IMapper _mapper;
        public NotificationRepo(CIA_dbContext dbContext, IHubContext<NotificationHub> context, IUserRepo userRepo, UserManager<ApplicationUser> userManager, IMapper mapper)
        {
            _dbContext = dbContext;
            _hubContext = context;
            _userRepo = userRepo;
            _userManager = userManager;
            _mapper = mapper;
        }
        public async Task PatientEntersClinic(int patientId, int doctorId, int? roomId)
        {

            var patient = await _dbContext.Patients.FirstAsync(x => x.Id == patientId);
            var doctor = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == doctorId);
            var room = await _dbContext.Rooms.FirstOrDefaultAsync(x => x.Id == roomId);

            var notification = new NotificationModel()
            {
                Content = $"Patient: {patient.Name}",
                Title = $"Patient Entered Clinic room {room.Name}",
                Date = DateTime.UtcNow,
                InfoId = patientId,
                Type = EnumNotificationType.Patient,
                Read = false,

            };

            notification.UserId = doctorId;
            notification.User = doctor;
            await _dbContext.AddAsync(notification);
            await _dbContext.SaveChangesAsync();
            var d = await _dbContext.Users.FirstAsync(x => x.IdInt == doctorId);

            if (d.Connections != null)
                foreach (var conn in d.Connections)
                {
                    await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                }



        }
        public async Task VisitScheduled(int patientId, int doctorId, DateTime date)
        {

            var patient = await _dbContext.Patients.FirstAsync(x => x.Id == patientId);
            var doctor = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == doctorId);

            var notification = new NotificationModel()
            {
                Content = $"You have a Scheduled Visit for patient {patient.Name} on {date.Day}/{date.Month}/{date.Year} ",
                Title = $"New Scheduled Visit on {date.Day}/{date.Month}/{date.Year}",
                Date = DateTime.UtcNow,
                InfoId = patientId,
                Type = EnumNotificationType.Patient,
                Read = false,

            };

            notification.UserId = doctorId;
            notification.User = doctor;
            await _dbContext.AddAsync(notification);
            await _dbContext.SaveChangesAsync();
            var d = await _dbContext.Users.FirstAsync(x => x.IdInt == doctorId);

            if (d.Connections != null)
                foreach (var conn in d.Connections)
                {
                    await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                }



        }
        public async Task TreatmentAssigned(int patientId, int assignedUserId, int treatmentItemId)
        {

            var user = await _userRepo.GetUser();
            var patient = await _dbContext.Patients.Include(x => x.Doctor).FirstAsync(x => x.Id == patientId);
            var assignedUser = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == assignedUserId);
            var treatmentItem = await _dbContext.TreatmentItems.FirstAsync(x => x.Id == treatmentItemId);
            var notification = new NotificationModel()
            {
                Content = $"{user.Name} assigned you \"{treatmentItem.Name}\" for patient: {patient.Name}",
                Title = "Treatment Assigned to you",
                Date = DateTime.UtcNow,
                InfoId = patientId,
                Type = EnumNotificationType.TreatmentPlan,
                Read = false,
                User = assignedUser,
                UserId = assignedUserId,
            };
            await _dbContext.AddAsync(notification);
            await _dbContext.SaveChangesAsync();
            if (assignedUser.Connections != null)
                foreach (var conn in assignedUser.Connections)
                {
                    await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                }




        }

        public async Task NewComplain(CIA_Complains complain)
        {
            List<NotificationModel> notifications = new List<NotificationModel>();
            String title = "";
            var patient = await _dbContext.Patients.Include(x => x.Doctor).FirstAsync(x => x.Id == complain.PatientID);

            notifications.Add(new NotificationModel()
            {
                Content = $"You are mentioined in Patient: {patient.Name} added new complain",
                Title = "New Complain",
                Date = DateTime.UtcNow,
                InfoId = patient.Id,
                Type = EnumNotificationType.Complains,
                Read = false,
                User = complain.MentionedDoctor,
                UserId = complain.MentionedDoctorId,
            });

            notifications.Add(new NotificationModel()
            {
                Content = $"Your Patient: {patient.Name} added new complain",
                Title = "New Complain",
                Date = DateTime.UtcNow,
                InfoId = patient.Id,
                Type = EnumNotificationType.Complains,
                Read = false,
                User = patient.Doctor,
                UserId = patient.DoctorID,
            });
            if (patient.DoctorID != complain.LastDoctorId)
            {
                notifications.Add(new NotificationModel()
                {
                    Content = $"Patient: {patient.Name} added new complain and you are last doctor",
                    Title = "New Complain",
                    Date = DateTime.UtcNow,
                    InfoId = patient.Id,
                    Type = EnumNotificationType.Complains,
                    Read = false,
                    User = complain.LastDoctor,
                    UserId = complain.LastDoctorId,
                });
            }
            if (patient.DoctorID != complain.LastDoctorId)
            {
                notifications.Add(new NotificationModel()
                {
                    Content = $"Patient: {patient.Name} added new complain and you are last supervisor",
                    Title = "New Complain",
                    Date = DateTime.UtcNow,
                    InfoId = patient.Id,
                    Type = EnumNotificationType.Complains,
                    Read = false,
                    User = complain.LastDoctor,
                    UserId = complain.LastDoctorId,
                });
            }
            var admins = await _userManager.GetUsersInRoleAsync("admin");
            foreach (var admin in admins)
            {
                notifications.Add(new NotificationModel()
                {
                    Content = $"Patient: {patient.Name} added new complain",
                    Title = "New Complain",
                    Date = DateTime.UtcNow,
                    InfoId = patient.Id,
                    Type = EnumNotificationType.Complains,
                    Read = false,
                    User = admin,
                    UserId = admin.IdInt,
                });
            }
            notifications = notifications.DistinctBy(x => x.UserId).ToList();
            notifications.RemoveAll(x => x.UserId == null);


            await _dbContext.Notifications.AddRangeAsync(notifications);
            await _dbContext.SaveChangesAsync();
            foreach (var not in notifications)
            {
                var user = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == not.UserId);
                if (user.Connections != null)
                    foreach (var conn in user.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }
            }





        }
        public async Task LAB_WaitingCustomerAction(int requestId, int userId, int patientId)
        {

            var user = await _dbContext.Users.FirstAsync(x => x.IdInt == userId);
            var sender = await _userRepo.GetUser();
            var patient = await _dbContext.Patients.FirstAsync(x => x.Id == patientId);
            var notification = new NotificationModel()
            {
                Content = $"{sender.Name} is waiting customer action in lab request {requestId} for patient {patient.Name}",
                Title = "Lab Request waiting your action",
                Date = DateTime.UtcNow,
                InfoId = requestId,
                Type = EnumNotificationType.LabRequest,
                Read = false,
                User = user,
                UserId = userId,
            };
            await _dbContext.AddAsync(notification);
            await _dbContext.SaveChangesAsync();
            if (user.Connections != null)
                foreach (var conn in user.Connections)
                {
                    await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                }




        }
        public async Task LAB_RequestUpdate(int requestId, int userId)
        {

            var user = await _dbContext.Users.FirstAsync(x => x.IdInt == userId);
            var sender = await _userRepo.GetUser();
            var notification = new NotificationModel()
            {
                Content = $"New update request {requestId} from user {sender.Name}",
                Title = "Lab Request Update",
                Date = DateTime.UtcNow,
                InfoId = requestId,
                Type = EnumNotificationType.LabRequest,
                Read = false,
                User = user,
                UserId = userId,
            };
            await _dbContext.AddAsync(notification);
            await _dbContext.SaveChangesAsync();
            if (user.Connections != null)
                foreach (var conn in user.Connections)
                {
                    await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                }




        }
        public async Task LAB_RequestAssigned(int requestId, int userId)
        {

            var user = await _dbContext.Users.FirstAsync(x => x.IdInt == userId);
            var sender = await _userRepo.GetUser();
            var notification = new NotificationModel()
            {
                Content = $"{sender.Name} assigned request {requestId} to you",
                Title = "Request assigned to you",
                Date = DateTime.UtcNow,
                InfoId = requestId,
                Type = EnumNotificationType.LabRequest,
                Read = false,
                User = user,
                UserId = userId,
            };
            await _dbContext.AddAsync(notification);
            await _dbContext.SaveChangesAsync();
            if (user.Connections != null)
                foreach (var conn in user.Connections)
                {
                    await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                }




        }
        public async Task LAB_RequestReady(int requestId)
        {

            var sender = await _userRepo.GetUser();
            var request = await _dbContext.Lab_Requests.Include(x => x.Patient).Include(x => x.Customer).FirstOrDefaultAsync(x => x.Id == requestId);

            var users = (await _userManager.GetUsersInRoleAsync("secretary")).ToList();
            users.RemoveAll(x => !x.AccessWebsites.Contains(EnumWebsite.Lab));
            users.Add(request.Customer);
            List<NotificationModel> notificationModels = new List<NotificationModel>();
            foreach (var user in users)
            {
                notificationModels.Add(
                    new NotificationModel()
                    {
                        Content = $"Lab Request for patient {request.Patient.Name} is ready by {sender.Name}",
                        Title = "Lab Request Finished",
                        Date = DateTime.UtcNow,
                        InfoId = requestId,
                        Type = EnumNotificationType.LabRequest,
                        Read = false,
                        User = user,
                        UserId = user.IdInt,
                    });
            }

            await _dbContext.AddRangeAsync(notificationModels);
            await _dbContext.SaveChangesAsync();
            foreach (var notification in notificationModels)
            {
                if (notification.User.Connections != null)
                    foreach (var conn in notification.User.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }
            }




        }

        public async Task AddChangeRequest(RequestChangeModel request)
        {

            var sender = await _userRepo.GetUser();

            var admins = await _userManager.GetUsersInRoleAsync("admin");

            List<NotificationModel> notifications = new List<NotificationModel>();
            foreach (var admin in admins)
            {
                notifications.Add(new NotificationModel()
                {
                    Content = $"User {sender.Name} requested to change: {request.Description}",
                    Title = "Change Request",
                    Date = DateTime.UtcNow,
                    InfoId = request.PatientId,
                    Type = EnumNotificationType.SurgicalTreatment,
                    Read = false,
                    User = admin,
                    UserId = admin.IdInt
                });
            }
            notifications = notifications.DistinctBy(x => x.UserId).ToList();
            notifications.RemoveAll(x => x.UserId == null);

            await _dbContext.Notifications.AddRangeAsync(notifications);
            await _dbContext.SaveChangesAsync();

            foreach (var notification in notifications)
            {
                if (notification.User.Connections != null)
                    foreach (var conn in notification.User.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }
            }






        }

        public async Task LAB_RequestAdded(int requestId)
        {

            var sender = await _userRepo.GetUser();
            var request = await _dbContext.Lab_Requests
                .Include(x => x.Patient)
                .Include(x => x.Customer)
                .Include(x => x.Designer)
                .FirstOrDefaultAsync(x => x.Id == requestId);
            var users = await _userManager.GetUsersInRoleAsync("labmoderator");
            if(request.Designer!=null)
            users.Add(request.Designer);
            
            foreach (var user in users)
            {
                var notification = new NotificationModel()
                {
                    Content = user == request.Designer ?
                           $"Your are assigned as Designer for Request of patient {request.Patient.Name}, added by {sender.Name}"
                    : $"Lab Request for patient {request.Patient.Name} is added by {sender.Name}",
                    Title = "New Lab Request",
                    Date = DateTime.UtcNow,
                    InfoId = requestId,
                    Type = EnumNotificationType.LabRequest,
                    Read = false,
                    User = user,
                    UserId = user.IdInt,
                };

                await _dbContext.AddAsync(notification);
                if (user.Connections != null)
                    foreach (var conn in user.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }
            }
            await _dbContext.SaveChangesAsync();
        }

        public async Task HighHBA1C(int patientId, double hba1c)
        {
            List<ApplicationUser> secretaries = (await _userManager.GetUsersInRoleAsync("secretary")).ToList();
            var patient = await _dbContext.Patients.Include(x => x.Doctor).Include(x => x.MedicalExamination).FirstAsync(x => x.Id == patientId);
            ApplicationUser? doctor = patient.Doctor;
            var users = new List<ApplicationUser>();

            if (secretaries != null)
                users.AddRange(secretaries.ToList());
            if (patient?.Doctor != null)
                users.Add(patient.Doctor);
            users = users.Distinct().ToList();

            foreach (var user in users)
            {
                var notification = new NotificationModel()
                {
                    Content = $"Patient {patient.Name} has high HBA1C of {hba1c}",
                    Title = "High HBA1C",
                    Date = DateTime.UtcNow,
                    InfoId = patientId,
                    Type = EnumNotificationType.Patient,
                    Read = false,
                    User = user,
                    UserId = user.IdInt,
                };
                _dbContext.Notifications.Add(notification);
                if (user.Connections != null)
                    foreach (var conn in user.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }
            }

            _dbContext.Patients.Update(patient);
            _dbContext.SaveChanges();

        }
        public async Task ToDoList(int patientId, int operatorId)
        {
            List<ApplicationUser> secretaries = (await _userManager.GetUsersInRoleAsync("secretary")).ToList();
            var patient = await _dbContext.Patients.Include(x => x.Doctor).FirstAsync(x => x.Id == patientId);
            ApplicationUser? doctor = patient.Doctor;
            var users = new List<ApplicationUser>();

            if (secretaries != null)
                users.AddRange(secretaries.ToList());
            if (patient?.Doctor != null)
                users.Add(patient.Doctor);
            users.Add(await _dbContext.Users.FirstAsync(x => x.IdInt == operatorId));
            users = users.Distinct().ToList();

            foreach (var user in users)
            {
                var notification = new NotificationModel()
                {
                    Content = $"Patient {patient.Name} has OverDue To Do List",
                    Title = "OverDue To Do List",
                    Date = DateTime.UtcNow,
                    InfoId = patientId,
                    Type = EnumNotificationType.Patient,
                    Read = false,
                    User = user,
                    UserId = user.IdInt,
                };
                _dbContext.Notifications.Add(notification);
                if (user.Connections != null)
                    foreach (var conn in user.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }
            }

            _dbContext.SaveChanges();

        }

        public async Task LAB_RequestFinishedDesign(int requestId)
        {
            var request = await _dbContext.Lab_Requests.AsNoTracking().FirstAsync(x => x.Id == requestId);
            List<ApplicationUser> users = new();
            users.AddRange(await _userManager.GetUsersInRoleAsync("labmoderator"));
            users.AddRange(await _userManager.GetUsersInRoleAsync("secretary"));
            users.Add(await _dbContext.Users.FirstAsync(x => x.IdInt == request.EntryById));
            users = users.Distinct().ToList();
            var sender = await _userRepo.GetUser();
            foreach (var user in users)
            {

                var notification = new NotificationModel()
                {
                    Content = $"{sender.Name} has finished Design of request {requestId}",
                    Title = "Lab Request Design Finished",
                    Date = DateTime.UtcNow,
                    InfoId = requestId,
                    Type = EnumNotificationType.LabRequest,
                    Read = false,
                    User = user,
                    UserId = user.IdInt,
                };
                await _dbContext.AddAsync(notification);
                await _dbContext.SaveChangesAsync();
                if (user.Connections != null)
                    foreach (var conn in user.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }

            }


        }

        public async Task LabItemsLessThanThreshold(int parentId,string size)
        {
            var parent = await _dbContext.LabItemParents.AsNoTracking().FirstAsync(x => x.Id == parentId);
            var items = await _dbContext.LabItems.Where(x => x.LabItemParentId == parentId && x.Size.Replace(" ", "") == size.Replace(" ", "")).ToListAsync();
            var sum = items.Sum(x => x.Count);
            List<ApplicationUser> users = new();
            users.AddRange(await _userManager.GetUsersInRoleAsync("labmoderator"));
            users.AddRange(await _userManager.GetUsersInRoleAsync("labtechnician"));
            users.AddRange(await _userManager.GetUsersInRoleAsync("secretary"));
            users.AddRange(await _userManager.GetUsersInRoleAsync("admin"));
            users = users.Distinct().ToList();
            var sender = await _userRepo.GetUser();
            foreach (var user in users)
            {

                var notification = new NotificationModel()
                {
                    Content = $"Only {sum} {parent.Name} of size {size} left in stock!",
                    Title = $"Lab {parent.Name} {size} Low Stock!",
                    Date = DateTime.UtcNow,
                    InfoId = null,
                    Type = null,
                    Read = false,
                    User = user,
                    UserId = user.IdInt,
                };
                await _dbContext.AddAsync(notification);
                await _dbContext.SaveChangesAsync();
                if (user.Connections != null)
                    foreach (var conn in user.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }

            }


        }

        public async Task VisitInfoUpdate(int patientId)
        {
            var patient = await _dbContext.Patients.FirstAsync(x => x.Id == patientId);
            var admins = await _userManager.GetUsersInRoleAsync("admin");

            foreach (var admin in admins)
            {
                var notification = new NotificationModel()
                {
                    Content = $"Visit Change Request",
                    Title = $"Patient {patient.Name} Visits has new change request!",
                    Date = DateTime.UtcNow,
                    InfoId = patient.Id,
                    Type = EnumNotificationType.PatientVisit,
                    Read = false,
                    UserId = (int)admin.IdInt,
                    User = admin,

                };
                await _dbContext.AddAsync(notification);
                await _dbContext.SaveChangesAsync();
                
                if (admin.Connections != null)
                    foreach (var conn in admin.Connections)
                    {
                        await _hubContext.Clients.Client(conn.ConnectionId).SendAsync("NewNotification", "");

                    }
            }


          
        

           

        }
    }
}
