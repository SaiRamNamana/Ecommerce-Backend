using Ecommerce.Models;
using Microsoft.Data.SqlClient;
using System.Data;
namespace Ecommerce.Service
{
    public class CartService
    {
        private readonly string ConnectionString;
        public CartService(IConfiguration Config)
        {
            this.ConnectionString = Config.GetConnectionString("DefaultConnection");
        }

        public List<CartItem> GetCart(int UserId)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                Conn.Open();
                using (SqlCommand Cmd = new SqlCommand("sp_GetCart", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);

                    using (SqlDataReader Reader = Cmd.ExecuteReader())
                    {
                        var CartProducts = new List<CartItem>();

                        while (Reader.Read())
                        {
                            CartProducts.Add(new CartItem
                            {
                                ProductId = Reader.GetInt32(0),
                                Title = Reader.GetString(1),
                                Quantity = Reader.GetInt32(2),
                                Price = Reader.GetDecimal(3),
                                Image = Reader.GetString(4),
                                Stock = Reader.GetInt32(5)
                            });
                        }

                        return CartProducts;
                    }
                }
            }
        }

        public async Task<bool> AddToCart(int UserId, int ProductId, int Quantity)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                await Conn.OpenAsync();
                using (SqlCommand Cmd = new SqlCommand("sp_AddToCart", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);
                    Cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    Cmd.Parameters.AddWithValue("@Quantity", Quantity);

                    var Result = await Cmd.ExecuteScalarAsync();
                    if (Result != null && Convert.ToInt32(Result) == 1) return true;
                    else return false;
                }
            }
        }

        public async Task<int> RemoveFromCart(int UserId, int CartProductId)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                Conn.Open();
                using (SqlCommand Cmd = new SqlCommand("sp_RemoveFromCart", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);
                    Cmd.Parameters.AddWithValue("@CartProductId", CartProductId);
                    Cmd.Parameters.AddWithValue("@Remove", 0);

                    int RowsAffected = await Cmd.ExecuteNonQueryAsync();
                    return RowsAffected;
                }
            }
        }

        public async Task<int> RemoveFromCartPermanent(int UserId, int CartProductId)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                Conn.Open();
                using (SqlCommand Cmd = new SqlCommand("sp_RemoveFromCart", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);
                    Cmd.Parameters.AddWithValue("@CartProductId", CartProductId);
                    Cmd.Parameters.AddWithValue("@Remove", 1);

                    int RowsAffected = await Cmd.ExecuteNonQueryAsync();
                    return RowsAffected;
                }
            }
        }

        public async Task AddToWishList(int UserId,int ProductId)
        {
            using(SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                await Conn.OpenAsync();
                using (SqlCommand Cmd = new SqlCommand("sp_InsertOrDeleteWishlist", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);
                    Cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    Cmd.Parameters.AddWithValue("@IsInsert", 1);
                    Cmd.ExecuteNonQuery();
                }
            }
        }

        public async Task<List<CartItem>> GetWishList(int UserId)
        {
            using(SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                await Conn.OpenAsync();
                using(SqlCommand Cmd = new SqlCommand("sp_GetWishList", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);

                    using (SqlDataReader Reader = Cmd.ExecuteReader())
                    {
                        var wishList = new List<CartItem>();

                        while (Reader.Read())
                        {
                            wishList.Add(new CartItem
                            {
                                ProductId = Reader.GetInt32(0),
                                Title = Reader.GetString(1),
                                Price = Reader.GetDecimal(2),
                                Image = Reader.GetString(3)
                            });
                        }
                        return wishList;
                    }
                }
            }
        }

        public async Task RemoveItem(int UserId,int ProductId)
        {
            using(SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                await Conn.OpenAsync();
                using(SqlCommand Cmd = new SqlCommand("sp_InsertOrDeleteWishlist", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);
                    Cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    Cmd.Parameters.AddWithValue("@IsInsert", 0);
                    await Cmd.ExecuteNonQueryAsync();
                }
            }
        }

        public async Task<bool> IsOrderable(int UserId,int Quantity,int ProductId)
        {
            using(SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                await Conn.OpenAsync();
                using(SqlCommand Cmd = new SqlCommand("sp_Order", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);
                    Cmd.Parameters.AddWithValue("@Quantity", Quantity);
                    Cmd.Parameters.AddWithValue("@ProductId", ProductId);

                    var Result = await Cmd.ExecuteScalarAsync();

                    if (Result != null && Convert.ToInt32(Result) == 1) return true;
                    else return false;
                }
            }
        }

        public async Task<List<OrderItem>> GetOrders(int UserId)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectionString))
            {
                await Conn.OpenAsync();
                using (SqlCommand Cmd = new SqlCommand("sp_GetOrders", Conn))
                {
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.Parameters.AddWithValue("@UserId", UserId);
                    using (SqlDataReader Reader = await Cmd.ExecuteReaderAsync())
                    {
                        var ListOfOrders = new List<OrderItem>();
                        OrderItem CurrentOrder = null;
                        List<Items> CurrentItems = new List<Items>();
                        while (Reader.Read())
                        {
                            DateTime orderDate = Reader.GetDateTime(0);
                            int Total = Reader.GetInt32(1);
                            string ProductName = Reader.GetString(2);
                            int Quantity = Reader.GetInt32(3);
                            decimal Price = Reader.GetDecimal(4);

                            if (CurrentOrder == null || CurrentOrder.Orderdate != orderDate)
                            {
                                if (CurrentOrder != null)
                                {
                                    CurrentOrder.Items = CurrentItems.ToArray(); 
                                    ListOfOrders.Add(CurrentOrder);
                                    CurrentItems = new List<Items>();
                                }

                                CurrentOrder = new OrderItem
                                {
                                    Orderdate = orderDate,
                                    Total = 0
                                };
                            }
                            CurrentOrder.Total += Total;
                            CurrentItems.Add(new Items { ProductName = ProductName, Quantity = Quantity,Price = Price});
                        }

                        if (CurrentOrder != null)
                        {
                            CurrentOrder.Items = CurrentItems.ToArray();
                            ListOfOrders.Add(CurrentOrder);
                        }

                        return ListOfOrders;
                    }
                }
            }
        }
    }
}
