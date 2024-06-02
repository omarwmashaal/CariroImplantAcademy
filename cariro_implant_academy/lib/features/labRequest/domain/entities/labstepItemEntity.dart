import 'package:cariro_implant_academy/features/labRequest/domain/entities/labOptionEntity.dart';
import 'package:equatable/equatable.dart';

import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';

class LabStepItemEntity extends Equatable {
  int? id;
  int? labRequestId;
  int? patientId;
  int? consumedLabItemId;
  LabItemEntity? consumedLabItem;
  int? labPrice;
  int? labOptionId;
  LabOptionEntity? labOption;
  int tooth;
  String? description;
  LabStepItemEntity({
    this.id,
    this.labRequestId,
    this.patientId,
    this.labOptionId,
    this.labOption,
    this.consumedLabItemId,
    this.consumedLabItem,
    this.labPrice,
    this.description = "",
    this.tooth = 0,
  });

  @override
  List<Object?> get props {
    return [
      id,
      labRequestId,
      patientId,
      consumedLabItemId,
      consumedLabItem,
      labPrice,
      tooth,
      description,
    ];
  }
}
