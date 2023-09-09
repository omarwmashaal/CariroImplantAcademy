import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:equatable/equatable.dart';

class TreatmentPlanEntity extends Equatable {
  int? id;
  int? patientId;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  DateTime? date;
  List<TeethTreatmentPlanEntity>? treatmentPlan;

  TreatmentPlanEntity({
    this.id,
    this.patientId,
    this.operatorId,
    this.operator,
    this.date,
    this.treatmentPlan,
  });



  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        patientId,
        operatorId,
        operator,
        date,
        treatmentPlan,
      ];
}
