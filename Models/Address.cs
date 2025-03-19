using MongoDB.Bson.Serialization.Attributes;

namespace Ecommerce.Models
{
    public class Address
    {
        [BsonElement("street")]
        public string? Street { get; set; }

        [BsonElement("addressLine2")]
        public string? AddressLine { get; set; }

        [BsonElement("city")]
        public string? City { get; set; }

        [BsonElement("state")]
        public string? State { get; set; }

        [BsonElement("postalCode")]
        public int PostalCode { get; set; }
    }
}
