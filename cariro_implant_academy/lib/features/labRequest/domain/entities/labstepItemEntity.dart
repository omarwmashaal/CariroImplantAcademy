import 'package:equatable/equatable.dart';

import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';

class LabStepItemEntity extends Equatable {
  int? id;
  int? labRequestId;
  int? patientId;
  int? labItemFromSettingsId;
  LabItemParentEntity? labItemFromSettings;
  int? consumedLabItemId;
  LabItemEntity? consumedLabItem;
  int? labPrice;
  int tooth;
  String? description;
  LabStepItemEntity({
    this.id,
    this.labRequestId,
    this.patientId,
    this.labItemFromSettingsId,
    this.labItemFromSettings,
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
      labItemFromSettingsId,
      labItemFromSettings,
      consumedLabItemId,
      consumedLabItem,
      labPrice,
      tooth,
      description,
    ];
  }
}
