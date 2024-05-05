using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using CIA.Models.CIA;

namespace CIA.Models
{
    public class GenericStockLog
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public String Name { get; set; }
        public int Count { get; set; }
        public DateTime Date { get; set; }
        [ForeignKey("Operator.IdInt")]
        public int OperatorId { get; set; }
        public ApplicationUser Operator { get; set; }
        public String Status { get; set; }
    }
    public class CIA_StockLog : GenericStockLog { }
}
