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
        public bool HasCompanies { get; set; }
        public bool HasShades { get; set; } 
        public bool HasSize { get; set; }
        public bool HasCode { get; set; }
        public bool IsStock { get; set; }
    }
      

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

        [ForeignKey("LabItemParent")]
        public int? LabItemParentId { get; set; }
        public LabItemParent? LabItemParent { get; set; }

        [ForeignKey("LabItemCompany")]
        public int? LabItemCompanyId { get; set; }
        public LabItemCompany? LabItemCompany { get; set; }
    }
    public class LabItem : StockItem
    {

        public void setName()
        {
            this.Name = "";
            if ((this.Code ?? "") != "")
                this.Name += $"{this.Code}";
            if (((this.Code ?? "") != "") && ((this.Size ?? "") != ""))
                this.Name += " || ";
            if ((this.Size ?? "") != "")
                this.Name += $"{this.Size}";
        }
        public String? Code { get; set; }
        public int? ConsumedCount { get; set; } = 0;
        public bool? Consumed { get; set; } = false;

        [ForeignKey("LabItemParent")]
        public int? LabItemParentId { get; set; }
        public LabItemParent? LabItemParent { get; set; }
        [ForeignKey("LabItemCompany")]
        public int? LabItemCompanyId { get; set; }
        public LabItemCompany? LabItemCompany { get; set; }
        [ForeignKey("LabItemShade")]
        public int? LabItemShadeId { get; set; }
        public LabItemShade? LabItemShade { get; set; }


    }

    public class LabOptions
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public String Name { get; set; } = "";
        public int Price { get; set; } = 0;

        [ForeignKey("LabItemParent")]
        public int? LabItemParentId { get; set; }
        public LabItemParent? LabItemParent { get; set; }
        

    }

    public class LabSizesThreshold
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        public int ParentId { get; set; }
        public string? Size { get; set; }
        public int Threshold { get; set; }
    }
}
