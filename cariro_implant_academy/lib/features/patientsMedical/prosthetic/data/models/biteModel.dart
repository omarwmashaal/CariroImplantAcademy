import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticTreatmentDiagnosticParentModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';

import '../../domain/entities/prostheticTreatmentDiagnosticParent.dart';
import '../../domain/enums/enum.dart';

class BiteModel extends BiteEntity {
  BiteModel({
    super.date,
    super.id,
    super.needsRemake,
    super.operator,
    super.operatorId,
    super.patient,
    super.patientId,
    super.prostheticTreatmentId,
    super.diagnostic,
    super.nextStep,
  });
  factory BiteModel.fromEntity(BiteEntity entity) {
    return BiteModel(
      date: entity.date,
      id: entity.id,
      needsRemake: entity.needsRemake,
      operator: entity.operator,
      operatorId: entity.operatorId,
      patient: entity.patient,
      patientId: entity.patientId,
      prostheticTreatmentId: entity.prostheticTreatmentId,
      diagnostic: entity.diagnostic,
      nextStep: entity.nextStep,

    );
  }
  factory BiteModel.fromJson(Map<String, dynamic> json) {
    var parent = ProstheticTreatmentDiagnosticParentModel.fromJson(json);
    return BiteModel(
      date: parent.date,
      id: parent.id,
      needsRemake: parent.needsRemake,
      operator: parent.operator,
      operatorId: parent.operatorId,
      patient: parent.patient,
      patientId: parent.patientId,
      prostheticTreatmentId: parent.prostheticTreatmentId,
      diagnostic: json['diagnostic'] == null ? null : EnumProstheticDiagnosticBiteDiagnostic.values[json['diagnostic']],
      nextStep: json['nextStep'] == null ? null : EnumProstheticDiagnosticBiteNextStep.values[json['nextStep']!],
    );
  }

  Map<String, dynamic> toJson() {
    var data = ProstheticTreatmentDiagnosticParentModel.fromEntiy(this).toJson();
    data['nextStep'] = this.nextStep == null ? null : this.nextStep!.index;
    data['diagnostic'] = this.diagnostic == null ? null : this.diagnostic!.index;
    return data;
  }
}
