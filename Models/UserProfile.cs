using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace Ecommerce.Models
{
    public class UserProfile
    {
        [BsonElement("userId")]
        public int UserId { get; set; }
        [BsonElement("profileImage")]
        public string? ProfileImage { get; set; }
        [BsonElement("addresses")]
        public List<Address>? Addresses { get; set; }
    }
}
