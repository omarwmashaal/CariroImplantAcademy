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
  String? previousState = "";

  DentalExaminationModel(
      {this.interarchspaceRT = 0,
      this.interarchspaceLT = 0,
      this.tooth,
      this.carious = false,
      this.filled = false,
      this.missed = false,
      this.notSure = false,
      this.mobilityI = false,
      this.mobilityII = false,
      this.mobilityIII = false,
      this.hopelessteeth = false,
      this.implantPlaced = false,
      this.implantFailed = false,
      this.previousState,
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
    previousState = json['previousState'] ?? "";
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
    data['previousState'] = this.previousState;
    return data;
  }

  updateToothStatus(String value) {
    switch (value) {
      case "Carious":
        {
          carious = true;
          missed = false;
          filled = false;
          implantPlaced = false;

          break;
        }
      case "Filled":
        {
          carious = false;
          missed = false;
          filled = true;
          implantPlaced = false;

          break;
        }
      case "Missed":
        {
          carious = false;
          implantPlaced = false;
          carious = false;
          missed = true;
          filled = false;
          notSure = false;
          mobilityII = false;
          mobilityI = false;
          mobilityIII = false;
          implantFailed = false;
          hopelessteeth = false;

          break;
        }
      case "Not Sure":
        {
          notSure = true;
          missed = false;
          implantPlaced = false;

          break;
        }

      case "Mobility I":
        {
          mobilityI = true;
          mobilityII = false;
          mobilityIII = false;
          missed = false;
          implantPlaced = false;

          break;
        }

      case "Mobility II":
        {
          mobilityII = true;
          mobilityI = false;
          mobilityIII = false;
          missed = false;
          implantPlaced = false;

          break;
        }

      case "Mobility III":
        {
          mobilityIII = true;
          mobilityII = false;
          mobilityI = false;
          missed = false;
          implantPlaced = false;

          break;
        }

      case "Hopeless teeth":
        {
          hopelessteeth = true;
          missed = false;

          break;
        }
      case "Implant Placed":
        {
          implantPlaced = true;
          carious = false;
          missed = false;
          filled = false;
          notSure = false;
          mobilityII = false;
          mobilityI = false;
          mobilityIII = false;
          implantFailed = false;
          hopelessteeth = false;

          break;
        }
      case "Implant Failed":
        {
          implantFailed = true;
          implantPlaced = false;
          carious = false;
          missed = true;
          filled = false;
          notSure = false;
          mobilityII = false;
          mobilityI = false;
          mobilityIII = false;
          hopelessteeth = false;

          break;
        }
    }
  }
}
