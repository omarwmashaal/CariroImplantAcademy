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
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    bool? finalProthesisHealingCollar,
    EnumFinalProthesisHealingCollarStatus? finalProthesisHealingCollarStatus,
    EnumFinalProthesisHealingCollarNextVisit? finalProthesisHealingCollarNextVisit,
    DateTime? finalProthesisHealingCollarDate,
  }) : super(
          id: id,
          patientId: patientId,
          patient: patient,
          searchTeethClassification: searchTeethClassification,
          website: website,
          finalProthesisTeeth: finalProthesisTeeth,
          finalProthesisHealingCollar: finalProthesisHealingCollar,
          finalProthesisHealingCollarStatus: finalProthesisHealingCollarStatus,
          finalProthesisHealingCollarNextVisit: finalProthesisHealingCollarNextVisit,
          finalProthesisHealingCollarDate: finalProthesisHealingCollarDate,
        );

  factory FinalProthesisHealingCollarModel.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return FinalProthesisHealingCollarModel.fromMap(map);
  }

  factory FinalProthesisHealingCollarModel.fromMap(Map<String, dynamic> map) {
    return FinalProthesisHealingCollarModel(
      id: map['id'],
      patientId: map['patientId'],
      patient: map['patient'] != null ? BasicNameIdObjectModel.fromJson(map['patient']) : null,
      searchTeethClassification: map['searchTeethClassification'],
      finalProthesisTeeth: map['finalProthesisTeeth'] == null
          ? null
          : List<int>.from((map['finalProthesisTeeth'] as List<dynamic>).map((e) => e as int)),

      // website: Website.values[],
      finalProthesisHealingCollar: map['finalProthesisHealingCollar'],
      finalProthesisHealingCollarStatus:
      map['finalProthesisHealingCollarStatus'] != null
          ? EnumFinalProthesisHealingCollarStatus.values[map['finalProthesisHealingCollarStatus']]
          : null,
      finalProthesisHealingCollarNextVisit:
      map['finalProthesisHealingCollarNextVisit'] != null
          ? EnumFinalProthesisHealingCollarNextVisit.values[map['finalProthesisHealingCollarNextVisit']]
          : null,
      finalProthesisHealingCollarDate: map['finalProthesisHealingCollarDate'] !=
          null
          ? DateTime.tryParse(map['finalProthesisHealingCollarDate']??"")?.toLocal()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'patientId': super.patientId,
    //  'patient': super.patient?.toJson(),
      'searchTeethClassification': super.searchTeethClassification,
     // 'website': super.website.toString().split('.').last,
      'finalProthesisTeeth': super.finalProthesisTeeth,
      'finalProthesisHealingCollar': super.finalProthesisHealingCollar,
      'finalProthesisHealingCollarStatus': super.finalProthesisHealingCollarStatus?.index,
      'finalProthesisHealingCollarNextVisit': super.finalProthesisHealingCollarNextVisit?.index,
      'finalProthesisHealingCollarDate': super.finalProthesisHealingCollarDate?.toUtc().toIso8601String(),
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
      finalProthesisHealingCollar: entity.finalProthesisHealingCollar,
      finalProthesisHealingCollarStatus: entity.finalProthesisHealingCollarStatus,
      finalProthesisHealingCollarNextVisit: entity.finalProthesisHealingCollarNextVisit,
      finalProthesisHealingCollarDate: entity.finalProthesisHealingCollarDate,
    );
  }
}
