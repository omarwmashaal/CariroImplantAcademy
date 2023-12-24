import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'labRequestItemEntity.dart';
import 'labStepEntity.dart';

class LabRequestEntity extends Equatable {
  int? id;
  DateTime? date;
  DateTime? deliveryDate;
  int? entryById;
  BasicNameIdObjectEntity? entryBy;
  int? assignedToId;
  BasicNameIdObjectEntity? assignedTo;
  EnumLabRequestSources? source;
  int? customerId;
  UserEntity? customer;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  EnumLabRequestStatus? status;
  bool? paid;
  int? cost;
  int? paidAmount;
  String? notes;
  String? notesFromTech;
  String? requiredStep;
  List<LabStepEntity>? steps;
  List<int>? teeth;
  EnumLabRequestInitStatus? initStatus;
  LabRequestItemEntity? waxUp;
  LabRequestItemEntity? zirconUnit;
  LabRequestItemEntity? pfm;
  LabRequestItemEntity? compositeInlay;
  LabRequestItemEntity? emaxVeneer;
  LabRequestItemEntity? milledPMMA;
  LabRequestItemEntity? printedPMMA;
  LabRequestItemEntity? tiAbutment;
  LabRequestItemEntity? tiBar;
  LabRequestItemEntity? threeDPrinting;
  List<LabRequestItemEntity>? others;

  int? fileId;
  BasicNameIdObjectEntity? file;

  LabRequestEntity({
    this.id,
    this.waxUp,
    this.notesFromTech,
    this.zirconUnit,
    this.pfm,
    this.compositeInlay,
    this.emaxVeneer,
    this.milledPMMA,
    this.printedPMMA,
    this.tiAbutment,
    this.tiBar,
    this.threeDPrinting,
    this.others,
    this.date,
    this.deliveryDate,
    this.entryById,
    this.entryBy,
    this.source,
    this.customerId,
    this.customer,
    this.patientId,
    this.patient,
    this.status,
    this.paid,
    this.cost,
    this.paidAmount,
    this.notes,
    this.requiredStep,
    this.steps,
    this.fileId,
    this.file,
    this.initStatus = EnumLabRequestInitStatus.Scan,
    this.teeth,
  }) {
    entryBy = BasicNameIdObjectEntity();
    customer = UserEntity();
    patient = BasicNameIdObjectEntity();
    file = BasicNameIdObjectEntity();
    teeth = [];
  }

  @override
  List<Object?> get props => [
        this.id,
        this.date,
        this.notesFromTech,
        this.deliveryDate,
        this.entryById,
        this.entryBy,
        this.source,
        this.customerId,
        this.customer,
        this.patientId,
        this.patient,
        this.status,
        this.paid,
        this.cost,
        this.paidAmount,
        this.notes,
        this.requiredStep,
        this.steps,
        this.fileId,
        this.file,
        this.initStatus,
        this.teeth,
        waxUp,
        zirconUnit,
        pfm,
        compositeInlay,
        emaxVeneer,
        milledPMMA,
        printedPMMA,
        tiAbutment,
        tiBar,
        threeDPrinting,
        others,
      ];
}
