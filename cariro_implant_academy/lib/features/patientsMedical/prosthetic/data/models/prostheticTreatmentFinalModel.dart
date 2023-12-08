import 'dart:convert';

import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisDeliveryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisHeallingCollarModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisImporessionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisTryInModel.dart';

import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/entities/finalProsthesisDeliveryEntity.dart';
import '../../domain/entities/finalProsthesisHealingCollarEntity.dart';
import '../../domain/entities/finalProsthesisImpressionEntity.dart';
import '../../domain/entities/finalProsthesisTryInEntity.dart';
import '../../domain/entities/prostheticTreatmentFinalEntity.dart';

class ProstheticTreatmentFinalModel extends ProstheticTreatmentFinalEntity {
  ProstheticTreatmentFinalModel({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    List<FinalProthesisHealingCollarEntity>? healingCollars,
    List<FinalProthesisImpressionEntity>? impressions,
    List<FinalProthesisTryInEntity>? tryIns,
    List<FinalProthesisDeliveryEntity>? delivery,
  }) : super(
          id: id,
          patientId: patientId,
          patient: patient,
          healingCollars: healingCollars,
          impressions: impressions,
          tryIns: tryIns,
          delivery: delivery,
        );

  factory ProstheticTreatmentFinalModel.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return ProstheticTreatmentFinalModel.fromMap(map);
  }

  factory ProstheticTreatmentFinalModel.fromMap(Map<String, dynamic> map) {
    return ProstheticTreatmentFinalModel(
      id: map['id'],
      patientId: map['patientId'],
      patient: map['patient'] != null ? BasicNameIdObjectModel.fromJson(map['patient']) : null,
      healingCollars: (map['healingCollars'] as List<dynamic>?)?.map((e) => FinalProthesisHealingCollarModel.fromMap(e)).toList(),
      impressions: (map['impressions'] as List<dynamic>?)?.map((e) => FinalProthesisImpressionModel.fromMap(e)).toList(),
      tryIns: (map['tryIns'] as List<dynamic>?)?.map((e) => FinalProthesisTryInModel.fromMap(e)).toList(),
      delivery: (map['delivery'] as List<dynamic>?)?.map((e) => FinalProthesisDeliveryModel.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'patientId': super.patientId,
      //'patient': super.patient?.toMap(),
      'healingCollars': super.healingCollars?.map((e) => FinalProthesisHealingCollarModel.fromEntity(e).toJson()).toList(),
      'impressions': super.impressions?.map((e) =>  FinalProthesisImpressionModel.fromEntity(e).toJson()).toList(),
      'tryIns': super.tryIns?.map((e) =>  FinalProthesisTryInModel.fromEntity(e).toJson()).toList(),
      'delivery': super.delivery?.map((e) => FinalProthesisDeliveryModel.fromEntity(e).toJson()).toList(),
    };
  }

  static ProstheticTreatmentFinalModel fromEntity(ProstheticTreatmentFinalEntity entity) {
    return ProstheticTreatmentFinalModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      healingCollars: entity.healingCollars,
      impressions: entity.impressions,
      tryIns: entity.tryIns,
      delivery: entity.delivery,
    );
  }
}
