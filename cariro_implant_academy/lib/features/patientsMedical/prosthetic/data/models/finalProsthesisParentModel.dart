import 'dart:convert';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';

import '../../domain/entities/finalProsthesisParentEntity.dart';

class FinalProthesisModel extends FinalProthesisParentEntity {
  FinalProthesisModel({
    super.id,
    super.patientId,
    super.patient,
    super.searchTeethClassification,
    super.website,
    super.finalProthesisTeeth,
  }) ;

  factory FinalProthesisModel.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return FinalProthesisModel.fromMap(map);
  }

  factory FinalProthesisModel.fromMap(Map<String, dynamic> map) {
    return FinalProthesisModel(
      id: map['id'],
      patientId: map['patientId'],
      patient: map['patient'] != null ? BasicNameIdObjectModel.fromJson(map['patient']) : null,
      searchTeethClassification: map['searchTeethClassification'],
      website: Website.values.firstWhere(
            (e) => e.toString() == 'EnumWebsite.' + map['website'],
      ),
      finalProthesisTeeth: List<int>.from(map['finalProthesisTeeth']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
     // 'patient': pat
      'searchTeethClassification': searchTeethClassification,
     // 'website': website.toString().split('.').last,
      'finalProthesisTeeth': finalProthesisTeeth,
    };
  }

  static FinalProthesisModel fromEntity(FinalProthesisParentEntity entity) {
    return FinalProthesisModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      searchTeethClassification: entity.searchTeethClassification,
      website: entity.website,
      finalProthesisTeeth: entity.finalProthesisTeeth,
    );
  }
}
