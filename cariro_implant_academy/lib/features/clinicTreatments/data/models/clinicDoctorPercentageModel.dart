import 'dart:core';

import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicDoctorPercentageEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class ClinicDoctorPercentageModel extends ClinicDoctorPercentageEntity {
  ClinicDoctorPercentageModel({
    super.id,
    super.dateTime,
    super.doctorId,
    super.doctor,
    super.restorationId,
    super.restoration,
    super.clinicImplantId,
    super.clinicImplant,
    super.orthoTreatmentId,
    super.orthoTreatment,
    super.tMDId,
    super.tMD,
    super.pedoId,
    super.pedo,
    super.rootCanalTreatmentId,
    super.rootCanalTreatment,
    super.scalingId,
    super.scaling,
    super.patientId,
    super.patient,
    super.operationFee,
    super.doctorsFees,
    super.doctorFeesType,
    super.clinicFee,
    super.paid,
  });

  factory ClinicDoctorPercentageModel.fromMap(Map<String, dynamic> map) {
    return ClinicDoctorPercentageModel(
      id: map['id'],
      dateTime: DateTime.tryParse(map['dateTime'] ?? ""),
      doctorId:map['doctorId'],
      doctor:map['doctor'] == null ? null : BasicNameIdObjectModel.fromJson(map['doctor']),
      restorationId: map['restorationId'],
      restoration: map['restoration'] == null ? null : BasicNameIdObjectModel.fromJson(map['restoration']),
      clinicImplantId: map['clinicImplantId'],
      orthoTreatmentId: map['orthoTreatmentId'],
      tMDId: map['tmdId'],
      pedoId: map['pedoId'],
      rootCanalTreatmentId: map['rootCanalTreatmentId'],
      scalingId: map['scalingId'],
      patientId: map['patientId'],
      patient: map['patient'] == null ? null : BasicNameIdObjectModel.fromJson(map['patient']),
      clinicImplant: map['clinicImplant'] == null ? null : BasicNameIdObjectModel.fromJson(map['clinicImplant']),
      scaling: map['scaling'] == null ? null : BasicNameIdObjectModel.fromJson(map['scaling']),
      orthoTreatment: map['orthoTreatment'] == null ? null : BasicNameIdObjectModel.fromJson(map['orthoTreatment']),
      tMD: map['tmd'] == null ? null : BasicNameIdObjectModel.fromJson(map['tmd']),
      pedo: map['pedo'] == null ? null : BasicNameIdObjectModel.fromJson(map['pedo']),
      rootCanalTreatment: map['rootCanalTreatment'] == null ? null : BasicNameIdObjectModel.fromJson(map['rootCanalTreatment']),
      operationFee: map['operationFee'],
      doctorsFees: map['doctorsFees'],
      doctorFeesType: map['doctorFeesType']==null?null:EnumDortorsPercentageEnum.values[map['doctorFeesType']] ,
      clinicFee: map['clinicFee'],
      paid: map['paid'],
    );
  }
}
