namespace Ecommerce.Models
{
    public class UserRequest
    {
        public int Id { get; set; }
        public string? Username { get; set; }
        public string? Role { get; set; }
        public string? Wishlist { get; set; }
    }
}
