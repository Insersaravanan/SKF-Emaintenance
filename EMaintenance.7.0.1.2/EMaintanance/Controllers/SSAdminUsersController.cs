using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using EMaintanance.Models;
using EMaintanance.Repository;
using EMaintanance.UserModels;
using EMaintanance.Utils;
using EMaintanance.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace EMaintanance.Controllers
{
    //[SKFAuthorize("PRG02")]
    [Authorize]
    public class SSAdminUsersController : Controller
    {
        private readonly SSAdminUsersRepo uRepo;
        private readonly UserManager<IdentityUser> _identityManager;
        private IConfiguration _configuration;
        public SSAdminUsersController(IConfiguration configuration, UserManager<IdentityUser> identityManager)
        {
            uRepo = new SSAdminUsersRepo(configuration);
            _identityManager = identityManager;
            _configuration = configuration;
        }

        [SKFAuthorize("PRG02:P1")]
        public IActionResult Index()
        {
            return View();
        }

        [SKFAuthorize("PRG02:P1")]
        public IActionResult UserLog()
        {
            return View();
        }

        // GET /GetAllUsers
        [HttpGet]
        [SKFAuthorize("PRG02:P1")]
        public async Task<IActionResult> GetAllUsers()
        {
            return Ok(await uRepo.GetAllUsers());
        }

        // GET /GetUser/5
        [HttpGet]
        public async Task<IActionResult> GetUser(int id)
        {
            return Ok(await uRepo.GetUser(id));
        }


        [HttpPost]
        [SKFAuthorize("PRG02:P1")]
        public async Task<IActionResult> Search([FromBody]  SSAdminUsersViewModel u)
        {
            try
            {
                return Ok(await uRepo.GetUsersByParams(u));
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
        [SKFAuthorize("PRG02:P1")]
        public async Task<IActionResult> SearchByName(string param)
        {
            try
            {
                return Ok(await uRepo.GetUserByName(param));
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
        [SKFAuthorize("PRG02:P1")]
        public async Task<IActionResult> GetAssignToList(string type, int lId, int csId)

        {
            try
            {
                CurrentUser cUser = new CurrentUser(HttpContext, _configuration);
                return Ok(await uRepo.GetAssignToList(type, cUser.UserId, lId, csId));
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
        [SKFAuthorize("PRG02:P3")]
        public async Task<IActionResult> Update([FromBody] SSAdminUsersViewModel u)
        {
            try
            {
                return Ok(await uRepo.SaveOrUpdate(u, _identityManager));
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

        [HttpPost]
        [SKFAuthorize("PRG02:P2")]
        public async Task<IActionResult> Create([FromBody] SSAdminUsersViewModel u)
        {
            try
            {
                CurrentUser cUser = new CurrentUser(HttpContext, _configuration);
                string baseURL = HttpContext.Request.Host.ToUriComponent();
                u.ApplicationBaseURL = baseURL;
                u.UserId = 0;
                u.CreatedUserId = cUser.UserId;
                return Ok(await uRepo.SaveOrUpdate(u, _identityManager));
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

        [HttpPost]
        [SKFAuthorize("PRG02:P6")]
        public async Task<IActionResult> Import([FromBody] List<SSAdminUsersViewModel> uvms)
        {
            try
            {
                CurrentUser cUser = new CurrentUser(HttpContext, _configuration);
                foreach (SSAdminUsersViewModel u in uvms)
                {
                    if(u.UserName != null && u.UserName !="")
                    {
                        string baseURL = HttpContext.Request.Host.ToUriComponent();
                        u.ApplicationBaseURL = baseURL;
                        u.UserId = 0;
                        u.CreatedUserId = cUser.UserId;
                        await uRepo.SaveOrUpdate(u, _identityManager);                        
                    }
                }
                return Ok(await Import(uvms));
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

        [AllowAnonymous]
        [HttpGet]
        public async Task<IActionResult> Activate(string Id)
        {
            try
            {
                string baseURL = HttpContext.Request.Host.ToUriComponent();
                await uRepo.Activate(Id, baseURL);
                return RedirectToAction("Index", "Home");
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
        public async Task<IActionResult> UpdateLastSession(int csId)

        {
            try
            {
                CurrentUser cUser = new CurrentUser(HttpContext, _configuration);
                return Ok(await uRepo.UpdateLastSession(cUser.UserId, csId, cUser.SessionId));
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
        //[SKFAuthorize("PRG02:P1")]
        public async Task<IActionResult> GetLastSession()

        {
            try
            {
                CurrentUser cUser = new CurrentUser(HttpContext, _configuration);
                return Ok(await uRepo.GetLastSession(cUser.UserId));
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
