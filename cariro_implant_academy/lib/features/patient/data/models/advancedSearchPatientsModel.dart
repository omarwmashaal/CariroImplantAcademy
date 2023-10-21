import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';

import '../../../../core/constants/enums/enums.dart';

class AdvancedSearchPatientsModel extends AdvancedPatientSearchEntity {
  AdvancedSearchPatientsModel({
    super.id,
    super.ageRangeFrom,
    super.ageRangeTo,
    super.gender,
    super.anyDiseases,
    super.bloodPressureCategories,
    super.diabetesCategories,
    super.lastHAB1cFrom,
    super.lastHAB1cTo,
    super.penecilin,
    super.illegalDrugs,
    super.pregnancy,
    super.chewing,
    super.smokingStatus,
    super.cooperationScore,
    super.noTreatmentPlan,
    super.oralHygieneRating,
  });

  factory AdvancedSearchPatientsModel.fromEntity(AdvancedPatientSearchEntity entity)
  {
    return AdvancedSearchPatientsModel(
      id:entity.id,
      ageRangeFrom:entity.ageRangeFrom,
      ageRangeTo:entity.ageRangeTo,
      gender:entity.gender,
      noTreatmentPlan:entity.noTreatmentPlan,
      anyDiseases:entity.anyDiseases,
      bloodPressureCategories:entity.bloodPressureCategories,
      diabetesCategories:entity.diabetesCategories,
      lastHAB1cFrom:entity.lastHAB1cFrom,
      lastHAB1cTo:entity.lastHAB1cTo,
      penecilin:entity.penecilin,
      illegalDrugs:entity.illegalDrugs,
      pregnancy:entity.pregnancy,
      chewing:entity.chewing,
      smokingStatus:entity.smokingStatus,
      cooperationScore:entity.cooperationScore,
      oralHygieneRating:entity.oralHygieneRating,
    );
  }
  AdvancedSearchPatientsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    //ageRangeFrom = json['ageRangeFrom'];
    //ageRangeTo = json['ageRangeTo'];
    gender = json['gender'] == null ? null : EnumGender.values[json['gender']];
    diseases = json['diseases'] == null ? null : ((json['diseases']) as List<dynamic>).map((e) => DiseasesEnum.values[e as int]).toList();
    //bloodPressureCategories = json['bloodPressureCategories'].cast<int>();
    bloodPressure = json['bloodPressure'] == null ? null : BloodPressureEnum.values[json['bloodPressure']];
    //diabetesCategories = json['diabetesCategories'].cast<int>();
    diabetes = json['diabetes'] == null ? null : DiabetesEnum.values[json['diabetes']];
    //lastHAB1cFrom = json['lastHAB1c_From'];
    //lastHAB1cTo = json['lastHAB1c_To'];
    lastHAB1c = json['lastHAB1c'];
    noTreatmentPlan = json['noTreatmentPlan'];
    penecilin = json['penecilin'];
    illegalDrugs = json['illegalDrugs'];
    pregnancy = json['pregnancy'] == null ? null : PregnancyEnum.values[json['pregnancy']];
    chewing = json['chewing'];
    smokingStatus = json['smokingStatus'] == null ? null : SmokingStatus.values[json['smokingStatus']];
    oralHygieneRating = json['oralHygieneRating'] == null ? null : EnumOralHygieneRating.values[json['oralHygieneRating']];
    cooperationScore = json['cooperationScore'] == null ? null : EnumCooperationScore.values[json['cooperationScore']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ageRangeFrom'] = this.ageRangeFrom;
    data['ageRangeTo'] = this.ageRangeTo;
    data['gender'] = this.gender == null ? null : this.gender!.index;
    data['anyDiseases'] = this.anyDiseases;
    data['bloodPressureCategories'] = this.bloodPressureCategories == null ? null : this.bloodPressureCategories!.map((e) => e.index).toList();
    data['diabetesCategories'] = this.diabetesCategories == null ? null : this.diabetesCategories!.map((e) => e.index).toList();
    data['lastHAB1c_From'] = this.lastHAB1cFrom;
    data['lastHAB1c_To'] = this.lastHAB1cTo;
    data['penecilin'] = this.penecilin;
    data['illegalDrugs'] = this.illegalDrugs;
    data['pregnancy'] = this.pregnancy == null ? null : this.pregnancy!.index;
    data['chewing'] = this.chewing;
    data['noTreatmentPlan'] = this.noTreatmentPlan;
    data['smokingStatus'] = this.smokingStatus == null ? null : this.smokingStatus!.index;
    data['oralHygieneRating'] = this.oralHygieneRating == null ? null : this.oralHygieneRating!.index;
    data['cooperationScore'] = this.cooperationScore == null ? null : this.cooperationScore!.index;

    return data;
  }
}
