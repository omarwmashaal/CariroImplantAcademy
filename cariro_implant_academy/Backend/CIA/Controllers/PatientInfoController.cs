﻿using AutoMapper;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels;
using CIA.Models.DTOs;
using CIA.Models.TreatmentModels;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Numerics;
using System.Xml.Linq;
using static CIA.Models.CIA.TreatmentModels.DentalExaminationModel;
using static CIA.Models.TreatmentModels.TreatmentPlanModel;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatientInfoController : BaseController
    {
        private readonly API_response _aPI_Response;
        private readonly CIA_dbContext _cia_DbContext;
        private readonly IPhotosRepo _photosRepo;
        private readonly IMapper _mapper;
        private readonly IUserRepo _userRepo;
        private readonly IEnumRepo _enumRepo;
        private readonly INotificationRepo _notificationRepo;
        private readonly EnumWebsite _site;
        public PatientInfoController(IHttpContextAccessor httpContextAccessor, INotificationRepo notificationRepo, IEnumRepo enumRepo, CIA_dbContext cIA_DbContext, IMapper mapper, IPhotosRepo photosRepo, IUserRepo userRepo)
        {
            _aPI_Response = new API_response();
            _cia_DbContext = cIA_DbContext;
            _photosRepo = photosRepo;
            _userRepo = userRepo;
            _mapper = mapper;
            _enumRepo = enumRepo;
            _notificationRepo = notificationRepo;
            var site = httpContextAccessor.HttpContext.Request.Headers["Site"].ToString();
            if (site == "")
                _site = EnumWebsite.CIA;
            else
                _site = (EnumWebsite)int.Parse(site);
        }
        [HttpPost("CreatePatient")]
        public async Task<ActionResult> CreatePatient([FromBody] AddPatientDTO patient)
        {

            var user = await _userRepo.GetUser();
            var patient_ = _mapper.Map<Patient>(patient);
            patient_.RegisteredById = user.IdInt;
            patient_.RegisteredBy = user;
            patient_.RegisterationDate = DateTime.UtcNow;

            var ids = await _cia_DbContext.Patients.OrderBy(x => x.Id).Select(x => x.Id).ToListAsync();

            int lastId = 0;
            foreach (var id in ids)
            {
                if (id == lastId + 1)
                    lastId = id;
                else if (id > lastId + 1)
                {
                    lastId += 1;
                    break;
                }

            }
            patient_.Id = lastId == 0 ? 1 : lastId;
            await _cia_DbContext.Patients.AddAsync(patient_);
            try
            {

                await _cia_DbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {

                await _cia_DbContext.SaveChangesAsync();
            }

            if (patient_.RelativePatientID != null)
                patient_.RelativePatient = await _cia_DbContext.Patients.FirstAsync(x => x.Id == patient_.RelativePatientID);
            patient = _mapper.Map<AddPatientDTO>(patient_);
            _aPI_Response.Result = _mapper.Map<AddPatientDTO>(patient);
            return Ok(_aPI_Response);
        }
        [HttpPut("AddToDoList")]
        public async Task<ActionResult> AddToDoList([FromBody] TodoList todoList)
        {

            var user = await _userRepo.GetUser();
            todoList.Operator = user;
            todoList.OperatorId = (int)user.IdInt;
            todoList.CreateDate = DateTime.UtcNow;
            await _cia_DbContext.ToDoLists.AddAsync(todoList);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetToDoLists")]
        public async Task<ActionResult> GetToDoLists(int patientId)
        {

            _aPI_Response.Result = await _cia_DbContext.ToDoLists.Where(x => x.PatientId == patientId).Include(X => X.Operator).OrderBy(x => x.CreateDate).ToListAsync();

            return Ok(_aPI_Response);
        }
        [HttpPost("UpdateToDoListItem")]
        public async Task<ActionResult> UpdateToDoListItem([FromBody] TodoList todoList, bool delete = false)
        {
            if (delete)
            {
                _cia_DbContext.ToDoLists.Remove(todoList);
                _cia_DbContext.SaveChanges();
                return Ok(_aPI_Response);
            }
            _cia_DbContext.ToDoLists.Update(todoList);
            _cia_DbContext.SaveChanges();

            return Ok(_aPI_Response);
        }


        [HttpGet("GetNextAvailableId")]
        public async Task<ActionResult> GetNextAvailableId()
        {
            //var patient = await _cia_DbContext.Patients.Where(x => x.Website == _site).OrderBy(x => x.SecondaryId).Select(x => x.SecondaryId).ToListAsync();

            //int lastId = 0;
            //foreach (var p in patient)
            //{
            //    if (p == lastId + 1)
            //        lastId = p;
            //    else if (p > lastId + 1)
            //    {
            //        lastId += 1;
            //        break;
            //    }

            //}
            //_aPI_Response.Result = lastId == 0 ? 1 : lastId;
            return Ok(_aPI_Response);
        }

        [HttpGet("CheckDuplicateId")]
        public async Task<ActionResult> CheckDuplicateId(String id)
        {
            _aPI_Response.Result = await _cia_DbContext.Patients.FirstOrDefaultAsync(x => x.SecondaryId == id && x.Website == _site);

            return Ok(_aPI_Response);
        }


        [HttpPost("SetPatientOut")]
        public async Task<ActionResult> SetPatientOut([FromQuery] int id, String? outReason)
        {

            var patient = await _cia_DbContext.Patients.FirstOrDefaultAsync(x => x.Id == id);
            patient.Out = !patient.Out;
            patient.OutReason = patient.Out ? outReason : null;
            _cia_DbContext.Patients.Update(patient);
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);

        }
        [HttpGet("GetPatientInfo")]
        public async Task<ActionResult> GetPatientInfo([FromQuery] int id)
        {
            var query = _cia_DbContext.Patients;
            var patient = await _mapper.ProjectTo<AddPatientDTO>(query, null).FirstOrDefaultAsync(x => x.Id == id);
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Paitent not found!";
                return BadRequest(_aPI_Response);
            }
            //var pat = _mapper.Map<AddPatientDTO>(patient);

            _aPI_Response.Result = patient;
            return Ok(_aPI_Response);

        }
        [HttpPut("UpdatePatientsInfo")]
        public async Task<ActionResult> UpdatePatientsInfo([FromBody] AddPatientDTO patient)
        {
            patient.Website = _site;
            var p = _cia_DbContext.Patients.FirstOrDefault(x => x.Id == patient.Id);
            p.Name = patient.Name;
            p.MaritalStatus = patient.MaritalStatus;
            p.Gender = patient.Gender;
            p.City = patient.City;
            p.DateOfBirth = patient.DateOfBirth;
            p.Address = patient.Address;
            p.Phone = patient.Phone;
            p.Phone2 = patient.Phone2;
            p.SecondaryId = patient.SecondaryId;
            p.NationalID = patient.NationalID;
            p.RelativePatientID = patient.RelativePatientID;
            p.Listed = patient.Listed;
            _cia_DbContext.Patients.Update(p);
            await _cia_DbContext.SaveChangesAsync();
            _aPI_Response.Result = p;
            return Ok(_aPI_Response);
        }

        [HttpGet("ListPatients")]
        public async Task<ActionResult> ListPatients(String? search, String? filter, bool? patientOut, bool? myPatients = false, bool? listed = true)
        {
            IQueryable<Patient> query = _cia_DbContext.Patients.Where(x => x.Website == _site && x.Listed == listed).
                    Include(x => x.ReferralPatient).
                    Include(x => x.RelativePatient).
                    Include(x => x.Doctor)
                    ;

            if (myPatients == true)
            {
                var user = await _userRepo.GetUser();
                query = query.Where(x => x.DoctorID == user.IdInt);
            }
            if (search != null && search != "null")
            {
                if (filter != "null" && filter.ToLower() == "name")
                    query = query.Where(x => x.Name.ToLower().Contains(search.ToLower()));

                else if (filter != "null" && filter.ToLower() == "phone")
                    query = query.Where(x => x.Phone.ToLower().Contains(search.ToLower()));
                else if (filter != "null" && filter.ToLower() == "id")
                    query = query.Where(x => x.SecondaryId.ToLower().Contains(search.ToLower()));
                else if (filter != "null" && filter.ToLower() == "all")
                    query = query.Where(x =>
                        x.Phone.ToLower().Contains(search.ToLower()) ||
                        x.Name.ToLower().Contains(search.ToLower()) ||
                        x.Gender.Value.ToString().ToLower().Contains(search.ToLower()) ||
                        x.RelativePatient.Name.ToLower().Contains(search.ToLower()) ||
                        x.ReferralPatient.Name.ToLower().Contains(search.ToLower()) ||
                        x.MaritalStatus.ToLower().Contains(search.ToLower())
                        );


            }
            if (patientOut != null)
            {
                query = query.Where(x => x.Out == patientOut);
            }

            _aPI_Response.Result = await query.
                    Select(x =>
                new
                {
                    x.Id,
                    x.SecondaryId,
                    x.Name,
                    x.Phone,
                    x.MaritalStatus,
                    x.Gender,
                    RelativePatient = x.RelativePatient == null ? null : x.RelativePatient.Name,
                    x.ReferralPatient,
                    x.DateOfBirth,
                    x.DoctorID,
                    x.Out,
                    x.Listed,
                    Doctor = x.Doctor == null ? null : x.Doctor.Name,
                }).OrderBy(x => x.Id).ToListAsync();
            return Ok(_aPI_Response);
        }


        [HttpGet("GetVisitsLog")]
        public async Task<ActionResult> GetVisitsLogs([FromQuery] int id)
        {
            var query = _cia_DbContext.VisitsLogs.Where(x => x.PatientID == id).OrderByDescending(x => x.Id);
            var visitsLog = await _mapper.ProjectTo<VisitDTO>(query, null).ToListAsync();
            foreach (var v in visitsLog)
            {
                if (v.Status.ToLower() == "scheduled" && v.ReservationTime != null && v.ReservationTime < DateTime.Now)
                {
                    v.Status = "Passed";
                    var visit = await _cia_DbContext.VisitsLogs.FirstAsync(x => x.Id == v.Id);
                    visit.Status = VisitsStatus.Passed;
                    _cia_DbContext.VisitsLogs.Update(visit);
                    _cia_DbContext.SaveChanges();
                }
            }

            _cia_DbContext.SaveChanges();
            _aPI_Response.Result = visitsLog;
            return Ok(_aPI_Response);
        }
        [HttpGet("ListVisitsLogs")]
        public async Task<ActionResult> ListVisitsLogs(String? search)
        {
            var query = _cia_DbContext.VisitsLogs.Where(x => x.Website == _site).OrderByDescending(x => x.ReservationTime);


            // var allVists = await _cia_DbContext.VisitsLogs.ToListAsync();
            //foreach(var t in allVists)
            // {
            //     t.Doctor = await _cia_DbContext.Users.FirstOrDefaultAsync(x => x.IdInt == t.DoctorID);
            //     t.Patient = await _cia_DbContext.Patients.FirstOrDefaultAsync(x => x.Id == t.PatientID);
            //     t.Room = await _cia_DbContext.Rooms.FirstOrDefaultAsync(x => x.Id == t.RoomId);
            //   //  t.Doctor = await _cia_DbContext.Users.FirstOrDefaultAsync(x => x.IdInt == t.DoctorID);
            // }
            // var visitsLog = _mapper.Map<List< VisitDTO >> (allVists);
            var visitsLog = await _mapper.ProjectTo<VisitDTO>(query, null).ToListAsync();

            foreach (var v in visitsLog)
            {
                if (v.Status.ToLower() == "scheduled" && v.ReservationTime != null && v.ReservationTime > DateTime.Now)
                {
                    v.Status = "Passed";
                    var visit = await _cia_DbContext.VisitsLogs.FirstAsync(x => x.Id == v.Id);
                    visit.Status = VisitsStatus.Passed;
                    _cia_DbContext.VisitsLogs.Update(visit);
                    _cia_DbContext.SaveChanges();
                }
            }

            _cia_DbContext.SaveChanges();
            if (search != null)
            {
                visitsLog = visitsLog.Where(x =>
                x.PatientName.ToLower().Contains(search.ToLower())
                || x.Status.ToLower().Contains(search.ToLower())
                || x.DoctorName.ToLower().Contains(search.ToLower())

                ).ToList();
            }

            _aPI_Response.Result = visitsLog;
            return Ok(_aPI_Response);
        }

        [HttpGet("GetAllSchedules")]
        public async Task<ActionResult> GetAllSchedules(int month)
        {
            var visitsLog = _cia_DbContext.VisitsLogs
                .Include(x => x.Room)
                .Include(x => x.Doctor)
                .Include(x => x.Patient)
                .Where(x => x.From != null && x.From.Value.Date.Month == month && x.Website == _site)
                .Select(x => new
                {
                    x.Id,
                    patientName = x.Patient.Name,
                    patientId = x.Patient.Id,
                    status = x.Status.ToString(),
                    x.ReservationTime,
                    x.RealVisitTime,
                    x.EntersClinicTime,
                    x.LeaveTime,
                    doctorName = x.Doctor.Name,
                    doctorId = x.Doctor.IdInt,
                    x.From,
                    x.To,
                    x.Room,
                    x.RoomId,
                    x.Duration,
                    Title = $"Patient: {x.Patient.Name} || {x.Title} || Dr: {x.Doctor.Name}"


                }).OrderByDescending(x => x.ReservationTime)
                .ToList();
            //   visitsLog = visitsLog.Where(x => x.From.Value.Day == 23).ToList();
            _aPI_Response.Result = visitsLog;

            return Ok(_aPI_Response);
        }


        [HttpGet("GetScheduleForDoctor")]
        public async Task<ActionResult> GetScheduleForDoctor(int month)
        {
            var user = await _userRepo.GetUser();
            var visitsLog = _cia_DbContext.VisitsLogs
                .Include(x => x.Doctor)
                .Include(x => x.Room)
                .Where(x => x.From != null && x.From.Value.Date.Month == month)
                .Where(x => x.Doctor == user && x.Website == _site).Select(x => new
                {
                    x.Id,
                    patientName = x.Patient.Name,
                    patientId = x.Patient.Id,
                    status = x.Status.ToString(),
                    x.ReservationTime,
                    x.RealVisitTime,
                    x.EntersClinicTime,
                    x.LeaveTime,
                    doctorName = x.Doctor.Name,
                    doctorId = x.Doctor.IdInt,
                    x.From,
                    x.To,
                    x.Room,
                    x.RoomId,
                    Title = $"Patient: {x.Patient.Name} || {x.Title} || Dr: {x.Doctor.Name}"


                }).OrderByDescending(x => x.ReservationTime)
                .ToList();
            _aPI_Response.Result = visitsLog;
            return Ok(_aPI_Response);
        }

        [HttpGet("GetAvailableRooms")]
        public async Task<ActionResult> GetAvailableRooms(DateTime from, DateTime to)
        {
            from = from.ToUniversalTime();
            to = to.ToUniversalTime();
            var AllRooms = await _cia_DbContext.Rooms.Where(x => x.Website == _site).ToListAsync();
            var Logs = await _cia_DbContext.VisitsLogs.Where(x => x.From.Value.Date == from.Date && x.Website == _site).ToListAsync();
            var BusyRooms = new List<RoomModel>();
            var AvailableRooms = new List<RoomModel>();
            //Looping through logs
            foreach (var log in Logs)
            {

                //only checking logs within timeslot
                if (
                    ((
                    log.From.Value.TimeOfDay.CompareTo(from.TimeOfDay) == 1 ||
                    log.From.Value.TimeOfDay.CompareTo(from.TimeOfDay) == 0
                    ) &&
                    log.From.Value.TimeOfDay.CompareTo(to.TimeOfDay) == -1) ||
                    (log.To.Value.TimeOfDay.CompareTo(from.TimeOfDay) == 1 &&
                    (log.To.Value.TimeOfDay.CompareTo(to.TimeOfDay) == -1) ||
                    (log.To.Value.TimeOfDay.CompareTo(to.TimeOfDay) == 0)

                    )
                    )
                {
                    //what rooms are busy in that timeslot
                    foreach (var room in AllRooms)
                    {
                        if (room.Id == log.RoomId)
                            BusyRooms.Add(room);
                    }
                }
            }
            BusyRooms = BusyRooms.Distinct().ToList();
            AvailableRooms = AllRooms.Except(BusyRooms).ToList();


            List<object> s = new List<object>();
            foreach (var c in AvailableRooms)
            {
                s.Add(new { id = c.Id, c.Name });
            }

            _aPI_Response.Result = s;
            return Ok(_aPI_Response);
        }



        [HttpPost("ScheduleVisit")]
        public async Task<ActionResult> ScheduleVisit([FromBody] VisitsLog visit, int? oldVisit)
        {
            visit.Website = _site;
            if (oldVisit != null)
            {
                var temp = await _cia_DbContext.VisitsLogs.FirstOrDefaultAsync(x => x.Id == oldVisit);
                temp.Status = VisitsStatus.ReScheduled;
                _cia_DbContext.VisitsLogs.Update(temp);
            }
            if (visit.DoctorID != null)
            {
                visit.Doctor = await _cia_DbContext.Users.FirstOrDefaultAsync(x => x.IdInt == visit.DoctorID);
            }

            //var history = await _cia_DbContext.VisitsLogs.OrderByDescending(x => x.Id).FirstOrDefaultAsync(x => x.PatientID == visit.PatientID && x.Status == VisitsStatus.Scheduled && x.RealVisitTime == null);
            //if (history != null)
            //{
            //    history.Status = VisitsStatus.Canceled;
            //    _cia_DbContext.VisitsLogs.Update(history);
            //}
            var visitLog = visit;
            visit.Patient = _cia_DbContext.Patients.FirstOrDefault(x => x.Id == visit.PatientID);
            visit.Status = VisitsStatus.Scheduled;
            visit.ReservationTime = ((DateTime)visit.From).ToUniversalTime();
            visit.From = visit.From.Value.ToUniversalTime();
            visit.To = visit.To.Value.ToUniversalTime();
            await _cia_DbContext.VisitsLogs.AddAsync(visitLog);
            await _cia_DbContext.SaveChangesAsync();
            _aPI_Response.Result = _cia_DbContext.VisitsLogs.Where(x => x.PatientID == visit.PatientID)
                .Select(x => new
                {
                    x.Id,
                    patientName = x.Patient.Name,
                    status = x.Status.ToString(),
                    x.ReservationTime,
                    x.RealVisitTime,
                    x.EntersClinicTime,
                    x.LeaveTime,
                    doctorName = x.Doctor.Name,
                    x.From,
                    x.To,
                    //      x.Color,
                    x.Title,
                    x.Treatment,

                }).OrderByDescending(x => x.Id).ToList();
            if (visit.DoctorID != null && visit.From != null)
                await _notificationRepo.VisitScheduled(visit.PatientID, (int)visit.DoctorID!, (DateTime)visit.From);
            return Ok(_aPI_Response);
        }


        [HttpPut("PatientVisits")]
        public async Task<ActionResult> PatientVisits([FromQuery] int id)
        {
            var visit = _cia_DbContext.VisitsLogs.Where(x =>
            x.PatientID == id && x.RealVisitTime != null
            && (
            x.RealVisitTime.Value.ToUniversalTime().Date == DateTime.UtcNow.Date ||
            x.ReservationTime.Value.ToUniversalTime().Date == DateTime.UtcNow.Date
            )

            )
                .OrderByDescending(x => x.Id)
                .FirstOrDefault();

            if (visit == null)
            {
                visit = new VisitsLog
                {
                    Patient = _cia_DbContext.Patients.FirstOrDefault(x => x.Id == id),
                    Status = VisitsStatus.NoReservation,
                    RealVisitTime = DateTime.UtcNow,
                    ReservationTime = null,
                    Website = _site,


                };
                await _cia_DbContext.VisitsLogs.AddAsync(visit);
            }
            else
            {
                visit.RealVisitTime = DateTime.UtcNow;
                visit.Status = VisitsStatus.Visited;
                _cia_DbContext.VisitsLogs.Update(visit);
            }
            await _cia_DbContext.SaveChangesAsync();
            _aPI_Response.Result = _cia_DbContext.VisitsLogs.Where(x => x.PatientID == id)
                .Select(x => new
                {
                    x.Id,
                    patientName = x.Patient.Name,
                    status = x.Status.ToString(),
                    x.ReservationTime,
                    x.RealVisitTime,
                    x.EntersClinicTime,
                    x.LeaveTime,
                    doctorName = x.Doctor.Name,
                    x.Treatment,
                    x.Duration


                }).OrderByDescending(x => x.Id).ToList();
            return Ok(_aPI_Response);
        }
        [HttpPut("PatientEntersClinic")]
        public async Task<ActionResult> PatientEntersClinic([FromQuery] int id, int doctorId, int? roomId)
        {
            var visit = _cia_DbContext.VisitsLogs.Where(x => x.PatientID == id).OrderByDescending(x => x.Id).FirstOrDefault();
            var doctor = await _cia_DbContext.Users.FirstOrDefaultAsync(x => x.IdInt == doctorId);
            if (visit == null || visit.RealVisitTime == null)
            {
                _aPI_Response.ErrorMessage = "Please register patinet's visit time!";
                return BadRequest(_aPI_Response);
            }
            else
            {
                visit.EntersClinicTime = DateTime.UtcNow;
                visit.From = DateTime.UtcNow;
                visit.To = DateTime.UtcNow.AddHours(1);
                visit.Title = "Not Scheduled";
                visit.Doctor = doctor;
                visit.DoctorID = doctorId;
                visit.RoomId = roomId ?? visit.RoomId;
                _cia_DbContext.VisitsLogs.Update(visit);

            }
            await _cia_DbContext.SaveChangesAsync();
            _aPI_Response.Result = _cia_DbContext.VisitsLogs.Include(x => x.Doctor).Where(x => x.PatientID == id)
                .Select(x => new
                {
                    x.Id,
                    patientName = x.Patient.Name,
                    status = x.Status.ToString(),
                    x.ReservationTime,
                    x.RealVisitTime,
                    x.EntersClinicTime,
                    x.LeaveTime,
                    doctorName = x.Doctor.Name,
                    x.Treatment,
                    x.Duration

                }).OrderByDescending(x => x.Id).ToList();

            await _notificationRepo.PatientEntersClinic(id, doctorId, visit.RoomId);

            return Ok(_aPI_Response);
        }
        [HttpPut("PatientLeavesClinic")]
        public async Task<ActionResult> PatientLeavesClinic([FromQuery] int id)
        {
            var visit = _cia_DbContext.VisitsLogs.Where(x => x.PatientID == id && x.RealVisitTime.Value.Date == DateTime.UtcNow.Date).OrderByDescending(x => x.Id).FirstOrDefault();
            if (visit == null || visit.RealVisitTime == null || visit.EntersClinicTime == null)
            {
                _aPI_Response.ErrorMessage = "Please register patinet's enter clinic time!";
                return BadRequest(_aPI_Response);
            }
            else
            {
                visit.LeaveTime = DateTime.UtcNow;
                visit.To = DateTime.UtcNow;
                visit.Duration = visit.LeaveTime - visit.EntersClinicTime;
                var non = await _cia_DbContext.NonSurgicalTreatment.Where(x => x.PatientId == id && x.Date.Value.Date == DateTime.UtcNow.Date).ToListAsync();
                visit.Treatment = "";
                foreach (var n in non)
                {
                    visit.Treatment += n.Treatment;
                }
                _cia_DbContext.VisitsLogs.Update(visit);
            }
            await _cia_DbContext.SaveChangesAsync();
            _aPI_Response.Result = _cia_DbContext.VisitsLogs.Where(x => x.PatientID == id)
                .Select(x => new
                {
                    x.Id,
                    patientName = x.Patient.Name,
                    status = x.Status.ToString(),
                    x.ReservationTime,
                    x.RealVisitTime,
                    x.EntersClinicTime,
                    x.LeaveTime,
                    doctorName = x.Doctor.Name,
                    x.Duration,
                    x.Treatment,



                }).OrderByDescending(x => x.Id)
                .ToList();
            return Ok(_aPI_Response);
        }
        [HttpPut("UpdateVisit")]
        public async Task<IActionResult> UpdateVisit([FromBody] VisitDTO visit, bool delete)
        {
            var v = await _cia_DbContext.VisitsLogs.FirstOrDefaultAsync(x => x.Id == visit.Id);
            if (delete == true)
            {
                _cia_DbContext.VisitsLogs.Remove(v);
                _cia_DbContext.SaveChanges();
                return Ok(_aPI_Response);
            }
            v.RealVisitTime = visit.RealVisitTime;
            v.ReservationTime = visit.ReservationTime;
            v.EntersClinicTime = visit.EntersClinicTime;
            v.LeaveTime = visit.LeaveTime;
            v.From = visit.From;
            v.To = visit.To;
            v.Title = visit.Title;
            v.RoomId = visit.RoomId ?? v.RoomId;
            if (v.LeaveTime != null && v.EntersClinicTime != null)
                v.Duration = v.LeaveTime - v.EntersClinicTime;

            _cia_DbContext.VisitsLogs.Update(v);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);


        }
        [HttpPost("CompareDuplicateNumber")]
        public async Task<IActionResult> CompareDuplicateNumber(String number)
        {
            var check = _cia_DbContext.Patients.Where(x => x.Phone == number && x.Website == _site).FirstOrDefault();
            if (check != null)
                _aPI_Response.Result = check.Name;
            else _aPI_Response.Result = null;
            return Ok(_aPI_Response);
        }
        [HttpGet("QuickSearch")]
        public async Task<IActionResult> QuickSearch(String name)
        {
            List<DropDowns> result = new List<DropDowns>();
            var quickSearch = await _cia_DbContext.Patients.Where(x => x.Name.ToLower().Contains(name.ToLower()) && x.Website == _site).ToListAsync();
            if (quickSearch != null || quickSearch.Count != 0)
            {
                foreach (var ss in quickSearch)
                {
                    result.Add(new DropDowns
                    {
                        Name = ss.Name,
                        Id = ss.Id,
                    });
                }
            }
            _aPI_Response.Result = result;
            return Ok(_aPI_Response);
        }

        [HttpPost("AddToMyPatients")]
        public async Task<IActionResult> AddToMyPatients(int id)
        {
            var patient = await _cia_DbContext.Patients.FirstOrDefaultAsync(x => x.Id == id);
            var user = await _userRepo.GetUser();
            patient.Doctor = user;
            patient.DoctorID = user.IdInt;
            _cia_DbContext.Patients.Update(patient);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }

        [HttpPost("AddRangeToMyPatients")]
        public async Task<IActionResult> AddRangeToMyPatients(int from, int to)
        {
            var patients = await _cia_DbContext.Patients.Where(x => x.Id >= from && x.Id <= to).ToListAsync();
            var user = await _userRepo.GetUser();
            foreach (var patient in patients)
            {
                patient.Doctor = user;
                patient.DoctorID = user.IdInt;
            }

            _cia_DbContext.Patients.UpdateRange(patients);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }

        [HttpPost("RemoveFromMyPatients")]
        public async Task<IActionResult> RemoveFromMyPatients(int id)
        {
            var patient = await _cia_DbContext.Patients.Include(x => x.Doctor).FirstOrDefaultAsync(x => x.Id == id);
            var user = await _userRepo.GetUser();
            if (patient.Doctor == user)
            {
                patient.Doctor = null;
                patient.DoctorID = null;
                _cia_DbContext.Patients.Update(patient);
                _cia_DbContext.SaveChanges();

            }

            return Ok(_aPI_Response);
        }



        [HttpGet("GetComplains")]
        public async Task<IActionResult> GetComplains(int? id, String? search, EnumComplainStatus? status)
        {
            IQueryable<CIA_Complains> query = _cia_DbContext.CIA_Complains.Where(x => x.Website == _site)
                // Include(x => x.LastDoctor).
                // Include(x => x.LastCandidate).
                // Include(x => x.LastSupervisor).
                // Include(x => x.MentionedDoctor).
                //Include(x => x.ResolvedBy).
                //  Include(x => x.Patient).
                //Include(x => x.EntryBy)


                ;
            if (status != null)
            {
                query = query.Where(x => x.Status == status);
            }
            if (search != null)
            {
                search = search.ToLower();
                query = query.Where(x =>
                x.LastDoctor != null && x.LastDoctor.Name.ToLower().Contains(search) ||
                x.LastSupervisor != null && x.LastSupervisor.Name.ToLower().Contains(search) ||
                x.MentionedDoctor != null && x.MentionedDoctor.Name.ToLower().Contains(search) ||
                x.ResolvedBy != null && x.ResolvedBy.Name.ToLower().Contains(search) ||
                x.EntryBy != null && x.EntryBy.Name.ToLower().Contains(search) ||
                x.Patient != null && x.Patient.Name.ToLower().Contains(search));
            }
            query = query.OrderByDescending(x => x.EntryTime);




            if (id != null)
                query = query.Where(x => x.PatientID == id);
            var y = await query.Select(x => new
            {
                x.Id,
                x.Comment,
                x.PatientID,
                SecondaryId = x.Patient.SecondaryId,
                Patient = new { name = x.Patient.Name, id = x.Patient.Id },
                x.LastDoctorId,
                LastDoctor = new { name = x.LastDoctor.Name, id = x.LastDoctor.IdInt },
                x.LastSupervisorId,
                LastSupervisor = new { name = x.LastSupervisor.Name, id = x.LastSupervisor.IdInt },
                x.MentionedDoctorId,
                MentionedDoctor = new { name = x.MentionedDoctor.Name, id = x.MentionedDoctor.IdInt },
                x.EntryById,
                EntryBy = new { name = x.EntryBy.Name, id = x.EntryBy.IdInt },
                x.EntryTime,
                x.Status,
                x.QueueNotes,
                x.ResolvedById,
                ResolvedBy = new { name = x.ResolvedBy.Name, id = x.ResolvedBy.IdInt },

            }).ToListAsync();
            return Ok(
                new API_response()
                {
                    Result = y
                }
                );

        }
        [HttpPost("AddComplain")]
        public async Task<IActionResult> AddComplains([FromBody] CIA_Complains complain)
        {
            complain.Website = _site;
            var patient = await _cia_DbContext.Patients.
                Include(x => x.NonSurgicalTreatment).
                ThenInclude(x => x.Operator).
                Include(x => x.NonSurgicalTreatment).
                ThenInclude(x => x.Supervisor).
                FirstAsync(x => x.Id == complain.PatientID);
            var treatment = patient.NonSurgicalTreatment.OrderByDescending(x => x.Date).FirstOrDefault();
            if (treatment != null)
            {
                complain.LastDoctor = treatment.Operator;
                complain.LastDoctorId = treatment.OperatorID;
                //complain.LastCandidate = await _cia_DbContext.Users.FirstAsync(x => x.IdInt == complain.LastCandidateId);
                complain.LastSupervisor = treatment.Supervisor;
                complain.LastSupervisorId = treatment.SupervisorID;

            }

            if (complain.MentionedDoctorId != null)
                complain.MentionedDoctor = await _cia_DbContext.Users.FirstAsync(x => x.IdInt == complain.MentionedDoctorId);

            complain.EntryBy = await _userRepo.GetUser();
            complain.EntryById = complain.EntryBy.IdInt;
            complain.EntryTime = DateTime.UtcNow;
            complain.Status = EnumComplainStatus.Untouched;

            await _cia_DbContext.CIA_Complains.AddAsync(complain);
            await _cia_DbContext.SaveChangesAsync();



            await _notificationRepo.NewComplain(complain);

            return Ok(_aPI_Response);

        }
        [HttpPut("ResolveComplain")]
        public async Task<IActionResult> ResolveComplain(int id)
        {
            var complain = await _cia_DbContext.CIA_Complains.FirstAsync(x => x.Id == id);
            var user = await _userRepo.GetUser();
            complain.Status = EnumComplainStatus.Resolved;
            complain.ResolvedBy = user;
            complain.ResolvedById = (int)user.IdInt;
            _cia_DbContext.CIA_Complains.Update(complain);
            await _cia_DbContext.SaveChangesAsync();


            return Ok(_aPI_Response);

        }


        [HttpPut("InQueueComplain")]
        public async Task<IActionResult> InQueueComplain(int id, String? notes)
        {
            var complain = await _cia_DbContext.CIA_Complains.FirstAsync(x => x.Id == id);
            var user = await _userRepo.GetUser();
            complain.Status = EnumComplainStatus.InQueue;
            complain.QueueNotes = notes;
            complain.ResolvedBy = user;
            complain.ResolvedById = (int)user.IdInt;
            _cia_DbContext.CIA_Complains.Update(complain);
            await _cia_DbContext.SaveChangesAsync();



            return Ok(_aPI_Response);

        }
        [HttpPut("UpdateComplainNotes")]
        public async Task<IActionResult> UpdateComplainNotes(int id, String notes)
        {
            var complain = await _cia_DbContext.CIA_Complains.FirstAsync(x => x.Id == id);
            var user = await _userRepo.GetUser();
            complain.QueueNotes = notes;
            complain.ResolvedBy = user;
            complain.ResolvedById = (int)user.IdInt;
            _cia_DbContext.CIA_Complains.Update(complain);
            await _cia_DbContext.SaveChangesAsync();


            return Ok(_aPI_Response);

        }


        [HttpGet("GetTodaysReceipt")]
        public async Task<IActionResult> GetTodaysReceipt(int id)
        {

            var receipt =

                await _cia_DbContext.Receipts.OrderByDescending(x => x.Date).AsNoTracking().FirstOrDefaultAsync(x => x.PatientId == id);

            var receiptDto = _mapper.Map<ReceiptDTO>(receipt);


            receiptDto.ClinicPrices = _mapper.Map<List<DropDowns>>(receipt.Prices);

            _aPI_Response.Result = receiptDto;





            return Ok(_aPI_Response);
        }
        [HttpGet("GetLastReceipt")]
        public async Task<IActionResult> GetLastReceipt(int id)
        {


            var receipt =

               
                     _cia_DbContext
                .Receipts
                .Where(x => x.Website == _site)

                .OrderByDescending(x => x.Date).AsNoTracking()

                    .FirstOrDefaultAsync(x => x.PatientId == id);


            var receiptDto = _mapper.Map<ReceiptDTO>(receipt);


            //receipts.ClinicPrices = _mapper.Map<List<DropDowns>>(receipt.Prices);

            _aPI_Response.Result = receiptDto;
            return Ok(_aPI_Response);
        }

        [HttpGet("GetReceipts")]
        public async Task<IActionResult> GetReceipts(int id)
        {
            var receipts =

                await 
                     _cia_DbContext
                .Receipts
                .Include(x=>x.Patient)
                .Include(x=>x.Operator)
                .Where(x => x.Website == _site && x.PatientId == id).AsNoTracking()

                .OrderByDescending(x => x.Date)

                    .ToListAsync();
            var receiptDto = _mapper.Map<List<ReceiptDTO>>(receipts);


            //receipts.ClinicPrices = _mapper.Map<List<DropDowns>>(receipt.Prices);

            _aPI_Response.Result = receiptDto;
            return Ok(_aPI_Response);
        }
        [HttpGet("GetReceiptById")]
        public async Task<IActionResult> GetReceiptById(int id)
        {
            var receipt =

                await _cia_DbContext
                .Receipts
                .Where(x => x.Website == _site)
                .Include(x=>x.Patient)
                .Include(x=>x.Operator)
                .OrderByDescending(x => x.Date).AsNoTracking()
                .FirstOrDefaultAsync(x => x.Id == id);

            var receiptDto = _mapper.Map<ReceiptDTO>(receipt);

            receiptDto.ClinicPrices = _mapper.Map<List<DropDowns>>(receipt.Prices);


            _aPI_Response.Result = receiptDto;
            return Ok(_aPI_Response);
        }

        [HttpGet("GetAllPaymentLogs")]
        public async Task<IActionResult> GetAllPaymentLogs(int id)
        {
            var logs = await _cia_DbContext.PaymentLogs.Include(x => x.Patient).Include(x => x.Operator).OrderByDescending(x => x.Date).Where(x => x.PatientId == id && x.Website == _site).ToListAsync();
            _aPI_Response.Result = logs;
            return Ok(_aPI_Response);
        }
        [HttpGet("GetPaymentLogsForAReceipt")]
        public async Task<IActionResult> GetPaymentLogsForAReceipt(int id, int receiptId)
        {
            var logs = await _cia_DbContext.PaymentLogs.Include(x => x.Patient).Include(x => x.Operator).OrderByDescending(x => x.Date).Where(x => x.PatientId == id && x.ReceiptId == receiptId && x.Website == _site).ToListAsync();
            _aPI_Response.Result = logs;
            return Ok(_aPI_Response);
        }

        [HttpPost("AddPayment")]
        public async Task<IActionResult> AddPayment(int id, int receiptId, int paidAmount)
        {
            var cat = await _cia_DbContext.IncomeCategories.Where(x => x.Website == EnumWebsite.CIA).FirstOrDefaultAsync(x => x.Name == "Patients");
            if (cat == null)
            {
                cat = new IncomeCategoriesModel()
                {
                    Name = "Patients",
                    Website = _site
                };
                _cia_DbContext.IncomeCategories.Add(cat);
                _cia_DbContext.SaveChanges();
            }
            var user = await _userRepo.GetUser();
            var receipt = await _cia_DbContext.Receipts.FirstOrDefaultAsync(x => x.Id == receiptId);
            PaymentLog paymentLog = new PaymentLog()
            {
                Date = DateTime.UtcNow,
                Operator = user,
                OperatorId = (int)user.IdInt,
                PaidAmount = paidAmount,
                Patient = await _cia_DbContext.Patients.FirstAsync(x => x.Id == id),
                PatientId = id,
                Receipt = receipt,
                ReceiptId = receiptId,
                Website = _site
            };
            await _cia_DbContext.PaymentLogs.AddAsync(paymentLog);
            await _cia_DbContext.SaveChangesAsync();
            receipt.Paid += paidAmount;
            receipt.Unpaid = receipt.Total - receipt.Paid;
            _cia_DbContext.Receipts.Update(receipt);
            await _cia_DbContext.SaveChangesAsync();
            IncomeModel income = new IncomeModel()
            {

                CreatedBy = user,
                CreatedById = (int)user.IdInt,
                Category = cat,
                Date = DateTime.UtcNow,
                Price = paidAmount,
                Receipt = receipt,
                ReceiptID = receiptId,
                Patient = paymentLog.Patient,
                PatientId = id,
                PaymentLog = paymentLog,
                PaymentLogId = paymentLog.Id,
                Website = _site

            };
            _cia_DbContext.Income.Add(income);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }

        [HttpPost("RemovePayment")]
        public async Task<IActionResult> AddPayment(int id)
        {
            var income = await _cia_DbContext.Income.FirstOrDefaultAsync(x => x.Website == EnumWebsite.CIA && x.PaymentLogId == id);
            _cia_DbContext.Income.Remove(income);
            _cia_DbContext.SaveChanges();

            var paymentLog = await _cia_DbContext.PaymentLogs.FirstOrDefaultAsync(x => x.Id == id);
            var receipt = await _cia_DbContext.Receipts.FirstOrDefaultAsync(x => x.Id == paymentLog.ReceiptId);
            _cia_DbContext.PaymentLogs.Remove(paymentLog);
            _cia_DbContext.SaveChanges();
            var recieptPaymentLogs = await _cia_DbContext.PaymentLogs.Where(x => x.ReceiptId == receipt.Id).ToListAsync();
            receipt.Paid = 0;
            receipt.Unpaid = receipt.Total;
            foreach (var log in recieptPaymentLogs)
            {
                receipt.Paid += log.PaidAmount;
            }
            receipt.Unpaid = receipt.Total - receipt.Paid;
            _cia_DbContext.Receipts.Update(receipt);
            _cia_DbContext.SaveChanges();


            return Ok(_aPI_Response);
        }

        [HttpGet("GetTotalDebt")]
        public async Task<IActionResult> GetTotalDebt(int id)
        {
            var receipts = await _cia_DbContext.Receipts.Where(x => x.Website == _site).Where(x => x.PatientId == id).ToListAsync();
            int debt = 0;
            foreach (var rec in receipts)
            {
                debt += rec.Unpaid;
            }
            _aPI_Response.Result = debt;
            return Ok(_aPI_Response);
        }

        [HttpPost("AdvancedSearchPatient")]
        public async Task<IActionResult> AdvancedSearchPatient([FromBody] AdvancedPatientSearchDTO model)
        {
            IQueryable<Patient> query = _cia_DbContext.Patients.Include(x => x.MedicalExamination).Include(x => x.DentalExamination).Include(x => x.DentalHistory);
            List<IQueryable> selectables;

            if (!model.Ids.IsNullOrEmpty())
            {
                query = query.Where(x => model.Ids.Contains((int)x.Id));
            }
            if (model.NoTreatmentPlan == true)
            {
                List<int> patientIds = (await _cia_DbContext.Patients.Select(x => x.Id).ToListAsync()) ?? new List<int>();

                List<int> treatmentIds = (await _cia_DbContext.TreatmentDetails.Select(x => x.PatientId ?? 0).ToListAsync());

                var selectedIds = patientIds.Except(treatmentIds);

                query = query.Where(x => selectedIds.Contains(x.Id));
            }

            if (model.AgeRangeFrom != null)
            {
                TimeSpan ageFrom = TimeSpan.FromDays(((double)model.AgeRangeFrom) * 365);
                query = query.Where(x => DateTime.UtcNow - ((DateOnly)(x.DateOfBirth)).ToDateTime(TimeOnly.Parse("12:00 AM")).ToUniversalTime() >= ageFrom);

            }
            if (model.AgeRangeTo != null)
            {
                TimeSpan ageTo = TimeSpan.FromDays(((double)model.AgeRangeTo) * 365);
                query = query.Where(x => DateTime.UtcNow - ((DateOnly)(x.DateOfBirth)).ToDateTime(TimeOnly.Parse("12:00 AM")).ToUniversalTime() <= ageTo);
            }
            if (model.Gender != null)
            {
                query = query.Where(x => x.Gender == model.Gender);
            }
            if (model.AnyDiseases == true)
            {
                query = query.Where(x => x.MedicalExamination != null && x.MedicalExamination.Diseases != null && x.MedicalExamination.Diseases.Count != 0);
            }
            if (model.DiabetesCategories != null)
            {
                List<IQueryable<Patient>> tempQueries = new List<IQueryable<Patient>>();
                foreach (var b in model.DiabetesCategories)
                {
                    tempQueries.Add(query.Where(x => x.MedicalExamination.Diabetic.Status == b));
                }

                if (tempQueries.Count > 0)
                {
                    IQueryable<Patient> finalQuery = tempQueries.First();
                    foreach (var q in tempQueries)
                    {

                        finalQuery = finalQuery.Union(q);
                    }
                    query = finalQuery;
                }

            }
            if (model.BloodPressureCategories != null)
            {
                List<IQueryable<Patient>> tempQueries = new List<IQueryable<Patient>>();
                foreach (var b in model.BloodPressureCategories)
                {
                    tempQueries.Add(query.Where(x => x.MedicalExamination.BloodPressure.Status == b));

                }

                if (tempQueries.Count > 0)
                {
                    IQueryable<Patient> finalQuery = tempQueries.First();
                    foreach (var q in tempQueries)
                    {

                        finalQuery = finalQuery.Union(q);
                    }
                    query = finalQuery;

                }

            }

            if (model.LastHAB1c_From != null)
            {
                query = query.Where(x => x.MedicalExamination != null && x.MedicalExamination.HBA1c != null && x.MedicalExamination.HBA1c.OrderByDescending(e => e.Date).First().Reading != null && x.MedicalExamination.HBA1c.OrderByDescending(e => e.Date).First().Reading >= model.LastHAB1c_From);
            }
            if (model.LastHAB1c_To != null)
            {
                query = query.Where(x => x.MedicalExamination != null && x.MedicalExamination.HBA1c != null && x.MedicalExamination.HBA1c.OrderByDescending(e => e.Date).First().Reading != null && x.MedicalExamination.HBA1c.OrderByDescending(e => e.Date).First().Reading <= model.LastHAB1c_To);
            }
            if (model.Penecilin != null)
            {
                query = query.Where(x => x.MedicalExamination != null && x.MedicalExamination.Penicillin == model.Penecilin);
            }
            if (model.IllegalDrugs != null)
            {
                query = query.Where(x => x.MedicalExamination != null && model.IllegalDrugs == true ? (x.MedicalExamination.IllegalDrugs != null && x.MedicalExamination.IllegalDrugs != "") : (x.MedicalExamination.IllegalDrugs == null || x.MedicalExamination.IllegalDrugs == ""));
            }
            if (model.Pregnancy != null)
            {
                query = query.Where(x => x.MedicalExamination != null && x.MedicalExamination.PregnancyStatus == model.Pregnancy);
            }
            if (model.Chewing != null)
            {
                query = query.Where(x => x.DentalHistory != null && x.DentalHistory.BittingCheweing != null && x.DentalHistory.BittingCheweing == model.Chewing);
            }
            if (model.SmokingStatus != null)
            {
                query = query.Where(x => x.DentalHistory != null && x.DentalHistory.SmokingStatus == model.SmokingStatus);
            }
            if (model.CooperationScore != null)
            {

                if (model.CooperationScore == EnumCooperationScore.BadCooperation)
                {
                    query = query.Where(x => x.DentalHistory != null && x.DentalHistory.CooperationScore != null && x.DentalHistory.CooperationScore < 3);
                }
                else if (model.CooperationScore == EnumCooperationScore.FairCooperation)
                {
                    query = query.Where(x => x.DentalHistory != null && x.DentalHistory.CooperationScore != null && x.DentalHistory.CooperationScore >= 3 && x.DentalHistory.CooperationScore < 5);
                }
                else if (model.CooperationScore == EnumCooperationScore.GoodCooperation)
                {
                    query = query.Where(x => x.DentalHistory != null && x.DentalHistory.CooperationScore != null && x.DentalHistory.CooperationScore >= 5 && x.DentalHistory.CooperationScore < 7);
                }
                else if (model.CooperationScore == EnumCooperationScore.ExcellentCooperation)
                {
                    query = query.Where(x => x.DentalHistory != null && x.DentalHistory.CooperationScore != null && x.DentalHistory.CooperationScore >= 7);
                }
            }
            if (model.OralHygieneRating != null)
            {
                query = query.Where(x => x.DentalExamination != null && x.DentalExamination.OralHygieneRating == model.OralHygieneRating);

            }
            //Todo: Generate Seed Patients with advanced search dto random data
            //todo: atuomapping with dto

            _aPI_Response.Result = await query.Select(x => new
            {
                x.Id,
                x.SecondaryId,
                x.Name,
                Age = (model.AgeRangeTo == null && model.AgeRangeFrom == null) ? null : (int?)((DateTime.UtcNow - ((DateOnly)(x.DateOfBirth)).ToDateTime(TimeOnly.Parse("12:00 AM")).ToUniversalTime()).TotalDays / 365),
                Gender = model.Gender == null ? null : x.Gender,
                Diseases = model.AnyDiseases == null ? null : x.MedicalExamination.Diseases,
                BloodPressure = model.BloodPressureCategories == null ? null : x.MedicalExamination.BloodPressure.Status,
                Diabetes = model.DiabetesCategories == null ? null : x.MedicalExamination.Diabetic.Status,
                LastHAB1c = model.LastHAB1c_To == null && model.LastHAB1c_From == null ? null : x.MedicalExamination.HBA1c.OrderByDescending(e => e.Date).First().Reading,
                Penecilin = model.Penecilin == null ? null : (x.MedicalExamination.Penicillin),
                IllegalDrugs = model.IllegalDrugs == null ? null : (bool?)(x.MedicalExamination.IllegalDrugs.Length > 0),
                OralHygieneRating = model.OralHygieneRating == null ? null : (x.DentalExamination.OralHygieneRating),
                SmokingStatus = model.SmokingStatus == null ? null : x.DentalHistory.SmokingStatus,
                Chewing = model.Chewing == null ? null : x.DentalHistory.BittingCheweing

            }).ToListAsync();


            return Ok(_aPI_Response);
        }
        [HttpPost("AdvancedSearchTreatment")]
        public async Task<IActionResult> AdvancedSearchTreatment([FromBody] AdvancedTreatmentSearchDTO model)
        {
            IQueryable<TreatmentDetailsModel> query = _cia_DbContext.TreatmentDetails.Include(x => x.Patient).Include(x => x.TreatmentItem).Where(x => x.Website == _site);
            IQueryable<ComplicationsAfterSurgeryParentModel> complicationsSurgeryParentsQuery = _cia_DbContext.ComplicationsAfterSurgeryParents.Include(x => x.Complications);
            List<ComplicationsAfterSurgeryParentModel> complicationSurgeryParents = new List<ComplicationsAfterSurgeryParentModel>();


            List<DentalExaminationModel> faildImplantsDentalExaminations = new List<DentalExaminationModel>();



            if (!model.Ids.IsNullOrEmpty())
            {
                query = query.Where(x => model.Ids.Contains((int)x.PatientId));
            }
            if (model.ImplantFailed != null)
            {

                var dentalExaminations = await _cia_DbContext.DentalExaminations.ToListAsync();
                foreach (var dent in dentalExaminations)
                {
                    foreach (var dd in dent.DentalExaminations)
                        if (dd.ImplantFailed == true)
                        {
                            faildImplantsDentalExaminations.Add(dent);
                            break;
                        }


                }
                var tempIds = faildImplantsDentalExaminations.Select(y => y.PatientId).Distinct().ToList();


                query = query.Where(x => tempIds.Contains(x.PatientId));


            }

            if (model.complicationsAfterSurgery != null)
            {
                IQueryable<ComplicationsAfterSurgeryModel> complicationsQuery = _cia_DbContext.ComplicationsAfterSurgery;

                if (model.complicationsAfterSurgery!.Swelling == true)
                    complicationsSurgeryParentsQuery = complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "Swelling"));
                if (model.complicationsAfterSurgery!.OpenWound == true)
                    complicationsSurgeryParentsQuery = complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "OpenWound"));
                if (model.complicationsAfterSurgery!.Numbness == true)
                    complicationsSurgeryParentsQuery = complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "Numbness"));
                if (model.complicationsAfterSurgery!.OroantralCommunication == true)
                    complicationsSurgeryParentsQuery = complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "OroantralCommunication"));
                if (model.complicationsAfterSurgery!.PusInImplantSite == true)
                    complicationsSurgeryParentsQuery = complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "PusInImplantSite"));
                if (model.complicationsAfterSurgery!.PusInDonorSite == true)
                    complicationsSurgeryParentsQuery = complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "PusInDonorSite"));
                if (model.complicationsAfterSurgery!.SinusElevationFailure == true)
                    complicationsSurgeryParentsQuery = complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "SinusElevationFailure"));
                if (model.complicationsAfterSurgery!.GBRFailure == true)
                    complicationsSurgeryParentsQuery = complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "GBRFailure"));



                List<int> compliactionsPatientIds = await complicationsSurgeryParentsQuery.Select(x => (int)x.PatientId).Distinct().ToListAsync();

                query = query.Where(x => compliactionsPatientIds.Contains((int)x.PatientId));

            }
            if (model.complicationsAfterSurgeryOr != null)
            {

                List<IQueryable<ComplicationsAfterSurgeryParentModel>> complicationsQueries = new List<IQueryable<ComplicationsAfterSurgeryParentModel>>();

                if (model.complicationsAfterSurgeryOr!.Swelling == true)
                    complicationsQueries.Add(complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "Swelling")));
                if (model.complicationsAfterSurgeryOr!.OpenWound == true)
                    complicationsQueries.Add(complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "OpenWound")));
                if (model.complicationsAfterSurgeryOr!.Numbness == true)
                    complicationsQueries.Add(complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "Numbness")));
                if (model.complicationsAfterSurgeryOr!.OroantralCommunication == true)
                    complicationsQueries.Add(complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "OroantralCommunication")));
                if (model.complicationsAfterSurgeryOr!.PusInImplantSite == true)
                    complicationsQueries.Add(complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "PusInImplantSite")));
                if (model.complicationsAfterSurgeryOr!.PusInDonorSite == true)
                    complicationsQueries.Add(complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "PusInDonorSite")));
                if (model.complicationsAfterSurgeryOr!.SinusElevationFailure == true)
                    complicationsQueries.Add(complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "SinusElevationFailure")));
                if (model.complicationsAfterSurgeryOr!.GBRFailure == true)
                    complicationsQueries.Add(complicationsSurgeryParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "GBRFailure")));

                if (complicationsQueries.Count != 0)
                {
                    IQueryable<ComplicationsAfterSurgeryParentModel> finalComplicationsQuery = complicationsQueries.First();
                    foreach (var q in complicationsQueries)
                    {
                        finalComplicationsQuery = finalComplicationsQuery.Union(q);
                    }
                    complicationsSurgeryParentsQuery = finalComplicationsQuery;

                    List<int> compliactionsPatientIds = await complicationsSurgeryParentsQuery.Select(x => (int)x.PatientId).Distinct().ToListAsync();

                    query = query.Where(x => compliactionsPatientIds.Contains((int)x.PatientId));



                }

            }






            List<IQueryable<TreatmentDetailsModel>> tempQueries = new List<IQueryable<TreatmentDetailsModel>>();



            if (model.NoTreatmentPlan == true)
            {
                List<int> patientIds = (await _cia_DbContext.Patients.Where(x => model.Ids.Contains(x.Id)).Select(x => x.Id).ToListAsync()) ?? new List<int>();

                List<int> patientIdsWithTreatments = (await query.Select(x => x.PatientId ?? 0).ToListAsync());

                var selectedIds = patientIds.Except(patientIdsWithTreatments);

                _aPI_Response.Result = await _cia_DbContext.Patients.Select(x => new
                {
                    x.Id,
                    PatientName = x.Name,
                    x.SecondaryId
                }).Where(x => selectedIds.Contains(x.Id)).ToListAsync();

                return Ok(_aPI_Response);
            }

            else
            {

                if (model.TeethClassification != null)
                {
                    if (model.TeethClassification == EnumTeethClassification.UpperAnterior)
                    {
                        query = query.Where(x => x.Tooth != null && ((x.Tooth >= 11 && x.Tooth <= 13) || (x.Tooth >= 21 && x.Tooth <= 23)));
                    }
                    else if (model.TeethClassification == EnumTeethClassification.LowerAnterior)
                    {
                        query = query.Where(x => x.Tooth != null && ((x.Tooth >= 31 && x.Tooth <= 33) || (x.Tooth >= 41 && x.Tooth <= 43)));
                    }
                    else if (model.TeethClassification == EnumTeethClassification.UpperPosterior)
                    {
                        query = query.Where(x => x.Tooth != null && ((x.Tooth >= 14 && x.Tooth <= 18) || (x.Tooth >= 24 && x.Tooth <= 28)));
                    }
                    else if (model.TeethClassification == EnumTeethClassification.LowerPosterior)
                    {
                        query = query.Where(x => x.Tooth != null && ((x.Tooth >= 34 && x.Tooth <= 38) || (x.Tooth >= 44 && x.Tooth <= 48)));
                    }
                }
                foreach (var and_treatmentId in model.And_TreatmentIds)
                {
                    query = query.Where(x => x.TreatmentItemId == and_treatmentId && x.Status == true);
                }
                foreach (var or_treatmentId in model.Or_TreatmentIds)
                {
                    tempQueries.Add(query.Where(x => x.TreatmentItemId == or_treatmentId && x.Status == true));

                }

                if (tempQueries.Count > 0)
                {
                    IQueryable<TreatmentDetailsModel> finalQuery = tempQueries.First();
                    foreach (var q in tempQueries)
                    {

                        finalQuery = finalQuery.Union(q);
                    }
                    query = finalQuery;
                }
            }


            var finalResult = await query.Select(x => new AdvancedSearchTreatmentResponseModel
            {
                Id = x.PatientId,
                SecondaryId = x.Patient.SecondaryId,
                PatientName = x.Patient.Name,
                Tooth = x.Tooth,
                TreatmentName = x.TreatmentItem.Name,
                TreatmentId = (int)x.TreatmentItemId,
                TreatmentValue = x.Status == true ? $"Done tooth: {x.Tooth}" : $"Planned tooth: {x.Tooth}"
            }).ToListAsync();

            if (model.ImplantFailed != null)
            {
                foreach (var result in finalResult)
                {
                    var failedDental = faildImplantsDentalExaminations.FirstOrDefault(x => x.PatientId == result.Id);
                    result.ImplantFailed = failedDental.DentalExaminations.FirstOrDefault(x => x.Tooth == result.Tooth && x.ImplantFailed == true);
                    if (result.ImplantFailed != null && result.TreatmentName.ToLower().Contains("implant") && !result.TreatmentName.ToLower().Contains("without"))
                    {
                        result.TreatmentValue = result.TreatmentValue.Replace("Done", "Failed").Replace("Planned", "Failed");
                    }
                }
                finalResult.RemoveAll(x => x.ImplantFailed == null);
            }


            if (model.complicationsAfterSurgery != null || model.complicationsAfterSurgeryOr != null)
            {
                var complications = await complicationsSurgeryParentsQuery.ToListAsync();
                foreach (var result in finalResult)
                {
                    var com = complications.FirstOrDefault(x => x.PatientId == result.Id && x.Tooth == result.Tooth)?.Complications?.Select(x => x.Name).ToList();

                    result.Str_ComplicationsAfterSurgery = com == null ? null : String.Join(", ", com.ToArray());
                }

                finalResult.RemoveAll(x => x.Str_ComplicationsAfterSurgery.IsNullOrEmpty());

            }





            _aPI_Response.Result = finalResult;


            return Ok(_aPI_Response);
        }

        [HttpPost("AdvancedSearchProsthetic")]
        public async Task<IActionResult> AdvancedSearchProsthetic([FromBody] AdvancedProstheticSearchRequestDTO model)
        {


            IQueryable<FinalProsthesisParentModel> finalParentsQuery = _cia_DbContext.FinalProsthesisParents;
            IQueryable<ProstheticTreatmentDiagnosticParentModel> diagnosticParentQuery = _cia_DbContext.DiagnosticProsthesisParents;
            IQueryable<ComplicationsAfterProsthesisParentModel> complicationsProsthesisParentsQuery = _cia_DbContext.ComplicationsAfterProsthesisParents.Include(x => x.Complications);
            List<ComplicationsAfterProsthesisModel> complicationProsthesisParents = new List<ComplicationsAfterProsthesisModel>();

            List<FinalProsthesisHealingCollar> healingCollars = new List<FinalProsthesisHealingCollar>();
            List<FinalProsthesisTryIn> tryIns = new List<FinalProsthesisTryIn>();
            List<FinalProsthesisDelivery> deliveries = new List<FinalProsthesisDelivery>();
            List<FinalProsthesisImpression> impressions = new List<FinalProsthesisImpression>();
            List<ProstheticTreatmentDiagnosticParentModel> diagnostics = new List<ProstheticTreatmentDiagnosticParentModel>();

            if (!model.Ids.IsNullOrEmpty())
            {
                finalParentsQuery = finalParentsQuery.AsNoTracking().Where(x => model.Ids!.Contains(x.PatientId ?? 0));
                diagnosticParentQuery = diagnosticParentQuery.AsNoTracking().Where(x => model.Ids!.Contains(x.PatientId ?? 0));
                complicationsProsthesisParentsQuery = complicationsProsthesisParentsQuery.AsNoTracking().Where(x => model.Ids!.Contains(x.PatientId ?? 0));
            }

            if (model.complicationsAnd != null)
            {
                IQueryable<ComplicationsAfterProsthesisModel> complicationsQuery = _cia_DbContext.ComplicationsAfterProsthesis;

                if (model.complicationsAnd!.ScrewLoosness == true)
                    complicationsProsthesisParentsQuery = complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "ScrewLoosness"));
                if (model.complicationsAnd!.CrownFall == true)
                    complicationsProsthesisParentsQuery = complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "CrownFall"));
                if (model.complicationsAnd!.FracturedZirconia == true)
                    complicationsProsthesisParentsQuery = complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "FracturedZirconia"));
                if (model.complicationsAnd!.FracturedPrintedPMMA == true)
                    complicationsProsthesisParentsQuery = complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "FracturedPrintedPMMA"));
                if (model.complicationsAnd!.FoodImpaction == true)
                    complicationsProsthesisParentsQuery = complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "FoodImpaction"));
                if (model.complicationsAnd!.Pain == true)
                    complicationsProsthesisParentsQuery = complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "Pain"));



                List<int> compliactionsPatientIds = await complicationsProsthesisParentsQuery.Select(x => (int)x.PatientId).Distinct().ToListAsync();

                finalParentsQuery = finalParentsQuery.Where(x => compliactionsPatientIds.Contains((int)x.PatientId));
                diagnosticParentQuery = diagnosticParentQuery.Where(x => compliactionsPatientIds.Contains((int)x.PatientId));
                model.Ids = compliactionsPatientIds;
            }
            if (model.complicationsOr != null)
            {

                List<IQueryable<ComplicationsAfterProsthesisParentModel>> complicationsQueries = new List<IQueryable<ComplicationsAfterProsthesisParentModel>>();

                if (model.complicationsOr!.ScrewLoosness == true)
                    complicationsQueries.Add(complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "ScrewLoosness")));
                if (model.complicationsOr!.CrownFall == true)
                    complicationsQueries.Add(complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "CrownFall")));
                if (model.complicationsOr!.FracturedZirconia == true)
                    complicationsQueries.Add(complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "FracturedZirconia")));
                if (model.complicationsOr!.FracturedPrintedPMMA == true)
                    complicationsQueries.Add(complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "FracturedPrintedPMMA")));
                if (model.complicationsOr!.FoodImpaction == true)
                    complicationsQueries.Add(complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "FoodImpaction")));
                if (model.complicationsOr!.Pain == true)
                    complicationsQueries.Add(complicationsProsthesisParentsQuery.Where(x => x.Complications.Any(y => y.Name.Replace(" ", "") == "Pain")));

                if (complicationsQueries.Count != 0)
                {
                    IQueryable<ComplicationsAfterProsthesisParentModel> finalComplicationsQuery = complicationsQueries.First();
                    foreach (var q in complicationsQueries)
                    {
                        finalComplicationsQuery = finalComplicationsQuery.Union(q);
                    }
                    complicationsProsthesisParentsQuery = finalComplicationsQuery;

                    List<int> compliactionsPatientIds = await complicationsProsthesisParentsQuery.Select(x => (int)x.PatientId).Distinct().ToListAsync();

                    finalParentsQuery = finalParentsQuery.Where(x => compliactionsPatientIds.Contains((int)x.PatientId));
                    diagnosticParentQuery = diagnosticParentQuery.Where(x => compliactionsPatientIds.Contains((int)x.PatientId));
                    model.Ids = compliactionsPatientIds;



                }

            }




            if (model.DiagnosticAnd != null)
            {

                diagnostics = await diagnosticParentQuery.GroupBy(x => x.PatientId ?? 0).Select(x => x.OrderByDescending(y => y.Date).FirstOrDefault()).ToListAsync();

                //searching diagnostic impression
                if (!(model.DiagnosticAnd?.ProstheticDiagnostic_DiagnosticImpression?.IsNullOrEmpty() ?? true))
                {
                    var tempModel = model.DiagnosticAnd!.ProstheticDiagnostic_DiagnosticImpression.FirstOrDefault();

                    if (tempModel.Scanned == true)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(DiagnosticImpressionModel) && ((DiagnosticImpressionModel)x).Scanned == true).ToList();

                    if (tempModel.NeedsRemake == true)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(DiagnosticImpressionModel) && ((DiagnosticImpressionModel)x).NeedsRemake == true).ToList();

                    if (tempModel.Diagnostic != null)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(DiagnosticImpressionModel) && ((DiagnosticImpressionModel)x).Diagnostic == tempModel.Diagnostic).ToList();

                    if (tempModel.NextStep != null)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(DiagnosticImpressionModel) && ((DiagnosticImpressionModel)x).NextStep == tempModel.NextStep).ToList();


                }

                //searching Bite 
                else if (!(model.DiagnosticAnd?.ProstheticDiagnostic_Bite?.IsNullOrEmpty() ?? true))
                {
                    var tempModel = model.DiagnosticAnd!.ProstheticDiagnostic_Bite.FirstOrDefault();
                    if (tempModel.Scanned == true)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(BiteModel) && ((BiteModel)x).Scanned == true).ToList();

                    if (tempModel.NeedsRemake == true)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(BiteModel) && ((BiteModel)x).NeedsRemake == true).ToList();

                    if (tempModel.Diagnostic != null)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(BiteModel) && ((BiteModel)x).Diagnostic == tempModel.Diagnostic).ToList();

                    if (tempModel.NextStep != null)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(BiteModel) && ((BiteModel)x).NextStep == tempModel.NextStep).ToList();

                }



                //searching Scan Appliance 
                else if (!(model.DiagnosticAnd?.ProstheticDiagnostic_ScanAppliance?.IsNullOrEmpty() ?? true))
                {

                    var tempModel = model.DiagnosticAnd!.ProstheticDiagnostic_ScanAppliance.FirstOrDefault();

                    if (tempModel.Scanned == true)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(ScanApplianceModel) && ((ScanApplianceModel)x).Scanned == true).ToList();

                    if (tempModel.NeedsRemake == true)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(ScanApplianceModel) && ((ScanApplianceModel)x).NeedsRemake == true).ToList();

                    if (tempModel.Diagnostic != null)
                        diagnostics = diagnostics.Where(x => x.GetType() == typeof(ScanApplianceModel) && ((ScanApplianceModel)x).Diagnostic == tempModel.Diagnostic).ToList();



                }




            }






            else if (model.SingleAndBridgeAnd != null)
            {
                var singleList = await finalParentsQuery.ToListAsync();

                singleList = singleList
                    .Where(x => !x.FinalProthesisTeeth.IsNullOrEmpty())
                    .ToList();

                var groupedByPatients = singleList.GroupBy(x => x.PatientId).ToList();



                var tempSingle = new List<FinalProsthesisParentModel>();
                List<FinalProsthesisParentModel> patientTreatments = new List<FinalProsthesisParentModel>();

                foreach (var p in groupedByPatients)
                {

                    foreach (var treatment in p)
                    {
                        var teeth = treatment.FinalProthesisTeeth;
                        foreach (var tooth in teeth)
                        {
                            if (treatment.GetType() == typeof(FinalProsthesisHealingCollar))
                                patientTreatments.Add(((FinalProsthesisHealingCollar)treatment).CopyWithTeeth(new List<int> { tooth }));
                            else if (treatment.GetType() == typeof(FinalProsthesisImpression))
                                patientTreatments.Add(((FinalProsthesisImpression)treatment).CopyWithTeeth(new List<int> { tooth }));
                            else if (treatment.GetType() == typeof(FinalProsthesisDelivery))
                                patientTreatments.Add(((FinalProsthesisDelivery)treatment).CopyWithTeeth(new List<int> { tooth }));
                            else if (treatment.GetType() == typeof(FinalProsthesisTryIn))
                                patientTreatments.Add(((FinalProsthesisTryIn)treatment).CopyWithTeeth(new List<int> { tooth }));

                        }
                    }

                }

                singleList = patientTreatments
                    .GroupBy(x => x.PatientId)
                    .SelectMany(x => x.GroupBy(y => y.FinalProthesisTeeth.FirstOrDefault()).Select(y => y.OrderByDescending(z => z.Date).FirstOrDefault()).ToList())
                    .ToList();


                if (!(model.SingleAndBridgeAnd?.HealingCollars?.IsNullOrEmpty() ?? true))
                {
                    healingCollars = singleList.Where(x => x.GetType() == typeof(FinalProsthesisHealingCollar)).Select(x => (FinalProsthesisHealingCollar)x).ToList();

                    var tempModel = model.SingleAndBridgeAnd!.HealingCollars.FirstOrDefault();
                    if (tempModel.FinalProthesisHealingCollarNextVisit != null)
                        healingCollars = healingCollars.Where(x => x.FinalProthesisHealingCollarNextVisit == tempModel.FinalProthesisHealingCollarNextVisit).ToList();
                    if (tempModel.FinalProthesisHealingCollarStatus != null)
                        healingCollars = healingCollars.Where(x => x.FinalProthesisHealingCollarStatus == tempModel.FinalProthesisHealingCollarStatus).ToList();

                }
                else if (!(model.SingleAndBridgeAnd?.TryIns?.IsNullOrEmpty() ?? true))
                {
                    tryIns = singleList.Where(x => x.GetType() == typeof(FinalProsthesisTryIn)).Select(x => (FinalProsthesisTryIn)x).ToList();

                    var tempModel = model.SingleAndBridgeAnd!.TryIns.FirstOrDefault();
                    if (tempModel.FinalProthesisTryInNextVisit != null)
                        tryIns = tryIns.Where(x => x.FinalProthesisTryInNextVisit == tempModel.FinalProthesisTryInNextVisit).ToList();
                    if (tempModel.FinalProthesisTryInStatus != null)
                        tryIns = tryIns.Where(x => x.FinalProthesisTryInStatus == tempModel.FinalProthesisTryInStatus).ToList();

                }
                else if (!(model.SingleAndBridgeAnd?.Impressions?.IsNullOrEmpty() ?? true))
                {
                    impressions = singleList.Where(x => x.GetType() == typeof(FinalProsthesisImpression)).Select(x => (FinalProsthesisImpression)x).ToList();

                    var tempModel = model.SingleAndBridgeAnd!.Impressions.FirstOrDefault();
                    if (tempModel.FinalProthesisImpressionStatus != null)
                        impressions = impressions.Where(x => x.FinalProthesisImpressionStatus == tempModel.FinalProthesisImpressionStatus).ToList();
                    if (tempModel.FinalProthesisImpressionNextVisit != null)
                        impressions = impressions.Where(x => x.FinalProthesisImpressionNextVisit == tempModel.FinalProthesisImpressionNextVisit).ToList();
                }
                else if (!(model.SingleAndBridgeAnd?.Delivery?.IsNullOrEmpty() ?? true))
                {
                    deliveries = singleList.Where(x => x.GetType() == typeof(FinalProsthesisDelivery)).Select(x => (FinalProsthesisDelivery)x).ToList();

                    var tempModel = model.SingleAndBridgeAnd!.Delivery.FirstOrDefault();
                    if (tempModel.FinalProthesisDeliveryNextVisit != null)
                        deliveries = deliveries.Where(x => x.FinalProthesisDeliveryNextVisit == tempModel.FinalProthesisDeliveryNextVisit).ToList();
                    if (tempModel.FinalProthesisDeliveryStatus != null)
                        deliveries = deliveries.Where(x => x.FinalProthesisDeliveryStatus == tempModel.FinalProthesisDeliveryStatus).ToList();


                }


            }



            else if (model.FullArchAnd != null)
            {
                var fullArchList = await finalParentsQuery.ToListAsync();

                fullArchList = (fullArchList
                    .Where(x => x.FinalProthesisTeeth.IsNullOrEmpty())
                  .GroupBy(x => x.PatientId ?? 0)
                  .Select(x => x.OrderByDescending(y => y.Date).FirstOrDefault())
                  .ToList()).ToList();


                if (!(model.FullArchAnd?.HealingCollars?.IsNullOrEmpty() ?? true))
                {
                    healingCollars = fullArchList.Where(x => x.GetType() == typeof(FinalProsthesisHealingCollar)).Select(x => (FinalProsthesisHealingCollar)x).ToList();

                    var tempModel = model.FullArchAnd!.HealingCollars.FirstOrDefault();
                    if (tempModel.FinalProthesisHealingCollarNextVisit != null)
                        healingCollars = healingCollars.Where(x => x.FinalProthesisHealingCollarNextVisit == tempModel.FinalProthesisHealingCollarNextVisit).ToList();
                    if (tempModel.FinalProthesisHealingCollarStatus != null)
                        healingCollars = healingCollars.Where(x => x.FinalProthesisHealingCollarStatus == tempModel.FinalProthesisHealingCollarStatus).ToList();

                }
                else if (!(model.FullArchAnd?.TryIns?.IsNullOrEmpty() ?? true))
                {
                    tryIns = fullArchList.Where(x => x.GetType() == typeof(FinalProsthesisTryIn)).Select(x => (FinalProsthesisTryIn)x).ToList();

                    var tempModel = model.FullArchAnd!.TryIns.FirstOrDefault();
                    if (tempModel.FinalProthesisTryInNextVisit != null)
                        tryIns = tryIns.Where(x => x.FinalProthesisTryInNextVisit == tempModel.FinalProthesisTryInNextVisit).ToList();
                    if (tempModel.FinalProthesisTryInStatus != null)
                        tryIns = tryIns.Where(x => x.FinalProthesisTryInStatus == tempModel.FinalProthesisTryInStatus).ToList();

                }
                else if (!(model.FullArchAnd?.Impressions?.IsNullOrEmpty() ?? true))
                {
                    impressions = fullArchList.Where(x => x.GetType() == typeof(FinalProsthesisImpression)).Select(x => (FinalProsthesisImpression)x).ToList();

                    var tempModel = model.FullArchAnd!.Impressions.FirstOrDefault();
                    if (tempModel.FinalProthesisImpressionStatus != null)
                        impressions = impressions.Where(x => x.FinalProthesisImpressionStatus == tempModel.FinalProthesisImpressionStatus).ToList();
                    if (tempModel.FinalProthesisImpressionNextVisit != null)
                        impressions = impressions.Where(x => x.FinalProthesisImpressionNextVisit == tempModel.FinalProthesisImpressionNextVisit).ToList();

                }
                else if (!(model.FullArchAnd?.Delivery?.IsNullOrEmpty() ?? true))
                {
                    deliveries = deliveries.Where(x => x.GetType() == typeof(FinalProsthesisDelivery)).Select(x => (FinalProsthesisDelivery)x).ToList();

                    var tempModel = model.FullArchAnd!.Delivery.FirstOrDefault();
                    if (tempModel.FinalProthesisDeliveryNextVisit != null)
                        deliveries = deliveries.Where(x => x.FinalProthesisDeliveryNextVisit == tempModel.FinalProthesisDeliveryNextVisit).ToList();
                    if (tempModel.FinalProthesisDeliveryStatus != null)
                        deliveries = deliveries.Where(x => x.FinalProthesisDeliveryStatus == tempModel.FinalProthesisDeliveryStatus).ToList();



                }

            }














            List<AdvancedProstheticSearchResponseDTO> result = new List<AdvancedProstheticSearchResponseDTO>();
            var patients = await _cia_DbContext.Patients.Where(x => model.Ids.Contains((int)x.Id)).Distinct().ToListAsync();


            List<ComplicationsAfterProsthesisParentModel> complications = new List<ComplicationsAfterProsthesisParentModel>();


            if ((!model.DiagnosticAnd?.ProstheticDiagnostic_DiagnosticImpression.IsNullOrEmpty()) ?? false)
            {
                var tempPatients = patients.Where(x => diagnostics.Where(y => y.GetType() == typeof(DiagnosticImpressionModel)).Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();
                foreach (var patient in tempPatients)
                {
                    List<String>? com = null;
                    if (model.complicationsAnd != null || model.complicationsOr != null)
                    {
                        complications = await complicationsProsthesisParentsQuery.ToListAsync();

                        com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                    }
                    result.Add(new AdvancedProstheticSearchResponseDTO
                    {
                        Id = patient.Id,
                        SecondaryId = patient.SecondaryId,
                        PatientName = patient.Name,
                        DiagnosticImpression = diagnostics.Where(x => x.PatientId == patient.Id && x.GetType() == typeof(DiagnosticImpressionModel)).Select(x => (DiagnosticImpressionModel)x).FirstOrDefault(),
                        Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())

                    });
                }
            }

            else if ((!model.DiagnosticAnd?.ProstheticDiagnostic_Bite.IsNullOrEmpty()) ?? false)
            {
                var tempPatients = patients.Where(x => diagnostics.Where(y => y.GetType() == typeof(BiteModel)).Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();
                foreach (var patient in tempPatients)
                {
                    List<String>? com = null;
                    if (model.complicationsAnd != null || model.complicationsOr != null)
                    {
                        complications = await complicationsProsthesisParentsQuery.ToListAsync();

                        com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                    }
                    result.Add(new AdvancedProstheticSearchResponseDTO
                    {
                        Id = patient.Id,
                        SecondaryId = patient.SecondaryId,
                        PatientName = patient.Name,
                        Bite = diagnostics.Where(x => x.PatientId == patient.Id && x.GetType() == typeof(BiteModel)).Select(x => (BiteModel)x).FirstOrDefault(),
                        Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())

                    });
                }
            }
            else if ((!model.DiagnosticAnd?.ProstheticDiagnostic_ScanAppliance.IsNullOrEmpty()) ?? false)
            {
                var tempPatients = patients.Where(x => diagnostics.Where(y => y.GetType() == typeof(ScanApplianceModel)).Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();
                foreach (var patient in tempPatients)
                {
                    List<String>? com = null;
                    if (model.complicationsAnd != null || model.complicationsOr != null)
                    {
                        complications = await complicationsProsthesisParentsQuery.ToListAsync();

                        com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                    }
                    result.Add(new AdvancedProstheticSearchResponseDTO
                    {
                        Id = patient.Id,
                        SecondaryId = patient.SecondaryId,
                        PatientName = patient.Name,
                        ScanAppliance = diagnostics.Where(x => x.PatientId == patient.Id && x.GetType() == typeof(ScanApplianceModel)).Select(x => (ScanApplianceModel)x).FirstOrDefault(),
                        Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())

                    });
                }
            }
            else if (model.SingleAndBridgeAnd != null)
            {


                if (!model.SingleAndBridgeAnd!.HealingCollars.IsNullOrEmpty())
                {
                    healingCollars = healingCollars.Where(x => !x.FinalProthesisTeeth.IsNullOrEmpty()).ToList();

                    var tempPatientsHealing = patients.Where(x => healingCollars.Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();

                    foreach (var patient in tempPatientsHealing)
                    {
                        List<String>? com = null;
                        if (model.complicationsAnd != null || model.complicationsOr != null)
                        {
                            complications = await complicationsProsthesisParentsQuery.ToListAsync();

                            com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                        }
                        var temp = healingCollars.Where(x => x.PatientId == patient.Id).ToList();
                        foreach (var t in temp)
                        {
                            foreach (var tooth in t.FinalProthesisTeeth ?? new List<int>())
                            {
                                result.Add(new AdvancedProstheticSearchResponseDTO
                                {
                                    Id = patient.Id,
                                    SecondaryId = patient.SecondaryId,
                                    PatientName = patient.Name,
                                    SingleAndBridge_HealingCollar = new FinalProsthesisHealingCollar
                                    {
                                        Date = t.Date,
                                        FinalProthesisTeeth = new List<int> { tooth },
                                        PatientId = t.PatientId,
                                        FinalProthesisHealingCollarNextVisit = t.FinalProthesisHealingCollarNextVisit,
                                        FinalProthesisHealingCollarStatus = t.FinalProthesisHealingCollarStatus,
                                        Id = t.Id,
                                    },
                                    Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())

                                });
                            }
                        }

                    }






                }
                if (!model.SingleAndBridgeAnd!.TryIns.IsNullOrEmpty())
                {
                    tryIns = tryIns.Where(x => !x.FinalProthesisTeeth.IsNullOrEmpty()).ToList();

                    var tempPatientsTryIn = patients.Where(x => tryIns.Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();


                    foreach (var patient in tempPatientsTryIn)
                    {
                        List<String>? com = null;
                        if (model.complicationsAnd != null || model.complicationsOr != null)
                        {
                            complications = await complicationsProsthesisParentsQuery.ToListAsync();

                            com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                        }
                        var temp = tryIns.Where(x => x.PatientId == patient.Id).ToList();
                        foreach (var t in temp)
                        {
                            foreach (var tooth in t.FinalProthesisTeeth ?? new List<int>())
                            {
                                result.Add(new AdvancedProstheticSearchResponseDTO
                                {
                                    Id = patient.Id,
                                    SecondaryId = patient.SecondaryId,
                                    PatientName = patient.Name,
                                    SingleAndBridge_TryIn = new FinalProsthesisTryIn
                                    {
                                        Date = t.Date,
                                        FinalProthesisTeeth = new List<int> { tooth },
                                        PatientId = t.PatientId,
                                        FinalProthesisTryInNextVisit = t.FinalProthesisTryInNextVisit,
                                        FinalProthesisTryInStatus = t.FinalProthesisTryInStatus,
                                        Id = t.Id,
                                    },
                                    Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())

                                });
                            }
                        }

                    }

                }
                if (!model.SingleAndBridgeAnd!.Delivery.IsNullOrEmpty())
                {
                    deliveries = deliveries.Where(x => !x.FinalProthesisTeeth.IsNullOrEmpty()).ToList();

                    var tempPatientsDelivery = patients.Where(x => deliveries.Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();


                    foreach (var patient in tempPatientsDelivery)
                    {
                        List<String>? com = null;
                        if (model.complicationsAnd != null || model.complicationsOr != null)
                        {
                            complications = await complicationsProsthesisParentsQuery.ToListAsync();

                            com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                        }

                        var temp = deliveries.Where(x => x.PatientId == patient.Id).ToList();
                        foreach (var t in temp)
                        {
                            foreach (var tooth in t.FinalProthesisTeeth ?? new List<int>())
                            {
                                result.Add(new AdvancedProstheticSearchResponseDTO
                                {
                                    Id = patient.Id,
                                    SecondaryId = patient.SecondaryId,
                                    PatientName = patient.Name,
                                    SingleAndBridge_Delivery = new FinalProsthesisDelivery
                                    {
                                        Date = t.Date,
                                        FinalProthesisTeeth = new List<int> { tooth },
                                        PatientId = t.PatientId,
                                        FinalProthesisDeliveryNextVisit = t.FinalProthesisDeliveryNextVisit,
                                        FinalProthesisDeliveryStatus = t.FinalProthesisDeliveryStatus,
                                        Id = t.Id,
                                    },
                                    Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())


                                });
                            }
                        }

                    }

                }
                if (!model.SingleAndBridgeAnd!.Impressions.IsNullOrEmpty())
                {
                    impressions = impressions.Where(x => !x.FinalProthesisTeeth.IsNullOrEmpty()).ToList();

                    var tempPatientsImpression = patients.Where(x => impressions.Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();

                    foreach (var patient in tempPatientsImpression)
                    {
                        List<String>? com = null;
                        if (model.complicationsAnd != null || model.complicationsOr != null)
                        {
                            complications = await complicationsProsthesisParentsQuery.ToListAsync();

                            com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                        }

                        var temp = impressions.Where(x => x.PatientId == patient.Id).ToList();
                        foreach (var t in temp)
                        {
                            foreach (var tooth in t.FinalProthesisTeeth ?? new List<int>())
                            {
                                result.Add(new AdvancedProstheticSearchResponseDTO
                                {
                                    Id = patient.Id,
                                    SecondaryId = patient.SecondaryId,
                                    PatientName = patient.Name,
                                    SingleAndBridge_Impression = new FinalProsthesisImpression
                                    {
                                        Date = t.Date,
                                        FinalProthesisTeeth = new List<int> { tooth },
                                        PatientId = t.PatientId,
                                        FinalProthesisImpressionNextVisit = t.FinalProthesisImpressionNextVisit,
                                        FinalProthesisImpressionStatus = t.FinalProthesisImpressionStatus,
                                        Id = t.Id,
                                    },
                                    Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())


                                });
                            }
                        }

                    }

                }

            }
            else if (model.FullArchAnd != null)
            {

                if (!model.FullArchAnd!.HealingCollars.IsNullOrEmpty())
                {
                    healingCollars = healingCollars.Where(x => x.FinalProthesisTeeth.IsNullOrEmpty()).ToList();

                    var tempPatientsHealing = patients.Where(x => healingCollars.Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();

                    foreach (var patient in tempPatientsHealing)
                    {
                        List<String>? com = null;
                        if (model.complicationsAnd != null || model.complicationsOr != null)
                        {
                            complications = await complicationsProsthesisParentsQuery.ToListAsync();

                            com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                        }

                        var temp = healingCollars.Where(x => x.PatientId == patient.Id).ToList();
                        foreach (var t in temp)
                        {

                            result.Add(new AdvancedProstheticSearchResponseDTO
                            {
                                Id = patient.Id,
                                SecondaryId = patient.SecondaryId,
                                PatientName = patient.Name,
                                FullArch_HealingCollar = t,
                                Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())


                            });

                        }

                    }

                }
                if (!model.FullArchAnd!.TryIns.IsNullOrEmpty())
                {
                    tryIns = tryIns.Where(x => x.FinalProthesisTeeth.IsNullOrEmpty()).ToList();

                    var tempPatientsTryIn = patients.Where(x => tryIns.Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();


                    foreach (var patient in tempPatientsTryIn)
                    {
                        List<String>? com = null;
                        if (model.complicationsAnd != null || model.complicationsOr != null)
                        {
                            complications = await complicationsProsthesisParentsQuery.ToListAsync();

                            com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                        }
                        var temp = tryIns.Where(x => x.PatientId == patient.Id).ToList();
                        foreach (var t in temp)
                        {
                            result.Add(new AdvancedProstheticSearchResponseDTO
                            {
                                Id = patient.Id,
                                SecondaryId = patient.SecondaryId,
                                PatientName = patient.Name,
                                FullArch_TryIn = t,
                                Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())


                            });

                        }

                    }

                }
                if (!model.FullArchAnd!.Delivery.IsNullOrEmpty())
                {
                    deliveries = deliveries.Where(x => x.FinalProthesisTeeth.IsNullOrEmpty()).ToList();

                    var tempPatientsDelivery = patients.Where(x => deliveries.Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();


                    foreach (var patient in tempPatientsDelivery)
                    {
                        List<String>? com = null;
                        if (model.complicationsAnd != null || model.complicationsOr != null)
                        {
                            complications = await complicationsProsthesisParentsQuery.ToListAsync();

                            com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                        }

                        var temp = deliveries.Where(x => x.PatientId == patient.Id).ToList();
                        foreach (var t in temp)
                        {
                            result.Add(new AdvancedProstheticSearchResponseDTO
                            {
                                Id = patient.Id,
                                SecondaryId = patient.SecondaryId,
                                PatientName = patient.Name,
                                FullArch_Delivery = t,
                                Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())

                            });
                        }

                    }

                }
                if (!model.FullArchAnd!.Impressions.IsNullOrEmpty())
                {
                    impressions = impressions.Where(x => x.FinalProthesisTeeth.IsNullOrEmpty()).ToList();

                    var tempPatientsImpression = patients.Where(x => impressions.Select(y => y.PatientId).ToList().Contains(x.Id)).ToList();

                    foreach (var patient in tempPatientsImpression)
                    {
                        List<String>? com = null;
                        if (model.complicationsAnd != null || model.complicationsOr != null)
                        {
                            complications = await complicationsProsthesisParentsQuery.ToListAsync();

                            com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                        }
                        var temp = impressions.Where(x => x.PatientId == patient.Id).ToList();
                        foreach (var t in temp)
                        {
                            result.Add(new AdvancedProstheticSearchResponseDTO
                            {
                                Id = patient.Id,
                                SecondaryId = patient.SecondaryId,
                                PatientName = patient.Name,
                                FullArch_Impression = t,
                                Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())


                            });
                        }

                    }

                }

            }
            else if (model.complicationsAnd != null || model.complicationsOr != null)
            {
                complications = await complicationsProsthesisParentsQuery.ToListAsync();
                foreach (var patient in patients)
                {
                    var com = complications.FirstOrDefault(x => x.PatientId == patient.Id)?.Complications?.Select(x => x.Name).ToList();

                    result.Add(new AdvancedProstheticSearchResponseDTO
                    {
                        Id = patient.Id,
                        SecondaryId = patient.SecondaryId,
                        PatientName = patient.Name,
                        Str_ComplicationsAfterProsthesis = com == null ? null : String.Join(", ", com.ToArray())
                    });

                }


            }

            if (model.complicationsAnd != null || model.complicationsOr != null)
            {
                result.RemoveAll(x => x.Str_ComplicationsAfterProsthesis.IsNullOrEmpty());


            }

            _aPI_Response.Result = result;








            return Ok(_aPI_Response);
        }


    }
}