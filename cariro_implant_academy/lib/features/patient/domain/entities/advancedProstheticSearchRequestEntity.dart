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
  int? nextId;
  EnumProstheticType type;
  bool? fullArch;
  bool? screwRetained;
  bool? cementRetained;
  ComplicationsAfterProsthesisEntity? complicationsAnd;
  ComplicationsAfterProsthesisEntity? complicationsOr;

  AdvancedProstheticSearchRequestEntity({
    this.ids,
    this.itemId,
    this.statusId,
    this.nextId,
    this.fullArch = false,
    this.complicationsAnd,
    this.complicationsOr,
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
        this.fullArch,
        screwRetained,
        cementRetained,
      ];

  bool isNull() =>
      this.itemId == null &&
      this.statusId == null &&
      this.nextId == null &&
      complicationsAnd == null &&
      complicationsOr == null &&
      screwRetained != true &&
      cementRetained != true;

  setNull() {
    itemId = null;
    statusId = null;
    nextId = null;
    complicationsAnd = null;
    complicationsOr = null;
    fullArch = false;
    screwRetained = false;
    cementRetained = false;
  }
}
