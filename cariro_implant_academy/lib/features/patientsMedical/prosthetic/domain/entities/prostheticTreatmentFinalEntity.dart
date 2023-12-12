import 'package:equatable/equatable.dart';

import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'finalProsthesisDeliveryEntity.dart';
import 'finalProsthesisHealingCollarEntity.dart';
import 'finalProsthesisImpressionEntity.dart';
import 'finalProsthesisTryInEntity.dart';

class ProstheticTreatmentFinalEntity extends Equatable {
  int? id;
  int? patientId;
  DateTime? date;
  BasicNameIdObjectEntity? patient;
  List<FinalProthesisHealingCollarEntity>? healingCollars;
  List<FinalProthesisImpressionEntity>? impressions;
  List<FinalProthesisTryInEntity>? tryIns;
  List<FinalProthesisDeliveryEntity>? delivery;

  ProstheticTreatmentFinalEntity({
    this.id,
    this.date,
    this.patientId,
    this.patient,
    this.healingCollars,
    this.impressions,
    this.tryIns,
    this.delivery,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    patientId,
    patient,
    healingCollars,
    impressions,
    tryIns,
    delivery,
  ];
}
