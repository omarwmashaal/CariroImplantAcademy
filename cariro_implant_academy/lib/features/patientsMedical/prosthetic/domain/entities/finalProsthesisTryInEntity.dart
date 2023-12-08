import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisParentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';

class FinalProthesisTryInEntity extends FinalProthesisParentEntity {
  bool? finalProthesisTryIn;
  EnumFinalProthesisTryInStatus? finalProthesisTryInStatus;
  EnumFinalProthesisTryInNextVisit? finalProthesisTryInNextVisit;
  DateTime? finalProthesisTryInDate;

  // New fields from C# TryInModel
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

  FinalProthesisTryInEntity({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    this.finalProthesisTryIn,
    this.finalProthesisTryInStatus,
    this.finalProthesisTryInNextVisit,
    this.finalProthesisTryInDate,
    // New fields from C# TryInModel
    this.satisfied,
    this.nonSatisfiedNewScan,
    this.nonSatisfiedDescription,
    this.seating,
    this.nonSeatingType,
    this.nonSeatingOtherNotes,
    this.mesialContacts,
    this.distalContacts, // Added property for distalContacts
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
  }) : super(
    id: id,
    patientId: patientId,
    patient: patient,
    searchTeethClassification: searchTeethClassification,
    website: website,
    finalProthesisTeeth: finalProthesisTeeth,
  );

  bool isNull() {
    return finalProthesisTryIn == null &&
        finalProthesisTryInStatus == null &&
        finalProthesisTryInNextVisit == null &&
        finalProthesisTryInDate == null &&
        satisfied == null &&
        nonSatisfiedNewScan == null &&
        nonSatisfiedDescription == null &&
        seating == null &&
        nonSeatingType == null &&
        nonSeatingOtherNotes == null &&
        mesialContacts == null &&
        distalContacts == null && // Added null check for distalContacts
        occlusion == null &&
        buccalContour == null &&
        passive == null &&
        retention == null &&
        occlusionNotes == null &&
        occlusalPlanAndMidline == null &&
        centricRelation == null &&
        verticalDimension == null &&
        lipSupport == null &&
        sizeAndShapeOfTeeth == null &&
        canting == null &&
        frontalSmilingAndLateralPhotos == null &&
        evaluation == null &&
        explainWhy == null;
  }

  @override
  List<Object?> get props {
    return [
      ...super.props,
      finalProthesisTryIn,
      finalProthesisTryInStatus,
      finalProthesisTryInNextVisit,
      finalProthesisTryInDate,
      satisfied,
      nonSatisfiedNewScan,
      nonSatisfiedDescription,
      seating,
      nonSeatingType,
      nonSeatingOtherNotes,
      mesialContacts,
      distalContacts,
      occlusion,
      buccalContour,
      passive,
      retention,
      occlusionNotes,
      occlusalPlanAndMidline,
      centricRelation,
      verticalDimension,
      lipSupport,
      sizeAndShapeOfTeeth,
      canting,
      frontalSmilingAndLateralPhotos,
      evaluation,
      explainWhy,
    ];
  }
}
