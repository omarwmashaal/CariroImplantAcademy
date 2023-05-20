import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';

import '../Enum.dart';

class MedicalExaminationModel {
  int? id;
  int? patientId;
  GeneralHealthEnum? generalHealth;
  PregnancyEnum? pregnancyStatus;
  String? areYouTreatedFromAnyThing;
  String? recentSurgery;
  String? comment;
  List<DiseasesEnum>? diseases;
  BloodPressure? bloodPressure;
  Diabetic? diabetic;
  List<HbA1c>? hbA1c;
  bool? penicillin;
  bool? sulfa;
  bool? otherAllergy;
  String? otherAllergyComment;
  bool? prolongedBleedingOrAspirin;
  bool? chronicDigestion;
  String? illegalDrugs;
  String? operatorComments;
  List<String>? drugsTaken;
  int? operatorId;
  DropDownDTO? operator;
  String? date;

  MedicalExaminationModel({
    this.id,
    this.patientId,
    this.generalHealth,
    this.pregnancyStatus,
    this.areYouTreatedFromAnyThing,
    this.recentSurgery,
    this.comment,
    this.diseases,
    this.bloodPressure,
    this.diabetic,
    this.hbA1c,
    this.penicillin,
    this.sulfa,
    this.otherAllergy,
    this.otherAllergyComment,
    this.prolongedBleedingOrAspirin,
    this.chronicDigestion,
    this.illegalDrugs,
    this.operatorComments,
    this.drugsTaken,
    this.operatorId,
    this.operator,
    this.date,
  });

  MedicalExaminationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    generalHealth = GeneralHealthEnum.values[json['generalHealth'] ?? 0];
    pregnancyStatus = PregnancyEnum.values[json['pregnancyStatus'] ?? 0];
    areYouTreatedFromAnyThing = json['areYouTreatedFromAnyThing'] ?? "";
    recentSurgery = json['recentSurgery'] ?? "";
    comment = json['comment'] ?? "";
    diseases = json['diseases']!=null?
    (json['diseases'] as List<dynamic>).map((e) => DiseasesEnum.values[e as int]).toList():[];
    bloodPressure = json['bloodPressure'] != null
        ? new BloodPressure.fromJson(json['bloodPressure'])
        : BloodPressure();
    diabetic = json['diabetic'] != null
        ? new Diabetic.fromJson(json['diabetic'])
        : Diabetic();
    if (json['hbA1c'] != null) {
      hbA1c = <HbA1c>[];
      json['hbA1c'].forEach((v) {
        hbA1c!.add(new HbA1c.fromJson(v));
      });
    } else {
      hbA1c = [];
    }
    penicillin = json['penicillin'] ?? false;
    sulfa = json['sulfa'] ?? false;
    otherAllergy = json['otherAllergy'] ?? false;
    otherAllergyComment = json['otherAllergyComment'] ?? "";
    prolongedBleedingOrAspirin = json['prolongedBleedingOrAspirin'] ?? false;
    chronicDigestion = json['chronicDigestion'] ?? false;
    illegalDrugs = json['illegalDrugs'] ?? "";
    operatorComments = json['operatorComments'] ?? "";
    drugsTaken = json['drugsTaken']!=null?
    (json['drugsTaken'] as List<dynamic>).map((e) => e as String).toList():
        []
    ;
    operatorId = json['operatorId'];
    operator = json['operator'] != null
        ? new DropDownDTO.fromJson(json['operator'])
        : DropDownDTO();
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['generalHealth'] = this.generalHealth!.index;
    data['pregnancyStatus'] = this.pregnancyStatus!.index;
    data['areYouTreatedFromAnyThing'] = this.areYouTreatedFromAnyThing;
    data['recentSurgery'] = this.recentSurgery;
    data['comment'] = this.comment;
    data['diseases'] = this.diseases!.map((e) => e.index).toList();
    if (this.bloodPressure != null) {
      data['bloodPressure'] = this.bloodPressure!.toJson();
    }
    if (this.diabetic != null) {
      data['diabetic'] = this.diabetic!.toJson();
    }
    if (this.hbA1c != null) {
      data['hbA1c'] = this.hbA1c!.map((v) => v.toJson()).toList();
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

class BloodPressure {
  String? lastReading;
  String? when;
  String? drug;
  String? readingInClinic;
  BloodPressureEnum? status;

  BloodPressure(
      {this.lastReading = "",
      this.when = "",
      this.drug = "",
      this.readingInClinic = "",
      this.status = BloodPressureEnum.Normal});

  BloodPressure.fromJson(Map<String, dynamic> json) {
    lastReading = json['lastReading'] ?? "";
    when = CIA_DateConverters.fromBackendToDateOnly(json['when']);
    drug = json['drug'] ?? "";
    readingInClinic = json['readingInClinic'] ?? "";
    status = BloodPressureEnum.values[json['status'] ?? 0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastReading'] = this.lastReading;
    data['when'] = CIA_DateConverters.fromDateOnlyToBackend(this.when);
    data['drug'] = this.drug;
    data['readingInClinic'] = this.readingInClinic;
    data['status'] = this.status!.index;
    return data;
  }
}

class Diabetic {
  String? lastReading;
  String? when;
  String? randomInClinic;
  DiabetesEnum? status;
  DiabetesMeasureType? type;

  Diabetic(
      {this.lastReading = "",
      this.when = "",
      this.randomInClinic = "",
      this.status = DiabetesEnum.Normal,
      this.type = DiabetesMeasureType.Random});

  Diabetic.fromJson(Map<String, dynamic> json) {
    lastReading = json['lastReading'];
    when = CIA_DateConverters.fromBackendToDateOnly(json['when']);
    randomInClinic = json['randomInClinic'] ?? "";
    status = DiabetesEnum.values[json["status"] ?? 0];
    type = DiabetesMeasureType.values[json['type'] ?? 0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastReading'] = this.lastReading;
    data['when'] = CIA_DateConverters.fromDateOnlyToBackend(this.when);
    data['randomInClinic'] = this.randomInClinic;
    data['status'] = this.status!.index;
    data['type'] = this.type!.index;
    return data;
  }
}

class HbA1c {
  String? date;
  String? reading;

  HbA1c({this.date = "", this.reading = "0"});

  HbA1c.fromJson(Map<String, dynamic> json) {
    date =  CIA_DateConverters.fromBackendToDateOnly(json['date']);
    reading = json['reading'] == null || json['reading'] ==""? "0":json['reading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = CIA_DateConverters.fromDateOnlyToBackend(this.date);
    data['reading'] = this.reading;
    return data;
  }
}
