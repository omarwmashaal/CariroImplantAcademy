import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticTreatmentDiagnosticParent.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/models/BasicNameIdObjectModel.dart';

class ProstheticTreatmentDiagnosticParentModel extends ProstheticTreatmentDiagnosticParent {


  ProstheticTreatmentDiagnosticParentModel({
    super.date,
    super.id,
    super.needsRemake,
    super.operator,
    super.operatorId,
    super.patient,
    super.patientId,
    super.prostheticTreatmentId,
  }) ;

  factory ProstheticTreatmentDiagnosticParentModel.fromJson(Map<String, dynamic> json) {
    return ProstheticTreatmentDiagnosticParentModel(
      date: DateTime.tryParse(json['date']??"")?.toLocal(),
      id: json['id'],
      needsRemake: json['needsRemake'] ?? false,
      operator: BasicNameIdObjectModel.fromJson(json['operator'] ?? Map<String, dynamic>()),
      operatorId: json['operatorId'],
      patientId: json['patientId'],
      prostheticTreatmentId: json['prostheticTreatmentId'],
    );
  }factory ProstheticTreatmentDiagnosticParentModel.fromEntiy(ProstheticTreatmentDiagnosticParent entity) {
    return ProstheticTreatmentDiagnosticParentModel(
      date: entity.date,
      id: entity.id,
      needsRemake: entity.needsRemake,
      operator: entity.operator,
      operatorId: entity.operatorId,
      patient: entity.patient,
      patientId: entity.patientId,
      prostheticTreatmentId: entity.prostheticTreatmentId,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date?.toUtc().toIso8601String();
    data['id'] = this.id;
    data['needsRemake'] = this.needsRemake;
    data['patientId'] = this.patientId;
    data['operatorId'] = this.operatorId;
    data['prostheticTreatmentId'] = this.prostheticTreatmentId;
    return data;
  }

}
