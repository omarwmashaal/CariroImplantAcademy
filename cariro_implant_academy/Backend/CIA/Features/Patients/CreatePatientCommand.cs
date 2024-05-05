using AutoMapper;
using Carter;
using CIA.DataBases;
using CIA.Models;
using MediatR;
using Microsoft.AspNetCore.Http.HttpResults;

namespace CIA.Features.Patients
{
    public static class CreatePatientCommand
    {
        public class Command : IRequest<int>
        {
            public int? Id { get; set; }
            public string Name { get; set; }
            public string Gender { get; set; }
            public string Phone { get; set; }
            public String? NationalID { get; set; }
            public string? Phone2 { get; set; }
            public DateOnly DateOfBirth { get; set; }
            public string MaritalStatus { get; set; }
            public string Address { get; set; }
            public string City { get; set; }
            public string? ProfilePhoto { get; set; }
            public string? IdBackPhoto { get; set; }
            public string? IdFrontPhoto { get; set; }
            public int? ReferralPatientID { get; set; }
            public int? RelativePatientID { get; set; }
            public String? RelativePatient { get; set; }
            public String? ReferralPatient { get; set; }
            public String? Doctor { get; set; }
            public int? DoctorID { get; set; }
            public int? RegisteredById { get; set; }
            public String? RegisteredBy { get; set; }
            public DateTime? RegisterationDate { get; set; }
            public EnumPatientType? PatientType { get; set; } = EnumPatientType.CIA;
            public int? ProfileImageId { get; set; }
            public int? IdBackImageId { get; set; }
            public int? IdFrontImageId { get; set; }

        }

        internal sealed class Handler : IRequestHandler<Command, int>
        {
            private readonly CIA_dbContext _dbContext;
            private readonly IMapper _iMapper;

            public Handler(CIA_dbContext dbContext, IMapper mapper)
            {
                _dbContext = dbContext;
                _iMapper = mapper;
            }
            public async Task<int> Handle(Command request, CancellationToken cancellationToken)
            {
                var newaPatient = _iMapper.Map<Patient>(request);
                await _dbContext.Patients.AddAsync(newaPatient);
                await _dbContext.SaveChangesAsync();
                return newaPatient.Id;
            }
        }


        public class CreatePatientEndPoint : ICarterModule
        {
            public void AddRoutes(IEndpointRouteBuilder app)
            {
                app.MapPost("api/patients", async (Command command, ISender sender) =>
                {
                    var patientId = await sender.Send(command);
                    return Results.Ok(patientId);

                });
            }
        }

    }


}
