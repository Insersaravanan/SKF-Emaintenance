using EMaintanance.Repository;
using EMaintanance.Utils;
using EMaintanance.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EMaintanance.Controllers
{
    [SKFAuthorize("PRG70")]
    public class ProgramTypeMapController : Controller
    {
        private readonly ProgramTypeMappingRepo ptmRepo;
        private IConfiguration _configuration;
        public ProgramTypeMapController(IConfiguration configuration)
        {
            ptmRepo = new ProgramTypeMappingRepo(configuration);
            _configuration = configuration;
        }

        [SKFAuthorize("PRG70:P1")]
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        [SKFAuthorize("PRG70:P1")]
        public async Task<IActionResult> Get(int lId, int csId)
        {
            try
            {
                return Ok(await ptmRepo.GetProgramTypeMapping(lId, csId));
            }
            catch (CustomException cex)
            {
                var responseObj = new EmaintenanceMessage(cex.Message, cex.Type, cex.IsException, cex.Exception?.ToString());
                return StatusCode(StatusCodes.Status500InternalServerError, responseObj);
            }
            catch (Exception ex)
            {
                return Ok(new EmaintenanceMessage(ex.Message));
            }
        }

        [HttpGet]
        [SKFAuthorize("PRG70:P1")]
        public async Task<IActionResult> GetProgramTypeSetup(int lId, int csId)
        {
            try
            {
                return Ok(await ptmRepo.GetProgramTypeSetup(lId, csId));
            }
            catch (CustomException cex)
            {
                var responseObj = new EmaintenanceMessage(cex.Message, cex.Type, cex.IsException, cex.Exception?.ToString());
                return StatusCode(StatusCodes.Status500InternalServerError, responseObj);
            }
            catch (Exception ex)
            {
                return Ok(new EmaintenanceMessage(ex.Message));
            }
        }

        [HttpPost]
        [SKFAuthorize("PRG70:P2")]
        public async Task<IActionResult> Create([FromBody] List<ProgramTypeMapViewModel> ptmvms)
        {
            try
            {
                CurrentUser cUser = new CurrentUser(HttpContext, _configuration);
                foreach (ProgramTypeMapViewModel ptmvm in ptmvms)
                {
                    //   if (ptmvm.ProgramTypeId != null && ptmvm.Active== "Y")
                    if (ptmvm.ProgramTypeId != null)
                    {
                        ptmvm.UserId = cUser.UserId;
                        ptmvm.ProgramTypeId = ptmvm.ProgramTypeId;
                        await ptmRepo.SaveOrUpdate(ptmvm);
                    }
                    //else
                    //{
                    //    throw new CustomException("Mandatory", "Client ProgramType Name is Mandatory.", "Error", true, "Custom Message : Client ProgramType Name is Mandatory.");
                    //}
                }
                return Ok();

            }
            catch (CustomException cex)
            {
                var returnObj = new EmaintenanceMessage(cex.Message, cex.Type, cex.IsException, cex.Exception?.ToString());
                return StatusCode(StatusCodes.Status500InternalServerError, returnObj);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new EmaintenanceMessage(ex.Message));
            }
        }

        [HttpGet]
        [SKFAuthorize("PRG70:P4")]
        public async Task<IActionResult> GetTransProgramTypeMapping(int CMappingId)
        {
            try
            {
                return Ok(await ptmRepo.GetTransProgramTypeMapping(CMappingId));
            }
            catch (CustomException cex)
            {
                var responseObj = new EmaintenanceMessage(cex.Message, cex.Type, cex.IsException, cex.Exception?.ToString());
                return StatusCode(StatusCodes.Status500InternalServerError, responseObj);
            }
            catch (Exception ex)
            {
                return Ok(new EmaintenanceMessage(ex.Message));
            }
        }

        [HttpGet]
        [SKFAuthorize("PRG70:P4")]
        public async Task<IActionResult> GetProgramTypeByClientID(int lId, int csId, string lName)
        {
            try
            {
                return Ok(await ptmRepo.GetProgramTypeByClientID(lId, csId, lName));
            }
            catch (CustomException cex)
            {
                var responseObj = new EmaintenanceMessage(cex.Message, cex.Type, cex.IsException, cex.Exception?.ToString());
                return StatusCode(StatusCodes.Status500InternalServerError, responseObj);
            }
            catch (Exception ex)
            {
                return Ok(new EmaintenanceMessage(ex.Message));
            }
        }


    }
}
