using AutoMapper;
using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;
using CIA.Repositories;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StockController : BaseController
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly API_response _apiResponse;
        private readonly String secretKey;
        private readonly IMapper _mapper;
        private readonly CIA_dbContext _ciaDbContext;
        private readonly IUserRepo _iUserRepo;
        private readonly EnumWebsite _site;
        public StockController(IHttpContextAccessor httpContextAccessor, IConfiguration configuration, UserManager<ApplicationUser> userManager, IUserRepo iUserRepo, IMapper mapper, CIA_dbContext cIA_DbContext, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _apiResponse = new();
            _mapper = mapper;
            _ciaDbContext = cIA_DbContext;
            _iUserRepo = iUserRepo;
            var site = httpContextAccessor.HttpContext.Request.Headers["Site"].ToString();
            if (site == "")
                _site = _site = EnumWebsite.Lab; 
            else
                _site = (EnumWebsite)int.Parse(site);

        }

        [HttpGet("GetAllStock")]
        public async Task<IActionResult> GetAllStock(String? search)
        {
            
            IQueryable<StockItem> query = _ciaDbContext.Stock.
                Include(x => x.Category).
                OrderBy(x => x.Id).
                Where(x => x.InventoryWebsite == _site);
            if (search != null)
            {
                search = search.ToLower();
                query = query.Where(x =>
                    x.Name.ToLower().Contains(search) ||
                    x.Category.Name.ToLower().Contains(search) ||
                    x.Id.ToString().ToLower().Contains(search)
                );
            }
            var result = await query.ToListAsync();
           
            if(_site==EnumWebsite.Lab)
            {
                foreach(var item in result)
                {
                    if(item.GetType()==typeof(LabItem))
                    {
                        ((LabItem)item).LabItemShade = await _ciaDbContext.LabItemShades.Include(x => x.LabItemCompany).ThenInclude(x => x.LabItemParent).FirstOrDefaultAsync(x => x.Id == ((LabItem)item).LabItemShadeId);
                    }
                }
            }

            List<object> myResult = new List<object>();
            //foreach(var r in myResult)
            //{
            //    if (r.GetType() != typeof(LabItem))
            //        myResult.Add((StockItem)r);
            //    else
            //    {
            //        myResult.Add((LabI
            //        tem)r);
            //    }
            //}
            myResult.AddRange(result);
            
            _apiResponse.Result = myResult;
            return Ok(_apiResponse);

        }
        [HttpGet("GetAllStockForLab")]
        public async Task<IActionResult> GetAllStockForLab(String? search,int? parentId,int? companyId, int? shadeId,bool? consumed)
        {
            
            IQueryable<LabItem> query = _ciaDbContext.LabItems.
                Include(x => x.Category).
                Include(x => x.LabItemParent).
                Include(x => x.LabItemCompany).
                Include(x => x.LabItemShade).
                OrderBy(x => x.Id).
                Where(x => x.InventoryWebsite == _site);
            if (search != null)
            {
                search = search.ToLower();
                query = query.Where(x =>
                    x.Name.ToLower().Contains(search) ||
                    x.Category.Name.ToLower().Contains(search) ||
                    x.LabItemParent.Name.ToLower().Contains(search) ||
                    x.LabItemCompany.Name.ToLower().Contains(search) ||
                    x.LabItemShade.Name.ToLower().Contains(search) ||
                    x.Id.ToString().ToLower().Contains(search)
                );
            }


            if (parentId != null) query = query.Where(x => x.LabItemParentId == parentId);
            if (companyId != null) query = query.Where(x => x.LabItemCompanyId == companyId);
            if (shadeId != null) query = query.Where(x => x.LabItemShadeId == shadeId);
            if (consumed != null) query = query.Where(x => x.Consumed == consumed);
            
            _apiResponse.Result = await query.ToListAsync();
           
            return Ok(_apiResponse);

        }
       
        [HttpGet("GetStockById")]
        public async Task<IActionResult> GetStockById(int id)
        {

            _apiResponse.Result = await _ciaDbContext.Stock.
                Where(x => x.InventoryWebsite == _site).
                Include(x => x.Category).
                FirstOrDefaultAsync(x => x.Id == id);
            return Ok(_apiResponse);

        }
        [HttpGet("GetStockByName")]
        public async Task<IActionResult> GetStockByName(String name)
        {

            _apiResponse.Result = await _ciaDbContext.Stock.Where(x => x.InventoryWebsite == _site).Include(x => x.Category).FirstOrDefaultAsync(x => x.Name == name);
            return Ok(_apiResponse);

        }
        [HttpGet("GetStockLogs")]
        public async Task<IActionResult> GetStockLogs(String? search,DateTime? from,DateTime? to,int? categoryId, int? operatorId,String? status)
        {

            IQueryable<StockLog> query = _ciaDbContext.StockLogs.Where(x => x.InventoryWebsite == _site).Include(x => x.Operator).OrderByDescending(x => x.Date);
            if (search != null)
            {
                search = search.ToLower();
                query = query.Where(x =>
                    x.Name.ToLower().Contains(search) ||
                    x.Operator.Name.ToLower().Contains(search) ||
                    x.Id.ToString().ToLower().Contains(search) ||
                    x.Status.ToLower().Contains(search)
                );
            }
            if(from!=null)
            {
                query = query.Where(x => x.Date >= from);
            }
            if(to!=null)
            {
                query = query.Where(x => x.Date <= to);
            }
            if(status !=null)
            {
                query = query.Where(x => x.Status.ToLower().Contains(status));
            }
            _apiResponse.Result = await query.ToListAsync();
            return Ok(_apiResponse);



        }

        [HttpPost("AddItem")]
        public async Task<IActionResult> AddItem([FromBody] AddStockDTO model)
        {
            var user = await _iUserRepo.GetUser();
            var item = await _ciaDbContext.Stock.Where(x => x.InventoryWebsite == _site).Include(x => x.Category).FirstOrDefaultAsync(x => x.Name == model.Name && x.Category.Name == model.Category);
            if (item != null)
            {
                item.Count += model.Count;
                _ciaDbContext.Stock.Update(item);


            }
            else
            {
                var category = await _ciaDbContext.StockCategories.FirstOrDefaultAsync(x => x.Name == model.Category && x.Website == _site);
                if (category == null)
                {
                    category = new StockCategoriesModel
                    {
                        Name = model.Category,
                        Website = _site,
                    };
                    _ciaDbContext.StockCategories.Add(category);
                    _ciaDbContext.SaveChanges();
                }

                _ciaDbContext.Stock.Add(new StockItem
                {
                    Website = _site,
                   // InventoryWebsite = _site,
                    Count = model.Count,
                    CategoryId = (int)category.Id,
                    Name = model.Name,
                });
            }

            _ciaDbContext.StockLogs.Add(new StockLog
            {
                Count = model.Count,
                Date = DateTime.UtcNow,
                Name = model.Name,
                Status = "Added",
                Operator = user,
                OperatorId = (int)user.IdInt,
                Website = _site
            });

            _ciaDbContext.SaveChanges();
            return Ok(_apiResponse);

        }

        [HttpPost("ConsumeItem")]
        public async Task<IActionResult> ConsumeItem(int id, int count)
        {
            //if (count == 0) return Ok();
            var user = await _iUserRepo.GetUser();
            var item = await _ciaDbContext.Stock.Include(x => x.Category).FirstOrDefaultAsync(x => x.Id == id && x.InventoryWebsite == _site);


            item.Count -= count;
            _ciaDbContext.Stock.Update(item);

            _ciaDbContext.StockLogs.Add(new StockLog
            {
                Count = count,
                Date = DateTime.UtcNow,
                Name = item.Name ?? item.Size ?? "",
                Status = "Consumed",
                Operator = user,
                OperatorId = (int)user.IdInt,
                Website = _site
            });

            _ciaDbContext.SaveChanges();
            return Ok(_apiResponse);

        }
        
        [HttpPost("ConsumeItemByName")]
        public async Task<IActionResult> ConsumeItemByName(String name, int count)
        {
            var item = await _ciaDbContext.Stock.Where(x => x.InventoryWebsite == _site).Include(x => x.Category).FirstOrDefaultAsync(x => x.Name.ToLower() == name.ToLower());

            //if (count == 0) return Ok();
            var user = await _iUserRepo.GetUser();
            


            item.Count -= count;
            _ciaDbContext.Stock.Update(item);

            _ciaDbContext.StockLogs.Add(new StockLog
            {
                Count = count,
                Date = DateTime.UtcNow,
                Name = item.Name ?? item.Size ?? "",
                Status = "Consumed",
                Operator = user,
                OperatorId = (int)user.IdInt,
                Website = _site
            });

            _ciaDbContext.SaveChanges();
            return Ok(_apiResponse);

        }


        [HttpDelete("RemoveItem")]
        public async Task<IActionResult> RemoveItem(int id)
        {
            var user = await _iUserRepo.GetUser();
            var item = await _ciaDbContext.Stock.Include(x => x.Category).FirstOrDefaultAsync(x => x.Id == id && x.InventoryWebsite == _site);

            _ciaDbContext.Stock.Remove(item);

            _ciaDbContext.StockLogs.Add(new StockLog
            {
                Count = item.Count ?? 0,
                Date = DateTime.UtcNow,
                Name = item.Name,
                Status = "Removed",
                Operator = user,
                Website = _site
            });

            _ciaDbContext.SaveChanges();
            return Ok(_apiResponse);

        }



        
        [HttpDelete("GetLabItemDetails")]
        public async Task<IActionResult> GetLabItemDetails(int id)
        {

         
            var item = await _ciaDbContext.LabItems.Include(x=>x.LabItemShade).ThenInclude(x=>x.LabItemCompany).ThenInclude(x=>x.LabItemParent).FirstOrDefaultAsync(x => x.Id == id);

            _apiResponse.Result = new
            {
                labItemType = item.LabItemShade?.LabItemCompany?.LabItemParent?.Name,
                companyName = item.LabItemShade?.LabItemCompany?.Name,
                shadeName = item.LabItemShade?.Name,
            };


            return Ok(_apiResponse);

        }




    }
}
