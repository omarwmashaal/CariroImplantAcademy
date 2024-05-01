import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/requestChangeModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentItemModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';

class TreatmentDetailsModel extends TreatmentDetailsEntity {
  TreatmentDetailsModel({
    super.id,
    super.treatmentItem,
    super.treatmentItemId,
    super.patientId,
    super.postSurgeryModelId,
    super.patient,
    super.value,
    super.status,
    super.assignedToID,
    super.assignedTo,
    super.date,
    super.doneByAssistantID,
    super.doneByAssistant,
    super.doneBySupervisorID,
    super.doneBySupervisor,
    super.doneByCandidateID,
    super.doneByCandidate,
    super.doneByCandidateBatchID,
    super.doneByCandidateBatch,
    super.implantID,
    super.implant,
    super.implantIDRequest,
    super.implantRequest,
    super.planPrice,
    super.requestChangeModel,
    super.requestChangeId,
    super.tooth,
  });

  factory TreatmentDetailsModel.fromEntity(TreatmentDetailsEntity entity) {
    return TreatmentDetailsModel(
      id: entity.id,
      treatmentItem: entity.treatmentItem,
      treatmentItemId: entity.treatmentItemId,
      postSurgeryModelId: entity.postSurgeryModelId,
      patientId: entity.patientId,
      patient: entity.patient,
      tooth: entity.tooth,
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
      planPrice: entity.planPrice,
      implant: entity.implant,
      implantRequest: entity.implantRequest,
      implantIDRequest: entity.implantIDRequest,
      requestChangeModel: entity.requestChangeModel,
      requestChangeId: entity.requestChangeId,
    );
  }
  TreatmentDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    treatmentItem = json['treatmentItem'] == null ? null : TreatmentItemModel.fromJson(json['treatmentItem']);
    treatmentItemId = json['treatmentItemId'];
    patientId = json['patientId'];
    postSurgeryModelId = json['postSurgeryModelId'];
    patient = json['patient'] != null ? BasicNameIdObjectModel.fromJson(json['patient']) : null;
    tooth = json['tooth'];
    value = json['value'] ?? "";
    status = json['status'] ?? false;
    assignedToID = json['assignedToID'];
    assignedTo = json['assignedTo'] != null ? BasicNameIdObjectModel.fromJson(json['assignedTo']) : null;
    date = DateTime.tryParse(json['date'] ?? "")?.toLocal();
    doneByAssistantID = json['doneByAssistantID'];
    doneByAssistant = json['doneByAssistant'] != null ? BasicNameIdObjectModel.fromJson(json['doneByAssistant']) : BasicNameIdObjectModel();
    doneBySupervisorID = json['doneBySupervisorID'];
    doneBySupervisor = json['doneBySupervisor'] != null ? BasicNameIdObjectModel.fromJson(json['doneBySupervisor']) : BasicNameIdObjectModel();
    doneByCandidateID = json['doneByCandidateID'];
    doneByCandidate = json['doneByCandidate'] != null ? BasicNameIdObjectModel.fromJson(json['doneByCandidate']) : BasicNameIdObjectModel();
    doneByCandidateBatchID = json['doneByCandidateBatchID'];
    doneByCandidateBatch =
        json['doneByCandidateBatch'] != null ? BasicNameIdObjectModel.fromJson(json['doneByCandidateBatch']) : BasicNameIdObjectModel();
    implantID = json['implantID'];
    implantIDRequest = json['implantIDRequest'];
    planPrice = json['planPrice'] ?? 0;
    implant = json['implant'] != null ? BasicNameIdObjectModel.fromJson(json['implant']) : BasicNameIdObjectModel();
    implantRequest = json['implantRequest'] != null ? BasicNameIdObjectModel.fromJson(json['implantRequest']) : BasicNameIdObjectModel();
    requestChangeModel = json['requestChangeModel'] == null ? null : RequestChangeModel.fromJson(json['requestChangeModel']);
    requestChangeId = json['requestChangeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['postSurgeryModelId'] = this.postSurgeryModelId;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['value'] = this.value;
    data['status'] = this.status ?? false;
    data['planPrice'] = this.planPrice;
    data['assignedToID'] = this.assignedToID;
    data['date'] = this.date != null ? this.date!.toUtc().toIso8601String() : null;
    data['doneByAssistantID'] = this.doneByAssistantID;
    data['doneBySupervisorID'] = this.doneBySupervisorID;
    data['doneByCandidateID'] = this.doneByCandidateID;
    data['doneByCandidateBatchID'] = this.doneByCandidateBatchID;
    data['implantID'] = this.implantID;
    data['implantIDRequest'] = this.implantIDRequest;
    data['requestChangeModel'] = this.requestChangeModel == null ? null : RequestChangeModel.fromEntity(this.requestChangeModel!).toJson();
    data['requestChangeId'] = this.requestChangeId;
    data['treatmentItem'] = this.treatmentItem == null ? null : TreatmentItemModel.fromEntity(this.treatmentItem!).toJson();
    data['treatmentItemId'] = this.treatmentItemId;
    return data;
  }
}
