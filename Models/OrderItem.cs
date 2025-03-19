using Microsoft.AspNetCore.Http.Features;

namespace Ecommerce.Models
{
    public class OrderItem
    {
        public DateTime Orderdate { get; set; }
        public int Total { get; set; }
        public Items[] Items { get; set; }
    }
}
