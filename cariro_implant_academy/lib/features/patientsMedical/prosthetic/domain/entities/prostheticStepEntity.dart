import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class ProstheticStepEntity {
  int? id;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  bool? needsRemake;
  bool? scanned;
  DateTime? dateTime;
  int? index;
  int? itemId;
  BasicNameIdObjectEntity? item;
  int? statusId;
  BasicNameIdObjectEntity? status;
  int? nextVisitId;
  BasicNameIdObjectEntity? nextVisit;
  int? tooth;
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
    this.dateTime,
    this.index,
    this.itemId,
    this.item,
    this.statusId,
    this.status,
    this.nextVisitId,
    this.nextVisit,
    this.tooth,
    this.single = false,
    this.bridge = false,
    this.fullArchUpper = false,
    this.fullArchLower = false,
  });
}
