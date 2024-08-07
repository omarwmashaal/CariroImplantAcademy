import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:equatable/equatable.dart';

class AdvancedProstheticSearchRequestEntity extends Equatable {
  List<int>? ids;
  int? itemId;
  int? statusId;
  BasicNameIdObjectEntity? status;
  BasicNameIdObjectEntity? nextVisit;
  BasicNameIdObjectEntity? technique;
  BasicNameIdObjectEntity? material;
  int? nextId;
  int? materialId;
  int? techniqueId;
  EnumProstheticType type;
  bool? fullArch;
  bool? screwRetained;
  bool? cementRetained;
  List<int>? complicationsAfterProstheticIds;
  List<int>? complicationsAfterProstheticIdsOr;

  AdvancedProstheticSearchRequestEntity({
    this.ids,
    this.itemId,
    this.statusId,
    this.nextId,
    this.materialId,
    this.techniqueId,
    this.fullArch = false,
    this.complicationsAfterProstheticIds,
    this.complicationsAfterProstheticIdsOr,
    this.screwRetained = false,
    this.cementRetained = false,
    this.type = EnumProstheticType.Diagnostic,
  });

  @override
  List<Object?> get props => [
        ids,
        this.type,
        this.itemId,
        this.statusId,
        this.nextId,
        this.materialId,
        this.techniqueId,
        this.fullArch,
        screwRetained,
        cementRetained,
      ];

  bool isNull() =>
      this.itemId == null &&
      this.statusId == null &&
      this.nextId == null &&
      this.materialId == null &&
      this.techniqueId == null &&
      complicationsAfterProstheticIdsOr == null &&
      complicationsAfterProstheticIds == null &&
      screwRetained != true &&
      cementRetained != true;

  setNull() {
    itemId = null;
    statusId = null;
    nextId = null;
    materialId = null;
    techniqueId = null;
    complicationsAfterProstheticIdsOr = null;
    complicationsAfterProstheticIds = null;
    fullArch = false;
    screwRetained = false;
    cementRetained = false;
  }
}
