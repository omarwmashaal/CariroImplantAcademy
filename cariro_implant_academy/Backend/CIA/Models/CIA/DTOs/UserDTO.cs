namespace CIA.Models.CIA.DTOs
{
    public class UserDTO
    {
        public int IdInt { get; set; }
        public string Name { get; set; }
        public string Phone { get; set; } = String.Empty;
        public string PhoneNumber { get; set; } = String.Empty;
        public String? Token { get; set; }
        public String? Role { get; set; }
        public List<String>? Roles { get; set; }
        public int? ProfileImageId { get; set; }
    }
}
