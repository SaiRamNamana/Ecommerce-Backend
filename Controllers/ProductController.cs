using Ecommerce.Models;
using Microsoft.AspNetCore.Mvc;
using Ecommerce.Service;


namespace Ecommerce.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private ProductService ProductService;

        public ProductController(ProductService Product)
        {
            ProductService = Product;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Product>> GetAll()
        {
            var Products = ProductService.GetAll();
            return Ok(Products);
        }

        [HttpGet("product/{Id}")]
        public ActionResult<Product> GetProduct(int Id)
        {
            var Product = ProductService.GetProduct(Id);
            return Ok(Product);
        }

        [HttpGet("{Id}")]
        public ActionResult<IEnumerable<Product>> GetAll(int Id)
        {
            var Products = ProductService.GetAll(Id);
            return Ok(Products);
        }


        [HttpPost]
        public async Task<ActionResult> Create([FromBody] Product Product)
        {
            string Response = await ProductService.Create(Product);
            return Ok(Response);
        }

        [HttpGet("category")]
        public ActionResult<List<Category>> GetCategories()
        {
            var List = ProductService.GetCategories();
            return Ok(List);
        }
      
        [HttpPost("category/add")]
        public ActionResult<CategoryItem> AddCategory([FromQuery] string Category)
        {
            var CategoryId = ProductService.AddCategory(Category);
            return Ok(CategoryId);
        }

        [HttpPut("update")]
        public async Task<IActionResult> Update([FromBody] Product Product)
        {
             int RowsAffected = await ProductService.Update(Product);
             return RowsAffected > 0 ? Ok() : NotFound();
        }

        [HttpDelete("{Id}")]
        public async Task<IActionResult> Delete(int Id)
        {
            int RowsAffected = await ProductService.Delete(Id);
             return RowsAffected > 0 ? Ok() : NotFound(); 
        }
    }
}
