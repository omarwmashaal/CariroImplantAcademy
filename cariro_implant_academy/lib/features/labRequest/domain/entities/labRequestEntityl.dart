import 'package:cariro_implant_academy/features/labRequest/domain/entities/labstepItemEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';

class LabRequestEntity extends Equatable {
  int? id;
  DateTime? date;
  DateTime? deliveryDate;
  int? entryById;
  BasicNameIdObjectEntity? entryBy;
  int? assignedToId;
  BasicNameIdObjectEntity? assignedTo;
  Website? source;
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
  String? notes;
  String? notesFromTech;
  String? requiredStep;
  List<int>? teeth;
  EnumLabRequestInitStatus? initStatus;
  List<LabStepItemEntity>? labRequestStepItems;
  int? labFees;

  int? fileId;
  BasicNameIdObjectEntity? file;

  LabRequestEntity({
    this.id,
    this.notesFromTech,
    this.designer,
    this.designerId,
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
    this.fileId,
    this.file,
    this.initStatus = EnumLabRequestInitStatus.Scan,
    this.teeth,
    this.assignedToId,
    this.assignedTo,
    this.labRequestStepItems,
    this.labFees = 0,
  }) {
    entryBy = entryBy ?? BasicNameIdObjectEntity();
    labRequestStepItems = labRequestStepItems ?? [];
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
        this.fileId,
        this.file,
        this.initStatus,
        this.teeth,
        this.labRequestStepItems,
        this.labFees,
      ];
}
