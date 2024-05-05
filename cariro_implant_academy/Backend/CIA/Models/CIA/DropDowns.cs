using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA
{
    public class DropDowns
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public string? Name { get; set; }
        public EnumWebsite Website { get; set; } = EnumWebsite.CIA;

    }

    public class ExpensesCategoriesModel : DropDowns { }
    public class StockCategoriesModel : ExpensesCategoriesModel { }
    public class MedicalExpensesModel : StockCategoriesModel { }
    public class SuppliersModel : DropDowns { }
    public class MedicalSuppliersModel : SuppliersModel { }
    public class NonMedicalSuppliersModel : SuppliersModel { }
    public class IncomeCategoriesModel : DropDowns { }
    public class PaymentMethodsModel : DropDowns { }
    public class CandidatesBatchesModel : DropDowns { }



}
