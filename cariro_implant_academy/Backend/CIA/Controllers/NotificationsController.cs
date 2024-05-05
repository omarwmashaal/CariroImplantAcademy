using CIA.DataBases;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationsController : BaseController
    {
        private readonly CIA_dbContext _dbContext;
        private readonly IUserRepo _userRepo;
        private readonly API_response _apiResponse;
        public NotificationsController(CIA_dbContext dbContext, IUserRepo userRepo)
        {
            _dbContext = dbContext;
            _userRepo = userRepo;
            _apiResponse = new API_response();
        }
        [HttpGet("GetNotifications")]
        public async Task<IActionResult> GetNotifications()
        {
            var user = await _userRepo.GetUser();
            if (user == null) { return BadRequest(); }
            _apiResponse.Result = await _dbContext.Notifications.Where(x => x.UserId == user.IdInt).Select(x=>new
            {
                x.Id,
                x.Date,
                x.InfoId,
                x.Content,  
                x.Title,
                x.Read,
                x.Type
            }).OrderByDescending(x => x.Date).ToListAsync();
            return Ok(_apiResponse);
        }
        [HttpPost("MarkAllAsRead")]
        public async Task<IActionResult> MarkAllAsRead(int? id = null)
        {
           
            var user = await _userRepo.GetUser();
            if (user == null) { return BadRequest(); }
            List<NotificationModel> notifications;
            
            if(id!=null)
            {
                notifications = await _dbContext.Notifications.Where(x=>x.Id==id).ToListAsync();
            }
            else
            {
                notifications = await _dbContext.Notifications.Where(x => x.UserId == user.IdInt).OrderByDescending(x => x.Date).ToListAsync();
            }
            foreach (var notification in notifications)
            {
                notification.Read = true;
            }
            _dbContext.Notifications.UpdateRange(notifications);
            await _dbContext.SaveChangesAsync();
            return Ok();
        }
        [HttpDelete("DeleteNotification")]
        public async Task<IActionResult> DeleteNotification(int id)
        {
            var notifcation = await _dbContext.Notifications.FirstOrDefaultAsync(x => x.Id == id);
            _dbContext.Notifications.Remove(notifcation);
            _dbContext.SaveChanges();
         
            return Ok();
        }
    }
}
