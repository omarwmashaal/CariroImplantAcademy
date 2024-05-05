using CIA.DataBases;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Identity;
using CIA.AutoMappers;
using CIA.Repositories;
using CIA.Repositories.Interfaces;
using System.Text;
using Microsoft.OpenApi.Models;
using System.Text.Json.Serialization;
using CIA.Models.CIA;
using Microsoft.AspNetCore.Http.Connections;
using CIA.Controllers;
using Microsoft.Extensions.Options;
using Microsoft.AspNetCore.SignalR;
using Carter;
using System.Net;
using Hardware.Info;
using Microsoft.AspNetCore.Mvc.Authorization;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("RequireLoggedIn", policy =>
    {
        policy.RequireAuthenticatedUser();
    });
});



builder.Services.AddSwaggerGen(options =>
{
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Scheme = "Bearer"
    });
    options.AddSecurityRequirement(new OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference= new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                },
                Scheme = "oauth2",
                Name = "Bearer",
                In = ParameterLocation.Header,
            },
            new List<string>()
        }
    });

});

builder.Services.AddDbContext<CIA_dbContext>(
    options =>
    {
        options.UseNpgsql("User ID=postgres;Password=admin;Host=localhost;Port=5432;Database=CIA_Database;");

    }
    );

builder.Services.AddCors(o => o.AddPolicy(
    name: "AllowAllOrigins",

       policy =>
       {
           policy.AllowAnyHeader();
           policy.AllowAnyMethod();
           policy.AllowAnyOrigin();





       }


    ));

builder.Services.AddIdentity<ApplicationUser, IdentityRole>().AddEntityFrameworkStores<CIA_dbContext>().AddDefaultTokenProviders();

builder.Services.AddControllers(options =>
{
    options.Filters.Add(new AuthorizeFilter("RequireLoggedIn"));
}).AddJsonOptions(x =>
                x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);
;
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddAutoMapper(typeof(RegisterMapper));
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<IMedical_Repo, Medical_Repo>();
builder.Services.AddScoped<IUserRepo, UserRepo>();
builder.Services.AddScoped<IPhotosRepo, PhotosRepo>();
builder.Services.AddScoped<IEnumRepo, EnumRepo>();
builder.Services.AddScoped<INotificationRepo, NotificationRepo>();
builder.Services.AddScoped<IClinicRepos, ClinicRepo>();
builder.Services.AddScoped<IHardwareInfo, HardwareInfo>();
builder.Services.AddSignalR();
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = true;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(builder.Configuration.GetValue<string>("API_Settings:SecretKey"))),
        ValidateIssuer = false,
        ValidateAudience = false,
    };
    x.Events = new JwtBearerEvents
    {
        OnMessageReceived = context =>
        {
            var accessToken = context.Request.Query["access_token"];

            // If the request is for our hub...
            var path = context.HttpContext.Request.Path;
            if (!string.IsNullOrEmpty(accessToken) &&
                (path.StartsWithSegments("/notificationhub")))
            {
                // Read the token out of the query string
                context.Token = accessToken;
            }
            return Task.CompletedTask;
        }
    };
});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();
app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();
using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<CIA_dbContext>();
    dataContext.Database.Migrate();
}

app.MapControllers()
    ;

//app.UseHttpsRedirection();

app.UseCors("AllowAllOrigins");
//app.MapHub<NotificationHub>("/notificationhub");


//app.MapHubMapHub<NotificationHub>("/notificationhub");
app.UseEndpoints(endpoints =>
endpoints.MapHub<NotificationHub>("/notificationhub")
);
app.Run();
