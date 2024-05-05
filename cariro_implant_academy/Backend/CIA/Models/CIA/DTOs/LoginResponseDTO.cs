namespace CIA.Models.CIA.DTOs
{
    public class LoginResponseDTO
    {

        public string token { get; set; }
        public string Role { get; set; }
        public ApplicationUser User { get; set; }
    }
}
