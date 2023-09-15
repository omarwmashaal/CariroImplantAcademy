

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

enum EnumFinalProthesisSingleBridgeHealingCollarStatus { With_Customization, Without_Customization }

enum EnumFinalProthesisSingleBridgeImpressionStatus { Scan_by_scan_body, Scan_by_abutment, Physical_Impression_open_tray, Physical_Impression_closed_tray }

enum EnumFinalProthesisSingleBridgeTryInStatus { Try_in_abutment_scan_abutment, Try_in_PMMA, Try_in_on_scan_abutment_PMMY, Physical_Impression_closed_tray }

enum EnumFinalProthesisSingleBridgeDeliveryStatus { Done, ReDesign, ReImpression, ReTryIn }

enum EnumFinalProthesisSingleBridgeHealingCollarNextVisit
{
  Needs_Impression
}
enum EnumFinalProthesisSingleBridgeImpressionNextVisit
{
  Custom_Abutment,
  Try_In,
  Delivery
}
enum EnumFinalProthesisSingleBridgeTryInNextVisit
{
  Delivery,
  Try_In_PMMA,
  ReImpression
}
enum EnumFinalProthesisSingleBridgeDeliveryNextVisit
{
  Done,
  ReDesign,
  ReImpression,
  ReTryIn
}