import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:intl/intl.dart';

import '../../../../../Helpers/CIA_DateConverters.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../domain/entities/medicalExaminationEntity.dart';
import 'bloodPressureModel.dart';
import 'diabeticModel.dart';
import 'hba1cModel.dart';

class MedicalExaminationModel extends MedicalExaminationEntity {
  MedicalExaminationModel({
    id,
    patientId,
    generalHealth,
    pregnancyStatus,
    areYouTreatedFromAnyThing,
    recentSurgery,
    comment,
    diseases,
    bloodPressure,
    diabetic,
    hbA1c,
    otherDiseases,
    penicillin,
    sulfa,
    otherAllergy,
    otherAllergyComment,
    prolongedBleedingOrAspirin,
    chronicDigestion,
    illegalDrugs,
    operatorComments,
    drugsTaken,
    operatorId,
    operator,
    date,
  }) : super(
          date: date,
          id: id,
          patientId: patientId,
          areYouTreatedFromAnyThing: areYouTreatedFromAnyThing,
          bloodPressure: bloodPressure,
          chronicDigestion: chronicDigestion,
          comment: comment,
          diabetic: diabetic,
          diseases: diseases,
          drugsTaken: drugsTaken,
          generalHealth: generalHealth,
          hbA1c: hbA1c,
          illegalDrugs: illegalDrugs,
          operator: operator,
          operatorComments: operatorComments,
          operatorId: operatorId,
          otherAllergy: otherAllergy,
          otherAllergyComment: otherAllergyComment,
          penicillin: penicillin,
          pregnancyStatus: pregnancyStatus,
          prolongedBleedingOrAspirin: prolongedBleedingOrAspirin,
          recentSurgery: recentSurgery,
          sulfa: sulfa,
          otherDiseases: otherDiseases,
        );

  MedicalExaminationModel.fromEntity(MedicalExaminationEntity entity) {
    date = entity.date;
    id = entity.id;
    patientId = entity.patientId;
    areYouTreatedFromAnyThing = entity.areYouTreatedFromAnyThing;
    bloodPressure = entity.bloodPressure;
    chronicDigestion = entity.chronicDigestion;
    comment = entity.comment;
    diabetic = entity.diabetic;
    diseases = entity.diseases;
    drugsTaken = entity.drugsTaken;
    generalHealth = entity.generalHealth;
    hbA1c = entity.hbA1c;
    illegalDrugs = entity.illegalDrugs;
    operator = entity.operator;
    operatorComments = entity.operatorComments;
    operatorId = entity.operatorId;
    otherAllergy = entity.otherAllergy;
    otherAllergyComment = entity.otherAllergyComment;
    penicillin = entity.penicillin;
    pregnancyStatus = entity.pregnancyStatus;
    prolongedBleedingOrAspirin = entity.prolongedBleedingOrAspirin;
    recentSurgery = entity.recentSurgery;
    sulfa = entity.sulfa;
    otherDiseases = entity.otherDiseases;
  }

  MedicalExaminationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    generalHealth = mapToEnum(GeneralHealthEnum.values, json['generalHealth']);
    pregnancyStatus = mapToEnum(PregnancyEnum.values, json['pregnancyStatus']);
    areYouTreatedFromAnyThing = json['areYouTreatedFromAnyThing'];
    recentSurgery = json['recentSurgery'];
    comment = json['comment'];
    diseases = json['diseases'] != null ? (json['diseases'] as List<dynamic>).map((e) => DiseasesEnum.values[e as int]).toList() : null;
    bloodPressure = json['bloodPressure'] != null ? new BloodPressureModel.fromJson(json['bloodPressure']) : null;
    diabetic = json['diabetic'] != null ? new DiabeticModel.fromJson(json['diabetic']) : null;
    if (json['hbA1c'] != null) {
      hbA1c = <HBA1CModel>[];
      json['hbA1c'].forEach((v) {
        hbA1c!.add(new HBA1CModel.fromJson(v));
      });
    } else {
      hbA1c = null;
    }
    penicillin = json['penicillin'];
    otherDiseases = json['otherDiseases'];
    sulfa = json['sulfa'];
    otherAllergy = json['otherAllergy'];
    otherAllergyComment = json['otherAllergyComment'];
    prolongedBleedingOrAspirin = json['prolongedBleedingOrAspirin'];
    chronicDigestion = json['chronicDigestion'];
    illegalDrugs = json['illegalDrugs'];
    operatorComments = json['operatorComments'];
    drugsTaken = json['drugsTaken'] != null ? (json['drugsTaken'] as List<dynamic>).map((e) => e as String).toList() : null;
    operatorId = json['operatorId'];
    operator = json['operator'] != null ? new BasicNameIdObjectModel.fromJson(json['operator']) : null;
    date = DateTime.tryParse(json["date"]??"")?.toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date==null?null:this.date!.toUtc().toIso8601String()  ;
    data['patientId'] = this.patientId;
    data['generalHealth'] = this.generalHealth == null ? null : this.generalHealth!.index;
    data['pregnancyStatus'] = this.pregnancyStatus == null ? null : this.pregnancyStatus!.index;
    data['areYouTreatedFromAnyThing'] = this.areYouTreatedFromAnyThing;
    data['recentSurgery'] = this.recentSurgery;
    data['comment'] = this.comment;
    data['otherDiseases'] = this.otherDiseases;
    data['diseases'] = this.diseases == null ? null : this.diseases!.map((e) => e.index).toList();
    if (this.bloodPressure != null) {
      data['bloodPressure'] = BloodPressureModel.fromEntity(this.bloodPressure!).toJson();
    }
    if (this.diabetic != null) {
      data['diabetic'] = DiabeticModel.fromEntity(this.diabetic!).toJson();
    }
    if (this.hbA1c != null) {
      data['hbA1c'] = this.hbA1c!.map((v) => HBA1CModel.fromEntity(v).toJson()).toList();
    }
    data['penicillin'] = this.penicillin;
    data['sulfa'] = this.sulfa;
    data['otherAllergy'] = this.otherAllergy;
    data['otherAllergyComment'] = this.otherAllergyComment;
    data['prolongedBleedingOrAspirin'] = this.prolongedBleedingOrAspirin;
    data['chronicDigestion'] = this.chronicDigestion;
    data['illegalDrugs'] = this.illegalDrugs;
    data['operatorComments'] = this.operatorComments;
    data['drugsTaken'] = this.drugsTaken;
    return data;
  }
}
