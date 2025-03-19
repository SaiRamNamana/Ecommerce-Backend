using Ecommerce.Models;
using Ecommerce.Service;
using Microsoft.AspNetCore.Mvc;

namespace Ecommerce.Controllers
{
    [ApiController]
    [Route("/user")]
    public class UserController:ControllerBase
    {
        private UserService UserService;
        public UserController(UserService UserService)
        {
            this.UserService = UserService;
        }

        [HttpPost("login")]
        public async Task<ActionResult<UserRequest>> GetUser([FromBody] EmailRequest email)
        {
            var RetrivedUser = await UserService.GetUser(email);
            if (RetrivedUser == null) return Ok("User Not Found");
            return Ok(RetrivedUser);
        }

        [HttpPost("signup")]
        public async Task<ActionResult<bool>> AddUser([FromBody] User User)
        {
            var RetrivedUser = await UserService.AddUser(User);
            return RetrivedUser ? true : false;
        }
        [HttpPost("update/{Id}")]
        public ActionResult UpdateUserName(int Id, [FromBody] UserName Name)
        {
            UserService.UpdateUserName(Id, Name.Name);
            return Ok();
        }
    }
}
