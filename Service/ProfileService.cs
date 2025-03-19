using Ecommerce.Models;
using Microsoft.Extensions.Options;
using MongoDB.Bson;
using MongoDB.Driver;
namespace Ecommerce.Service
{
    public class ProfileService
    {
        private readonly IMongoCollection<UserProfile> UserCollection;
        private readonly IWebHostEnvironment Environment;
        private readonly IHttpContextAccessor HttpContextAccessor;
        public ProfileService(IOptions<MongoDBSettings> MongoDBSettings, IWebHostEnvironment Environment, IHttpContextAccessor HttpContextAccessor)
        {
            MongoClient client = new MongoClient(MongoDBSettings.Value.ConnectionURI);
            IMongoDatabase Database = client.GetDatabase(MongoDBSettings.Value.DatabaseName);
            UserCollection = Database.GetCollection<UserProfile>(MongoDBSettings.Value.CollectionName);
            this.Environment = Environment;
            this.HttpContextAccessor = HttpContextAccessor;
        }

        public UserProfile GetUser(int Id)
        {
            var User = UserCollection.Find(u => u.UserId == Id).Project<UserProfile>(Builders<UserProfile>.Projection.Exclude("_id")).FirstOrDefault();
            return User;
        }

        public List<UserProfile> GetAll()
        {
            return UserCollection.Find(_ => true).Project<UserProfile>(Builders<UserProfile>.Projection.Exclude("_id"))
                .ToList();
        }

        public bool Update(int Id, Address Address)
        {
            var Filter = Builders<UserProfile>.Filter.Eq(x => x.UserId, Id);
            var UserProfile = UserCollection.Find(Filter).Project<UserProfile>(Builders<UserProfile>.Projection.Exclude("_id")).FirstOrDefault();

            if (UserProfile != null)
            {
                bool IsExists = UserProfile.Addresses.Any(existed =>
                    existed.AddressLine == Address.AddressLine &&
                    existed.Street == Address.Street &&
                    existed.State == Address.State &&
                    existed.City == Address.City &&
                    existed.PostalCode == Address.PostalCode
                );
                if (!IsExists)
                {
                    UserProfile.Addresses.Add(Address);
                    var UpdateOfAddress = Builders<UserProfile>.Update.Set(x => x.Addresses, UserProfile.Addresses);
                    UserCollection.UpdateOne(Filter, UpdateOfAddress);
                }
            }
            else
            {
                var NewProfile = new UserProfile
                {
                    UserId = Id,
                    Addresses = new List<Address> { Address }
                };

                UserCollection.InsertOne(NewProfile);
            }
            return true;
        }

        public void Delete(int Id, Address RemoveAddress)
        {
            var Filter = Builders<UserProfile>.Filter.Eq(x => x.UserId, Id);
            var Update = Builders<UserProfile>.Update.PullFilter(x => x.Addresses, Address =>
                                            RemoveAddress.Street.Equals(Address.Street)
                                                );
            var result = UserCollection.UpdateOne(Filter, Update);
        }


        public async Task<string> UploadFile(IFormFile File,int Id)
        {
            string UploadPath = Path.Combine(Environment.WebRootPath, "uploads");

            if (!Directory.Exists(UploadPath))
                Directory.CreateDirectory(UploadPath);

            string FilePath = Path.Combine(UploadPath, File.FileName);

            using (var Stream = new FileStream(FilePath, FileMode.Create))
            {
                await File.CopyToAsync(Stream);
            }
            var Request = HttpContextAccessor.HttpContext!.Request;
            string FileUrl = $"{Request.Scheme}://{Request.Host}/uploads/{File.FileName}";

            await UpSetImageUrl(Id, FileUrl);
            return FileUrl;
        }
        public async Task UpSetImageUrl(int Id,string Url)
        {
            var Filter = Builders<UserProfile>.Filter.Eq(x => x.UserId, Id);
            var Update = Builders<UserProfile>.Update
           .Set("profileImage", Url)
           .SetOnInsert("userId", Id) 
           .SetOnInsert("Addresses", new BsonArray());

            await UserCollection.UpdateOneAsync(Filter,Update,new UpdateOptions { IsUpsert = true });

        }
    }
}
