import 'dart:convert';

import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/data/models/BasicNameIdObjectModel.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/entities/finalProsthesisHealingCollarEntity.dart';

class FinalProthesisHealingCollarModel extends FinalProthesisHealingCollarEntity {
  FinalProthesisHealingCollarModel({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    int? operatorId,
    BasicNameIdObjectEntity? operator,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    EnumFinalProthesisHealingCollarStatus? finalProthesisHealingCollarStatus,
    EnumFinalProthesisHealingCollarNextVisit? finalProthesisHealingCollarNextVisit,
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
          finalProthesisHealingCollarStatus: finalProthesisHealingCollarStatus,
          finalProthesisHealingCollarNextVisit: finalProthesisHealingCollarNextVisit,
    date: date,
        );

  factory FinalProthesisHealingCollarModel.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return FinalProthesisHealingCollarModel.fromMap(map);
  }

  factory FinalProthesisHealingCollarModel.fromMap(Map<String, dynamic> map) {
    return FinalProthesisHealingCollarModel(
      id: map['id'],
      patientId: map['patientId'],
      operatorId: map['operatorId'],
      operator: map['operatorDTO']==null?null:BasicNameIdObjectModel.fromJson(map['operatorDTO']),
      patient: map['patient'] != null ? BasicNameIdObjectModel.fromJson(map['patient']) : null,
      searchTeethClassification: map['searchTeethClassification'],
      finalProthesisTeeth: map['finalProthesisTeeth'] == null
          ? null
          : List<int>.from((map['finalProthesisTeeth'] as List<dynamic>).map((e) => e as int)),

      // website: Website.values[],
      finalProthesisHealingCollarStatus:
      map['finalProthesisHealingCollarStatus'] != null
          ? EnumFinalProthesisHealingCollarStatus.values[map['finalProthesisHealingCollarStatus']]
          : null,
      finalProthesisHealingCollarNextVisit:
      map['finalProthesisHealingCollarNextVisit'] != null
          ? EnumFinalProthesisHealingCollarNextVisit.values[map['finalProthesisHealingCollarNextVisit']]
          : null,
      date: map['date'] !=
          null
          ? DateTime.tryParse(map['date']??"")?.toLocal()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'patientId': super.patientId,
      'operatorId': operatorId,
    //  'patient': super.patient?.toJson(),
      'searchTeethClassification': super.searchTeethClassification,
     // 'website': super.website.toString().split('.').last,
      'finalProthesisTeeth': super.finalProthesisTeeth,
      'finalProthesisHealingCollarStatus': super.finalProthesisHealingCollarStatus?.index,
      'finalProthesisHealingCollarNextVisit': super.finalProthesisHealingCollarNextVisit?.index,
      'date': super.date?.toUtc().toIso8601String(),
    };
  }

  static FinalProthesisHealingCollarModel fromEntity(FinalProthesisHealingCollarEntity entity) {
    return FinalProthesisHealingCollarModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      searchTeethClassification: entity.searchTeethClassification,
      website: entity.website,
      finalProthesisTeeth: entity.finalProthesisTeeth,
      finalProthesisHealingCollarStatus: entity.finalProthesisHealingCollarStatus,
      finalProthesisHealingCollarNextVisit: entity.finalProthesisHealingCollarNextVisit,
      date: entity.date,
      operatorId: entity.operatorId,
    );
  }
}
