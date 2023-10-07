

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


enum EnumGender
{
  Male,
  Female
}
enum EnumCooperationScore
{
  BadCooperation,
  FairCooperation,
  GoodCooperation,
  ExcellentCooperation
}
enum EnumTeethClassification
{
UpperAnterior,
LowerAnterior,
UpperPosterior,
LowerPosterior
}
enum EnumExpenseseCategoriesType { Service, BoughtItem, BoughtMedical }
enum EnumNotificationType { Patient, TreatmentPlan, Complains, LabRequest }


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
