import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/toothReceiptEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class ReceiptEntity extends Equatable {
  int? id;
  DateTime? date;
  int? patientId;
  int? candidateId;
  BasicNameIdObjectEntity? patient;
  BasicNameIdObjectEntity? candidate;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  List<ToothReceiptEntity>? toothReceiptData;
  int? total;
  int? paid;
  int? unpaid;
  bool? isPaid;

  ReceiptEntity({
    this.id,
    this.date,
    this.patientId,
    this.patient,
    this.candidate,
    this.candidateId,
    this.operatorId,
    this.operator,
    this.toothReceiptData,
    this.total,
    this.paid,
    this.unpaid,
    this.isPaid,
  });

  @override
  List<Object?> get props => [
    this.id,
    this.date,
    this.patientId,
    this.patient,
    this.operatorId,
    this.operator,
    this.toothReceiptData,
    this.total,
    this.paid,
    this.unpaid,
    this.isPaid,
      ];
}
