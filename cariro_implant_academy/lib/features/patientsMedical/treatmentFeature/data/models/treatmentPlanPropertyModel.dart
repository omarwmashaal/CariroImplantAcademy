import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/trearmentPlanPropertyEntity.dart';
import 'package:intl/intl.dart';

class TreatmentPlanPropertyModel extends TreatmentPlanPropertyEntity
{
  TreatmentPlanPropertyModel({
    value,
    status,
    assignedToID,
    assignedTo,
    date,
    doneByAssistantID,
    doneByAssistant,
    doneBySupervisorID,
    doneBySupervisor,
    doneByCandidateID,
    doneByCandidate,
    doneByCandidateBatchID,
    doneByCandidateBatch,
    implantID,
    price,
    implant,
}):super(
      value:value,
      status:status,
      assignedToID:assignedToID,
      assignedTo:assignedTo,
      date:date,
      doneByAssistantID:doneByAssistantID,
      doneByAssistant:doneByAssistant,
      doneBySupervisorID:doneBySupervisorID,
      doneBySupervisor:doneBySupervisor,
      doneByCandidateID:doneByCandidateID,
      doneByCandidate:doneByCandidate,
      doneByCandidateBatchID:doneByCandidateBatchID,
      doneByCandidateBatch:doneByCandidateBatch,
      implantID:implantID,
      planPrice:price,
      implant:implant,
  );
  
  factory TreatmentPlanPropertyModel.fromEntity(TreatmentPlanPropertyEntity entity)
  {
    return TreatmentPlanPropertyModel(
      value: entity.value,
      status: entity.status,
      assignedToID: entity.assignedToID,
      assignedTo: entity.assignedTo,
      date: entity.date,
      doneByAssistantID: entity.doneByAssistantID,
      doneByAssistant: entity.doneByAssistant,
      doneBySupervisorID: entity.doneBySupervisorID,
      doneBySupervisor: entity.doneBySupervisor,
      doneByCandidateID: entity.doneByCandidateID,
      doneByCandidate: entity.doneByCandidate,
      doneByCandidateBatchID: entity.doneByCandidateBatchID,
      doneByCandidateBatch: entity.doneByCandidateBatch,
      implantID: entity.implantID,
      price: entity.planPrice,
      implant: entity.implant,
    );
  }
  TreatmentPlanPropertyModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] ?? "";
    status = json['status'] ?? false;
    assignedToID = json['assignedToID'];
    assignedTo = json['assignedTo'] != null ? new BasicNameIdObjectModel.fromJson(json['assignedTo']) : null;
    date =  DateTime.tryParse(json['date']??"") ;
    doneByAssistantID = json['doneByAssistantID'];
    doneByAssistant = json['doneByAssistant'] != null ? new BasicNameIdObjectModel.fromJson(json['doneByAssistant']) : BasicNameIdObjectModel();
    doneBySupervisorID = json['doneBySupervisorID'];
    doneBySupervisor = json['doneBySupervisor'] != null ? new BasicNameIdObjectModel.fromJson(json['doneBySupervisor']) : BasicNameIdObjectModel();
    doneByCandidateID = json['doneByCandidateID'];
    doneByCandidate = json['doneByCandidate'] != null ? new BasicNameIdObjectModel.fromJson(json['doneByCandidate']) : BasicNameIdObjectModel();
    doneByCandidateBatchID = json['doneByCandidateBatchID'];
    doneByCandidateBatch = json['doneByCandidateBatch'] != null ? new BasicNameIdObjectModel.fromJson(json['doneByCandidateBatch']) : BasicNameIdObjectModel();
    implantID = json['implantID'];
    planPrice = json['planPrice'] ?? 0;
    implant = json['implant'] != null ? new BasicNameIdObjectModel.fromJson(json['implant']) : BasicNameIdObjectModel();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['status'] = this.status;
    data['planPrice'] = this.planPrice;
    data['assignedToID'] = this.assignedToID;
    data['date'] = this.date != null ? this.date!.toIso8601String() : null;
    data['doneByAssistantID'] = this.doneByAssistantID;
    data['doneBySupervisorID'] = this.doneBySupervisorID;
    data['doneByCandidateID'] = this.doneByCandidateID;
    data['doneByCandidateBatchID'] = this.doneByCandidateBatchID;
    data['implantID'] = this.implantID;

    return data;
  }

}