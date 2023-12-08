

enum EnumProstheticDiagnosticDiagnosticImpressionDiagnostic { Physical, Digital }

enum EnumProstheticDiagnosticDiagnosticImpressionNextStep { Ready_For_Implant, Bite, Needs_New_Impression, Needs_Scan_PPT }

enum EnumProstheticDiagnosticBiteDiagnostic {
  Done,
  Needs_ReScan,
  Needs_ReImpression,
}

enum EnumProstheticDiagnosticBiteNextStep {
  Scan_Appliance,
  ReImpression,
  ReBite,
}

enum EnumProstheticDiagnosticScanApplianceDiagnostic {
  Done,
  Needs_ReBite,
  Needs_ReImpression,
  Needs_ReDesign,
}

enum EnumFinalProthesisHealingCollarStatus { With_Customization, Without_Customization }

enum EnumFinalProthesisImpressionStatus { Scan_by_scan_body, Scan_by_abutment, Physical_Impression_open_tray, Physical_Impression_closed_tray }

enum EnumFinalProthesisTryInStatus { Try_in_abutment_scan_abutment, Try_in_PMMA, Try_in_on_scan_abutment_PMMA, Physical_Impression_closed_tray }

enum EnumFinalProthesisDeliveryStatus { Done, ReDesign, ReImpression, ReTryIn }

enum EnumFinalProthesisHealingCollarNextVisit
{
  Needs_Impression
}
enum EnumFinalProthesisImpressionNextVisit
{
  Custom_Abutment,
  Try_In,
  Delivery
}
enum EnumFinalProthesisTryInNextVisit
{
  Delivery,
  Try_In_PMMA,
  ReImpression
}
enum EnumFinalProthesisDeliveryNextVisit
{
  Done,
  ReDesign,
  ReImpression,
  ReTryIn
}