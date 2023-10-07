import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:get/get.dart';

class DentalExaminationModel {
  int? id;
  int? patientId;
  List<DentalExaminations> dentalExaminations=[];
  int? interarchspaceRT;
  int? interarchspaceLT;
  String? date;
  String? operatorImplantNotes;
  int? operatorId;
  DropDownDTO? operator;
  EnumOralHygieneRating?  oralHygieneRating;

  DentalExaminationModel(
      {this.id,
        this.patientId,
        this.dentalExaminations=const [],
        this.interarchspaceRT=0,
        this.interarchspaceLT=0,
        this.date="",
        this.operatorImplantNotes="",
        this.oralHygieneRating=EnumOralHygieneRating.GoodHygiene,
        this.operatorId,
        this.operator});

  DentalExaminationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    if (json['dentalExaminations'] != null) {
      dentalExaminations = <DentalExaminations>[];
      json['dentalExaminations'].forEach((v) {
        dentalExaminations!.add(new DentalExaminations.fromJson(v));
      });
    }
    else dentalExaminations = [];
    interarchspaceRT = json['interarchspaceRT']??0;
    interarchspaceLT = json['interarchspaceLT']??0;
    oralHygieneRating = EnumOralHygieneRating.values[json['oralHygieneRating']??2];
    date = json['date']??"";
    operatorImplantNotes = json['operatorImplantNotes']??"";
    operatorId = json['operatorId'];
    operator = json['operator'] != null
        ? new DropDownDTO.fromJson(json['operator'])
        : DropDownDTO();


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    if (this.dentalExaminations != null) {
      data['dentalExaminations'] =
          this.dentalExaminations!.map((v) => v.toJson()).toList();
    }
    data['interarchspaceRT'] = this.interarchspaceRT;
    data['interarchspaceLT'] = this.interarchspaceLT;
    data['operatorImplantNotes'] = this.operatorImplantNotes;
    data['oralHygieneRating'] = this.oralHygieneRating!.index;

    return data;
  }

  Compare(DentalExaminationModel model)
  {
    return this.toJson()==model.toJson();
  }

}

class DentalExaminations {
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
  String? previousState;

  DentalExaminations(
      {this.tooth,
        this.carious=false,
        this.filled=false,
        this.missed=false,
        this.notSure=false,
        this.mobilityI=false,
        this.mobilityII=false,
        this.mobilityIII=false,
        this.hopelessteeth=false,
        this.implantPlaced=false,
        this.implantFailed=false,
        this.previousState=""});

  DentalExaminations.fromJson(Map<String, dynamic> json) {
    tooth = json['tooth'];
    carious = json['carious']??false;
    filled = json['filled']??false;
    missed = json['missed']??false;
    notSure = json['notSure']??false;
    mobilityI = json['mobilityI']??false;
    mobilityII = json['mobilityII']??false;
    mobilityIII = json['mobilityIII']??false;
    hopelessteeth = json['hopelessteeth']??false;
    implantPlaced = json['implantPlaced']??false;
    implantFailed = json['implantFailed']??false;
    previousState = json['previousState']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['previousState'] = this.previousState;
    return data;
  }

  updateToothStatus(String value)  {


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

