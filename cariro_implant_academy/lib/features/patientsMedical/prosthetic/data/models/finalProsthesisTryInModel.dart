import 'dart:convert';

import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/data/models/BasicNameIdObjectModel.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/entities/finalProsthesisTryInEntity.dart';

class FinalProthesisTryInModel extends FinalProthesisTryInEntity {
  bool? satisfied;
  bool? nonSatisfiedNewScan;
  String? nonSatisfiedDescription;
  bool? seating;
  EnumTryInSeating? nonSeatingType;
  String? nonSeatingOtherNotes;
  EnumTryInContacts? mesialContacts;
  EnumTryInContacts? distalContacts; // New field
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

  FinalProthesisTryInModel({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    EnumFinalProthesisTryInStatus? finalProthesisTryInStatus,
    EnumFinalProthesisTryInNextVisit? finalProthesisTryInNextVisit,
    DateTime? date,
    int? operatorId,
    BasicNameIdObjectEntity? operator,
    // Additional fields from C# TryInModel
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
  }) : super(
    id: id,
    patientId: patientId,
    patient: patient,
    searchTeethClassification: searchTeethClassification,
    website: website,
    operator: operator,
    operatorId: operatorId,
    finalProthesisTeeth: finalProthesisTeeth,
    finalProthesisTryInStatus: finalProthesisTryInStatus,
    finalProthesisTryInNextVisit: finalProthesisTryInNextVisit,
    date: date,
  );

  factory FinalProthesisTryInModel.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return FinalProthesisTryInModel.fromMap(map);
  }

  factory FinalProthesisTryInModel.fromMap(Map<String, dynamic> map) {
    return FinalProthesisTryInModel(
      id: map['id'],
      patientId: map['patientId'],
      patient: map['patient'] != null ? BasicNameIdObjectModel.fromJson(map['patient']) : null,
      searchTeethClassification: map['searchTeethClassification'],
      finalProthesisTeeth: map['finalProthesisTeeth'] == null ? null : (map['finalProthesisTeeth'] as List<dynamic>).map((e) => e as int).toList(),
      finalProthesisTryInStatus: map['finalProthesisTryInStatus'] != null ? EnumFinalProthesisTryInStatus.values[map['finalProthesisTryInStatus']] : null,
      finalProthesisTryInNextVisit:
      map['finalProthesisTryInNextVisit'] != null ? EnumFinalProthesisTryInNextVisit.values[map['finalProthesisTryInNextVisit']] : null,
      date: DateTime.tryParse(map['date'] ?? "")?.toLocal(),
      // Additional fields from C# TryInModel
      satisfied: map['satisfied'],
      nonSatisfiedNewScan: map['nonSatisfiedNewScan'],
      nonSatisfiedDescription: map['nonSatisfiedDescription'],
      seating: map['seating'],
      nonSeatingType: map['nonSeatingType'] != null ? EnumTryInSeating.values[map['nonSeatingType']] : null,
      nonSeatingOtherNotes: map['nonSeatingOtherNotes'],
      mesialContacts: map['mesialContacts'] != null ? EnumTryInContacts.values[map['mesialContacts']] : null,
      distalContacts: map['distalContacts'] != null ? EnumTryInContacts.values[map['distalContacts']] : null,
      occlusion: map['occlusion'] != null ? EnumOcclusion.values[map['occlusion']] : null,
      buccalContour: map['buccalContour'] != null ? EnumBuccalContour.values[map['buccalContour']] : null,
      passive: map['passive'],
      retention: map['retention'],
      occlusionNotes: map['occlusionNotes'],
      occlusalPlanAndMidline: map['occlusalPlanAndMidline'],
      centricRelation: map['centricRelation'],
      verticalDimension: map['verticalDimension'],
      lipSupport: map['lipSupport'],
      sizeAndShapeOfTeeth: map['sizeAndShapeOfTeeth'],
      canting: map['canting'],
      frontalSmilingAndLateralPhotos: map['frontalSmilingAndLateralPhotos'],
      evaluation: map['evaluation'],
      explainWhy: map['explainWhy'],
      operatorId: map['operatorId'],
      operator: map['operatorDTO']==null?null:BasicNameIdObjectModel.fromJson(map['operatorDTO']),
      // ... add more properties as needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'patientId': super.patientId,
      //'patient': super.patient?.toJson(),
      'searchTeethClassification': super.searchTeethClassification,
      //'website': super.website.toString().split('.').last,
      'finalProthesisTeeth': super.finalProthesisTeeth,
      'finalProthesisTryInStatus': super.finalProthesisTryInStatus?.index,
      'finalProthesisTryInNextVisit': super.finalProthesisTryInNextVisit?.index,
      'date': super.date?.toUtc().toIso8601String(),
      // Additional fields from C# TryInModel
      'satisfied': satisfied,
      'nonSatisfiedNewScan': nonSatisfiedNewScan,
      'nonSatisfiedDescription': nonSatisfiedDescription,
      'seating': seating,
      'nonSeatingType': nonSeatingType?.index,
      'nonSeatingOtherNotes': nonSeatingOtherNotes,
      'mesialContacts': mesialContacts?.index,
      'distalContacts': distalContacts?.index,
      'occlusion': occlusion?.index,
      'buccalContour': buccalContour?.index,
      'passive': passive,
      'retention': retention,
      'occlusionNotes': occlusionNotes,
      'occlusalPlanAndMidline': occlusalPlanAndMidline,
      'centricRelation': centricRelation,
      'verticalDimension': verticalDimension,
      'lipSupport': lipSupport,
      'sizeAndShapeOfTeeth': sizeAndShapeOfTeeth,
      'canting': canting,
      'frontalSmilingAndLateralPhotos': frontalSmilingAndLateralPhotos,
      'evaluation': evaluation,
      'explainWhy': explainWhy,
      'operatorId': operatorId,
      // ... add more properties as needed
    };
  }

  static FinalProthesisTryInModel fromEntity(FinalProthesisTryInEntity entity) {
    return FinalProthesisTryInModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      searchTeethClassification: entity.searchTeethClassification,
      website: entity.website,
      finalProthesisTeeth: entity.finalProthesisTeeth,
      finalProthesisTryInStatus: entity.finalProthesisTryInStatus,
      finalProthesisTryInNextVisit: entity.finalProthesisTryInNextVisit,
      date: entity.date,
      // Additional fields from C# TryInModel
      satisfied: entity.satisfied,
      nonSatisfiedNewScan: entity.nonSatisfiedNewScan,
      nonSatisfiedDescription: entity.nonSatisfiedDescription,
      seating: entity.seating,
      nonSeatingType: entity.nonSeatingType,
      nonSeatingOtherNotes: entity.nonSeatingOtherNotes,
      mesialContacts: entity.mesialContacts,
      distalContacts: entity.distalContacts,
      occlusion: entity.occlusion,
      buccalContour: entity.buccalContour,
      passive: entity.passive,
      retention: entity.retention,
      occlusionNotes: entity.occlusionNotes,
      occlusalPlanAndMidline: entity.occlusalPlanAndMidline,
      centricRelation: entity.centricRelation,
      verticalDimension: entity.verticalDimension,
      lipSupport: entity.lipSupport,
      sizeAndShapeOfTeeth: entity.sizeAndShapeOfTeeth,
      canting: entity.canting,
      frontalSmilingAndLateralPhotos: entity.frontalSmilingAndLateralPhotos,
      evaluation: entity.evaluation,
      explainWhy: entity.explainWhy,
      operatorId: entity.operatorId,
      // ... add more properties as needed
    );
  }
}
