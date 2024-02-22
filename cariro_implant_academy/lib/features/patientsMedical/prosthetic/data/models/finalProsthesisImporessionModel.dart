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
    EnumFinalProthesisImpressionStatus? finalProthesisImpressionStatus,
    EnumFinalProthesisImpressionNextVisit? finalProthesisImpressionNextVisit,
    DateTime? date,
  }) : super(
          id: id,
          patientId: patientId,
          patient: patient,
          searchTeethClassification: searchTeethClassification,
          website: website,
          operator: operator,
          operatorId: operatorId,
          finalProthesisTeeth: finalProthesisTeeth,
          finalProthesisImpressionStatus: finalProthesisImpressionStatus,
          finalProthesisImpressionNextVisit: finalProthesisImpressionNextVisit,
          date: date,
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
      operator: map['operatorDTO'] == null ? null : BasicNameIdObjectModel.fromJson(map['operatorDTO']),
      patient: map['patient'] != null ? BasicNameIdObjectModel.fromJson(map['patient']) : null,
      searchTeethClassification: map['searchTeethClassification'],
      finalProthesisTeeth: map['finalProthesisTeeth'] == null ? null : (map['finalProthesisTeeth'] as List<dynamic>).map((e) => e as int).toList(),
      finalProthesisImpressionStatus:
          map['finalProthesisImpressionStatus'] != null ? EnumFinalProthesisImpressionStatus.values[map['finalProthesisImpressionStatus']] : null,
      finalProthesisImpressionNextVisit:
          map['finalProthesisImpressionNextVisit'] != null ? EnumFinalProthesisImpressionNextVisit.values[map['finalProthesisImpressionNextVisit']] : null,
      date: DateTime.tryParse(map['date'] ?? "")?.toLocal(),
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
      'finalProthesisImpressionStatus': super.finalProthesisImpressionStatus?.index,
      'finalProthesisImpressionNextVisit': super.finalProthesisImpressionNextVisit?.index,
      'date': super.date?.toUtc().toIso8601String(),
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
      finalProthesisImpressionStatus: entity.finalProthesisImpressionStatus,
      finalProthesisImpressionNextVisit: entity.finalProthesisImpressionNextVisit,
      date: entity.date,
      operatorId: entity.operatorId,
    );
  }
}
