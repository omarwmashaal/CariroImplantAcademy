import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patient/data/models/patientInfoModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:equatable/equatable.dart';

class ComplicationsAfterProsthesisModel extends ComplicationsAfterProsthesisEntity {
  ComplicationsAfterProsthesisModel({
    super.id,
    super.patientId,
    super.screwLoosness,
    super.crownFall,
    super.fracturedZirconia,
    super.fracturedPrintedPMMA,
    super.foodImpaction,
    super.pain,
    super.patient,
    super.tooth,
    super.date,
    super.name,
    super.notes,
    super.operator,
    super.operatorId,
  });

  factory ComplicationsAfterProsthesisModel.fromEntity(ComplicationsAfterProsthesisEntity entity) {
    return ComplicationsAfterProsthesisModel(
      id: entity.id,
      patientId: entity.patientId,
      screwLoosness: entity.screwLoosness,
      crownFall: entity.crownFall,
      fracturedZirconia: entity.fracturedZirconia,
      fracturedPrintedPMMA: entity.fracturedPrintedPMMA,
      foodImpaction: entity.foodImpaction,
      pain: entity.pain,
      patient: entity.patient,
      date: entity.date,
      name: entity.name,
      notes: entity.notes,
      operatorId: entity.operatorId,
      tooth: entity.tooth,
    );
  }
  factory ComplicationsAfterProsthesisModel.fromJson(Map<String, dynamic> json) {
    return ComplicationsAfterProsthesisModel(
      id: json['id'],
      patient: json['patient'] == null ? null : PatientInfoModel.fromMap(json['patient']),
      patientId: json['patientId'],
      screwLoosness: json['screwLoosness'],
      crownFall: json['crownFall'],
      fracturedZirconia: json['fracturedZirconia'],
      fracturedPrintedPMMA: json['fracturedPrintedPMMA'],
      foodImpaction: json['foodImpaction'],
      pain: json['pain'],
      date: DateTime.tryParse(json['date'] ?? "")?.toLocal(),
      tooth: json['tooth'],
      name: json['name'],
      notes: json['notes'],
      operatorId: json['operatorId'],
      operator: json['operator'] == null ? null : BasicNameIdObjectModel.fromJson(json['operator']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'screwLoosness': screwLoosness ?? false,
      'crownFall': crownFall ?? false,
      'fracturedZirconia': fracturedZirconia ?? false,
      'fracturedPrintedPMMA': fracturedPrintedPMMA ?? false,
      'foodImpaction': foodImpaction ?? false,
      'pain': pain ?? false,
      'tooth': tooth,
      'name': name,
      'notes': notes,
      'operatorId': operatorId,
      'date': date?.toUtc().toIso8601String(),
    };
  }
}
