import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticTreatmentDiagnosticParentModel.dart';

import '../../domain/entities/diagnosticImpressionEntity.dart';
import '../../domain/enums/enum.dart';

class DiagnosticImpressionModel extends DiagnosticImpressionEntity {
  DiagnosticImpressionModel({
    super.date,
    super.id,
    super.needsRemake,
    super.operator,
    super.operatorId,
    super.patient,
    super.patientId,
    super.prostheticTreatmentId,
    super.scanned,
    super.diagnostic,
    super.nextStep,
  });
  factory DiagnosticImpressionModel.fromEntity(DiagnosticImpressionEntity entity) {
    return DiagnosticImpressionModel(
      date: entity.date,
      id: entity.id,
      needsRemake: entity.needsRemake,
      scanned: entity.scanned,
      operator: entity.operator,
      operatorId: entity.operatorId,
      patient: entity.patient,
      patientId: entity.patientId,
      prostheticTreatmentId: entity.prostheticTreatmentId,
      diagnostic: entity.diagnostic,
      nextStep: entity.nextStep,
    );
  }
  factory DiagnosticImpressionModel.fromJson(Map<String, dynamic> json) {
    var parent = ProstheticTreatmentDiagnosticParentModel.fromJson(json);
    return DiagnosticImpressionModel(
      date: parent.date,
      id: parent.id,
      needsRemake: parent.needsRemake,
      operator: parent.operator,
      operatorId: parent.operatorId,
      scanned: parent.scanned,
      patient: parent.patient,
      patientId: parent.patientId,
      prostheticTreatmentId: parent.prostheticTreatmentId,
      diagnostic: json['diagnostic'] == null ? null : EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[json['diagnostic']!],
      nextStep: json['nextStep'] == null ? null : EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[json['nextStep']!],
    );
    }

  Map<String, dynamic> toJson() {
    var data = ProstheticTreatmentDiagnosticParentModel.fromEntiy(this).toJson();
    data['nextStep'] = this.nextStep == null ? null : this.nextStep!.index;
    data['diagnostic'] = this.diagnostic == null ? null : this.diagnostic!.index;
    return data;
  }
}
