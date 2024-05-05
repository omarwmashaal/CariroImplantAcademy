using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA.DTOs
{
    public class AddStockDTO
    {

        public string Name { get; set; }
        public int Count { get; set; }
        public string Category { get; set; }
    }
}
