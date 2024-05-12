import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class ProstheticStepEntity {
  int? id;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  bool? needsRemake;
  bool? scanned;
  DateTime? date;
  int? index;
  int? tryInCheckListId;
  int? itemId;
  BasicNameIdObjectEntity? item;
  int? statusId;
  BasicNameIdObjectEntity? status;
  int? nextVisitId;
  BasicNameIdObjectEntity? nextVisit;
  List<int>? teeth;
  bool single;
  bool bridge;
  bool fullArchUpper;
  bool fullArchLower;

  ProstheticStepEntity({
    this.id,
    this.patientId,
    this.patient,
    this.operatorId,
    this.operator,
    this.needsRemake,
    this.scanned,
    this.date,
    this.index,
    this.tryInCheckListId,
    this.itemId,
    this.item,
    this.statusId,
    this.status,
    this.nextVisitId,
    this.nextVisit,
    this.teeth,
    this.single = false,
    this.bridge = false,
    this.fullArchUpper = false,
    this.fullArchLower = false,
  });
}
