using AutoMapper;
using CIA.DataBases;
using CIA.Models.CIA;
using CIA.Models.CIA.TreatmentModels;
using CIA.Models.TreatmentModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatientMedicalController : BaseController
    {
        private readonly API_response _aPI_Response;
        private readonly CIA_dbContext _cia_DbContext;
        private readonly IMapper _mapper;
        public PatientMedicalController(CIA_dbContext cIA_DbContext, IMapper mapper)
        {
            _aPI_Response = new API_response();
            _cia_DbContext = cIA_DbContext;
            _mapper = mapper;
        }

        [HttpGet("GetPatientMedicalExamination")]
        public async Task<ActionResult> GetPatientMedicalExamination(int id)
        {
            var patient = await _cia_DbContext.Patients.FirstOrDefaultAsync(x => x.Id == id);
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Couldn't find patient!";
                return BadRequest(_aPI_Response);
            }
            _aPI_Response.Result = patient.MedicalExamination;
            return Ok(_aPI_Response);
        }
        [HttpPut("UpdatePatientMedicalExamination")]
        public async Task<ActionResult> UpdatePatientMedicalExamination([FromQuery]int id, [FromBody] MedicalExaminationModel model)
        {
            var patient = await _cia_DbContext.Patients.FirstOrDefaultAsync(x => x.Id == id);
            if (patient == null)
            {
                _aPI_Response.ErrorMessage = "Couldn't find patient!";
                return BadRequest(_aPI_Response);
            }
            patient.MedicalExamination= model;
             _cia_DbContext.Patients.Update(patient);
            await _cia_DbContext.SaveChangesAsync();
            return Ok(_aPI_Response);
        }



        [HttpDelete]
        public async Task<ActionResult> delete(int id)
        {

            _cia_DbContext.Patients.Remove(_cia_DbContext.Patients.FirstOrDefault(x => x.Id == id));
            _cia_DbContext.SaveChanges();
            return Ok();
        }
    }
}
