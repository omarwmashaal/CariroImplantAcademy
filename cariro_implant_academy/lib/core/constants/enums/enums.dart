import 'package:get/get.dart';

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

enum EnumGender { Male, Female }

enum EnumCooperationScore { BadCooperation, FairCooperation, GoodCooperation, ExcellentCooperation }

enum EnumTeethClassification { UpperAnterior, LowerAnterior, UpperPosterior, LowerPosterior }

enum EnumExpenseseCategoriesType { Service, BoughtItem, BoughtMedical }

enum EnumNotificationType { Patient, TreatmentPlan, Complains, LabRequest, SurgicalTreatment }

T? mapToEnum<T extends Enum>(List<T> values, dynamic? value) {
  if (value is String) return values.firstWhereOrNull((element) => (element as Enum).name.toLowerCase() == value.toLowerCase());
  if (value == null || value is! int) {
    return null;
  }
  return values[value];
}

int? getEnumIndex<T extends Enum>(List<T> values, dynamic? value) {
  if (value is String) {
    var found = values.firstWhereOrNull((element) => element.name.toLowerCase() == value.toLowerCase());
    if (found == null) return null;
    return values.indexWhere((element) => element.name.toLowerCase() == value);
  }
  if (value is Enum) return value.index;
  return null;
}

String? getEnumName(Enum? value) {
  if (value == null) return null;
  return value.name;
}

T getEnumFromName<T extends Enum>(List<T> values, String name) {
  name = name.toLowerCase().replaceAll(" ", "");
  var result = values.firstWhereOrNull((element) => element.name.toLowerCase() == name);
  if (result == null) throw Exception();
  return result;
}

enum EnumMaritalStatus { Married, Single }

enum EnumImageType { PatientProfile, IdBack, IdFront, UserProfile, Pros }

enum EnumComplainStatus { InQueue, Untouched, Resolved }

enum EnumSummaryFilter {
  ThisWeek,
  LastMonth,
  ThisMonth,
  ThisYear,
}

enum RequestChangeEnum {
  ImplantChange,
  MembraneChange,
  TacsChange,
  ScrewChange,
}

enum EnumClinicRestorationStatus { NotSelected, Done, Temp }

enum EnumClinicRestorationType { NotSelected, Composite, ReinforcedGlassIonomer, Temp, IndirectRestoration }

enum EnumClinicRestorationClass {
  NotSelected,
  ClassI,
  ClassII,
  ClassIII,
  ClassIV,
  ClassV,
  ClassVI,
}

enum EnumClinicImplantTypes { NotSelected, Simple, Immediate, Guided, Expansion, Splitting, GBR, OpenSinus, ClosedSinus }

enum EnumClinicTMDtypes { NotSelected, Diagnosis, Injection, SRS, NightGuardHard, NightGuardSoft }

enum EnumClinicPedoTooth {
  UpperRightA(51),
  UpperRightB(52),
  UpperRightC(53),
  UpperRightD(54),
  UpperRightE(55),
  UpperLeftA(61),
  UpperLeftB(62),
  UpperLeftC(63),
  UpperLeftD(64),
  UpperLeftE(65),
  LowerRightA(71),
  LowerRightB(72),
  LowerRightC(73),
  LowerRightD(74),
  LowerRightE(75),
  LowerLeftA(81),
  LowerLeftB(82),
  LowerLeftC(83),
  LowerLeftD(84),
  LowerLeftE(85);
  const EnumClinicPedoTooth(this.value);
  final int value;
}

enum EnumClinicPedoFirstStep { NotSelected,Pulpotomy, Pulpectomy }

enum EnumClinicPedoSecondStep {NotSelected, CastStanlessSteelZirconia, FinalRestoration, TempFilling }

enum EnumClinicRootCanalTreatmentType {
  NotSelected,
  SingleCanal,
  B,
  L,
  MB,
  DB,
  DL,
  MB2,
  P,
  Other,
}

enum EnumClinicScalingType {
  NotSelected,
  Regular,
  Deep
}


enum EnumClinicPrices {
  RestorationStatusDone,
  RestorationStatusTemp,
  RestorationTypeComposite,
  RestorationTypeReinforcedGlassIonomer,
  RestorationTypeTemp,
  RestorationTypeIndirectRestoration,
  RestorationClassI,
  RestorationClassII,
  RestorationClassIII,
  RestorationClassIV,
  RestorationClassV,
  RestorationClassVI,
  ImplantTypeSimple,
  ImplantTypeImmediate,
  ImplantTypeGuided,
  ImplantTypeExpansion,
  ImplantTypeSplitting,
  ImplantTypeGBR,
  ImplantTypeOpenSinus,
  ImplantTypeClosedSinus,
  TMDTypeDiagnosis,
  TMDTypeInjection,
  TMDTypeSRS,
  TMDTypeNightGuardHard,
  TMDTypeNightGuardSoft,
  PedoPulpotomy,
  PedoPulpectomy,
  PedoCastStanlessSteelZirconia,
  PedoFinalRestoration,
  PedoTempFilling,
  RootCanalTreatmentTypeSingleCanal,
  RootCanalTreatmentTypeB,
  RootCanalTreatmentTypeL,
  RootCanalTreatmentTypeMB,
  RootCanalTreatmentTypeDB,
  RootCanalTreatmentTypeDL,
  RootCanalTreatmentTypeMB2,
  RootCanalTreatmentTypeP,
  RootCanalTreatmentTypeOther,
  ScalingRegular,
  ScalingDeep,
  Ortho,
}