import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class TryInCheckListEntity {
  bool? satisfied;
  bool? nonSatisfiedNewScan;
  String? nonSatisfiedDescription;
  bool? seating;
  EnumTryInSeating? nonSeatingType;
  String? nonSeatingOtherNotes;
  EnumTryInContacts? mesialContacts;
  EnumTryInContacts? distalContacts;
  EnumOcclusion? occlusion;
  EnumBuccalContour? buccalContour;
  bool? passive;
  String? retention;
  String? occlusionNotes;
  String? occlusalPlanAndMidline;
  String? centricRelation;
  String? verticalDimension;
  String? lipSupport;
  String? sizeAndShapeOfTeeth;
  String? canting;
  String? frontalSmilingAndLateralPhotos;
  String? evaluation;
  String? explainWhy;
  int? id;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  List<int>? teeth;
  int? stepId;
  BasicNameIdObjectEntity? step;

  TryInCheckListEntity({
    this.satisfied,
    this.nonSatisfiedNewScan,
    this.nonSatisfiedDescription,
    this.seating,
    this.nonSeatingType,
    this.nonSeatingOtherNotes,
    this.mesialContacts,
    this.distalContacts,
    this.occlusion,
    this.buccalContour,
    this.passive,
    this.retention,
    this.occlusionNotes,
    this.occlusalPlanAndMidline,
    this.centricRelation,
    this.verticalDimension,
    this.lipSupport,
    this.sizeAndShapeOfTeeth,
    this.canting,
    this.frontalSmilingAndLateralPhotos,
    this.evaluation,
    this.explainWhy,
    this.id,
    this.patientId,
    this.patient,
    this.teeth,
    this.stepId,
    this.step,
  }) {
    this.teeth = this.teeth ?? [];
  }
}
