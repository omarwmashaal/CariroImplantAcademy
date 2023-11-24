import 'dart:core';

import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class ClinicDoctorPercentageEntity extends Equatable {
  int? id;
  DateTime? dateTime;
  int? doctorId;
  BasicNameIdObjectEntity? doctor;
  int? restorationId;
  BasicNameIdObjectEntity? restoration;
  int? clinicImplantId;
  BasicNameIdObjectEntity? clinicImplant;
  int? orthoTreatmentId;
  BasicNameIdObjectEntity? orthoTreatment;
  int? tMDId;
  BasicNameIdObjectEntity? tMD;
  int? pedoId;
  BasicNameIdObjectEntity? pedo;
  int? rootCanalTreatmentId;
  BasicNameIdObjectEntity? rootCanalTreatment;
  int? scalingId;
  BasicNameIdObjectEntity? scaling;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  int? operationFee;
  int? doctorsFees;
  EnumDortorsPercentageEnum? doctorFeesType;
  int? clinicFee;
  bool? paid;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.id,
        this.dateTime,
        this.doctorId,
        this.doctor,
        this.restorationId,
        this.restoration,
        this.clinicImplantId,
        this.clinicImplant,
        this.orthoTreatmentId,
        this.orthoTreatment,
        this.tMDId,
        this.tMD,
        this.pedoId,
        this.pedo,
        this.rootCanalTreatmentId,
        this.rootCanalTreatment,
        this.scalingId,
        this.scaling,
        this.patientId,
        this.patient,
        this.operationFee,
        this.doctorFeesType,
        this.doctorsFees,
        this.clinicFee,
        this.paid,
      ];

  ClinicDoctorPercentageEntity({
    this.id,
    this.dateTime,
    this.doctorId,
    this.doctor,
    this.restorationId,
    this.restoration,
    this.clinicImplantId,
    this.clinicImplant,
    this.orthoTreatmentId,
    this.orthoTreatment,
    this.tMDId,
    this.tMD,
    this.pedoId,
    this.pedo,
    this.rootCanalTreatmentId,
    this.rootCanalTreatment,
    this.scalingId,
    this.scaling,
    this.patientId,
    this.patient,
    this.operationFee,
    this.doctorFeesType,
    this.doctorsFees,
    this.clinicFee,
    this.paid,
  });
}
