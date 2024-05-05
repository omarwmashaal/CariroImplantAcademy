using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA
{
    public class StockItem : ExpensesModel
    {
        public int? Count { get; set; } = 0;
        public String? Size { get; set; }
        [ForeignKey("ImplantLine")]
        public int? ImplantLineId { get; set; }
        public ImplantLine? ImplantLine { get; set; }

        [ForeignKey("MembraneCompany")]
        public int? MembraneCompnayId { get; set; }
        public MembraneCompany? MembraneCompany { get; set; }

    }




}
