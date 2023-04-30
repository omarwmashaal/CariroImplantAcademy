
enum DiabetesEnum {
  Normal,
  DiabeticControlled,
  DiabeticUncontrolled,
}

enum DiabetesMeasureType { Fasting, Random }

enum BloodPressureEnum {
  Normal,
  HypertensiveControlled,
  HypertensiveUncontrolled,
  HypotensiveControlled,
  HypotensiveUncontrolled
}

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

enum PregnancyEnum
{
  None,
  Pregnant,
  Lactating
}

enum SmokingStatus
{
  NoneSmoker,
  LightSmoker,
  MediumSmoker,
  HeavySmoker
}
enum Website
{
  CIA,
  Lab,
  Clinic
}


enum LabStepStatus {
  Done,
  InProgress,
  NotYet,
}
enum EnumLabRequestStatus
{
  InQueue,
  InProgress,
  FinishedNotHandeled,
  FinishedAndHandeled
}

enum EnumPatientType
{
  CIA,
  Clinic,
  OutSource
}
enum EnumLabRequestSources
{
  CIA,
  Clinic,
  OutSource
}

enum UserRoles
{
  Admin,
  Assistant,
  Instructor,
  Secretary,
  Technician,
  OutSource
}