import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class AdvancedPatientSearchEntity extends Equatable {
  int? id;
  String? name;
  int? ageRangeFrom;
  int? ageRangeTo;
  int? age;
  EnumGender? gender;
  bool? anyDiseases;
  bool? noTreatmentPlan;
  List<DiseasesEnum>? diseases;
  List<BloodPressureEnum>? bloodPressureCategories;
  BloodPressureEnum? bloodPressure;
  List<DiabetesEnum>? diabetesCategories;
  DiabetesEnum? diabetes;
  int? lastHAB1cFrom;
  int? lastHAB1cTo;
  bool? penecilin;
  bool? illegalDrugs;
  PregnancyEnum? pregnancy;
  bool? chewing;
  SmokingStatus? smokingStatus;
  EnumCooperationScore? cooperationScore;
  EnumOralHygieneRating? oralHygieneRating;
  int? lastHAB1c;

  AdvancedPatientSearchEntity(
      {this.id,
      this.ageRangeFrom,
      this.ageRangeTo,
      this.gender,
      this.anyDiseases,
      this.bloodPressureCategories,
      this.diabetesCategories,
      this.lastHAB1cFrom,
      this.lastHAB1cTo,
      this.penecilin,
      this.illegalDrugs,
      this.pregnancy,
      this.chewing,
      this.noTreatmentPlan,
      this.smokingStatus,
      this.cooperationScore,
      this.oralHygieneRating});


  @override
  List<Object?> get props => [
        this.id,
        this.ageRangeFrom,
        this.ageRangeTo,
        this.gender,
        this.noTreatmentPlan,
        this.anyDiseases,
        this.bloodPressureCategories,
        this.diabetesCategories,
        this.lastHAB1cFrom,
        this.lastHAB1cTo,
        this.penecilin,
        this.illegalDrugs,
        this.pregnancy,
        this.chewing,
        this.smokingStatus,
        this.cooperationScore,
        this.oralHygieneRating,
      ];
}
