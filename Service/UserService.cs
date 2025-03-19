using Ecommerce.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Ecommerce.Service
{
    public class UserService
    {
        private readonly string? ConnectionString;

        public UserService(IConfiguration config)
        {
           ConnectionString = config.GetConnectionString("DefaultConnection");
        }

        public async Task<UserRequest?> GetUser(EmailRequest email)
        {
            using (var Connection = new SqlConnection(ConnectionString))
            {
                await Connection.OpenAsync();
                using (var Command = new SqlCommand("GetUserByEmail", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@Email", email.Email);
                    Command.Parameters.AddWithValue("@Password", email.Password);
                    Command.Parameters.AddWithValue("@Role", email.isAdmin ? "admin" : "user");
                    using (var reader = await Command.ExecuteReaderAsync())
                    {

                        while (await reader.ReadAsync())
                        {
                            return new UserRequest
                            {
                                Id = reader.GetInt32(0),
                                Username = reader.GetString(1),
                                Role = reader.GetString(2),
                                Wishlist = reader.GetString(3)
                            };    
                        }
               
                    }
                }
            }
            return null;
        }

        public async Task<bool> AddUser(User user)
        {
            using (var Connection = new SqlConnection(ConnectionString))
            {
                await Connection.OpenAsync();

                using (var Command = new SqlCommand("usp_AddUser", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@Username", user.Username);
                    Command.Parameters.AddWithValue("@Email", user.Email);
                    Command.Parameters.AddWithValue("@Password", user.PasswordHash);
                    Command.Parameters.AddWithValue("@Role", user.Role);

                    var result = await Command.ExecuteScalarAsync();
                    if (result != null && Convert.ToInt32(result) == 1) return true;
                    else return false;
                }
            }
        }
        public void UpdateUserName(int Id,string User)
        {
            using(var Con = new SqlConnection(ConnectionString))
            {
                Con.Open();
                using(var Command = new SqlCommand("sp_UpdateUserName",Con))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.AddWithValue("@UserName", User);
                    Command.Parameters.AddWithValue("@Id", Id);
                    Command.ExecuteNonQuery();
                }
            }
        }
    }
}
