using Ecommerce.Models;
using Ecommerce.Service;
using Microsoft.AspNetCore.Mvc;

namespace Ecommerce.Controllers
{
    [ApiController]
    [Route("/[controller]")]
    public class CartController:ControllerBase
    {
        private CartService CartService;
        public CartController(CartService Cart)
        {

            this.CartService = Cart;
        }

        [HttpGet("{UserId}")]

        public ActionResult<List<CartItem>> GetCart(int UserId)
        {
            var List = CartService.GetCart(UserId);
            return Ok(List);
        }

        [HttpPost("add-to-cart")]
        public async Task<ActionResult<Response>> AddToCart(int UserId,int ProductId,int Quantity)
        {
            var IsAdded = await CartService.AddToCart(UserId, ProductId, Quantity);
            return new Response { Success = IsAdded };
        }

        [HttpDelete("remove/{CartProductId}")]
        public async Task<ActionResult> RemoveFromCart([FromQuery]int UserId, int CartProductId)
        {
            int Rows = await CartService.RemoveFromCart(UserId, CartProductId);
            return Ok("Removed");
        }
        [HttpDelete("remove/permanent/{CartProductId}")]
        public async Task<ActionResult> RemoveFromCartPermanent([FromQuery] int UserId, int CartProductId)
        {
            int Rows = await CartService.RemoveFromCartPermanent(UserId, CartProductId);
            return Ok("Removed");
        }

        [HttpPost("wishlist")]
        public async Task<ActionResult> AddToWishList(int UserId,int ProductId)
        {
            await CartService.AddToWishList(UserId, ProductId);
            return Ok("Product added");
        }

        [HttpGet("wishlist")]
        public async Task<ActionResult<List<CartItem>>> GetWishList(int UserId)
        {
            var List = await CartService.GetWishList(UserId);
            return Ok(List);
        }

        [HttpPost("wishlist/remove")]
        public async Task<ActionResult> RemoveItem(int UserId,int ProductId)
        {
            await CartService.RemoveItem(UserId, ProductId);
            return Ok("Removed");
        }

        [HttpPost("order/{ProductId}")]
        public async Task<bool> IsOrdered(int UserId,int Quantity,[FromRoute]int ProductId)
        {
            var IsOk = await CartService.IsOrderable(UserId, Quantity,ProductId);
            return IsOk;
        }
        [HttpPost("orderList/{UserId}")]
        public async Task<List<OrderItem>> GetOrders(int UserId)
        {
            var List = await CartService.GetOrders(UserId);
            return List;
        }
    }
}
