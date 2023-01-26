class MedicalExaminationModel {
  GeneralHealthEnum? generalHealth;
  bool? pregnant = false;
  bool? lactating = false;
  String? areYouTreatedFromAnyThing;
  String? recentSurgery;
  String? comment;
  List<DiseasesEnum?>? diseases;
  String? otherDiseases;
  BloodPressure? bloodPressure;
  Diabetic? diabetic;
  List<HbA1c?>? hbA1c;
  bool? penicillin = false;
  bool? sulfa = false;
  bool? otherAllergy = false;
  bool? prolongedBleedingOrAspirin = false;
  bool? chronicDigestion = false;
  String? illegalDrugs;
  String? operatorComments;
  List<String?>? drugsTaken;

  MedicalExaminationModel(
      {this.generalHealth,
      this.pregnant,
      this.lactating,
      this.areYouTreatedFromAnyThing,
      this.recentSurgery,
      this.comment,
      this.diseases,
      this.otherDiseases,
      this.bloodPressure,
      this.diabetic,
      this.hbA1c,
      this.penicillin,
      this.sulfa,
      this.otherAllergy,
      this.prolongedBleedingOrAspirin,
      this.chronicDigestion,
      this.illegalDrugs,
      this.operatorComments,
      this.drugsTaken});

  MedicalExaminationModel.fromJson(Map<String, dynamic> json) {
    generalHealth = json['generalHealth'] != null
        ? GeneralHealthEnum.values[json['generalHealth']]
        : null;
    pregnant = json['pregnant'] ?? false;
    lactating = json['lactating'] ?? false;
    areYouTreatedFromAnyThing = json['areYouTreatedFromAnyThing'];
    recentSurgery = json['recentSurgery'];
    comment = json['comment'];
    if (json['diseases'] != null) {
      diseases = [];
      json['diseases'].forEach((v) {
        diseases!.add(DiseasesEnum.values[v as int]);
      });
    }
    otherDiseases = json['otherDiseases'];
    bloodPressure = json['bloodPressure'] != null
        ? BloodPressure?.fromJson(json['bloodPressure'])
        : null;
    diabetic =
        json['diabetic'] != null ? Diabetic?.fromJson(json['diabetic']) : null;
    if (json['hbA1c'] != null) {
      hbA1c = <HbA1c>[];
      json['hbA1c'].forEach((v) {
        hbA1c!.add(HbA1c.fromJson(v));
      });
    }
    penicillin = json['penicillin'] ?? false;
    sulfa = json['sulfa'] ?? false;
    otherAllergy = json['otherAllergy'] ?? false;
    prolongedBleedingOrAspirin = json['prolongedBleedingOrAspirin'] ?? false;
    chronicDigestion = json['chronicDigestion'] ?? false;
    illegalDrugs = json['illegalDrugs'];
    operatorComments = json['operatorComments'];
    if (json['drugsTaken'] != null) {
      drugsTaken = [];
      json['drugsTaken'].forEach((v) {
        drugsTaken!.add(v as String);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['generalHealth'] = generalHealth != null ? generalHealth!.index : null;
    data['pregnant'] = pregnant;
    data['lactating'] = lactating;
    data['areYouTreatedFromAnyThing'] = areYouTreatedFromAnyThing;
    data['recentSurgery'] = recentSurgery;
    data['comment'] = comment;
    data['diseases'] =
        diseases != null ? diseases!.map((v) => v!.index).toList() : null;
    data['otherDiseases'] = otherDiseases;
    data['bloodPressure'] =
        bloodPressure == null ? null : bloodPressure!.toJson();
    data['diabetic'] = diabetic == null ? null : diabetic!.toJson();
    data['hbA1c'] =
        hbA1c != null ? hbA1c!.map((v) => v?.toJson()).toList() : null;
    data['penicillin'] = penicillin;
    data['sulfa'] = sulfa;
    data['otherAllergy'] = otherAllergy;
    data['prolongedBleedingOrAspirin'] = prolongedBleedingOrAspirin;
    data['chronicDigestion'] = chronicDigestion;
    data['illegalDrugs'] = illegalDrugs;
    data['operatorComments'] = operatorComments;
    data['drugsTaken'] =
        drugsTaken != null ? drugsTaken!.map((v) => v).toList() : null;
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
      {this.lastReading,
      this.when,
      this.drug,
      this.readingInClinic,
      this.status});

  BloodPressure.fromJson(Map<String, dynamic> json) {
    lastReading = json['lastReading'];
    when = json["when"] == null ? null : json['when'];
    drug = json['drug'];
    readingInClinic = json['readingInClinic'];
    status = BloodPressureEnum.values[json['status']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lastReading'] = lastReading;
    data['when'] = when == null || when == "" ? null : when;
    data['drug'] = drug;
    data['readingInClinic'] = readingInClinic;
    data['status'] = status != null ? status!.index : null;
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
      {this.lastReading,
      this.when,
      this.randomInClinic,
      this.status,
      this.type});

  Diabetic.fromJson(Map<String, dynamic> json) {
    lastReading = json['lastReading'];
    when = json["when"] == null ? null : json['when'];
    randomInClinic = json['randomInClinic'];
    status = DiabetesEnum.values[json['status']];
    type = DiabetesMeasureType.values[json['type']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lastReading'] = lastReading;
    data['when'] = when;
    data['randomInClinic'] = randomInClinic;
    data['status'] = status != null ? status!.index : null;
    data['type'] = type != null ? type!.index : null;
    return data;
  }
}

class HbA1c {
  String? date;
  String? reading;

  HbA1c({this.date, this.reading});

  HbA1c.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    reading = json['reading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date == null || date == "" ? null : date;
    data['reading'] = reading;
    return data;
  }
}

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
