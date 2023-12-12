import 'dart:convert';

import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/data/models/BasicNameIdObjectModel.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/entities/finalProsthesisImpressionEntity.dart';

class FinalProthesisImpressionModel extends FinalProthesisImpressionEntity {
  FinalProthesisImpressionModel({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    int? operatorId,
    BasicNameIdObjectEntity? operator,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    bool? finalProthesisImpression,
    EnumFinalProthesisImpressionStatus? finalProthesisImpressionStatus,
    EnumFinalProthesisImpressionNextVisit? finalProthesisImpressionNextVisit,
    DateTime? finalProthesisImpressionDate,
  }) : super(
          id: id,
          patientId: patientId,
          patient: patient,
          searchTeethClassification: searchTeethClassification,
          website: website,
    operator: operator,
    operatorId: operatorId,
          finalProthesisTeeth: finalProthesisTeeth,
          finalProthesisImpression: finalProthesisImpression,
          finalProthesisImpressionStatus: finalProthesisImpressionStatus,
          finalProthesisImpressionNextVisit: finalProthesisImpressionNextVisit,
          finalProthesisImpressionDate: finalProthesisImpressionDate,
        );

  factory FinalProthesisImpressionModel.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return FinalProthesisImpressionModel.fromMap(map);
  }

  factory FinalProthesisImpressionModel.fromMap(Map<String, dynamic> map) {
    return FinalProthesisImpressionModel(
      id: map['id'],
      patientId: map['patientId'],
      operatorId: map['operatorId'],
      operator: map['operatorDTO']==null?null:BasicNameIdObjectModel.fromJson(map['operatorDTO']),
      patient: map['patient'] != null
          ? BasicNameIdObjectModel.fromJson(map['patient'])
          : null,
      searchTeethClassification: map['searchTeethClassification'],
      finalProthesisTeeth: map['finalProthesisTeeth'] == null
          ? null
          : (map['finalProthesisTeeth'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      finalProthesisImpression: map['finalProthesisImpression'],
      finalProthesisImpressionStatus:
      map['finalProthesisImpressionStatus'] != null
          ? EnumFinalProthesisImpressionStatus.values[map['finalProthesisImpressionStatus']]
          : null,
      finalProthesisImpressionNextVisit:
      map['finalProthesisImpressionNextVisit'] != null
          ? EnumFinalProthesisImpressionNextVisit.values[map['finalProthesisImpressionNextVisit']]
          : null,
      finalProthesisImpressionDate: DateTime.tryParse(map['finalProthesisImpressionDate'] ?? "")?.toLocal(),
      // ... add more properties as needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'patientId': super.patientId,
      'operatorId': operatorId,
     // 'patient': super.patient?.toJson(),
      'searchTeethClassification': super.searchTeethClassification,
      //'website': super.website.toString().split('.').last,
      'finalProthesisTeeth': super.finalProthesisTeeth,
      'finalProthesisImpression': super.finalProthesisImpression,
      'finalProthesisImpressionStatus': super.finalProthesisImpressionStatus?.index,
      'finalProthesisImpressionNextVisit': super.finalProthesisImpressionNextVisit?.index,
      'finalProthesisImpressionDate': super.finalProthesisImpressionDate?.toUtc().toIso8601String(),
    };
  }

  static FinalProthesisImpressionModel fromEntity(FinalProthesisImpressionEntity entity) {
    return FinalProthesisImpressionModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      searchTeethClassification: entity.searchTeethClassification,
      website: entity.website,
      finalProthesisTeeth: entity.finalProthesisTeeth,
      finalProthesisImpression: entity.finalProthesisImpression,
      finalProthesisImpressionStatus: entity.finalProthesisImpressionStatus,
      finalProthesisImpressionNextVisit: entity.finalProthesisImpressionNextVisit,
      finalProthesisImpressionDate: entity.finalProthesisImpressionDate,
      operatorId: entity.operatorId,
    );
  }
}
