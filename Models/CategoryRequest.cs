using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models
{
    public class CategoryRequest
    {
        [Required]
        public string Name { get; set; } = string.Empty;
    }
}
