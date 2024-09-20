using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using AutoMapper;
using CIA.DataBases;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using CIA.Models.CIA;
using CIA.Models;
using CIA.Models.CIA.DTOs;
using Newtonsoft.Json;
using System.Xml.Schema;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CashFlowController : BaseController
    {
        private readonly API_response _apiResponse;
        private readonly CIA_dbContext _cia_DbContext;
        private readonly IMedical_Repo _iMedicalRepo;
        private readonly IMapper _mapper;
        private readonly IUserRepo _iUserRepo;
        private readonly EnumWebsite _site;
        public CashFlowController(IHttpContextAccessor httpContextAccessor, CIA_dbContext cIA_DbContext, IMapper mapper, IMedical_Repo medical_Repo, IUserRepo iUserRepo)
        {
            _apiResponse = new API_response();
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

        [HttpGet("GetExpenesesCategoryByName")]
        public async Task<IActionResult> GetExpenesesCategoryByName(String name)
        {
            _apiResponse.Result = await _cia_DbContext.ExpensesCategories.FirstOrDefaultAsync(x => x.Name.ToLower() == name.ToLower());
            return Ok(_apiResponse);
        }
        [HttpPost("AddReceipt")]
        public async Task<IActionResult> AddReceipt([FromBody] Receipt model)
        {
            model.Operator = await _cia_DbContext.Users.FirstOrDefaultAsync(x => x.IdInt == model.OperatorId);
            _cia_DbContext.Receipts.Add(model);
            _cia_DbContext.SaveChanges();
            model = await _cia_DbContext.Receipts.FirstOrDefaultAsync(x => x.Id == model.Id);
            _apiResponse.Result = model;
            return Ok(_apiResponse);

        }

        [HttpPost("AddIncome")]
        public async Task<IActionResult> AddIncome([FromBody] IncomeModel model)
        {
            var cat = await _cia_DbContext.IncomeCategories.FirstOrDefaultAsync(x => x.Id == model.CategoryId && x.Website == _site);
            var pay = await _cia_DbContext.PaymentMethods.FirstOrDefaultAsync(x => x.Id == model.PaymentMethodId);

            if (cat == null)
            {
                cat = new IncomeCategoriesModel();
                cat.Name = model.Category.Name;
                cat.Website = _site;
                _cia_DbContext.IncomeCategories.Add(cat);
                _cia_DbContext.SaveChanges();
                model.CategoryId = cat.Id;
                model.Category = null;
            }
            else
            {
                model.Category = null;
            }
            if (pay == null)
            {
                pay = new PaymentMethodsModel();
                pay.Name = model.PaymentMethod.Name;
                _cia_DbContext.PaymentMethods.Add(pay);
                _cia_DbContext.SaveChanges();
                model.PaymentMethodId = pay.Id;
                model.PaymentMethod = null;
            }
            else
            {
                model.PaymentMethod = null;
            }
            var user = await _iUserRepo.GetUser();
            model.CreatedBy = user;
            model.Date = DateTime.UtcNow;
            //if (model.Type == null) model.Type = new List<string>() { "Income" };
            //else if(!model.Type.Contains("Income")) model.Type.Add("Income");
            model.Website = _site;
            await _cia_DbContext.Income.AddAsync(model);
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_apiResponse);

        }
        [HttpPost("AddExpense")]
        public async Task<IActionResult> AddExpense([FromBody] List<CashFlowDTO>? model, bool isStockItem, bool? isMedicalExpenses, EnumExpenseseCategoriesType type, EnumWebsite inventoryWebsite)
        {
            var user = await _iUserRepo.GetUser();

            if (model.Count > 0)
            {
                //Suppliers
                SuppliersModel supplier;
                if (type == EnumExpenseseCategoriesType.BoughtMedical)
                {
                    supplier = await _cia_DbContext.MedicalSuppliers.FirstOrDefaultAsync(x => x.Id == model[0].SupplierId && x.Website == inventoryWebsite);

                }
                else
                    supplier = await _cia_DbContext.NonMedicalSuppliers.FirstOrDefaultAsync(x => x.Id == model[0].SupplierId && x.Website == inventoryWebsite);
                if (supplier == null && model[0].Supplier != null)
                {

                    supplier = type == EnumExpenseseCategoriesType.BoughtMedical ? new MedicalSuppliersModel() : new NonMedicalSuppliersModel();
                    supplier.Name = model[0].Supplier.Name;
                    supplier.Website = inventoryWebsite;
                    if (type == EnumExpenseseCategoriesType.BoughtMedical)
                        _cia_DbContext.MedicalSuppliers.Add((MedicalSuppliersModel)supplier);
                    else
                        _cia_DbContext.NonMedicalSuppliers.Add((NonMedicalSuppliersModel)supplier);
                    _cia_DbContext.SaveChanges();
                    model.ForEach(x =>
                    {
                        x.Website = inventoryWebsite;
                        x.InventoryWebsite = inventoryWebsite;
                        x.SupplierId = supplier.Id;
                        x.Supplier = null;
                    });
                }
                else
                {
                    model.ForEach(x =>
                    {
                        x.Supplier = null;
                    });
                }

                //Payment Methods
                var paymentMethod = await _cia_DbContext.PaymentMethods.FirstOrDefaultAsync(x => x.Id == model[0].PaymentMethodId);
                if (paymentMethod == null && model[0].PaymentMethod != null)
                {
                    paymentMethod = new PaymentMethodsModel();
                    paymentMethod.Name = model[0].PaymentMethod.Name;
                    _cia_DbContext.PaymentMethods.Add(paymentMethod);
                    _cia_DbContext.SaveChanges();
                    model.ForEach(x =>
                    {
                        x.PaymentMethodId = paymentMethod.Id;
                        x.PaymentMethod = null;
                        x.Website = _site;
                    });
                }
                else
                {
                    model.ForEach(x =>
                    {
                        x.PaymentMethod = null;
                    });
                }


                var cat = await _cia_DbContext.ExpensesCategories.FirstOrDefaultAsync(x => x.Id == model[0].CategoryId && x.Website == inventoryWebsite);

                var reciept = new Receipt()
                {
                    //Items = model,
                    Date = DateTime.UtcNow,
                    Website = _site,

                };
                await _cia_DbContext.Receipts.AddAsync(reciept);
                await _cia_DbContext.SaveChangesAsync();

                if (type != EnumExpenseseCategoriesType.BoughtMedical || model[0].Id == null)
                {

                    if (cat == null && model[0].Category != null)
                    {
                        if (type == EnumExpenseseCategoriesType.BoughtItem)
                            cat = new StockCategoriesModel();
                        else if (type == EnumExpenseseCategoriesType.BoughtMedical)

                            cat = new MedicalExpensesModel();

                        else
                            cat = new ExpensesCategoriesModel();

                        cat.Name = model[0].Category.Name;
                        cat.Website = inventoryWebsite;

                        if (type == EnumExpenseseCategoriesType.BoughtItem)
                        {
                            cat = _mapper.Map<StockCategoriesModel>(cat);
                            _cia_DbContext.StockCategories.Add((StockCategoriesModel)cat);
                        }
                        else if (type == EnumExpenseseCategoriesType.BoughtMedical)
                        {
                            cat = _mapper.Map<MedicalExpensesModel>(cat);
                            _cia_DbContext.MedicalExpenses.Add((MedicalExpensesModel)cat);
                        }
                        else
                        {
                            _cia_DbContext.ExpensesCategories.Add(cat);
                        }
                        _cia_DbContext.SaveChanges();

                        model.ForEach(x =>
                        {
                            x.CategoryId = cat.Id;
                            x.Category = null;
                        });

                    }
                    else
                    {
                        model.ForEach(x =>
                        {
                            x.Category = null;
                        });
                    }




                }


                foreach (var itemFromQuery in model)
                {
                    itemFromQuery.CreatedBy = user;
                    itemFromQuery.CreatedById = (int)user.IdInt;
                    itemFromQuery.Date = DateTime.UtcNow;
                    itemFromQuery.ReceiptID = reciept.Id;
                    itemFromQuery.Category = null;
                    itemFromQuery.Website = _site;
                    itemFromQuery.InventoryWebsite = inventoryWebsite;
                    if (type == EnumExpenseseCategoriesType.BoughtItem)
                    {
                        var itemFromDataBase = await _cia_DbContext.Stock.Include(e => e.Category).FirstOrDefaultAsync(e => e.Name == itemFromQuery.Name && e.Category.Name == cat.Name && e.Website == inventoryWebsite);

                        if (itemFromDataBase == null)
                        {

                            _cia_DbContext.Stock.Add(itemFromQuery);
                        }
                        else
                        {
                            itemFromDataBase.Count += itemFromQuery.Count;
                            _cia_DbContext.Stock.Update(itemFromDataBase);
                            itemFromQuery.Id = null;
                            _cia_DbContext.Expenses.Add(_mapper.Map<ExpensesModel>(itemFromQuery));

                        }
                        _cia_DbContext.StockLogs.Add(new StockLog
                        {
                            Count = itemFromQuery.Count ?? 0,
                            Date = DateTime.UtcNow,
                            Name = itemFromQuery.Name,
                            Status = "Added",
                            Operator = user,
                            Website = _site,
                            InventoryWebsite = inventoryWebsite,
                        }); ;
                    }
                    else if (type == EnumExpenseseCategoriesType.BoughtMedical)
                    {
                        StockItem itemFromDataBase;
                        if (itemFromQuery.Name == "Screws")
                        {
                            itemFromDataBase = await _cia_DbContext.Screws.FirstOrDefaultAsync();

                            cat = await _cia_DbContext.MedicalExpenses.FirstOrDefaultAsync(e => e.Name == "Screws" && e.Website == _site);
                            if (cat == null)
                            {

                                cat = new MedicalExpensesModel()
                                {
                                    Name = "Screws",
                                    Website = _site

                                };
                            }

                            itemFromQuery.Category = cat;
                            if (itemFromDataBase == null)
                            {
                                itemFromDataBase = _mapper.Map<ScrewsModel>(itemFromQuery);
                                _cia_DbContext.Screws.Add((ScrewsModel)itemFromDataBase);
                            }
                            else
                            {
                                itemFromDataBase.Category = itemFromQuery.Category;
                                itemFromDataBase.Count += itemFromQuery.Count;
                                itemFromDataBase.Name = itemFromQuery.Name;
                                itemFromDataBase.Website = _site;
                                inventoryWebsite = inventoryWebsite;
                                _cia_DbContext.Stock.Update(itemFromDataBase);
                                itemFromQuery.Id = null;
                                _cia_DbContext.Expenses.Add(_mapper.Map<ExpensesModel>(itemFromQuery));
                            }

                        }
                        else
                        {
                            itemFromDataBase = await _cia_DbContext.Stock.FirstOrDefaultAsync(e => e.Id == itemFromQuery.Id);
                            if (itemFromDataBase != null)
                            {

                                itemFromDataBase.Count += itemFromQuery.Count;
                                itemFromDataBase.Website = _site;
                                inventoryWebsite = inventoryWebsite;
                                _cia_DbContext.Stock.Update(itemFromDataBase);
                                itemFromQuery.CategoryId = itemFromDataBase.CategoryId;
                                itemFromQuery.Name = itemFromDataBase.Name ?? itemFromDataBase.Size;
                                itemFromQuery.Id = null;
                                _cia_DbContext.Expenses.Add(_mapper.Map<ExpensesModel>(itemFromQuery));
                            }
                            else
                            {
                                _cia_DbContext.Stock.Add(itemFromQuery);
                                itemFromDataBase = itemFromQuery;
                            }

                        }


                        _cia_DbContext.StockLogs.Add(new StockLog
                        {
                            Count = itemFromQuery.Count ?? 0,
                            Date = DateTime.UtcNow,
                            Name = itemFromDataBase.Name ?? itemFromQuery.Size,
                            Status = "Added",
                            Operator = user,
                            InventoryWebsite = inventoryWebsite,
                            Website = _site
                        });
                    }
                    else
                    {
                        _cia_DbContext.Expenses.Add(_mapper.Map<ExpensesModel>(itemFromQuery));
                    }








                }




            }
            else
            {
                _apiResponse.ErrorMessage = "Empty";
                return BadRequest(_apiResponse);
            }

            await _cia_DbContext.SaveChangesAsync();

            return Ok(_apiResponse);

        }

        [HttpPost("AddLabExpense")]
        public async Task<IActionResult> AddLabExpense([FromBody] List<CashFlowDTO>? model, bool isStockItem, bool? isMedicalExpenses, EnumExpenseseCategoriesType type, EnumWebsite? inventoryWebsite)
        {
            var user = await _iUserRepo.GetUser();

            if (model.Count > 0)
            {
                //Suppliers
                var supplier = await _cia_DbContext.MedicalSuppliers.FirstOrDefaultAsync(x => x.Id == model[0].SupplierId);
                if (supplier == null && model[0].Supplier != null)
                {
                    supplier = new MedicalSuppliersModel();
                    supplier.Name = model[0].Supplier.Name;
                    supplier.Website = EnumWebsite.Lab;
                    _cia_DbContext.MedicalSuppliers.Add(supplier);
                    _cia_DbContext.SaveChanges();
                    model.ForEach(x =>
                    {
                        x.Website = EnumWebsite.Lab;
                        x.InventoryWebsite = inventoryWebsite ?? _site;
                        x.SupplierId = supplier.Id;
                        x.Supplier = null;
                    });
                }
                else
                {
                    model.ForEach(x =>
                    {
                        x.Supplier = null;
                    });
                }

                //Payment Methods
                var paymentMethod = await _cia_DbContext.PaymentMethods.FirstOrDefaultAsync(x => x.Id == model[0].PaymentMethodId);
                if (paymentMethod == null && model[0].PaymentMethod != null)
                {
                    paymentMethod = new PaymentMethodsModel();
                    paymentMethod.Name = model[0].PaymentMethod.Name;
                    _cia_DbContext.PaymentMethods.Add(paymentMethod);
                    _cia_DbContext.SaveChanges();
                    model.ForEach(x =>
                    {
                        x.PaymentMethodId = paymentMethod.Id;
                        x.PaymentMethod = null;
                        x.Website = _site;
                    });
                }
                else
                {
                    model.ForEach(x =>
                    {
                        x.PaymentMethod = null;
                    });
                }


                var cat = await _cia_DbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Lab Medical Item");
                if (cat == null)
                {
                    cat = new MedicalExpensesModel()
                    {
                        Name = "Lab Medical Item",
                        Website = EnumWebsite.Lab,
                    };
                    _cia_DbContext.MedicalExpenses.Add(cat);
                    _cia_DbContext.SaveChanges();
                }
                model.ForEach(x =>
                {
                    x.Category = cat;
                    x.CreatedBy = user;
                    x.CreatedById = user.IdInt;
                    x.Website = _site;
                    x.InventoryWebsite = inventoryWebsite ?? EnumWebsite.Lab;
                    x.Date = DateTime.UtcNow;
                    x.Name = x.Code;
                    _cia_DbContext.StockLogs.Add(new StockLog
                    {
                        Count = 1,
                        Date = DateTime.UtcNow,
                        Name = x.Code,
                        Status = "Added",
                        Operator = user,
                        InventoryWebsite = EnumWebsite.Lab,
                        Website = EnumWebsite.Lab
                    });

                });


                var reciept = new Receipt()
                {
                    //Items = model,
                    Date = DateTime.UtcNow,
                    Website = _site,

                };


                await _cia_DbContext.Receipts.AddAsync(reciept);


                await _cia_DbContext.LabItems.AddRangeAsync(model);


                await _cia_DbContext.SaveChangesAsync();

            }
            else
            {
                _apiResponse.ErrorMessage = "Empty";
                return BadRequest(_apiResponse);
            }

            await _cia_DbContext.SaveChangesAsync();

            return Ok(_apiResponse);

        }



        //[HttpPost("AddImplantsExpenses")]
        //public async Task<IActionResult> AddImplantsExpenses(int id, int count, int price)
        //{
        //    var user = await _iUserRepo.GetUser();
        //    var category = await _cia_DbContext.MedicalExpenses.FirstOrDefaultAsync(x => x.Name == "Implants");
        //    var im = await _cia_DbContext.Implants.Include(x => x.StockItem).FirstOrDefaultAsync(x => x.Id == id);
        //    if (im.StockItem == null)
        //    {
        //        if (category == null)
        //        {
        //            category = new DropDowns()
        //            {
        //                Name = "Implants",
        //                Type = "MedicalExpenses"
        //            };
        //            //_cia_DbContext.DropDowns.Add(category);
        //            _cia_DbContext.SaveChanges();
        //        }
        //        StockItem expenseItem = new StockItem()
        //        {
        //            Name = im.Name,
        //            Category = category,
        //            Count = count,
        //        };
        //        _cia_DbContext.Stock.Add(expenseItem);
        //        _cia_DbContext.SaveChanges();
        //        im.StockItem = expenseItem;


        //    }
        //    else
        //    {
        //        im.StockItem.Count += count;
        //    }
        //    im.Count += count;

        //    CashFlowModel expesnse = new CashFlowModel()
        //    {
        //        Count = count,
        //        Price = price,
        //        Date = DateTime.UtcNow,
        //        Category = category,
        //        CreatedById = user.IdInt,
        //        CreatedBy = user,
        //        Name = im.Name,
        //        Type = "Expenses",

        //    };
        //    StockLog stockLog = new StockLog()
        //    {
        //        Count = count,
        //        Date = DateTime.UtcNow,
        //        Name = im.Name,
        //        OperatorId = (int)user.IdInt,
        //        Operator = user,
        //        Status = "Added"

        //    };
        //    _cia_DbContext.Implants.Update(im);
        //    _cia_DbContext.StockLogs.Add(stockLog);
        //    _cia_DbContext.CashFlow.Add(expesnse);
        //    _cia_DbContext.SaveChanges();
        //    return Ok(_apiResponse);
        //}

        [HttpGet("ListIncome")]
        public async Task<IActionResult> ListIncome(DateOnly? from, DateOnly? to, int? catId, int? paymentMethodId)
        {
            IQueryable<IncomeModel> query = _cia_DbContext.Income
                .OrderByDescending(x => x.Date)
                .Where(x => x.Website == _site)
                .Include(x => x.PaymentMethod)
                .Include(x => x.CreatedBy)
                .Include(x => x.Category)
                .Include(x => x.Patient)
                .Include(x => x.Candidate)
                ;
            if (from != null)

                query = query.Where(x => x.Date.Value.Date >= from.Value.ToDateTime(TimeOnly.Parse("12:00 AM")).Date.ToUniversalTime());

            if (to != null)
            {
                query = query.Where(x => x.Date.Value.Date <= to.Value.ToDateTime(TimeOnly.Parse("12:00 AM")).Date.ToUniversalTime());

            }
            if (catId != null)
            {
                query = query.Where(x => x.CategoryId == catId);
            }
            if (paymentMethodId != null)
            {
                query = query.Where(x => x.PaymentMethodId == paymentMethodId);
            }
            _apiResponse.Result = await query.ToListAsync();
            return Ok(_apiResponse);
        }
        [HttpGet("ListExpenses")]
        public async Task<IActionResult> ListExpenses(DateOnly? from, DateOnly? to, int? catId, int? paymentMethodId)
        {
            IQueryable<ExpensesModel> query = _cia_DbContext.Expenses
                .Where(x => x.Price != null && x.Website == _site && x.Price != 0)
                .OrderByDescending(x => x.Date)
                .Include(x => x.PaymentMethod)
                .Include(x => x.CreatedBy)
                .Include(x => x.Supplier)
                .Include(x => x.Category)
                .Include(x => x.Patient)
                .Include(x => x.Receipt);
            if (from != null)

                query = query.Where(x => x.Date.Value.Date >= from.Value.ToDateTime(TimeOnly.Parse("12:00 AM")).Date.ToUniversalTime());

            if (to != null)
            {
                query = query.Where(x => x.Date.Value.Date <= to.Value.ToDateTime(TimeOnly.Parse("12:00 AM")).Date.ToUniversalTime());

            }
            if (catId != null)
            {
                query = query.Where(x => x.CategoryId == catId);
            }
            if (paymentMethodId != null)
            {
                query = query.Where(x => x.PaymentMethodId == paymentMethodId);
            }
            _apiResponse.Result = await query.ToListAsync();
            return Ok(_apiResponse);
        }

        [HttpGet("ListReciepts")]
        public async Task<IActionResult> ListReciepts()
        {
            _apiResponse.Result = await _cia_DbContext.Receipts.Where(x => x.Website == _site).OrderByDescending(x => x.Date)
                // .Include(x => x.Items).ThenInclude(x => x.Category)
                //.Include(x => x.Items).ThenInclude(x => x.PaymentMethod)
                //.Include(x => x.Items).ThenInclude(x => x.CreatedBy)
                .ToListAsync();
            return Ok(_apiResponse);
        }

        [HttpGet("GetSummary")]
        public async Task<IActionResult> GetSummary(DateTime from, DateTime to)
        {
            List<IncomeModel> income;
            List<ExpensesModel> expenses;
         
            IQueryable<IncomeModel> incomeQuery = _cia_DbContext.Income.Include(x => x.PaymentMethod).Include(x => x.CreatedBy).Include(x => x.Category).Where(x => x.Website == _site);
            IQueryable<ExpensesModel> expensesQuery = _cia_DbContext.Expenses.Include(x => x.PaymentMethod).Include(x => x.CreatedBy).Include(x => x.Category).Where(x => x.Website == _site);

            income = await incomeQuery.Where(x => x.Date.Value.Date > from.Date && x.Date.Value.Date <= to.Date).ToListAsync();
            expenses = await expensesQuery.Where(x => x.Date.Value.Date > from.Date && x.Date.Value.Date <= to.Date).ToListAsync();

       
            var incomeCats = income.Select(x => x.Category).Distinct().ToList();
            var expCats = expenses.Select(x => x.Category).Distinct().ToList();

            List<CashFlowSummaryModel> incomeSummary = new List<CashFlowSummaryModel>();
            List<CashFlowSummaryModel> expensesSummary = new List<CashFlowSummaryModel>();

            foreach (var i in incomeCats)
            {
                var temp = new CashFlowSummaryModel();
                int total = 0;
                temp.Category = i;
                var incs = income.Where(x => x.Category == temp.Category).ToList();
                incs.ForEach(delegate (IncomeModel x)
                {
                    total += (int)(x.Price ?? 0);
                });
                temp.Total = total;
                incomeSummary.Add(temp);

            }

            foreach (var i in expCats)
            {
                var temp = new CashFlowSummaryModel();
                int total = 0;
                temp.Category = i;
                var exps = expenses.Where(x => x.Category == temp.Category).ToList();
                exps.ForEach(delegate (ExpensesModel x)
                {
                    total += (int)(x.Price ?? 0);
                });
                temp.Total = total;
                expensesSummary.Add(temp);

            }


            _apiResponse.Result = new
            {
                from = from,
                to = to,
                income = incomeSummary,
                expenses = expensesSummary
            };
            return Ok(_apiResponse);
        }

        [HttpGet("GetIncomeByCategory")]
        public async Task<IActionResult> GetIncomeByCategory(int categoryID, String filter)
        {
            List<IncomeModel> income;
            DateTime now = DateTime.UtcNow;
            IQueryable<IncomeModel> incomeQuery = _cia_DbContext.Income.Include(x => x.PaymentMethod).Include(x => x.CreatedBy).Include(x => x.Category).Where(x => x.CategoryId == categoryID && x.Website == _site);

            switch (filter)
            {
                case "ThisWeek":
                    {
                        if (now.DayOfWeek == DayOfWeek.Saturday)
                        {
                            income = await incomeQuery.Where(x => x.Date.Value.Date == now.Date).ToListAsync();

                        }
                        else
                        {
                            int i = 1;
                            for (i = 1; i < 7; i++)
                            {
                                if (now.AddDays(-i).DayOfWeek == DayOfWeek.Saturday)
                                    break;
                            }
                            now = now.AddDays(-i - 1);
                            income = await incomeQuery.Where(x => x.Date.Value.Date > now.Date).ToListAsync();

                        }
                        break;
                    }
                case "ThisMonth":
                    {
                        now = now.AddDays(-now.Day);
                        income = await incomeQuery.Where(x => x.Date.Value.Date > now.Date).ToListAsync();

                        break;
                    }
                case "ThisYear":
                    {
                        now = now.AddDays(-now.Day);
                        now = now.AddMonths(-now.Month);
                        income = await incomeQuery.Where(x => x.Date.Value.Date > now.Date).ToListAsync();
                        break;
                    }
                case "LastMonth":
                    {
                        now = now.AddDays(-now.Day);
                        now = now.AddMonths(-1);
                        income = await incomeQuery.Where(x => x.Date.Value.Date > now.Date && x.Date < now.Date.AddMonths(1)).ToListAsync();
                        break;
                    }
                default:
                    {
                        _apiResponse.ErrorMessage = "Please choose time range";
                        return BadRequest(_apiResponse);
                    }
            }
            _apiResponse.Result = new
            {
                from = now.AddDays(1),
                to = DateTime.UtcNow,
                category = await _cia_DbContext.IncomeCategories.FirstOrDefaultAsync(x => x.Id == categoryID),
                income = income

            };
            return Ok(_apiResponse);
        }

        [HttpGet("GetExpensesByCategory")]
        public async Task<IActionResult> GetExpensesByCategory(int categoryID, String filter)
        {
            List<ExpensesModel> expenses;
            DateTime now = DateTime.UtcNow;
            IQueryable<ExpensesModel> expensesQuery = _cia_DbContext.Expenses.Include(x => x.PaymentMethod).Include(x => x.CreatedBy).Include(x => x.Category).Where(x => x.CategoryId == categoryID && x.Website == _site);

            switch (filter)
            {
                case "ThisWeek":
                    {
                        if (now.DayOfWeek == DayOfWeek.Saturday)
                        {
                            expenses = await expensesQuery.Where(x => x.Date.Value.Date == now.Date).ToListAsync();

                        }
                        else
                        {
                            int i = 1;
                            for (i = 1; i < 7; i++)
                            {
                                if (now.AddDays(-i).DayOfWeek == DayOfWeek.Saturday)
                                    break;
                            }
                            now = now.AddDays(-i - 1);
                            expenses = await expensesQuery.Where(x => x.Date.Value.Date > now.Date).ToListAsync();

                        }
                        break;
                    }
                case "ThisMonth":
                    {
                        now = now.AddDays(-now.Day);
                        expenses = await expensesQuery.Where(x => x.Date.Value.Date > now.Date).ToListAsync();

                        break;
                    }
                case "ThisYear":
                    {
                        now = now.AddDays(-now.Day);
                        now = now.AddMonths(-now.Month);
                        expenses = await expensesQuery.Where(x => x.Date.Value.Date > now.Date).ToListAsync();
                        break;
                    }
                case "LastMonth":
                    {
                        now = now.AddDays(-now.Day);
                        now = now.AddMonths(-1);
                        expenses = await expensesQuery.Where(x => x.Date.Value.Date > now.Date && x.Date < now.Date.AddMonths(1)).ToListAsync();
                        break;
                    }
                default:
                    {
                        _apiResponse.ErrorMessage = "Please choose time range";
                        return BadRequest(_apiResponse);
                    }
            }
            _apiResponse.Result = new
            {
                from = now.AddDays(1),
                to = DateTime.UtcNow,
                category = await _cia_DbContext.ExpensesCategories.FirstOrDefaultAsync(x => x.Id == categoryID),
                expenses = expenses

            };

            return Ok(_apiResponse);
        }

        [HttpPost("AddSettlement")]
        public async Task<IActionResult> AddSettlement(String filter, int value)
        {
            var cat = await _cia_DbContext.IncomeCategories.FirstOrDefaultAsync(x => x.Name == "Settlements" && x.Website == _site);
            var user = await _iUserRepo.GetUser();
            if (cat == null)
            {
                cat = new IncomeCategoriesModel()
                {
                    Name = "Settlements",
                    Website = _site
                };
                _cia_DbContext.IncomeCategories.Add(cat);
                _cia_DbContext.SaveChanges();
            }
            DateTime date = DateTime.UtcNow;

            if (filter == "Last month")
            {
                date = date.AddDays(-date.Day);
            }
            IncomeModel newIncome = new IncomeModel()
            {
                Category = cat,
                Website = _site,

                CreatedBy = user,
                CreatedById = (int)user.IdInt,
                Date = date,
                Name = "Settlement",
                Price = value,
            };
            _cia_DbContext.Income.Add(newIncome);
            _cia_DbContext.SaveChanges();
            return Ok(_apiResponse);
        }

        [HttpGet("getInstallmentsOfUser")]
        public async Task<IActionResult> getInstallmentsOfUser(int id)
        {
            var installments = await _cia_DbContext
                .InstallmentPlans
                .FirstOrDefaultAsync(x => x.UserId == id);

            if(installments!=null)
            {
                installments.Installments.OrderBy(x => x.DueDate);
            }
            _apiResponse.Result = installments;
            return Ok(_apiResponse);
        }

        [HttpPost("createInstallmentPlan")]
        public async Task<IActionResult> createInstallmentPlan(int? id, int total, DateTime startDate, int numberOfPayments, EnumInstallmentInterval interval)
        {

            var installmentPlan = InstallmentPlanModel.CreateInstallmentPlan(
                total,
                startDate,
                numberOfPayments,
                interval);
            if (id == null)
                _apiResponse.Result = installmentPlan;
            else
            {
                var user = await _iUserRepo.GetUser();
                installmentPlan.UserId = id;
                Receipt receipt = new Receipt()
                {
                    Total = installmentPlan.Total,
                    IsPaid = false,
                    Date = DateTime.UtcNow,
                    Operator = user,
                    OperatorId = user.IdInt,
                    Unpaid = installmentPlan.Total,
                    Website = _site,
                    Paid = 0,
                    Candidate = _cia_DbContext.Users.FirstOrDefault(x=>x.IdInt==id)

                };
                _cia_DbContext.Receipts.Add(receipt);
                _cia_DbContext.SaveChanges();
                installmentPlan.ReceiptId = receipt.Id;
                _cia_DbContext.InstallmentPlans.Add(installmentPlan);
                _cia_DbContext.SaveChanges();

                _apiResponse.Result = await _cia_DbContext.InstallmentPlans.Include(x => x.User).FirstOrDefaultAsync(x => x.UserId == id);

            }
            return Ok(_apiResponse);
        }

        [HttpPut("payInstallment")]
        public async Task<IActionResult> payInstallment(int installmentPlanId, int value)
        {
            var installmentPlan = await _cia_DbContext.InstallmentPlans.Include(x => x.User).Include(x => x.ReceiptData).FirstOrDefaultAsync(x => x.Id == installmentPlanId);
            try
            {
                installmentPlan.PayInstallment(value);

                var user = await _iUserRepo.GetUser();

                var paymentLog = new PaymentLog
                {
                    Date = DateTime.UtcNow,
                    Operator = user,
                    OperatorId = (int)user.IdInt,
                    PaidAmount = value,
                    ReceiptId = (int)installmentPlan.ReceiptId,
                    Website = _site,
                };
                _cia_DbContext.PaymentLogs.Add(paymentLog);

                installmentPlan.ReceiptData.Paid += value;
                installmentPlan.ReceiptData.Unpaid = installmentPlan.Total - installmentPlan.PaidAmount;
                installmentPlan.ReceiptData.IsPaid = installmentPlan.Status == EnumInstallmentStatus.Finished;


                _cia_DbContext.InstallmentPlans.Update(installmentPlan);
                _cia_DbContext.SaveChanges();

                var cat = await _cia_DbContext.IncomeCategories.FirstOrDefaultAsync(x => x.Name == "Candidates Installment" && x.Website == _site);
                if (cat == null)
                {
                    cat = new IncomeCategoriesModel
                    {
                        Website = _site,
                        Name = "Candidates Installment",

                    };


                    _cia_DbContext.IncomeCategories.Update(cat);
                    _cia_DbContext.SaveChanges();
                }
                var income = new IncomeModel
                {
                    Date = DateTime.UtcNow,
                    CreatedById = (int)user.IdInt,
                    CreatedBy = user,
                    InventoryWebsite = _site,
                    Name = $"{installmentPlan.User.Name}",
                    PaymentLogId = paymentLog.Id,
                    Price = value,
                    Website = _site,
                    ReceiptID = installmentPlan.ReceiptId,
                    Category = cat,
                    CategoryId = cat.Id, 
                    Candidate = installmentPlan.User,
                    CandidateId = installmentPlan.UserId,


                };
                _cia_DbContext.Income.Add(income);

                _cia_DbContext.SaveChanges();


            }
            catch (Exception e)
            {
                _apiResponse.ErrorMessage = e.Message;
                return BadRequest(_apiResponse);
            }

            return Ok(_apiResponse);
        }

    }
}
