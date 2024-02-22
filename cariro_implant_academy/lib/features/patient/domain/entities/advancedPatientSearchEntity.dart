import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/constants/enums/enums.dart';

class AdvancedPatientSearchEntity extends Equatable {
  int? id;
  List<int>? ids;
  String? secondaryId;
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

  AdvancedPatientSearchEntity({
    this.id,
    this.secondaryId,
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
    this.ids,
    this.pregnancy,
    this.chewing,
    this.noTreatmentPlan,
    this.smokingStatus,
    this.cooperationScore,
    this.oralHygieneRating,
    this.age,
    this.bloodPressure,
    this.diabetes,
    this.diseases,
    this.lastHAB1c,
    this.name,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.secondaryId,
        this.ageRangeFrom,
        this.ageRangeTo,
        this.gender,
        this.noTreatmentPlan,
        this.anyDiseases,
        this.bloodPressureCategories,
        this.diabetesCategories,
        this.lastHAB1cFrom,
        this.ids,
        this.lastHAB1cTo,
        this.penecilin,
        this.illegalDrugs,
        this.pregnancy,
        this.chewing,
        this.smokingStatus,
        this.cooperationScore,
        this.oralHygieneRating,
      ];

  AdvancedPatientSearchEntity copyWith({
    ValueGetter<int?>? id,
    ValueGetter<List<int>?>? ids,
    ValueGetter<String?>? secondaryId,
    ValueGetter<String?>? name,
    ValueGetter<int?>? ageRangeFrom,
    ValueGetter<int?>? ageRangeTo,
    ValueGetter<int?>? age,
    ValueGetter<EnumGender?>? gender,
    ValueGetter<bool?>? anyDiseases,
    ValueGetter<bool?>? noTreatmentPlan,
    ValueGetter<List<DiseasesEnum>?>? diseases,
    ValueGetter<List<BloodPressureEnum>?>? bloodPressureCategories,
    ValueGetter<BloodPressureEnum?>? bloodPressure,
    ValueGetter<List<DiabetesEnum>?>? diabetesCategories,
    ValueGetter<DiabetesEnum?>? diabetes,
    ValueGetter<int?>? lastHAB1cFrom,
    ValueGetter<int?>? lastHAB1cTo,
    ValueGetter<bool?>? penecilin,
    ValueGetter<bool?>? illegalDrugs,
    ValueGetter<PregnancyEnum?>? pregnancy,
    ValueGetter<bool?>? chewing,
    ValueGetter<SmokingStatus?>? smokingStatus,
    ValueGetter<EnumCooperationScore?>? cooperationScore,
    ValueGetter<EnumOralHygieneRating?>? oralHygieneRating,
    ValueGetter<int?>? lastHAB1c,
  }) {
    return AdvancedPatientSearchEntity(
      id: id != null ? id() : this.id,
      ids: ids != null ? ids() : this.ids,
      secondaryId: secondaryId != null ? secondaryId() : this.secondaryId,
      name: name != null ? name() : this.name,
      ageRangeFrom: ageRangeFrom != null ? ageRangeFrom() : this.ageRangeFrom,
      ageRangeTo: ageRangeTo != null ? ageRangeTo() : this.ageRangeTo,
      age: age != null ? age() : this.age,
      gender: gender != null ? gender() : this.gender,
      anyDiseases: anyDiseases != null ? anyDiseases() : this.anyDiseases,
      noTreatmentPlan: noTreatmentPlan != null ? noTreatmentPlan() : this.noTreatmentPlan,
      diseases: diseases != null ? diseases() : this.diseases,
      bloodPressureCategories: bloodPressureCategories != null ? bloodPressureCategories() : this.bloodPressureCategories,
      bloodPressure: bloodPressure != null ? bloodPressure() : this.bloodPressure,
      diabetesCategories: diabetesCategories != null ? diabetesCategories() : this.diabetesCategories,
      diabetes: diabetes != null ? diabetes() : this.diabetes,
      lastHAB1cFrom: lastHAB1cFrom != null ? lastHAB1cFrom() : this.lastHAB1cFrom,
      lastHAB1cTo: lastHAB1cTo != null ? lastHAB1cTo() : this.lastHAB1cTo,
      penecilin: penecilin != null ? penecilin() : this.penecilin,
      illegalDrugs: illegalDrugs != null ? illegalDrugs() : this.illegalDrugs,
      pregnancy: pregnancy != null ? pregnancy() : this.pregnancy,
      chewing: chewing != null ? chewing() : this.chewing,
      smokingStatus: smokingStatus != null ? smokingStatus() : this.smokingStatus,
      cooperationScore: cooperationScore != null ? cooperationScore() : this.cooperationScore,
      oralHygieneRating: oralHygieneRating != null ? oralHygieneRating() : this.oralHygieneRating,
      lastHAB1c: lastHAB1c != null ? lastHAB1c() : this.lastHAB1c,
    );
  }
}
