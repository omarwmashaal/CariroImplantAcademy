import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';

class TreatmentPlanModel extends TreatmentPlanEntity {
  TreatmentPlanModel({
    id,
    patientId,
    operatorId,
    operator,
    date,
    doctor,
    clearanceUpper,
    clearanceLower,
    treatmentPlan,
  }) : super(
          id: id,
          patientId: patientId,
          operatorId: operatorId,
          operator: operator,
          date: date,
          clearanceUpper: clearanceUpper,
          clearanceLower: clearanceLower,
    doctor: doctor,
        );

  factory TreatmentPlanModel.fromEntity(TreatmentPlanEntity entity)
  {
    return TreatmentPlanModel(
      id: entity.id,
      patientId: entity.patientId,
      operatorId: entity.operatorId,
      operator:entity. operator,
      date: entity.date,
      doctor: entity.doctor,
      clearanceUpper: entity.clearanceUpper,
      clearanceLower: entity.clearanceLower,
    );
  }
  TreatmentPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    operatorId = json['operatorId'];
    clearanceUpper = json['clearanceUpper'];
    clearanceLower = json['clearanceLower'];
    doctor = json['doctor']==null?null:BasicNameIdObjectModel.fromJson(json['doctor'] as Map<String,dynamic>);
    operator = json['operator'] != null ? new BasicNameIdObjectModel.fromJson(json['operator']) : null;
    date = DateTime.tryParse(json['date']??"")?.toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clearanceLower'] = this.clearanceLower;
    data['clearanceUpper'] = this.clearanceUpper;
    data['patientId'] = this.patientId;
    // data['operatorId'] = this.operatorId;
    if (this.operator != null) {
      //data['operator'] = this.operator!.toJson();
    }
    data['date'] = this.date==null?null:this.date!.toUtc().toIso8601String();
    return data;
  }

}
