using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models.CIA
{

    public class LabItemParent
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String? Name { get; set; }
        public int UnitPrice { get; set; } = 0;
        public List<LabItemCompany> Companies { get; set; }
    }
   
    public class LabItem_WaxUp : LabItemParent { }
    public class LabItem_ZirconUnit : LabItemParent { }

    public class LabItem_PFM : LabItemParent { }

    public class LabItem_CompositeInlay : LabItemParent { }

    public class LabItem_EmaxVeneer : LabItemParent { }

    public class LabItem_MilledPMMA : LabItemParent { }

    public class LabItem_PrintedPMMA : LabItemParent { }

    public class LabItem_TiAbutment : LabItemParent { }

    public class LabItem_TiBar : LabItemParent { }

    public class LabItem_ThreeDPrinting : LabItemParent { }

    public class LabItemCompany
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public string? Name { get; set; }
        public List<LabItemShade>? Shades { get; set; } = new List<LabItemShade>();


        [ForeignKey("LabItemParent")]
        public int? LabItemParentId { get; set; }
        public LabItemParent? LabItemParent { get; set; }
    }

    public class LabItemShade
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public string? Name { get; set; }
       
        public List<LabItem>? Items { get; set; } = new List<LabItem>();

        [ForeignKey("LabItemCompany")]
        public int? LabItemCompanyId { get; set; }
        public LabItemCompany? LabItemCompany { get; set; }
    }
    public class LabItem : StockItem
    {

        public String? Code { get; set; }
        public int? ConsumedCount { get; set; } = 0;
        public bool? Consumed { get; set; } = false;
        [ForeignKey("LabItemShade")]
        public int? LabItemShadeId { get; set   ; }
        public LabItemShade? LabItemShade { get; set; }

    }
}
