import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/models/complicationsAfterProsthesisModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/models/complicationsAfterSurgeryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:get/get.dart';

class AdvancedTreatmentSearchModel extends AdvancedTreatmentSearchEntity {
  AdvancedTreatmentSearchModel({
    super.id,
    super.ids,
    super.tooth,
    super.secondaryId,
    super.patientName,
    super.done,
    super.str_implantFailed,
    super.implantFailed,
    super.complicationsAfterSurgeryIds,
    super.complicationsAfterSurgeryIdsOr,
    super.noTreatmentPlan,
    super.str_complicationsAfterSurgery,
    super.teethClassification,
    super.and_treatmentIds,
    super.or_treatmentIds,
    super.treatmentValue,
    super.treatmentName,
    super.treatmentId,
    super.clearnaceLower,
    super.clearnaceUpper,
    super.candidateBatch,
    super.candidate,
    super.implantLineId,
    super.implantId,
    super.implantLine,
    super.implant,
  });

  factory AdvancedTreatmentSearchModel.fromEntity(AdvancedTreatmentSearchEntity entity) {
    return AdvancedTreatmentSearchModel(
      id: entity.id,
      ids: entity.ids,
      secondaryId: entity.secondaryId,
      complicationsAfterSurgeryIdsOr: entity.complicationsAfterSurgeryIdsOr,
      patientName: entity.patientName,
      done: entity.done,
      noTreatmentPlan: entity.noTreatmentPlan,
      implantFailed: entity.implantFailed,
      complicationsAfterSurgeryIds: entity.complicationsAfterSurgeryIds,
      teethClassification: entity.teethClassification,
      and_treatmentIds: entity.and_treatmentIds,
      or_treatmentIds: entity.or_treatmentIds,
      clearnaceLower: entity.clearnaceLower,
      clearnaceUpper: entity.clearnaceUpper,
      candidate: entity.candidate,
      candidateBatch: entity.candidateBatch,
      implantLineId: entity.implantLineId,
      implantId: entity.implantId,
    );
  }

  AdvancedTreatmentSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tooth = json['tooth'];
    secondaryId = json['secondaryId'];
    patientName = json['patientName'];
    done = json['done'];
    noTreatmentPlan = json['noTreatmentPlan'];
    treatmentValue = json['treatmentValue'];
    treatmentName = json['treatmentName'];
    treatmentId = json['treatmentId'];
    clearnaceUpper = json['clearanceUpper'];
    clearnaceLower = json['clearanceLower'];
    str_complicationsAfterSurgery = json['str_ComplicationsAfterSurgery'];
    candidate = json['candidate'] == null ? null : BasicNameIdObjectModel.fromJson(json['candidate']);
    candidateBatch = json['candidateBatch'] == null ? null : BasicNameIdObjectModel.fromJson(json['candidateBatch']);
    implantLine = json['implantLine'];
    implant = json['implant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['candidateBatchId'] = this.candidateBatch?.id;
    data['candidateId'] = this.candidate?.id;
    data['ids'] = this.ids?.map((e) => e as int).toList();
    data['secondaryId'] = this.secondaryId;
    data['patientName'] = this.patientName;
    data['done'] = this.done;
    data['noTreatmentPlan'] = this.noTreatmentPlan;
    data['clearanceUpper'] = this.clearnaceUpper;
    data['clearanceLower'] = this.clearnaceLower;
    data['teethClassification'] = this.teethClassification == null ? null : this.teethClassification!.index;

    data['implantFailed'] = this.implantFailed;
    data['complicationsAfterSurgeryIds'] = this.complicationsAfterSurgeryIds?.map((e) => e as int).toList();
    data['complicationsAfterSurgeryIdsOr'] = this.complicationsAfterSurgeryIdsOr?.map((e) => e as int).toList();

    data['and_treatmentIds'] = (and_treatmentIds ?? []).map((e) => e as int).toList();
    data['or_treatmentIds'] = (or_treatmentIds ?? []).map((e) => e as int).toList();
    data['implantLineId'] = this.implantLineId?.id;
    data['implantId'] = this.implantId?.id;
    return data;
  }
}
