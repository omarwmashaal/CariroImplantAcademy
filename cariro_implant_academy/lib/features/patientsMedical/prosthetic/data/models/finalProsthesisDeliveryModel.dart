import 'dart:convert';

import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/entities/finalProsthesisDeliveryEntity.dart';

class FinalProthesisDeliveryModel extends FinalProthesisDeliveryEntity {
  FinalProthesisDeliveryModel({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    int? operatorId,
    BasicNameIdObjectEntity? operator,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    EnumFinalProthesisDeliveryStatus? finalProthesisDeliveryStatus,
    EnumFinalProthesisDeliveryNextVisit? finalProthesisDeliveryNextVisit,
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
          finalProthesisDeliveryStatus: finalProthesisDeliveryStatus,
          finalProthesisDeliveryNextVisit: finalProthesisDeliveryNextVisit,
          date: date,
        );

  factory FinalProthesisDeliveryModel.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return FinalProthesisDeliveryModel.fromMap(map);
  }

  factory FinalProthesisDeliveryModel.fromMap(Map<String, dynamic> map) {
    return FinalProthesisDeliveryModel(
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
      finalProthesisDeliveryStatus:
      map['finalProthesisDeliveryStatus'] != null
          ? EnumFinalProthesisDeliveryStatus.values[map['finalProthesisDeliveryStatus']]
          : null,
      finalProthesisDeliveryNextVisit:
      map['finalProthesisDeliveryNextVisit'] != null
          ? EnumFinalProthesisDeliveryNextVisit.values[map['finalProthesisDeliveryNextVisit']]
          : null,
      date: DateTime.tryParse(map['date'] ?? "")?.toLocal(),
      // ... add more properties as needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'patientId': super.patientId,
      //'patient': super.patient?.toMap(),
      'searchTeethClassification': super.searchTeethClassification,
      //'website': super.website.toString().split('.').last,
      'finalProthesisTeeth': super.finalProthesisTeeth,
      'operatorId': operatorId,
      'finalProthesisDeliveryStatus': super.finalProthesisDeliveryStatus?.index,
      'finalProthesisDeliveryNextVisit': super.finalProthesisDeliveryNextVisit?.index,
      'date': super.date?.toUtc().toIso8601String(),
    };
  }

  static FinalProthesisDeliveryModel fromEntity(FinalProthesisDeliveryEntity entity) {
    return FinalProthesisDeliveryModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      searchTeethClassification: entity.searchTeethClassification,
      website: entity.website,
      finalProthesisTeeth: entity.finalProthesisTeeth,
      finalProthesisDeliveryStatus: entity.finalProthesisDeliveryStatus,
      finalProthesisDeliveryNextVisit: entity.finalProthesisDeliveryNextVisit,
      date: entity.date,
      operatorId: entity.operatorId,
    );
  }
}
