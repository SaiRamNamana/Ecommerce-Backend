using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models
{
    public class EmailRequest
    {
        [Required]
        [EmailAddress]
        public string? Email { get; set; }

        [Required]
        public string? Password { get; set; }

        public bool isAdmin { get; set; }
    }
}
