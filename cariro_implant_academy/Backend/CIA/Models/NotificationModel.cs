using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CIA.Models
{
    public class NotificationModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]   
        public int Id { get; set; }
        public String? Title { get; set; }
        public String? Content { get; set; }
        public bool? Read { get; set; } = false;
        public DateTime? Date { get; set; }
        public int? InfoId { get; set; }
        public EnumNotificationType? Type { get; set; }
        [ForeignKey("User.IdInt")]
        public int? UserId { get; set; }
        public ApplicationUser? User { get; set; }

    }
}
