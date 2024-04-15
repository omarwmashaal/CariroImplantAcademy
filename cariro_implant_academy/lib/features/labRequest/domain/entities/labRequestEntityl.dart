import 'package:cariro_implant_academy/features/labRequest/domain/entities/OmarEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
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
  int? designerId;
  BasicNameIdObjectEntity? designer;
  EnumLabRequestStatus? status;
  EnumLabRequestStatus2? status2;
  bool? paid;
  bool? free;
  int? cost;
  int? paidAmount;
  int? labFees;
  String? notes;
  String? notesFromTech;
  String? requiredStep;
  List<LabStepEntity>? steps;
  List<int>? teeth;
  EnumLabRequestInitStatus? initStatus;
  OmarEntity? waxUp;
  OmarEntity? zirconUnit;
  OmarEntity? pfm;
  OmarEntity? compositeInlay;
  OmarEntity? emaxVeneer;
  OmarEntity? milledPMMA;
  OmarEntity? printedPMMA;
  OmarEntity? tiAbutment;
  OmarEntity? tiBar;
  OmarEntity? threeDPrinting;
  List<OmarEntity>? others;

  int? fileId;
  BasicNameIdObjectEntity? file;

  LabRequestEntity({
    this.id,
    this.waxUp,
    this.notesFromTech,
    this.zirconUnit,
    this.pfm,
    this.labFees,
    this.designer,
    this.designerId,
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
    this.status2 = EnumLabRequestStatus2.New,
    this.free = false,
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
    this.assignedToId,
    this.assignedTo,
  }) {
    entryBy = entryBy ?? BasicNameIdObjectEntity();
    customer = customer ?? UserEntity();
    patient = patient ?? BasicNameIdObjectEntity();
    file = file ?? BasicNameIdObjectEntity();
    teeth = teeth ?? [];
  }

  @override
  List<Object?> get props => [
        this.id,
        this.date,
        this.designer,
        this.designerId,
        this.notesFromTech,
        this.deliveryDate,
        this.assignedTo,
        this.assignedToId,
        this.labFees,
        this.entryById,
        this.entryBy,
        this.source,
        this.customerId,
        this.customer,
        this.patientId,
        this.patient,
        this.status,
        this.status2,
        this.paid,
        this.free,
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
