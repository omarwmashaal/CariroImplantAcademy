namespace CIA.Models.CIA.DTOs
{
    public class GetClinicPricesDTO
    {
        public List<int>? Teeth { get; set; }
        public List<EnumClinicPrices>? Category { get; set; }
    }
}
