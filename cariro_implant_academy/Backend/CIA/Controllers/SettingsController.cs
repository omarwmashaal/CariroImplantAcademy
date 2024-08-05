using AutoMapper;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.LAB;
using CIA.Models.TreatmentModels;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SettingsController : BaseController
    {
        private readonly API_response _aPI_Response;
        private readonly CIA_dbContext _cia_DbContext;
        private readonly IMedical_Repo _iMedicalRepo;
        private readonly IMapper _mapper;
        private readonly IUserRepo _iUserRepo;
        private readonly EnumWebsite _site;
        public SettingsController(IHttpContextAccessor httpContextAccessor, CIA_dbContext cIA_DbContext, IMapper mapper, IMedical_Repo medical_Repo, IUserRepo iUserRepo)
        {
            _aPI_Response = new API_response();
            _cia_DbContext = cIA_DbContext;
            _mapper = mapper;
            _iMedicalRepo = medical_Repo;
            _iUserRepo = iUserRepo;
            var site = httpContextAccessor.HttpContext.Request.Headers["Site"].ToString();
            if (site == "")
                _site = EnumWebsite.CIA;
            else
                _site = (EnumWebsite)int.Parse(site);
        }


        [HttpGet("GetImplantCompanies")]
        public async Task<IActionResult> GetImplantCompanies()
        {
            _aPI_Response.Result = await _cia_DbContext.ImplantCompanies.OrderBy(x => x.Id).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetImplantLines")]
        public async Task<IActionResult> GetImplantLines(int id)
        {
            var lines = await _cia_DbContext.ImplantLines.Where(x => x.ImplantCompanyId == id).ToListAsync();
            _aPI_Response.Result = lines ?? new List<ImplantLine>();
            return Ok(_aPI_Response);
        }

        [HttpGet("GetImplants")]
        public async Task<IActionResult> GetImplants(int id)
        {
            var res = await _cia_DbContext.Implants.Where(x => x.ImplantLineId == id && x.InventoryWebsite == _site).ToListAsync();
            _aPI_Response.Result = res;
            return Ok(_aPI_Response);
        }

        [HttpGet("GetImplant")]
        public async Task<IActionResult> GetImplant(int id)
        {
            var res = await _cia_DbContext.Implants.FirstOrDefaultAsync(x => x.Id == id);
            _aPI_Response.Result = res;
            return Ok(_aPI_Response);
        }

        [HttpGet("GetAllImplants")]
        public async Task<IActionResult> GetAllImplants()
        {
            var res = await _cia_DbContext.Implants.Where(x => x.InventoryWebsite == _site).ToListAsync();
            _aPI_Response.Result = res;
            return Ok(_aPI_Response);
        }


        [HttpGet("GetAllMembranes")]
        public async Task<IActionResult> GetAllMembranes()
        {
            _aPI_Response.Result = await _cia_DbContext.Membranes.Where(x => x.InventoryWebsite == _site).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetMembranes")]
        public async Task<IActionResult> GetMembranes(int id)
        {
            _aPI_Response.Result = await _cia_DbContext.Membranes.Where(x => x.MembraneCompnayId == id && x.InventoryWebsite == _site).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetMembraneCompanies")]
        public async Task<IActionResult> GetOpenSinusLiftMembraneCompanies()
        {
            _aPI_Response.Result = await _cia_DbContext.MembraneCompanies.ToListAsync();
            return Ok(_aPI_Response);
        }



        [HttpGet("GetTacsCompanies")]
        public async Task<IActionResult> GetTacsCompanies()
        {
            _aPI_Response.Result = await _cia_DbContext.TacCompanies.Where(x => x.InventoryWebsite == _site).ToListAsync();
            return Ok(_aPI_Response);
        }

        [HttpGet("GetExpensesCategories")]
        public async Task<IActionResult> GetExpensesCategories(EnumWebsite website)
        {
            _aPI_Response.Result = await _cia_DbContext.ExpensesCategories.Where(x => x.Website == website).ToListAsync();
            return Ok(_aPI_Response);
        }

        [HttpGet("GetMedicalExpensesCategories")]
        public async Task<IActionResult> GetMedicalExpensesCategories(EnumWebsite website)
        {
            _aPI_Response.Result = await _cia_DbContext.MedicalExpenses.Where(x => x.Website == website).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetNonMedicalNonStockExpensesCategories")]
        public async Task<IActionResult> GetNonMedicalNonStockExpensesCategories(EnumWebsite website)
        {
            _aPI_Response.Result = await _cia_DbContext.ExpensesCategories.Where(x => x.Website == website).
                Where(x => !(x is MedicalExpensesModel)).
                Where(x => !(x is StockCategoriesModel)).
                ToListAsync();

            return Ok(_aPI_Response);
        }
        [HttpGet("GetNonMedicalStockCategories")]
        public async Task<IActionResult> GetNonMedicalStockCategories(EnumWebsite website)
        {
            _aPI_Response.Result = await _cia_DbContext.StockCategories.
                Where(x => !(x is MedicalExpensesModel) && x.Website == website).
                ToListAsync();

            return Ok(_aPI_Response);
        }


        [HttpGet("GetIncomeCategories")]
        public async Task<IActionResult> GetIncomeCategories()
        {
            _aPI_Response.Result = await _cia_DbContext.IncomeCategories.Where(x => x.Website == _site).ToListAsync();
            return Ok(_aPI_Response);
        }

        [HttpGet("GetSuppliers")]
        public async Task<IActionResult> GetSuppliers(EnumWebsite website, bool medical)
        {
            if (medical)
                _aPI_Response.Result = await _cia_DbContext.MedicalSuppliers.ToListAsync();
            else
                _aPI_Response.Result = await _cia_DbContext.NonMedicalSuppliers.ToListAsync();
            return Ok(_aPI_Response);
        }

        [HttpGet("GetStockCategories")]
        public async Task<IActionResult> GetStockCategories(EnumWebsite website)
        {
            _aPI_Response.Result = await _cia_DbContext.StockCategories.Where(x => x.Website == website).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetPaymentMethods")]
        public async Task<IActionResult> GetPaymentMethods()
        {
            _aPI_Response.Result = await _cia_DbContext.PaymentMethods.ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetRooms")]
        public async Task<IActionResult> GetRooms()
        {
            _aPI_Response.Result = await _cia_DbContext.Rooms.Where(x => x.Website == _site).ToListAsync();
            return Ok(_aPI_Response);
        }

        [HttpGet("GetTreatmentPrices")]
        public async Task<IActionResult> GetTreatmentPrices()
        {
            _aPI_Response.Result = await _cia_DbContext.TreatmentItems.FirstAsync();
            return Ok(_aPI_Response);
        }

        [HttpGet("GetLabItemsParents")]
        public async Task<IActionResult> GetLabItemsParents()
        {
            _aPI_Response.Result = await _cia_DbContext.LabItemParents.OrderBy(x => x.Id).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetLabOptions")]
        public async Task<IActionResult> GetLabOptions(int? parentId, int? userId)
        {
            List<LabOptions> options = new List<LabOptions>();
            if (parentId == null || parentId == 0)
                options = await _cia_DbContext.LabOptions.AsNoTracking().OrderBy(x => x.Id).Include(x => x.LabItemParent).ToListAsync();
            else
                options = await _cia_DbContext.LabOptions.AsNoTracking().Where(x => x.LabItemParentId == parentId).Include(x => x.LabItemParent).OrderBy(x => x.Id).ToListAsync();

            if (userId != null)
            {
                var priceList = await _cia_DbContext.LabDoctorPriceList.Where(x => x.DoctorId == (int)userId).ToListAsync();
                foreach (LabOptions option in options)
                {
                    int? newPrice = priceList.FirstOrDefault(x => x.LabOptionId == option.Id)?.Price;
                    if (newPrice == null)
                    {
                        await _cia_DbContext.LabDoctorPriceList.AddAsync(new LabDoctorPriceListModel
                        {
                            DoctorId = (int)userId,
                            LabOptionId = (int)option.Id,
                            Price = option.Price,
                        });
                        _cia_DbContext.SaveChanges();
                        newPrice = option.Price;
                    }
                    option.Price = (int)newPrice;
                }

            }

            _aPI_Response.Result = options;
            return Ok(_aPI_Response);
        }
        [HttpGet("GetLabItemCompanies")]
        public async Task<IActionResult> GetLabItemCompanies(int id)
        {
            _aPI_Response.Result = await _cia_DbContext.LabItemCompanies.Where(x => x.LabItemParentId == id).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetLabItemShades")]
        public async Task<IActionResult> GetLabItemShades(int? parentId, int? companyId)
        {
            if (companyId != null)
                _aPI_Response.Result = await _cia_DbContext.LabItemShades.Where(x => x.LabItemCompanyId == companyId).ToListAsync();
            else if (parentId != null)
                _aPI_Response.Result = await _cia_DbContext.LabItemShades.Where(x => x.LabItemParentId == parentId).ToListAsync();

            return Ok(_aPI_Response);
        }
        [HttpGet("GetLabItems")]
        public async Task<IActionResult> GetLabItems(int? parentId, int? companyId, int? shadeId)
        {
            List<LabItem> labItems = new();
            if (shadeId != null)
                labItems = await _cia_DbContext.LabItems.Where(x => x.LabItemShadeId == shadeId && !(x.Consumed ?? true)).ToListAsync();
            else if (companyId != null)
                labItems = await _cia_DbContext.LabItems.Where(x => x.LabItemCompanyId == companyId && !(x.Consumed ?? true)).ToListAsync();
            else if (parentId != null)
                labItems = await _cia_DbContext.LabItems.Where(x => x.LabItemParentId == parentId && !(x.Consumed ?? true)).ToListAsync();
            else
            {
                _aPI_Response.ErrorMessage = "No Id provided!";
                return BadRequest(_aPI_Response);
            }

            foreach (var item in labItems)
            {
                item.setName();
            }
            _aPI_Response.Result = labItems;
            return Ok(_aPI_Response);
        }

        [HttpPut("ChangeImplantCompanyName")]
        public async Task<IActionResult> ChangeImplantCompanyName(int id, String name)
        {
            var company = await _cia_DbContext.ImplantCompanies.Include(x => x.Lines).ThenInclude(x => x.Implants).FirstOrDefaultAsync(x => x.Id == id);
            company.Name = name;
            foreach (var line in company.Lines)
            {
                foreach (var implant in line.Implants)
                {
                    implant.Name = company.Name + "_" + line.Name + "_" + implant.Size;
                }
            }
            _cia_DbContext.ImplantCompanies.Update(company);
            _cia_DbContext.SaveChanges();


            return Ok(_aPI_Response);
        }

        [HttpPut("ChangeImplantLineName")]
        public async Task<IActionResult> ChangeImplantLineName(int id, String name)
        {
            var line = await _cia_DbContext.ImplantLines.Include(x => x.Implants).FirstOrDefaultAsync(x => x.Id == id);
            var company = await _cia_DbContext.ImplantCompanies.FirstOrDefaultAsync(x => x.Lines.Contains(line));
            line.Name = name;
            foreach (var implant in line.Implants)
            {
                implant.Name = company.Name + "_" + line.Name + "_" + implant.Size;
            }
            _cia_DbContext.ImplantLines.Update(line);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }



        [HttpPut("Implants")]
        public async Task<IActionResult> SetImplants(int id, [FromBody] List<Implant> model)
        {
            var user = await _iUserRepo.GetUser();
            var line = await _cia_DbContext.ImplantLines.Include(x => x.Implants).FirstOrDefaultAsync(x => x.Id == id);
            var implants = line.Implants;
            var category = await _cia_DbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Implants");
            if (category == null)
            {
                category = new MedicalExpensesModel()
                {
                    Name = "Implants",
                    Website = _site,

                };
                _cia_DbContext.MedicalExpenses.Add(category);
                _cia_DbContext.SaveChanges();
            }

            if (model.Count < implants.Count)
            {
                foreach (Implant item in implants)
                {
                    if (!model.Contains(item))
                        _cia_DbContext.Implants.Remove(item);

                }
            }
            var company = await _cia_DbContext.ImplantCompanies.Include(x => x.Lines).FirstOrDefaultAsync(x => x.Lines.Contains(line));
            foreach (Implant item in model)
            {
                var temp = implants.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {
                    item.Name = company.Name + "_" + line.Name + "_" + item.Size;
                    item.Count = 0;
                    _cia_DbContext.Implants.Add(item);
                    _cia_DbContext.SaveChanges();
                    temp = item;
                    item.CategoryId = category.Id;
                    item.CreatedBy = user;
                    item.CreatedById = user.IdInt;
                    item.InventoryWebsite = _site;
                    line.Implants.Add(item);

                }
                else
                {
                    item.Name = company.Name + "_" + line.Name + "_" + item.Size;
                    temp.Name = item.Name;
                    temp.Size = item.Size;
                    _cia_DbContext.Implants.Update(temp);
                }

                _cia_DbContext.Implants.Update(temp);
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }


        [HttpPut("ImplantLines")]
        public async Task<IActionResult> SetImplantLines(int id, String name)
        {
            var company = await _cia_DbContext.ImplantCompanies.FirstAsync(x => x.Id == id);
            ImplantLine line = new ImplantLine()
            {
                Name = name,
                Implants = new List<Implant>()
            };
            _cia_DbContext.ImplantLines.Add(line);
            _cia_DbContext.SaveChanges();
            if (company.Lines == null) company.Lines = new List<ImplantLine>();
            company.Lines.Add(line);
            _cia_DbContext.ImplantCompanies.Update(company);
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }


        [HttpPut("ImplantCompanies")]
        public async Task<IActionResult> SetImplantCompanies(String name)
        {


            _cia_DbContext.ImplantCompanies.Add(new ImplantCompany()
            {
                Name = name,
                Lines = new List<ImplantLine>()

            });
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }




        [HttpPut("AddMembranes")]
        public async Task<IActionResult> AddMembranes(int id, [FromBody] List<Membrane> model)
        {
            List<Membrane> Membranes = await _cia_DbContext.Membranes.Where(x => x.MembraneCompnayId == id).ToListAsync();
            var cat = await _cia_DbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Membranes");

            if (cat == null)
            {
                cat = new MedicalExpensesModel
                {
                    Name = "Membranes",
                    Website = _site,
                };
                _cia_DbContext.MedicalExpenses.Add(cat);
                _cia_DbContext.SaveChanges();
            }

            var Company = await _cia_DbContext.MembraneCompanies.FirstOrDefaultAsync(x => x.Id == id);
            Membrane temp;
            if (model.Count < Membranes.Count)
            {
                foreach (Membrane item in Membranes)
                {
                    if (!model.Contains(item))
                        _cia_DbContext.Membranes.Remove(item);

                }
            }
            foreach (Membrane item in model)
            {
                temp = Membranes.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {
                    item.MembraneCompnayId = Company.Id;
                    item.Name = Company.Name + "_" + item.Size;
                    item.InventoryWebsite = _site;
                    item.Category = cat;
                    await _cia_DbContext.Membranes.AddAsync(item);
                    await _cia_DbContext.SaveChangesAsync();

                }
                else
                {
                    temp.Size = item.Size;
                    temp.Name = Company.Name + "_" + item.Size;
                    temp.InventoryWebsite = _site;
                    _cia_DbContext.Membranes.Update(temp);
                }
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }

        [HttpPut("AddMembraneCompanies")]
        public async Task<IActionResult> AddMembraneCompanies([FromBody] List<MembraneCompany> model)
        {

            List<MembraneCompany> Companies = await _cia_DbContext.MembraneCompanies.ToListAsync();

            MembraneCompany temp;
            if (model.Count < Companies.Count)
            {
                foreach (MembraneCompany item in Companies)
                {
                    if (!model.Contains(item))
                        _cia_DbContext.MembraneCompanies.Remove(item);

                }
            }
            foreach (MembraneCompany item in model)
            {
                temp = Companies.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {
                    await _cia_DbContext.MembraneCompanies.AddAsync(item);
                }
                else
                {
                    temp.Name = item.Name;
                    _cia_DbContext.MembraneCompanies.Update(temp);
                }
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }


        [HttpPut("AddTacsCompanies")]
        public async Task<IActionResult> AddTacsCompanies([FromBody] List<TacCompany> model)
        {
            var cat = await _cia_DbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Tacs");

            if (cat == null)
            {
                cat = new MedicalExpensesModel
                {
                    Name = "Tacs",
                    Website = _site,
                };
                _cia_DbContext.MedicalExpenses.Add(cat);
                _cia_DbContext.SaveChanges();
            }
            List<TacCompany> Companies = await _cia_DbContext.TacCompanies.ToListAsync();

            TacCompany temp;
            if (model.Count < Companies.Count)
            {
                foreach (TacCompany item in Companies)
                {
                    if (!model.Contains(item))
                        _cia_DbContext.TacCompanies.Remove(item);

                }
            }
            foreach (TacCompany item in model)
            {
                temp = Companies.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {
                    item.Category = cat;
                    item.InventoryWebsite = _site;
                    await _cia_DbContext.TacCompanies.AddAsync(item);
                }
                else
                {
                    temp.Name = item.Name;
                    temp.Count = item.Count;
                    temp.InventoryWebsite = _site;
                    _cia_DbContext.TacCompanies.Update(temp);
                }
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }



        [HttpPut("AddExpensesCategories")]
        public async Task<IActionResult> SetExpensesCategories([FromBody] List<ExpensesCategoriesModel> model)
        {

            List<ExpensesCategoriesModel> m = await _cia_DbContext.ExpensesCategories.Where(x => x.Website == _site).ToListAsync();

            ExpensesCategoriesModel temp;
            if (model.Count < m.Count)
            {
                foreach (ExpensesCategoriesModel item in m)
                {
                    if (!model.Contains(item))
                        _cia_DbContext.ExpensesCategories.Remove(item);

                }
            }
            foreach (ExpensesCategoriesModel item in model)
            {
                item.Website = _site;
                temp = m.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {

                    await _cia_DbContext.ExpensesCategories.AddAsync(item);
                }
                else
                {
                    temp.Name = item.Name;
                    _cia_DbContext.ExpensesCategories.Update(temp);
                }
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }

        [HttpPut("EditRooms")]
        public async Task<IActionResult> EditRooms([FromBody] List<RoomModel> models)
        {

            List<RoomModel> rooms = await _cia_DbContext.Rooms.Where(x => x.Website == _site).ToListAsync();

            RoomModel temp;
            if (models.Count < rooms.Count)
            {
                foreach (RoomModel item in rooms)
                {
                    if (!models.Contains(item))
                        _cia_DbContext.Rooms.Remove(item);

                }
            }
            foreach (RoomModel item in models)
            {
                temp = rooms.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {
                    temp = new RoomModel()
                    {
                        Name = item.Name,
                        Color = item.Color,
                        Website = _site
                    };

                    await _cia_DbContext.Rooms.AddAsync(temp);
                }
                else
                {
                    temp.Name = item.Name;
                    temp.Color = item.Color;
                    _cia_DbContext.Rooms.Update(temp);
                }
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }

        [HttpPut("AddIncomeCategories")]
        public async Task<IActionResult> SetIncomeCategories([FromBody] List<IncomeCategoriesModel> model)
        {


            List<IncomeCategoriesModel> m = await _cia_DbContext.IncomeCategories.Where(x => x.Website == _site).ToListAsync();
            IncomeCategoriesModel temp;
            if (model.Count < m.Count)
            {
                foreach (IncomeCategoriesModel item in m)
                {
                    if (!model.Contains(item))
                        _cia_DbContext.IncomeCategories.Remove(item);

                }
            }
            foreach (IncomeCategoriesModel item in model)
            {
                item.Website = _site;
                temp = m.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {
                    await _cia_DbContext.IncomeCategories.AddAsync(item);
                }
                else
                {
                    temp.Name = item.Name;
                    _cia_DbContext.IncomeCategories.Update(temp);
                }
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }

        [HttpPut("AddSuppliers")]
        public async Task<IActionResult> SetSuppliers([FromBody] List<SuppliersModel> model, bool medical)
        {



            if (medical)

                _cia_DbContext.MedicalSuppliers.UpdateRange(_mapper.Map<List<MedicalSuppliersModel>>(model));
            else
                _cia_DbContext.NonMedicalSuppliers.UpdateRange(_mapper.Map<List<NonMedicalSuppliersModel>>(model));








            _cia_DbContext.SaveChanges();


            return Ok(_aPI_Response);
        }

        [HttpPut("AddStockCategories")]
        public async Task<IActionResult> SetStockCategories([FromBody] List<StockCategoriesModel> model)
        {

            List<StockCategoriesModel> m = await _cia_DbContext.StockCategories.Where(x => x.Website == _site).ToListAsync();

            StockCategoriesModel temp;
            if (model.Count < m.Count)
            {
                foreach (StockCategoriesModel item in m)
                {
                    if (!model.Contains(item))
                        _cia_DbContext.StockCategories.Remove(item);

                }
            }
            foreach (StockCategoriesModel item in model)
            {
                item.Website = _site;
                temp = m.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {
                    await _cia_DbContext.StockCategories.AddAsync(item);
                }
                else
                {
                    temp.Name = item.Name;
                    _cia_DbContext.StockCategories.Update(temp);
                }
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }

        [HttpPut("AddPaymentMethods")]
        public async Task<IActionResult> SetPaymentMethods([FromBody] List<PaymentMethodsModel> model)
        {

            List<PaymentMethodsModel> m = await _cia_DbContext.PaymentMethods.Where(x => x.Website == _site).ToListAsync();

            PaymentMethodsModel temp;
            if (model.Count < m.Count)
            {
                foreach (PaymentMethodsModel item in m)
                {
                    if (!model.Contains(item))
                        _cia_DbContext.PaymentMethods.Remove(item);

                }
            }
            foreach (PaymentMethodsModel item in model)
            {
                item.Website = _site;
                temp = m.FirstOrDefault(x => x.Id == item.Id);
                if (temp == null)
                {
                    await _cia_DbContext.PaymentMethods.AddAsync(item);
                }
                else
                {
                    temp.Name = item.Name;
                    _cia_DbContext.PaymentMethods.Update(temp);
                }
            }
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }


        [HttpGet("LoadRooms")]
        public async Task<ActionResult> LoadRooms()
        {

            var Rooms = await _cia_DbContext.Rooms.Where(x => x.Website == _site).ToListAsync();
            List<Object> s = new List<Object>();

            foreach (var c in Rooms)
            {
                s.Add(new { id = c.Id, c.Name });
            }

            _aPI_Response.Result = s;
            return Ok(_aPI_Response);
        }
        [HttpPut("EditTreatmentPrices")]
        public async Task<IActionResult> EditTreatmentPrices(List<TreatmentItemModel> prices)
        {
            var ids = await _cia_DbContext.TreatmentItems.AsNoTracking().Select(x => x.Id).ToListAsync();
            var nullPrices = prices.Where(x => x.Id == null).ToList();
            int maxId = (int)ids.Max();
            if (nullPrices != null)
            {
                foreach (var nn in nullPrices)
                {
                    nn.Id = maxId + 1;
                    maxId = (int)nn.Id;
                    _cia_DbContext.TreatmentItems.Add(nn);
                    _cia_DbContext.SaveChanges();
                    prices.Remove(nn);

                }


            }

            _cia_DbContext.TreatmentItems.UpdateRange(prices);
            _cia_DbContext.SaveChanges();



            _aPI_Response.Result = prices;
            return Ok(_aPI_Response);
        }

        [HttpPost("GetTeethTreatmentPrices")]
        public async Task<IActionResult> GetTeethTreatmentPrices([FromBody] GetClinicPricesDTO model)
        {
            IQueryable<ClinicPricesModel> query = _cia_DbContext.ClinicPrices;
            if (model.Teeth != null && model.Category != null && !model.Category.Contains(EnumClinicPrices.DoctorsPatientDoctorsOperation_DoctorPercent))
            {
                query = query.Where(x => model.Teeth!.Contains((int)x.Tooth!));
            }
            if (model.Category != null)
            {


                query = query.Where(x => model.Category!.Contains(x.Category));
            }

            _aPI_Response.Result = await query.ToListAsync();


            return Ok(_aPI_Response);
        }

        [HttpPut("UpdateTeethTreatmentPrices")]
        public async Task<IActionResult> UpdateTeethTreatmentPrices([FromBody] List<ClinicPricesModel> prices)
        {

            _cia_DbContext.ClinicPrices.UpdateRange(prices);
            _cia_DbContext.SaveChanges();



            return Ok(_aPI_Response);
        }

        [HttpPut("UpdateLabItemParents")]
        public async Task<IActionResult> UpdateLabItemParents(List<LabItemParent> parents)
        {
            _cia_DbContext.LabItemParents.UpdateRange(parents);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }
        [HttpPut("UpdateLabItemCompanies")]
        public async Task<IActionResult> UpdateLabItemCompanies(List<LabItemCompany> data)
        {

            _cia_DbContext.LabItemCompanies.UpdateRange(data);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }
        [HttpPut("UpdateLabItemShades")]
        public async Task<IActionResult> UpdateLabItemShades(List<LabItemShade> data)
        {
            _cia_DbContext.LabItemShades.UpdateRange(data);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }
        [HttpPut("UpdateLabOptions")]
        public async Task<IActionResult> UpdateLabOptions(List<LabOptions> data)
        {
            _cia_DbContext.LabOptions.UpdateRange(data);
            _cia_DbContext.SaveChanges();
            return Ok(_aPI_Response);
        }
        [HttpPut("UpdateLabOptionsDoctorPriceList")]
        public async Task<IActionResult> UpdateLabOptionsDoctorPriceList(List<LabDoctorPriceListModel> data)
        {
            var drIds = data.Select(X => X.DoctorId).Distinct().ToList();
            var priceList = await _cia_DbContext.LabDoctorPriceList.Where(x => drIds.Contains(x.DoctorId)).ToListAsync();
            foreach (var price in priceList)
            {
                price.Price = data.First(x => x.LabOptionId == price.LabOptionId).Price;
            }
            _cia_DbContext.LabDoctorPriceList.UpdateRange(priceList);
            _cia_DbContext.SaveChanges();
            return Ok();
        }
        [HttpPut("UpdateLabItems")]
        public async Task<IActionResult> UpdateLabItems(List<LabItem> data)
        {
            var user = await _iUserRepo.GetUser();
            var cat = await _cia_DbContext.StockCategories.FirstOrDefaultAsync(x => x.Name == "Lab Medical Item");
            if (cat == null)
            {
                cat = new StockCategoriesModel
                {
                    Name = "Lab Medical Item",
                    Website = EnumWebsite.Lab,

                };
                _cia_DbContext.StockCategories.Add(cat);
                _cia_DbContext.SaveChanges();
            }
            foreach (var item in data)
            {
                item.setName();
                item.Website = EnumWebsite.Lab;
                item.InventoryWebsite = EnumWebsite.Lab;
                item.Category = cat;
                if (item.Id == null)
                {
                    item.Date = DateTime.UtcNow;
                    item.CreatedBy = user;
                    item.CreatedById = user.IdInt;
                    _cia_DbContext.StockLogs.Add(new StockLog
                    {
                        Count = 1,
                        Date = DateTime.UtcNow,
                        InventoryWebsite = EnumWebsite.Lab,
                        Name = item.Name,
                        Operator = user,
                        OperatorId = (int)user.IdInt,
                        Status = "Added",
                        Website = EnumWebsite.Lab,
                    });
                }
                if (item.Consumed == false)
                    item.Count = 1;
            }

            _cia_DbContext.LabItems.UpdateRange(data);
            _cia_DbContext.SaveChanges();


            return Ok(_aPI_Response);
        }


        [HttpGet("GetProstheticItems")]
        public async Task<IActionResult> GetProstheticItems(EnumProstheticType type)
        {
            if (type == EnumProstheticType.Diagnostic)
                _aPI_Response.Result = await _cia_DbContext.DiagnosticItems.ToListAsync();
            else
                _aPI_Response.Result = await _cia_DbContext.FinalItems.ToListAsync();
            return Ok(_aPI_Response);
        }

        [HttpGet("GetProstheticStatus")]
        public async Task<IActionResult> GetProstheticStatus(EnumProstheticType type, int itemId)
        {
            if (type == EnumProstheticType.Diagnostic)
                _aPI_Response.Result = await _cia_DbContext.DiagnosticStatusItems.Where(x => x.DiagnosticItemId == itemId).ToListAsync();
            else
                _aPI_Response.Result = await _cia_DbContext.FinalStatusItems.Where(x => x.FinaltemId == itemId).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetProstheticNextVist")]
        public async Task<IActionResult> GetProstheticNextVist(EnumProstheticType type, int itemId)
        {
            if (type == EnumProstheticType.Diagnostic)
                _aPI_Response.Result = await _cia_DbContext.DiagnosticNextVisitItems.Where(x => x.DiagnosticItemId == itemId).ToListAsync();
            else
                _aPI_Response.Result = await _cia_DbContext.FinalNextVisitItems.Where(x => x.FinalItemId == itemId).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetProstheticMaterial")]
        public async Task<IActionResult> GetProstheticMaterial(EnumProstheticType type, int itemId)
        {
            if (type == EnumProstheticType.Diagnostic)
                _aPI_Response.Result = await _cia_DbContext.DiagnosticMaterialItems.Where(x => x.DiagnosticItemId == itemId).ToListAsync();
            else
                _aPI_Response.Result = await _cia_DbContext.FinalMaterialItems.Where(x => x.FinalItemId == itemId).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpGet("GetProstheticTechnique")]
        public async Task<IActionResult> GetProstheticTechnique(EnumProstheticType type, int itemId)
        {
            if (type == EnumProstheticType.Diagnostic)
                _aPI_Response.Result = await _cia_DbContext.DiagnosticTechniqueItems.Where(x => x.DiagnosticItemId == itemId).ToListAsync();
            else
                _aPI_Response.Result = await _cia_DbContext.FinalTechniqueItems.Where(x => x.FinalItemId == itemId).ToListAsync();
            return Ok(_aPI_Response);
        }
        [HttpPost("UpdateProstheticItems")]
        public async Task<IActionResult> UpdateProstheticItems(EnumProstheticType type, [FromBody] List<DropDowns> data)
        {
            if (type == EnumProstheticType.Diagnostic)
            {
                var models = data.Select(x => new DiagnosticItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                }).ToList();
                _cia_DbContext.DiagnosticItems.UpdateRange(models);
            }
            else
            {
                var models = data.Select(x => new FinalItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                }).ToList();
                _cia_DbContext.FinalItems.UpdateRange(models);
            }
            _cia_DbContext.SaveChanges();
            return Ok();
        }

        [HttpPost("UpdateProstheticStatus")]
        public async Task<IActionResult> UpdateProstheticStatus(int itemId, EnumProstheticType type, [FromBody] List<DropDowns> data)
        {
            if (type == EnumProstheticType.Diagnostic)
            {
                var models = data.Select(x => new DiagnosticStatusItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                    DiagnosticItemId = itemId,
                }).ToList();
                _cia_DbContext.DiagnosticStatusItems.UpdateRange(models);
            }
            else
            {
                var models = data.Select(x => new FinalStatusItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                    FinaltemId = itemId,
                }).ToList();
                _cia_DbContext.FinalStatusItems.UpdateRange(models);
            }
            _cia_DbContext.SaveChanges();
            return Ok();
        }

        [HttpPost("UpdateProstheticNextVisit")]
        public async Task<IActionResult> UpdateProstheticNextVisit(int itemId, EnumProstheticType type, [FromBody] List<DropDowns> data)
        {
            if (type == EnumProstheticType.Diagnostic)
            {
                var models = data.Select(x => new DiagnosticNextVisitItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                    DiagnosticItemId = itemId,
                }).ToList();
                _cia_DbContext.DiagnosticNextVisitItems.UpdateRange(models);
            }
            else
            {
                var models = data.Select(x => new FinalNextVisitItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                    FinalItemId = itemId,
                }).ToList();
                _cia_DbContext.FinalNextVisitItems.UpdateRange(models);
            }
            _cia_DbContext.SaveChanges();
            return Ok();
        }

        [HttpPost("UpdateProstheticMaterial")]
        public async Task<IActionResult> UpdateProstheticMaterial(int itemId, EnumProstheticType type, [FromBody] List<DropDowns> data)
        {
            if (type == EnumProstheticType.Diagnostic)
            {
                var models = data.Select(x => new DiagnosticMaterialItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                    DiagnosticItemId = itemId,
                }).ToList();
                _cia_DbContext.DiagnosticMaterialItems.UpdateRange(models);
            }
            else
            {
                var models = data.Select(x => new FinalMaterialItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                    FinalItemId = itemId,
                }).ToList();
                _cia_DbContext.FinalMaterialItems.UpdateRange(models);
            }
            _cia_DbContext.SaveChanges();
            return Ok();
        }

        [HttpPost("UpdateProstheticTechnique")]
        public async Task<IActionResult> UpdateProstheticTechnique(int itemId, EnumProstheticType type, [FromBody] List<DropDowns> data)
        {
            if (type == EnumProstheticType.Diagnostic)
            {
                var models = data.Select(x => new DiagnosticTechniqueItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                    DiagnosticItemId = itemId,
                }).ToList();
                _cia_DbContext.DiagnosticTechniqueItems.UpdateRange(models);
            }
            else
            {
                var models = data.Select(x => new FinalTechniqueItemModel
                {
                    Id = x.Id,
                    Name = x.Name,
                    FinalItemId = itemId,
                }).ToList();
                _cia_DbContext.FinalTechniqueItems.UpdateRange(models);
            }
            _cia_DbContext.SaveChanges();
            return Ok();
        }


        [HttpGet("GetSurgicalComplications")]
        public async Task<IActionResult> GetSurgicalComplications()
        {
            _aPI_Response.Result = await _cia_DbContext.DefaultSurgicalComplications.ToListAsync();

            return Ok(_aPI_Response);
        }
        [HttpPut("UpdateSurgicalComplications")]
        public async Task<IActionResult> UpdateSurgicalComplications(List<DefaultSurgicalComplications> model)
        {
            _cia_DbContext.DefaultSurgicalComplications.UpdateRange(model);
            _cia_DbContext.SaveChanges();

            return Ok();
        }
        [HttpGet("GetProstheticComplications")]
        public async Task<IActionResult> GetProstheticComplications()
        {
            _aPI_Response.Result = await _cia_DbContext.DefaultProstheticComplications.ToListAsync();

            return Ok(_aPI_Response);
        }
        [HttpPut("UpdateProstheticComplications")]
        public async Task<IActionResult> UpdateProstheticComplications(List<DefaultProstheticComplications> model)
        {
            _cia_DbContext.DefaultProstheticComplications.UpdateRange(model);
            _cia_DbContext.SaveChanges();

            return Ok();
        }


    }

}
