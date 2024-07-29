using CIA.Models.CIA.TreatmentModels;
using CIA.Models.CIA.TreatmentModels.ProstheticTreatmentModels;

namespace CIA.Models.CIA.DTOs
{
    public class AdvancedProstheticSearchRequestDTO
    {
        public List<int>? Ids { get; set; }
        public EnumProstheticType Type { get; set; }
        public int? ItemId { get; set; }
        public int? StatusId { get; set; }
        public int? NextId { get; set; }
        public int? MaterialId { get; set; }
        public int? TechniqueId { get; set; }
        public bool FullArch { get; set; } = false;
        public bool ScrewRetained { get; set; } = false;
        public bool CementRetained { get; set; } = false;
        public List<int>? complicationsAnd { get; set; }
        public List<int>? complicationsOr { get; set; }

    }

    public class AdvancedProstheticSearchResponseDTO
    {
        public int? Id { get; set; }
        public String? SecondaryId { get; set; }
        public String? PatientName { get; set; }
        public FinalStepModel? FinalStep { get; set; }
        public DiagnosticStepModel? DiagnosticStep { get; set; }
        public String? Str_ComplicationsAfterProsthesis { get; set; }
    }
}
