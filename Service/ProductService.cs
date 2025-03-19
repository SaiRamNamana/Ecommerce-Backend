using Ecommerce.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Ecommerce.Service
{
    public class ProductService
    {
        private readonly string? ConnectionString;
        public ProductService(IConfiguration Config)
        {
            ConnectionString = Config.GetConnectionString("DefaultConnection");
        }

        public IEnumerable<Product> GetAll()
        {
            var Products = new List<Product>();

            using (var Connection = new SqlConnection(ConnectionString))
            {
                Connection.Open();
                using (var Command = new SqlCommand("sp_GetProducts", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@Id", -1);
                    using (var Reader = Command.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            Products.Add(new Product
                            {
                                Id = Reader.GetInt32(0),
                                Title = Reader.GetString(1),
                                Image = Reader.GetString(2),
                                Price = Reader.GetDecimal(3),
                                Stock = Reader.GetInt32(5),
                                Description = Reader.GetString(6),
                                CategoryId = Reader.GetInt32(7)
                            });
                        }
                    }
                }
            }
            return Products;
        }

        public IEnumerable<Product> GetAll(int CategoryId)
        {
            var Products = new List<Product>();

            using (var Connection = new SqlConnection(ConnectionString))
            {
                Connection.Open();
                using (var Command = new SqlCommand("sp_GetProducts", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@Id", CategoryId);

                    using (var Reader = Command.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            Products.Add(new Product
                            {
                                Id = Reader.GetInt32(0),
                                Title = Reader.GetString(1),
                                Image = Reader.GetString(2),
                                Price = Reader.GetDecimal(3),
                                Stock = Reader.GetInt32(5),
                                Description = Reader.GetString(6),
                            });
                        }
                    }
                }
            }
            return Products;
        }

        public async Task<string> Create(Product Product)
        {
            using (var Connection = new SqlConnection(ConnectionString))
            {
                await Connection.OpenAsync();
                using (var Command = new SqlCommand("sp_InsertProduct", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@Title", Product.Title);
                    Command.Parameters.AddWithValue("@Image", Product.Image);
                    Command.Parameters.AddWithValue("@Price", Product.Price);
                    Command.Parameters.AddWithValue("@Stock", Product.Stock);
                    Command.Parameters.AddWithValue("@Description", Product.Description);
                    Command.Parameters.AddWithValue("@CategoryId", Product.CategoryId);
                    Command.Parameters.AddWithValue("@Id", -1);
                    await Command.ExecuteNonQueryAsync();
                }
            }
            return "Product Created";
        }

        public async Task<int> Update(Product Product)
        {
            using (var Connection = new SqlConnection(ConnectionString))
            {
                await Connection.OpenAsync();
                using (var Command = new SqlCommand("sp_InsertProduct", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@Title", Product.Title);
                    Command.Parameters.AddWithValue("@Image", Product.Image);
                    Command.Parameters.AddWithValue("@Price", Product.Price);
                    Command.Parameters.AddWithValue("@Stock", Product.Stock);
                    Command.Parameters.AddWithValue("@Description", Product.Description);
                    Command.Parameters.AddWithValue("@CategoryId", Product.CategoryId);
                    Command.Parameters.AddWithValue("@Id", Product.Id);

                    int rowsAffected = await Command.ExecuteNonQueryAsync();
                    return rowsAffected;
                }
            }
        }

        public async Task<int> Delete(int Id)
        {
            using (var Connection = new SqlConnection(ConnectionString))
            {
                await Connection.OpenAsync();
                using (var Command = new SqlCommand("sp_GetOrDeleteProduct", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@Id", Id);
                    Command.Parameters.AddWithValue("@IsDelete", 1);
                    int RowsAffected = await Command.ExecuteNonQueryAsync();
                    return RowsAffected;
                }
            }
        }

        public Product GetProduct(int ProductId)
        {
            using (var Connection = new SqlConnection(ConnectionString))
            {
                Connection.Open();
                using (var Command = new SqlCommand("sp_GetOrDeleteProduct", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@Id", ProductId);
                    Command.Parameters.AddWithValue("@IsDelete", 0);

                    using (var Reader = Command.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                           return new Product
                            {
                                Id = Reader.GetInt32(0),
                                Title = Reader.GetString(1),
                                Image = Reader.GetString(2),
                                Price = Reader.GetDecimal(3),
                                Stock = Reader.GetInt32(4),
                                Description = Reader.GetString(5),
                            };
                        }
                    }
                }
            }
            return null;
        }

        public CategoryItem AddCategory(string Category)
        {
            using(var Connection = new SqlConnection(ConnectionString))
            {
                Connection.Open();
                using (var Cmd = new SqlCommand("sp_InsertCategory", Connection))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@Category", Category);
                    var OutputParam = new SqlParameter("@Id", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    Cmd.Parameters.Add(OutputParam);

                    Cmd.ExecuteNonQuery();

                    return new CategoryItem
                    {
                        Id = Convert.ToInt32(OutputParam.Value)
                    };
                }
            }
        }

        public List<Category> GetCategories()
        {
            using (var Connection = new SqlConnection(ConnectionString))
            {
                var List = new List<Category>();
                Connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_GetCategories", Connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (var Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            List.Add(new Category
                            {
                                Id = Reader.GetInt32(0),
                                Name = Reader.GetString(1)
                            });
                        }
                    }
                }
                return List;
            }
        }
    }
}
