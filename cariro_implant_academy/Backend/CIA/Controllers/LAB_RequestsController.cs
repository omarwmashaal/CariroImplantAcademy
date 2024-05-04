using AutoMapper;
using AutoMapper.QueryableExtensions;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.LAB;
using CIA.Models.LAB.DTO;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LAB_RequestsController : BaseController
    {
        private readonly API_response _apiResponse;
        private readonly CIA_dbContext _dbContext;
        private readonly IMedical_Repo _iMedicalRepo;
        private readonly IMapper _mapper;
        private readonly IUserRepo _iUserRepo;
        private readonly INotificationRepo _notificationRepo;
        public LAB_RequestsController(CIA_dbContext cIA_DbContext, IMapper mapper, IMedical_Repo medical_Repo, IUserRepo iUserRepo, INotificationRepo notificationRepo)
        {
            _apiResponse = new API_response();
            _dbContext = cIA_DbContext;
            _mapper = mapper;
            _iMedicalRepo = medical_Repo;
            _iUserRepo = iUserRepo;
            _notificationRepo = notificationRepo;
        }
        [HttpGet("GetAllRequests")]
        public async Task<IActionResult> GetAllRequests(
            DateTime? from,
            DateTime? to,
            EnumLabRequestStatus? status,
            EnumLabRequestSources? source,
            bool? paid,
            String? search,
            bool? myRequests
            )
        {
            IQueryable<Lab_Request> query = _dbContext.Lab_Requests;
            // .Include(x => x.EntryBy)
            //  .Include(x => x.Customer)
            //  .Include(x => x.Patient)
            //    .Include(x => x.AssignedTo)
            //   .Include(x => x.Steps).ThenInclude(x => x.Technician)
            //    .Include(x => x.Steps).ThenInclude(x => x.Step)
            //.Include(x => x.File);
            ;
            // List<LAB_MultiRequestsDTO> requests = new List<LAB_MultiRequestsDTO>();
            if (from != null)
            {
                from = from.Value.ToUniversalTime();
                query = query.Where(x => x.Date.Value.Date >= from.Value.Date);

            }
            if (to != null)
            {
                to = to.Value.ToUniversalTime();
                query = query.Where(x => x.Date.Value.Date <= to.Value.Date);
            }
            if (status != null)
                query = query.Where(x => x.Status == status);

            if (source != null)
                query = query.Where(x => x.Source == source);
            if (paid != null)
                query = query.Where(x => x.Paid == paid);
            if (search != null)
            {
                search = search.ToLower();
                query = query.Where(x => (

                   //(x.Source != null && ((string)((object)x.Source)).ToLower().Contains(search)) ||
                   // (x.Status != null && (x.Status.Value.).ToLower().Contains(search)) ||
                   (x.Patient != null && x.Patient.Name.ToLower().Contains(search) ||
                  (x.Customer != null && x.Customer.Name.ToLower().Contains(search)) ||
                   (x.AssignedTo != null && x.AssignedTo.Name.ToLower().Contains(search))


                )));
                // query = query.Where(x => x.Patient != null && x.Patient.Name.ToLower().Contains);
            }


            var requests = await query.ToListAsync();

            List<LAB_MultiRequestsDTO> requestsReslult = new List<LAB_MultiRequestsDTO>();

            foreach (var request in requests)
            {
                var temp = _mapper.Map<LAB_MultiRequestsDTO>(request);

                ApplicationUser tempUser = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == request.AssignedToId);
                temp.AssignedTo = _mapper.Map<UserDTO>(tempUser);
                tempUser = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == request.CustomerId);
                temp.Customer = _mapper.Map<UserDTO>(tempUser);

                Patient temppatient = await _dbContext.Patients.FirstOrDefaultAsync(x => x.Id == request.PatientId);
                temp.Patient = _mapper.Map<PatientDTO>(temppatient);


                requestsReslult.Add(temp);
            }

            if (search != null)
            {
                search = search.ToLower();
                requestsReslult = requestsReslult.Where(x => (

                   //(x.Source != null && ((string)((object)x.Source)).ToLower().Contains(search)) ||
                   // (x.Status != null && (x.Status.Value.).ToLower().Contains(search)) ||
                   (x.Patient != null && x.Patient.Name.ToLower().Contains(search) ||
                  (x.Customer != null && x.Customer.Name.ToLower().Contains(search)) ||
                   (x.AssignedTo != null && x.AssignedTo.Name.ToLower().Contains(search))


                ))).ToList();
                // query = query.Where(x => x.Patient != null && x.Patient.Name.ToLower().Contains);
            }
            // requests = await query.ToListAsync();

            //foreach (var request in requestsReslult)
            //{
            //    request.AssignedTo = request.Steps.Last().Technician;
            //    request.AssignedToId = request.Steps.Last().TechnicianId;
            //}

            if (myRequests == true)
            {
                var user = await _iUserRepo.GetUser();
                requestsReslult.RemoveAll(x => x.AssignedToId != user.IdInt);
            }


            _apiResponse.Result = requestsReslult;
            return Ok(_apiResponse);
        }


        [HttpGet("GetRequest")]
        public async Task<IActionResult> GetRequest(int id)
        {
            var request = await _dbContext.Lab_Requests
            //     .Include(x => x.EntryBy)
            //     .Include(x => x.Customer)
            //    .Include(x => x.AssignedTo)
                 .Include(x => x.Patient)
                // .Include(x => x.Steps).ThenInclude(x => x.Technician)
                //.Include(x => x.Steps).ThenInclude(x => x.Step)
                //Include(x => x.EntryBy).
                //Include(x => x.Customer).
                //Include(x => x.Patient).
                //Include(x => x.File).
                //Include(x => x.Steps).ThenInclude(x => x.Technician).
                //Include(x => x.Steps).ThenInclude(x => x.Step).
                .FirstOrDefaultAsync(x => x.Id == id);

            request.AssignedTo = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == request.AssignedToId);
            request.EntryBy = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == request.EntryById);
            request.Customer = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == request.CustomerId);
            request.Designer = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == request.DesignerId);

            if (request.WaxUp != null)
            {
                request.WaxUp.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Wax Up")).UnitPrice;
                request.WaxUp.TotalPrice = request.WaxUp.Price * request.WaxUp.Number;
                if (request.WaxUp.LabItemId != null)
                {
                    request.WaxUp.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.WaxUp.LabItemId);
                }
            }
            if (request.ZirconUnit != null)
            {
                request.ZirconUnit.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Zircon Unit")).UnitPrice;
                request.ZirconUnit.TotalPrice = request.ZirconUnit.Price * request.ZirconUnit.Number;
                if (request.ZirconUnit.LabItemId != null)
                {
                    request.ZirconUnit.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.ZirconUnit.LabItemId);
                }
            }
            if (request.PFM != null)
            {
                request.PFM.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "PFM")).UnitPrice;
                request.PFM.TotalPrice = request.PFM.Price * request.PFM.Number;
                if (request.PFM.LabItemId != null)
                {
                    request.PFM.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.PFM.LabItemId);
                }
            }
            if (request.CompositeInlay != null)
            {
                request.CompositeInlay.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Composite Inlay")).UnitPrice;
                request.CompositeInlay.TotalPrice = request.CompositeInlay.Price * request.CompositeInlay.Number;
                if (request.CompositeInlay.LabItemId != null)
                {
                    request.CompositeInlay.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.CompositeInlay.LabItemId);
                }
            }
            if (request.EmaxVeneer != null)
            {
                request.EmaxVeneer.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Emax Veneer")).UnitPrice;
                request.EmaxVeneer.TotalPrice = request.EmaxVeneer.Price * request.EmaxVeneer.Number;
                if (request.EmaxVeneer.LabItemId != null)
                {
                    request.EmaxVeneer.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.EmaxVeneer.LabItemId);
                }
            }
            if (request.MilledPMMA != null)
            {
                request.MilledPMMA.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Milled PMMA")).UnitPrice;
                request.MilledPMMA.TotalPrice = request.MilledPMMA.Price * request.MilledPMMA.Number;
                if (request.MilledPMMA.LabItemId != null)
                {
                    request.MilledPMMA.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.MilledPMMA.LabItemId);
                }
            }
            if (request.PrintedPMMA != null)
            {
                request.PrintedPMMA.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Printed PMMA")).UnitPrice;
                request.PrintedPMMA.TotalPrice = request.PrintedPMMA.Price * request.PrintedPMMA.Number;
                if (request.PrintedPMMA.LabItemId != null)
                {
                    request.PrintedPMMA.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.PrintedPMMA.LabItemId);
                }
            }
            if (request.TiAbutment != null)
            {
                request.TiAbutment.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Ti Abutment")).UnitPrice;
                request.TiAbutment.TotalPrice = request.TiAbutment.Price * request.TiAbutment.Number;
                if (request.TiAbutment.LabItemId != null)
                {
                    request.TiAbutment.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.TiAbutment.LabItemId);
                }
            }
            if (request.TiBar != null)
            {
                request.TiBar.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Ti Bar")).UnitPrice;
                request.TiBar.TotalPrice = request.TiBar.Price * request.TiBar.Number;
                if (request.TiBar.LabItemId != null)
                {
                    request.TiBar.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.TiBar.LabItemId);
                }
            }
            if (request.ThreeDPrinting != null)
            {
                request.ThreeDPrinting.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "3D Printing")).UnitPrice;
                request.ThreeDPrinting.TotalPrice = request.ThreeDPrinting.Price * request.ThreeDPrinting.Number;
                if (request.ThreeDPrinting.LabItemId != null)
                {
                    request.ThreeDPrinting.LabItem = await _dbContext.LabItems.FirstOrDefaultAsync(x => x.Id == request.ThreeDPrinting.LabItemId);
                }
            }

            if (!request.Steps.IsNullOrEmpty())
            {
                request.Steps = request.Steps.OrderBy(x => x.index).ToList();
            }
            // request.AssignedTo = request.Steps.Last().Technician;
            //request.AssignedToId = request.Steps.Last().TechnicianId;

            _apiResponse.Result = request;


            return Ok(_apiResponse);
        }
        [HttpGet("GetMyRequests")]
        public async Task<IActionResult> GetMyRequests()
        {
            var user = await _iUserRepo.GetUser();
            var steps = await _dbContext.Lab_RequestSteps.Where(x => x.TechnicianId == user.IdInt).ToListAsync();
            List<int> requestsIds = new List<int>();
            foreach (var step in steps)
            {
                if (step.RequestId != null)
                    requestsIds.Add((int)step.RequestId);
            }
            requestsIds = requestsIds.Distinct().ToList();
            _apiResponse.Result = await _dbContext.Lab_Requests.Include(x => x.EntryBy).Include(x => x.Customer).Include(x => x.Patient).Include(x => x.File).Where(x => requestsIds.Contains(x.Id)).ToListAsync();

            return Ok(_apiResponse);
        }

        [HttpGet("GetPatientRequests")]
        public async Task<IActionResult> GetPatientRequests(int id)
        {

            var requests = await _dbContext.Lab_Requests
                 .Where(x => x.PatientId == id)
                 .Include(x => x.EntryBy)
                 .Include(x => x.Patient)
                 .Include(x => x.Steps).ThenInclude(x => x.Technician)
                 .Include(x => x.Steps).ThenInclude(x => x.Step)
                 // .Select(x => new LAB_RequestsDTO())
                 //.Take(5)

                 .ToListAsync();



            _apiResponse.Result = _mapper.Map<List<LAB_RequestsDTO>>(requests);
            return Ok(_apiResponse);
        }

        [HttpPost("AddRequest")]
        public async Task<IActionResult> AddRequest([FromBody] Lab_Request request)
        {

            List<Lab_RequestStep> steps = new List<Lab_RequestStep>();
            if (request.Steps != null)
            {
                request.Steps[0].Status = EnumLabRequestStepStatus.Done;
                request.Steps[0].Date = DateTime.UtcNow;
                steps = request.Steps;
                request.Steps = null;
            }
            var user = await _iUserRepo.GetUser();
            request.EntryBy = user;
            request.EntryById = (int)user.IdInt;
            request.Date = DateTime.UtcNow;
            request.Customer = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == request.CustomerId);
            if (request.AssignedToId != null)
                request.AssignedTo = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == request.AssignedToId);
            await _dbContext.Lab_Requests.AddAsync(request);
            await _dbContext.SaveChangesAsync();
            for (int i = 0; i < steps.Count; i++)
            {
                steps[i].index = i;
                //steps[i].Request = request;
                steps[i].RequestId = request.Id;
            }
            await _dbContext.Lab_RequestSteps.AddRangeAsync(steps);
            await _dbContext.SaveChangesAsync();
            request.Steps = steps;
            _dbContext.Lab_Requests.Update(request);
            await _dbContext.SaveChangesAsync();
            await _notificationRepo.LAB_RequestAdded(request.Id);
            return Ok();
        }
        [HttpPut("UpdateStepStatus")]
        public async Task<IActionResult> UpdateStepStatus(int id, [FromBody] Lab_RequestStep step)
        {
            var dbStep = await _dbContext.Lab_RequestSteps.FirstOrDefaultAsync(x => x.Id == id);
            dbStep = step;
            _dbContext.Lab_RequestSteps.Update(step);
            _dbContext.SaveChanges();
            return Ok();
        }

        [HttpGet("GetDefaultStepByName")]
        public async Task<IActionResult> GetDefaultStepByName(String name)
        {
            _apiResponse.Result = await _dbContext.Lab_DefaultSteps.FirstOrDefaultAsync(x => x.Name == name);

            return Ok(_apiResponse);
        }

        [HttpGet("GetDefaultSteps")]
        public async Task<IActionResult> GetDefaultSteps()
        {
            _apiResponse.Result = await _dbContext.Lab_DefaultSteps.ToListAsync();

            return Ok(_apiResponse);
        }


        [HttpPost("AddToMyTasks")]
        public async Task<IActionResult> AddToMyTasks(int id)
        {
            var user = await _iUserRepo.GetUser();
            var request = await _dbContext.Lab_Requests.
                Include(x => x.Steps).ThenInclude(x => x.Technician).
                FirstAsync(x => x.Id == id);
            request.AssignedToId = user.IdInt;
            request.AssignedTo = user;
            request.Status = EnumLabRequestStatus.InProgress;
            request.Steps.Last().Technician = user;
            request.Steps.Last().TechnicianId = user.IdInt;
            request.Steps.Last().Status = EnumLabRequestStepStatus.InProgress;
            _dbContext.Lab_Requests.Update(request);
            _dbContext.SaveChanges();
            return Ok();
        }

        [HttpPost("AssignToTechnician")]
        public async Task<IActionResult> AssignToTechnician(int id, int technicianId,int? designerId)
        {
            var technician = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == technicianId);
            var request = await _dbContext.Lab_Requests.
              Include(x => x.Steps).ThenInclude(x => x.Technician).
              FirstAsync(x => x.Id == id);
            if (designerId != null)
            {
                var designer = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == designerId);
                request.Designer = designer;
                request.DesignerId = designerId;
            }
          
            request.AssignedToId = technician.IdInt;
            request.AssignedTo = technician;
            request.Status = EnumLabRequestStatus.InProgress;
            //request.Steps.Last().Technician = user;
            //request.Steps.Last().TechnicianId = user.IdInt;
            //request.Steps.Last().Status = EnumLabRequestStepStatus.InProgress;
            _dbContext.Lab_Requests.Update(request);
            _dbContext.SaveChanges();
            await _notificationRepo.LAB_RequestAssigned(id, technicianId);
            return Ok();
        }

        [HttpPost("FinishTask")]
        public async Task<IActionResult> FinishTask(int id, int nextTaskId, int? assignToId, String? notes)
        {
            var user = await _iUserRepo.GetUser();
            var nextAssign = await _dbContext.Users.FirstOrDefaultAsync(x => x.IdInt == assignToId);

            var request = await _dbContext.Lab_Requests.
                Include(x => x.Steps).ThenInclude(x => x.Technician).
                FirstAsync(x => x.Id == id);

            request.Steps.Last().Status = EnumLabRequestStepStatus.Done;
            request.Steps.Last().Date = DateTime.UtcNow;
            request.Steps.Last().Notes = notes;
            request.Steps.Last().TechnicianId = user.IdInt;
            request.Steps.Last().Technician = user;

            var nextDefaultStep = await _dbContext.Lab_DefaultSteps.FirstAsync(x => x.Id == nextTaskId);
            Lab_RequestStep nextStep = new Lab_RequestStep()
            {
                index = request.Steps.Count(),
                Request = request,
                RequestId = request.Id,
                Status = EnumLabRequestStepStatus.InProgress,
                Technician = nextAssign,
                TechnicianId = nextAssign == null ? null : nextAssign.IdInt,
                Step = nextDefaultStep,
                StepId = nextTaskId,
            };

            request.Status = EnumLabRequestStatus.InProgress;
            request.AssignedTo = nextAssign;
            request.AssignedToId = nextAssign == null ? null : nextAssign.IdInt;

            request.Steps.Add(nextStep);

            _dbContext.Lab_Requests.Update(request);
            _dbContext.SaveChanges();

            if (nextAssign != null && nextAssign.IdInt == request.CustomerId && request.CustomerId != null && request.PatientId != null)
            {
                await _notificationRepo.LAB_WaitingCustomerAction(id, (int)request.CustomerId, (int)request.PatientId);
            }
            else if (nextAssign != null)
            {
                await _notificationRepo.LAB_RequestUpdate(id, (int)nextAssign.IdInt);

            }
            return Ok();
        }


        [HttpPost("MarkRequestAsDone")]
        public async Task<IActionResult> MarkRequestAsDone(int id, String? notes)
        {
            var user = await _iUserRepo.GetUser();

            var request = await _dbContext.Lab_Requests.
                Include(x => x.Steps).ThenInclude(x => x.Technician).
                FirstAsync(x => x.Id == id);

            request.Steps.Last().Status = EnumLabRequestStepStatus.Done;
            request.Steps.Last().Date = DateTime.UtcNow;
            request.Steps.Last().Notes = notes;
            var nextDefaultStep = await _dbContext.Lab_DefaultSteps.FirstAsync(x => x.Name == "Done");
            Lab_RequestStep nextStep = new Lab_RequestStep()
            {
                index = request.Steps.Count(),
                Request = request,
                RequestId = request.Id,
                Status = EnumLabRequestStepStatus.Done,
                Step = nextDefaultStep,
                StepId = nextDefaultStep.Id,
                Date = DateTime.UtcNow,
                Technician = user,
                TechnicianId = user.IdInt
            };

            request.Status = EnumLabRequestStatus.Finished;

            request.Steps.Add(nextStep);

            _dbContext.Lab_Requests.Update(request);
            _dbContext.SaveChanges();
            await _notificationRepo.LAB_RequestReady(id);
            return Ok();
        }

        [HttpPost("AddOrUpdateRequestReceipt")]
        public async Task<IActionResult> AddRequestReceipt(int id, [FromBody] List<Lab_RequestStep> steps)
        {
            var request = await _dbContext.Lab_Requests.FirstOrDefaultAsync(x => x.Id == id);
            if (request.Paid == true)
            {
                _apiResponse.ErrorMessage = "Request is already paid";
                return BadRequest(_apiResponse);
            }
            var user = await _iUserRepo.GetUser();
            var requestSteps = await _dbContext.Lab_RequestSteps.OrderBy(x => x.index).Where(x => x.RequestId == id).ToListAsync();
            var receipt = await _dbContext.Receipts.FirstOrDefaultAsync(x => x.RequestId == id && x.Website == EnumWebsite.Lab);
            if (receipt == null)
            {
                receipt = new Receipt()
                {
                    Date = DateTime.UtcNow,
                    RequestId = id,
                    Operator = user,
                    OperatorId = user.IdInt,
                    Website = EnumWebsite.Lab

                };
                await _dbContext.Receipts.AddAsync(receipt);
                await _dbContext.SaveChangesAsync();
            }

            receipt.Total = 0;
            steps = steps.OrderBy(x => x.index).ToList();


            if (!(request.Free ?? false))
            {
                for (int i = 0; i < steps.Count; i++)
                {
                    requestSteps[i].Price = steps[i].Price;
                    receipt.Total += steps[i].Price ?? 0;
                }
            }
            receipt.Unpaid = receipt.Total - receipt.Paid;

            _dbContext.Receipts.Update(receipt);
            _dbContext.Lab_RequestSteps.UpdateRange(requestSteps);

            request.Cost = receipt.Total;
            _dbContext.Lab_Requests.Update(request);
            _dbContext.SaveChanges();

            return Ok();
        }

        [HttpPost("PayForRequest")]
        public async Task<IActionResult> PayForRequest(int id)
        {
            var request = await _dbContext.Lab_Requests.FirstOrDefaultAsync(x => x.Id == id);
            var receipt = await _dbContext.Receipts.FirstOrDefaultAsync(x => x.RequestId == id && x.Website == EnumWebsite.Lab);
            receipt.Paid = receipt.Total;
            receipt.Unpaid = 0;
            request.Paid = true;
            request.PaidAmount = receipt.Total;

            _dbContext.Lab_Requests.Update(request);
            _dbContext.Receipts.Update(receipt);
            var user = await _iUserRepo.GetUser();
            var cat = await _dbContext.IncomeCategories.FirstOrDefaultAsync(x => x.Name == "Lab Request" && x.Website == EnumWebsite.Lab);
            if (cat == null)
            {
                cat = new IncomeCategoriesModel()
                {
                    Website = EnumWebsite.Lab,
                    Name = "Lab Request"
                };
                await _dbContext.IncomeCategories.AddAsync(cat);
                await _dbContext.SaveChangesAsync();
            }

            _dbContext.Income.Add(new IncomeModel()
            {
                Name = "Request",
                Website = EnumWebsite.Lab,
                Category = cat,
                CategoryId = cat.Id,
                Date = DateTime.UtcNow,
                ReceiptID = receipt.Id,
                Price = receipt.Total,
                CreatedBy = user,
                CreatedById = user.IdInt,
                LabRequestId = request.Id,
                LabRequest = request,


            });
            _dbContext.SaveChanges();
            return Ok();
        }
        [HttpGet("CheckLabRequests")]
        public async Task<IActionResult> CheckLabRequests(int id)
        {
            var requests = await _dbContext.Lab_Requests.Where(x => x.PatientId == id).ToListAsync();
            bool unFinishedRequests = false;
            foreach (var r in requests)
            {
                if (r.Status != EnumLabRequestStatus.Finished)
                {
                    unFinishedRequests = true;
                    break;
                }
            }
            if (unFinishedRequests)
                return BadRequest();
            return Ok();

        }

        [HttpPut("UpdateLabRequest")]
        public async Task<IActionResult> UpdateLabRequest([FromBody] Lab_Request request)
        {
            var requestFromDB = await _dbContext.Lab_Requests.AsNoTracking().FirstAsync(x => x.Id == request.Id);
            var receiptFromDB = await _dbContext.Receipts.FirstOrDefaultAsync(x => x.RequestId == request.Id);
            if (request.WaxUp != null)
            {
                request.WaxUp.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Wax Up")).UnitPrice;
                request.WaxUp.TotalPrice = request.WaxUp.Price * request.WaxUp.Number;
            }
            if (request.ZirconUnit != null)
            {
                request.ZirconUnit.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Zircon Unit")).UnitPrice;
                request.ZirconUnit.TotalPrice = request.ZirconUnit.Price * request.ZirconUnit.Number;
            }
            if (request.PFM != null)
            {
                request.PFM.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "PFM")).UnitPrice;
                request.PFM.TotalPrice = request.PFM.Price * request.PFM.Number;
            }
            if (request.CompositeInlay != null)
            {
                request.CompositeInlay.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Composite Inlay")).UnitPrice;
                request.CompositeInlay.TotalPrice = request.CompositeInlay.Price * request.CompositeInlay.Number;
            }
            if (request.EmaxVeneer != null)
            {
                request.EmaxVeneer.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Emax Veneer")).UnitPrice;
                request.EmaxVeneer.TotalPrice = request.EmaxVeneer.Price * request.EmaxVeneer.Number;
            }
            if (request.MilledPMMA != null)
            {
                request.MilledPMMA.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Milled PMMA")).UnitPrice;
                request.MilledPMMA.TotalPrice = request.MilledPMMA.Price * request.MilledPMMA.Number;
            }
            if (request.PrintedPMMA != null)
            {
                request.PrintedPMMA.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Printed PMMA")).UnitPrice;
                request.PrintedPMMA.TotalPrice = request.PrintedPMMA.Price * request.PrintedPMMA.Number;
            }
            if (request.TiAbutment != null)
            {
                request.TiAbutment.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Ti Abutment")).UnitPrice;
                request.TiAbutment.TotalPrice = request.TiAbutment.Price * request.TiAbutment.Number;
            }
            if (request.TiBar != null)
            {
                request.TiBar.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "Ti Bar")).UnitPrice;
                request.TiBar.TotalPrice = request.TiBar.Price * request.TiBar.Number;
            }
            if (request.ThreeDPrinting != null)
            {
                request.ThreeDPrinting.Price = (await _dbContext.LabItemParents.FirstAsync(x => x.Name == "3D Printing")).UnitPrice;
                request.ThreeDPrinting.TotalPrice = request.ThreeDPrinting.Price * request.ThreeDPrinting.Number;
            }

            bool sendNotification = false;

            if (requestFromDB.Status != EnumLabRequestStatus.Finished && request.Status == EnumLabRequestStatus.Finished && receiptFromDB == null)
            {
                var receipt = new Receipt();
                receipt.Total = 0;
                receipt.WaxUp = request.WaxUp;
                receipt.ZirconUnit = request.ZirconUnit;
                receipt.PFM = request.PFM;
                receipt.CompositeInlay = request.CompositeInlay;
                receipt.EmaxVeneer = request.EmaxVeneer;
                receipt.MilledPMMA = request.MilledPMMA;
                receipt.PrintedPMMA = request.PrintedPMMA;
                receipt.TiAbutment = request.TiAbutment;
                receipt.TiBar = request.TiBar;
                receipt.ThreeDPrinting = request.ThreeDPrinting;
                receipt.LabFees = request.LabFees;

                if (!(request.Free ?? false))
                {



                    receipt.Total += request.WaxUp?.TotalPrice ?? 0;
                    receipt.Total += request.ZirconUnit?.TotalPrice ?? 0;
                    receipt.Total += request.PFM?.TotalPrice ?? 0;
                    receipt.Total += request.CompositeInlay?.TotalPrice ?? 0;
                    receipt.Total += request.EmaxVeneer?.TotalPrice ?? 0;
                    receipt.Total += request.MilledPMMA?.TotalPrice ?? 0;
                    receipt.Total += request.PrintedPMMA?.TotalPrice ?? 0;
                    receipt.Total += request.TiAbutment?.TotalPrice ?? 0;
                    receipt.Total += request.TiBar?.TotalPrice ?? 0;
                    receipt.Total += request.ThreeDPrinting?.TotalPrice ?? 0;
                    receipt.Total += request.LabFees ?? 0;

                }
                request.Cost = receipt.Total;
                receipt.Paid = 0;
                receipt.Unpaid = receipt.Total;
                receipt.RequestId = request.Id;
                receipt.Website = EnumWebsite.Lab;
                var user = await _iUserRepo.GetUser();
                receipt.Operator = user;
                receipt.OperatorId = user.IdInt;
                receipt.Date = DateTime.UtcNow;

                _dbContext.Receipts.Add(receipt);
                sendNotification = true;


            }
            //if (request.EntryById != null)
            //    request.EntryBy = await _dbContext.Users.FirstAsync(x => x.IdInt == request.EntryById);
            //if (request.AssignedToId != null)
            //    request.AssignedTo = await _dbContext.Users.FirstAsync(x => x.IdInt == request.AssignedToId);
            //if (request.CustomerId != null)
            //    request.Customer = await _dbContext.Users.FirstAsync(x => x.IdInt == request.CustomerId);



            _dbContext.Lab_Requests.Update(request);
            _dbContext.SaveChanges();

            if (sendNotification)
                await _notificationRepo.LAB_RequestReady(request.Id);
            return Ok();
        }
        [HttpPost("ConsumeLabItem")]
        public async Task<IActionResult> ConsumeLabItem(int id, int? number, bool consumeWholeBlock)
        {
            var item = await _dbContext.LabItems.FirstAsync(x => x.Id == id);
            if ((consumeWholeBlock == false && number == null) || (consumeWholeBlock == true && number != null))
            {
                _apiResponse.ErrorMessage = "Error Invalid input";
                return BadRequest(_apiResponse);
            }
            var user = await _iUserRepo.GetUser();
            if (consumeWholeBlock)
            {

                item.Consumed = true;
                item.Count = 0;
                await _dbContext.StockLogs.AddAsync(new StockLog()
                {
                    Count = 1,
                    Date = DateTime.UtcNow,
                    InventoryWebsite = EnumWebsite.Lab,
                    Name = item.Name,
                    Operator = user,
                    OperatorId = (int)user.IdInt,
                    Status = "Consumed",
                    Website = EnumWebsite.Lab
                });
            }
            else
            {
                item.ConsumedCount += (int)number;
                await _dbContext.StockLogs.AddAsync(new StockLog()
                {
                    Count = (int)number,
                    Date = DateTime.UtcNow,
                    InventoryWebsite = EnumWebsite.Lab,
                    Name = item.Name,
                    Operator = user,
                    OperatorId = (int)user.IdInt,
                    Status = "Used",
                    Website = EnumWebsite.Lab
                });

            }





            _dbContext.LabItems.Update(item);
            _dbContext.SaveChanges();

            return Ok();
        }
        [HttpGet("GetLabItemDetails")]
        public async Task<IActionResult> GetLabItemDetails(int id)
        {
            var item = await _dbContext.LabItems.FirstAsync(x => x.Id == id);
            _apiResponse.Result = item;

            return Ok(_apiResponse);
        }
        [HttpGet("GetReceipt")]
        public async Task<IActionResult> GetReceipt(int id)
        {
            _apiResponse.Result = await _dbContext.Receipts.FirstOrDefaultAsync(x => x.RequestId == id);
            return Ok(_apiResponse);
        }


    }
}
