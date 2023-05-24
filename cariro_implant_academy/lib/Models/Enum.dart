enum DiabetesEnum {
  Normal,
  DiabeticControlled,
  DiabeticUncontrolled,
}

enum DiabetesMeasureType { Fasting, Random }

enum BloodPressureEnum { Normal, HypertensiveControlled, HypertensiveUncontrolled, HypotensiveControlled, HypotensiveUncontrolled }

enum DiseasesEnum {
  KidneyDisease,
  LiverDisease,
  Asthma,
  Psychological,
  Rhemuatic,
  Anemia,
  Epilepsy,
  HeartProblem,
  Thyroid,
  Hepatitis,
  VenerealDisease,
  Other,
}

enum GeneralHealthEnum { Excellent, VeryGood, Good, Fair, Fail }

enum PregnancyEnum { None, Pregnant, Lactating }

enum SmokingStatus { NoneSmoker, LightSmoker, MediumSmoker, HeavySmoker }

enum Website { CIA, Lab, Clinic }

enum LabStepStatus {
  Done,
  InProgress,
  NotYet,
}

enum EnumLabRequestStatus { InQueue, InProgress, FinishedNotHandeled, FinishedAndHandeled }

enum EnumPatientType { CIA, Clinic, OutSource }

enum EnumLabRequestSources { CIA, Clinic, OutSource }

enum UserRoles { Admin, Assistant, Instructor, Secretary, Technician, OutSource, Candidate }

enum EnumOralHygieneRating {
  BadHygiene,
  FairHygiene,
  GoodHygiene,
  ExcellentHygiene,
}

enum EnumLabRequestInitStatus {
  Scan,
  Physical,
  Cast,
  Remake,
}

enum EnumImageType {
  PatientProfile,
  IdBack,
  IdFront,
  Remake,
}

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
