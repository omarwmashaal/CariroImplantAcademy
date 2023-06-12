import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';

import '../ImplantModel.dart';

class TreatmentPlanModel {
  int? id;
  int? patientId;
  int? operatorId;
  DropDownDTO? operator;
  String? date;
  List<TreatmentPlanSubModel>? treatmentPlan;

  TreatmentPlanModel({this.id, this.patientId, this.operatorId, this.operator, this.date, this.treatmentPlan});

  TreatmentPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    operatorId = json['operatorId'];
    operator = json['operator'] != null ? new DropDownDTO.fromJson(json['operator']) : null;
    date = json['date'];
    treatmentPlan = ((json['treatmentPlan'] ?? []) as List<dynamic>).map((e) => TreatmentPlanSubModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    // data['operatorId'] = this.operatorId;
    if (this.operator != null) {
      //data['operator'] = this.operator!.toJson();
    }
    data['date'] = this.date;
    data['treatmentPlan'] = (this.treatmentPlan ?? <TreatmentPlanSubModel>[]).map((e) => e.toJson()).toList();
    return data;
  }
}

class TreatmentPlanSubModel {
  int? id;
  int? patientId;
  DropDownDTO? patient;
  int? tooth;
  TreatmentPlanFieldsModel? rootCanalTreatment;
  TreatmentPlanFieldsModel? restoration;
  TreatmentPlanFieldsModel? pontic;
  TreatmentPlanFieldsModel? extraction;
  TreatmentPlanFieldsModel? simpleImplant;
  TreatmentPlanFieldsModel? immediateImplant;
  TreatmentPlanFieldsModel? expansionWithImplant;
  TreatmentPlanFieldsModel? splittingWithImplant;
  TreatmentPlanFieldsModel? gbrWithImplant;
  TreatmentPlanFieldsModel? openSinusWithImplant;
  TreatmentPlanFieldsModel? closedSinusWithImplant;
  TreatmentPlanFieldsModel? guidedImplant;
  TreatmentPlanFieldsModel? expansionWithoutImplant;
  TreatmentPlanFieldsModel? splittingWithoutImplant;
  TreatmentPlanFieldsModel? gbrWithoutImplant;
  TreatmentPlanFieldsModel? openSinusWithoutImplant;
  TreatmentPlanFieldsModel? closedSinusWithoutImplant;
  TreatmentPlanFieldsModel? scaling;
  TreatmentPlanFieldsModel? crown;

  TreatmentPlanSubModel(
      {this.id,
      this.patientId,
      this.patient,
      this.tooth,
      this.rootCanalTreatment,
      this.restoration,
      this.pontic,
      this.extraction,
      this.simpleImplant,
      this.immediateImplant,
      this.expansionWithImplant,
      this.splittingWithImplant,
      this.gbrWithImplant,
      this.openSinusWithImplant,
      this.closedSinusWithImplant,
      this.guidedImplant,
      this.expansionWithoutImplant,
      this.splittingWithoutImplant,
      this.gbrWithoutImplant,
      this.openSinusWithoutImplant,
      this.closedSinusWithoutImplant});

  TreatmentPlanSubModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    patient = json['patient'] != null ? new DropDownDTO.fromJson(json['patient']) : null;
    tooth = json['tooth'];
    rootCanalTreatment = json['rootCanalTreatment'] != null ? new TreatmentPlanFieldsModel.fromJson(json['rootCanalTreatment']) : null;
    restoration = json['restoration'] != null ? new TreatmentPlanFieldsModel.fromJson(json['restoration']) : null;
    pontic = json['pontic'] != null ? new TreatmentPlanFieldsModel.fromJson(json['pontic']) : null;
    extraction = json['extraction'] != null ? new TreatmentPlanFieldsModel.fromJson(json['extraction']) : null;
    simpleImplant = json['simpleImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['simpleImplant']) : null;
    immediateImplant = json['immediateImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['immediateImplant']) : null;
    expansionWithImplant = json['expansionWithImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['expansionWithImplant']) : null;
    splittingWithImplant = json['splittingWithImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['splittingWithImplant']) : null;
    gbrWithImplant = json['gbrWithImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['gbrWithImplant']) : null;
    openSinusWithImplant = json['openSinusWithImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['openSinusWithImplant']) : null;
    closedSinusWithImplant = json['closedSinusWithImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['closedSinusWithImplant']) : null;
    guidedImplant = json['guidedImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['guidedImplant']) : null;
    expansionWithoutImplant = json['expansionWithoutImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['expansionWithoutImplant']) : null;
    splittingWithoutImplant = json['splittingWithoutImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['splittingWithoutImplant']) : null;
    gbrWithoutImplant = json['gbrWithoutImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['gbrWithoutImplant']) : null;
    openSinusWithoutImplant = json['openSinusWithoutImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['openSinusWithoutImplant']) : null;
    closedSinusWithoutImplant = json['closedSinusWithoutImplant'] != null ? new TreatmentPlanFieldsModel.fromJson(json['closedSinusWithoutImplant']) : null;
    scaling = json['scaling'] != null ? new TreatmentPlanFieldsModel.fromJson(json['scaling']) : null;
    crown = json['crown'] != null ? new TreatmentPlanFieldsModel.fromJson(json['crown']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    if (this.rootCanalTreatment != null) {
      data['rootCanalTreatment'] = this.rootCanalTreatment!.toJson();
    }
    if (this.restoration != null) {
      data['restoration'] = this.restoration!.toJson();
    }
    if (this.pontic != null) {
      data['pontic'] = this.pontic!.toJson();
    }
    if (this.extraction != null) {
      data['extraction'] = this.extraction!.toJson();
    }
    if (this.simpleImplant != null) {
      data['simpleImplant'] = this.simpleImplant!.toJson();
    }
    if (this.immediateImplant != null) {
      data['immediateImplant'] = this.immediateImplant!.toJson();
    }
    if (this.expansionWithImplant != null) {
      data['expansionWithImplant'] = this.expansionWithImplant!.toJson();
    }
    if (this.splittingWithImplant != null) {
      data['splittingWithImplant'] = this.splittingWithImplant!.toJson();
    }
    if (this.gbrWithImplant != null) {
      data['gbrWithImplant'] = this.gbrWithImplant!.toJson();
    }
    if (this.openSinusWithImplant != null) {
      data['openSinusWithImplant'] = this.openSinusWithImplant!.toJson();
    }
    if (this.closedSinusWithImplant != null) {
      data['closedSinusWithImplant'] = this.closedSinusWithImplant!.toJson();
    }
    if (this.guidedImplant != null) {
      data['guidedImplant'] = this.guidedImplant!.toJson();
    }
    if (this.expansionWithoutImplant != null) {
      data['expansionWithoutImplant'] = this.expansionWithoutImplant!.toJson();
    }
    if (this.splittingWithoutImplant != null) {
      data['splittingWithoutImplant'] = this.splittingWithoutImplant!.toJson();
    }
    if (this.gbrWithoutImplant != null) {
      data['gbrWithoutImplant'] = this.gbrWithoutImplant!.toJson();
    }
    if (this.openSinusWithoutImplant != null) {
      data['openSinusWithoutImplant'] = this.openSinusWithoutImplant!.toJson();
    }
    if (this.closedSinusWithoutImplant != null) {
      data['closedSinusWithoutImplant'] = this.closedSinusWithoutImplant!.toJson();
    }
    if (this.scaling != null) {
      data['scaling'] = this.scaling!.toJson();
    }
    if (this.crown != null) {
      data['crown'] = this.crown!.toJson();
    }
    return data;
  }
}

class TreatmentPlanFieldsModel {
  String? value;
  bool? status;
  int? assignedToID;
  DropDownDTO? assignedTo;
  String? date;
  int? doneByAssistantID;
  DropDownDTO? doneByAssistant;
  int? doneBySupervisorID;
  DropDownDTO? doneBySupervisor;
  int? doneByCandidateID;
  DropDownDTO? doneByCandidate;
  int? doneByCandidateBatchID;
  DropDownDTO? doneByCandidateBatch;
  int? implantID;
  DropDownDTO? implant;
  int? price;
  int? planPrice;

  TreatmentPlanFieldsModel(
      {this.value = "",
      this.status = false,
      this.assignedToID,
      this.assignedTo,
      this.date,
      this.doneByAssistantID,
      this.doneByAssistant,
      this.doneBySupervisorID,
      this.doneBySupervisor,
      this.doneByCandidateID,
      this.doneByCandidate,
      this.doneByCandidateBatchID,
      this.doneByCandidateBatch,
      this.implantID,
        this.price=0,
        this.planPrice=0,
      this.implant}) {
    doneByAssistant = DropDownDTO();
    doneByCandidate = DropDownDTO();
    doneByCandidateBatch = DropDownDTO();
    doneBySupervisor = DropDownDTO();
    implant = DropDownDTO();
  }

  TreatmentPlanFieldsModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] ?? "";
    status = json['status'] ?? false;
    assignedToID = json['assignedToID'];
    assignedTo = json['assignedTo'] != null ? new DropDownDTO.fromJson(json['assignedTo']) : null;
    date = json['date'];
    doneByAssistantID = json['doneByAssistantID'];
    doneByAssistant = json['doneByAssistant'] != null ? new DropDownDTO.fromJson(json['doneByAssistant']) : DropDownDTO();
    doneBySupervisorID = json['doneBySupervisorID'];
    doneBySupervisor = json['doneBySupervisor'] != null ? new DropDownDTO.fromJson(json['doneBySupervisor']) : DropDownDTO();
    doneByCandidateID = json['doneByCandidateID'];
    doneByCandidate = json['doneByCandidate'] != null ? new DropDownDTO.fromJson(json['doneByCandidate']) : DropDownDTO();
    doneByCandidateBatchID = json['doneByCandidateBatchID'];
    doneByCandidateBatch = json['doneByCandidateBatch'] != null ? new DropDownDTO.fromJson(json['doneByCandidateBatch']) : DropDownDTO();
    implantID = json['implantID'];
    price = json['price']??0;
    planPrice = json['planPrice'];
    implant = json['implant'] != null ? new DropDownDTO.fromJson(json['implant']) : DropDownDTO();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['status'] = this.status;
    data['price'] = this.price;
    data['planPrice'] = this.planPrice??this.price;
    data['assignedToID'] = this.assignedToID;

    data['date'] =this.date!=null? this.date!.replaceFirst(" ", "T"):null;
    data['doneByAssistantID'] = this.doneByAssistantID;

    data['doneBySupervisorID'] = this.doneBySupervisorID;

    data['doneByCandidateID'] = this.doneByCandidateID;

    data['doneByCandidateBatchID'] = this.doneByCandidateBatchID;

    data['implantID'] = this.implantID;

    return data;
  }
}
