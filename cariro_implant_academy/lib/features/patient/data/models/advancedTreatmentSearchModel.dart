import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';
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
    super.complicationsAfterSurgery,
    super.complicationsAfterSurgeryOr,
    super.noTreatmentPlan,
    super.str_complicationsAfterSurgery,
    super.teethClassification,
    super.and_treatmentIds,
    super.or_treatmentIds,
    super.treatmentValue,
    super.treatmentName,
    super.treatmentId,
  });

  factory AdvancedTreatmentSearchModel.fromEntity(AdvancedTreatmentSearchEntity entity) {
    return AdvancedTreatmentSearchModel(
      id: entity.id,
      ids: entity.ids,
      secondaryId: entity.secondaryId,
      complicationsAfterSurgeryOr: entity.complicationsAfterSurgeryOr,
      patientName: entity.patientName,
      done: entity.done,
      noTreatmentPlan: entity.noTreatmentPlan,
      implantFailed: entity.implantFailed,
      complicationsAfterSurgery: entity.complicationsAfterSurgery,
      teethClassification: entity.teethClassification,
      and_treatmentIds: entity.and_treatmentIds,
      or_treatmentIds: entity.or_treatmentIds,
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
    str_complicationsAfterSurgery = json['str_ComplicationsAfterSurgery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ids'] = this.ids?.map((e) => e as int).toList();
    data['secondaryId'] = this.secondaryId;
    data['patientName'] = this.patientName;
    data['done'] = this.done;
    data['noTreatmentPlan'] = this.noTreatmentPlan;
    data['teethClassification'] = this.teethClassification == null ? null : this.teethClassification!.index;

    data['implantFailed'] = this.implantFailed;
    data['complicationsAfterSurgery'] =
        this.complicationsAfterSurgery == null ? null : ComplicationsAfterSurgeryModel.fromEntity(this.complicationsAfterSurgery!).toJson();
    data['complicationsAfterSurgeryOr'] =
        this.complicationsAfterSurgeryOr == null ? null : ComplicationsAfterSurgeryModel.fromEntity(this.complicationsAfterSurgeryOr!).toJson();

    data['and_treatmentIds'] = (and_treatmentIds ?? []).map((e) => e as int).toList();
    data['or_treatmentIds'] = (or_treatmentIds ?? []).map((e) => e as int).toList();
    return data;
  }
}
