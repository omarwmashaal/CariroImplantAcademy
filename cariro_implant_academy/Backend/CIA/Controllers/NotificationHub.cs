using CIA.DataBases;
using CIA.Models.CIA;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using System.Security.Claims;

namespace CIA.Controllers
{

    public class NotificationHub : Hub
    {
        private readonly CIA_dbContext _dbContext;
        private readonly IUserRepo _userRepo;
        public NotificationHub(CIA_dbContext dbContext, IUserRepo userRepo)
        {
            _dbContext = dbContext;
            _userRepo = userRepo;
        }

        public override async Task OnConnectedAsync()
        {

            var idClaim = Context.User.Claims.FirstOrDefault(x => x.Type == "Id");
            if (idClaim != null)
            {
                var user = await _dbContext.Users.FirstOrDefaultAsync(x => x.Id == idClaim.Value);
                if (user.Connections.FirstOrDefault(x => x.ConnectionId == Context.ConnectionId) == null)
                {
                    user.Connections.Add(new ConnectionModel()
                    {

                        ConnectionId = Context.ConnectionId,
                        isConnected = true,
                    });
                    _dbContext.Users.Update(user);
                    _dbContext.SaveChanges();
                }

            }
            await base.OnConnectedAsync();
        }
        public override Task OnDisconnectedAsync(Exception? exception)
        {
            var idClaim = Context.User.Claims.FirstOrDefault(x => x.Type == "Id");
            if (idClaim != null)
            {
                var user = _dbContext.Users.FirstOrDefault(x => x.Connections.FirstOrDefault(x => x.ConnectionId == Context.ConnectionId) != null);
                if (user != null)
                {
                    user.Connections.RemoveAll(x => x.ConnectionId == Context.ConnectionId);
                }
                _dbContext.Users.Update(user);
                _dbContext.SaveChanges();
            }
            return base.OnDisconnectedAsync(exception);
        }


    }
}
