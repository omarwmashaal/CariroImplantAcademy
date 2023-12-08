import 'dart:convert';

import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/data/models/BasicNameIdObjectModel.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/entities/finalProsthesisTryInEntity.dart';

class FinalProthesisTryInModel extends FinalProthesisTryInEntity {
  FinalProthesisTryInModel({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    bool? finalProthesisTryIn,
    EnumFinalProthesisTryInStatus? finalProthesisTryInStatus,
    EnumFinalProthesisTryInNextVisit? finalProthesisTryInNextVisit,
    DateTime? finalProthesisTryInDate,
  }) : super(
    id: id,
    patientId: patientId,
    patient: patient,
    searchTeethClassification: searchTeethClassification,
    website: website,
    finalProthesisTeeth: finalProthesisTeeth,
    finalProthesisTryIn: finalProthesisTryIn,
    finalProthesisTryInStatus: finalProthesisTryInStatus,
    finalProthesisTryInNextVisit: finalProthesisTryInNextVisit,
    finalProthesisTryInDate: finalProthesisTryInDate,
  );

  factory FinalProthesisTryInModel.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return FinalProthesisTryInModel.fromMap(map);
  }

  factory FinalProthesisTryInModel.fromMap(Map<String, dynamic> map) {
    return FinalProthesisTryInModel(
      id: map['id'],
      patientId: map['patientId'],
      patient: map['patient'] != null
          ? BasicNameIdObjectModel.fromJson(map['patient'])
          : null,
      searchTeethClassification: map['searchTeethClassification'],
      finalProthesisTeeth: map['finalProthesisTeeth'] == null
          ? null
          : (map['finalProthesisTeeth'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      finalProthesisTryIn: map['finalProthesisTryIn'],
      finalProthesisTryInStatus:
      map['finalProthesisTryInStatus'] != null
          ? EnumFinalProthesisTryInStatus.values[map['finalProthesisTryInStatus']]
          : null,
      finalProthesisTryInNextVisit:
      map['finalProthesisTryInNextVisit'] != null
          ? EnumFinalProthesisTryInNextVisit.values[map['finalProthesisTryInNextVisit']]
          : null,
      finalProthesisTryInDate: DateTime.tryParse(map['finalProthesisTryInDate'] ?? "")?.toLocal(),
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
      'finalProthesisTryIn': super.finalProthesisTryIn,
      'finalProthesisTryInStatus': super.finalProthesisTryInStatus?.index,
      'finalProthesisTryInNextVisit': super.finalProthesisTryInNextVisit?.index,
      'finalProthesisTryInDate': super.finalProthesisTryInDate?.toUtc().toIso8601String(),
    };
  }

  static FinalProthesisTryInModel fromEntity(
      FinalProthesisTryInEntity entity) {
    return FinalProthesisTryInModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      searchTeethClassification: entity.searchTeethClassification,
      website: entity.website,
      finalProthesisTeeth: entity.finalProthesisTeeth,
      finalProthesisTryIn: entity.finalProthesisTryIn,
      finalProthesisTryInStatus: entity.finalProthesisTryInStatus,
      finalProthesisTryInNextVisit: entity.finalProthesisTryInNextVisit,
      finalProthesisTryInDate: entity.finalProthesisTryInDate,
    );
  }
}
