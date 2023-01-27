class DentalExaminationModel {
  int? interarchspaceRT;
  int? interarchspaceLT;
  int? tooth;
  bool? carious;
  bool? filled;
  bool? missed;
  bool? notSure;
  bool? mobilityI;
  bool? mobilityII;
  bool? mobilityIII;
  bool? hopelessteeth;
  bool? implantPlaced;
  bool? implantFailed;
  String? operatorImplantNotes;

  DentalExaminationModel(
      {this.interarchspaceRT,
      this.interarchspaceLT,
      this.tooth,
      this.carious,
      this.filled,
      this.missed,
      this.notSure,
      this.mobilityI,
      this.mobilityII,
      this.mobilityIII,
      this.hopelessteeth,
      this.implantPlaced,
      this.implantFailed,
      this.operatorImplantNotes});

  DentalExaminationModel.fromJson(Map<String, dynamic> json) {
    interarchspaceRT = json['interarchspaceRT'] ?? 0;
    interarchspaceLT = json['interarchspaceLT'] ?? 0;
    tooth = json['tooth'];
    carious = json['carious'] ?? false;
    filled = json['filled'] ?? false;
    missed = json['missed'] ?? false;
    notSure = json['notSure'] ?? false;
    mobilityI = json['mobilityI'] ?? false;
    mobilityII = json['mobilityII'] ?? false;
    mobilityIII = json['mobilityIII'] ?? false;
    hopelessteeth = json['hopelessteeth'] ?? false;
    implantPlaced = json['implantPlaced'] ?? false;
    implantFailed = json['implantFailed'] ?? false;
    operatorImplantNotes = json['operatorImplantNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interarchspaceRT'] = this.interarchspaceRT ?? 0;
    data['interarchspaceLT'] = this.interarchspaceLT ?? 0;
    data['tooth'] = this.tooth;
    data['carious'] = this.carious;
    data['filled'] = this.filled;
    data['missed'] = this.missed;
    data['notSure'] = this.notSure;
    data['mobilityI'] = this.mobilityI;
    data['mobilityII'] = this.mobilityII;
    data['mobilityIII'] = this.mobilityIII;
    data['hopelessteeth'] = this.hopelessteeth;
    data['implantPlaced'] = this.implantPlaced;
    data['implantFailed'] = this.implantFailed;
    data['operatorImplantNotes'] = this.operatorImplantNotes;
    return data;
  }
}
