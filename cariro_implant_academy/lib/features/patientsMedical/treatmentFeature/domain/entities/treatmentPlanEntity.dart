import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class TreatmentPlanEntity extends Equatable {
  int? id;
  int? patientId;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  bool clearanceUpper;
  bool clearanceLower;
  BasicNameIdObjectEntity? doctor;
  DateTime? date;

  TreatmentPlanEntity({
    this.id,
    this.patientId,
    this.operatorId,
    this.operator,
    this.date,
    this.doctor,
    this.clearanceLower = false,
    this.clearanceUpper = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        patientId,
        operatorId,
        operator,
        date,
        doctor,
      ];
}
