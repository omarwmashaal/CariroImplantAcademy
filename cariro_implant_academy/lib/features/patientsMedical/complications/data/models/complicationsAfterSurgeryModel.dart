import 'dart:math';

import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patient/data/models/patientInfoModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';

class ComplicationsAfterSurgeryModel extends ComplicationsAfterSurgeryEntity {
  ComplicationsAfterSurgeryModel({
    super.id,
    super.patientId,
    super.patient,
    super.swelling,
    super.openWound,
    super.numbness,
    super.oroantralCommunication,
    super.pusInImplantSite,
    super.pusInDonorSite,
    super.sinusElevationFailure,
    super.gbrFailure,
    super.tooth,
    super.date,
    super.name,
    super.notes,
    super.operator,
    super.operatorId,
  });

  factory ComplicationsAfterSurgeryModel.fromEntity(ComplicationsAfterSurgeryEntity entity) {
    return ComplicationsAfterSurgeryModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      swelling: entity.swelling,
      openWound: entity.openWound,
      numbness: entity.numbness,
      oroantralCommunication: entity.oroantralCommunication,
      pusInImplantSite: entity.pusInImplantSite,
      pusInDonorSite: entity.pusInDonorSite,
      sinusElevationFailure: entity.sinusElevationFailure,
      gbrFailure: entity.gbrFailure,
      date: entity.date,
      name: entity.name,
      notes: entity.notes,
      operatorId: entity.operatorId,
      tooth: entity.tooth,
    );
  }

  factory ComplicationsAfterSurgeryModel.fromJson(Map<String, dynamic> json) {
    return ComplicationsAfterSurgeryModel(
      id: json['id'],
      patientId: json['patientId'],
      patient: json['patient'] == null ? null : PatientInfoModel.fromMap(json['patient']),
      swelling: json['swelling'],
      openWound: json['openWound'],
      numbness: json['numbness'],
      oroantralCommunication: json['oroantralCommunication'],
      pusInImplantSite: json['pusInImplantSite'],
      pusInDonorSite: json['pusInDonorSite'],
      sinusElevationFailure: json['sinusElevationFailure'],
      gbrFailure: json['gbrFailure'],
      tooth: json['tooth'],
      name: json['name'],
      notes: json['notes'],
      operatorId: json['operatorId'],
      operator: json['operator'] == null ? null : BasicNameIdObjectModel.fromJson(json['operator']),
      date: DateTime.tryParse(json['date'] ?? "")?.toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'swelling': swelling ?? false,
      'openWound': openWound ?? false,
      'numbness': numbness ?? false,
      'oroantralCommunication': oroantralCommunication ?? false,
      'pusInImplantSite': pusInImplantSite ?? false,
      'pusInDonorSite': pusInDonorSite ?? false,
      'sinusElevationFailure': sinusElevationFailure ?? false,
      'gbrFailure': gbrFailure ?? false,
      'tooth': tooth,
      'name': name,
      'notes': notes,
      'operatorId': operatorId,
      'date': date?.toUtc().toIso8601String(),
    };
  }
}
