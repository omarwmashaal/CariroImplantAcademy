using CIA.Models.CIA;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using CIA.Models.CIA.DTOs;

namespace CIA.Models.LAB.DTO
{
    
    public class LAB_RequestsDTO
    {
        public int Id { get; set; }
        public DateTime? Date { get; set; }
        public DateOnly? DeliveryDate { get; set; }
        public int? EntryById { get; set; }
        public UserDTO? EntryBy { get; set; }
        public int? AssignedToId { get; set; }
        public UserDTO? AssignedTo { get; set; }
        public EnumLabRequestSources? Source { get; set; }
        public int? CustomerId { get; set; }
        public UserDTO? Customer { get; set; }
        public int PatientId { get; set; }
        public PatientDTO? Patient { get; set; }
        public EnumLabRequestStatus? Status { get; set; }
        public bool? Paid { get; set; }
        public int? Cost { get; set; }
        public int? PaidAmount { get; set; }
        public String? Notes { get; set; }
        public String? RequiredStep { get; set; }
        public List<LAB_RequestStepDTO>? Steps { get; set; }
        public List<int>? Teeth { get; set; }
        public EnumLabRequestInitStatus? InitStatus { get; set; }
        public bool? Full_zireon_crown { get; set; }
        public bool? Porcelain_fused_to_zircomium { get; set; }
        public bool? Porcelain_fused_to_metal { get; set; }
        public bool? Porcelain_fused_to_metal_CAD_CAM_Co_Cr_alloy { get; set; }
        public bool? Glass_ceramic_crown { get; set; }
        public bool? Visiolign_bonded_to_PEEK { get; set; }
        public bool? Laminate_veneer { get; set; }
        public bool? Milled_PMMA_temporary_crown { get; set; }
        public bool? Long_term_temporary_crown { get; set; }
        public bool? Screw_ratained_crown { get; set; }
        public bool? Survey_crown_for_RPD { get; set; }
        public bool? Survey_crown_with_extra_coronal_attahcment { get; set; }
        public bool? Cast_postcore { get; set; }
        public bool? Zirconium_post_and_core { get; set; }
        public bool? Custom_carbon_fiber_post { get; set; }
        public bool? Zirconium_inlay_or_onlay { get; set; }
        public bool? Glass_ceramic_inlay_or_onlay { get; set; }
        public bool? CAD_CAM_abutment { get; set; }
        public bool? Special_tray { get; set; }
        public bool? Occlusion_block { get; set; }
        public bool? Diagnostic_or_trail_setup { get; set; }
        public bool? Flexible_RPD { get; set; }
        public bool? Metallic_RPD { get; set; }
        public bool? Night_guard_vacuum_template { get; set; }
        public bool? Radiographic_duplicates_for_CBCT { get; set; }
        public bool? Clear_surgical_templates { get; set; }
        public bool? Diagnostic_surveying { get; set; }


    }
    public class LAB_MultiRequestsDTO
    {
        public int Id { get; set; }
        public DateTime? Date { get; set; }
        public EnumLabRequestSources? Source { get; set; }
        public int? CustomerId { get; set; }
        public UserDTO? Customer { get; set; }
        public int PatientId { get; set; }
        public PatientDTO? Patient { get; set; }
        public bool? Paid { get; set; }
        public int? AssignedToId { get; set; }
        public UserDTO? AssignedTo { get; set; }
        public EnumLabRequestStatus? Status { get; set; }
        public List<LAB_RequestStepDTO>? Steps { get; set; }


    }
}
