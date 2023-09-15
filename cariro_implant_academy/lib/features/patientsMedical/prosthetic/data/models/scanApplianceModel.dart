import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticTreatmentDiagnosticParentModel.dart';

import '../../domain/entities/scanApplianceEntity.dart';
import '../../domain/enums/enum.dart';

class ScanApplianceModel extends ScanApplianceEntity {
  EnumProstheticDiagnosticScanApplianceDiagnostic? diagnostic;

  ScanApplianceModel({
    super.date,
    super.id,
    super.needsRemake,
    super.operator,
    super.operatorId,
    super.patient,
    super.patientId,
    super.prostheticTreatmentId,
    super.diagnostic,
  });

  factory ScanApplianceModel.fromEntity(ScanApplianceEntity entity) {
    return ScanApplianceModel(
      date: entity.date,
      id: entity.id,
      needsRemake: entity.needsRemake,
      operator: entity.operator,
      operatorId: entity.operatorId,
      patient: entity.patient,
      patientId: entity.patientId,
      prostheticTreatmentId: entity.prostheticTreatmentId,
      diagnostic: entity.diagnostic,
    );
  }

  factory ScanApplianceModel.fromJson(Map<String, dynamic> json) {
    var parent = ProstheticTreatmentDiagnosticParentModel.fromJson(json);
    return ScanApplianceModel(
      date: parent.date,
      id: parent.id,
      needsRemake: parent.needsRemake,
      operator: parent.operator,
      operatorId: parent.operatorId,
      patient: parent.patient,
      patientId: parent.patientId,
      prostheticTreatmentId: parent.prostheticTreatmentId,
      diagnostic: json['diagnostic'] == null ? null : EnumProstheticDiagnosticScanApplianceDiagnostic.values[json['diagnostic']!],
    );
  }

  Map<String, dynamic> toJson() {
    var data = ProstheticTreatmentDiagnosticParentModel.fromEntiy(this).toJson();
    data['diagnostic'] = this.diagnostic == null ? null : this.diagnostic!.index;
    return data;
  }
}
