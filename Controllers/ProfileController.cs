using Ecommerce.Models;
using Ecommerce.Service;
using Microsoft.AspNetCore.Mvc;

namespace Ecommerce.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProfileController : ControllerBase
    {
        private ProfileService ProfileService;

        public ProfileController(ProfileService Profile)
        {
            this.ProfileService = Profile;
        }

        [HttpGet("{Id}")]
        public ActionResult<UserProfile> GetUser(int Id)
        {
            var User = ProfileService.GetUser(Id);
            return Ok(User);
        }
        [HttpGet]
        public ActionResult<List<UserProfile>> GetAll()
        {
            var List =  ProfileService.GetAll();
            return Ok(List);
        }
        [HttpPost("{Id}")]
        public ActionResult UpdateAddress(int Id, [FromBody]Address Address)
        {
            var Result = ProfileService.Update(Id, Address);
            return Result ? Ok() : NotFound();
        }
        [HttpPost("delete/{Id}")]
        public ActionResult DeleteAddress(int Id, [FromBody]Address Address)
        {
            ProfileService.Delete(Id, Address);
            return Ok("Deleted");
        }
        [HttpPost("upload/{Id}")]
        public async Task<IActionResult> UploadFile(int Id,IFormFile File)
        {
            if (File == null || File.Length == 0)
                return BadRequest("No file uploaded.");
            var FileUrl = await ProfileService.UploadFile(File,Id);
            return Ok(new { filePath = FileUrl });
        }
    }
}
