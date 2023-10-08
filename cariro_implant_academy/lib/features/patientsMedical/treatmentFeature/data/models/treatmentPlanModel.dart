import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/teethTreatmentPlanModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';

class TreatmentPlanModel extends TreatmentPlanEntity {
  TreatmentPlanModel({
    id,
    patientId,
    operatorId,
    operator,
    date,
    treatmentPlan,
  }) : super(
          id: id,
          patientId: patientId,
          operatorId: operatorId,
          operator: operator,
          date: date,
          treatmentPlan: treatmentPlan,
        );

  factory TreatmentPlanModel.fromEntity(TreatmentPlanEntity entity)
  {
    return TreatmentPlanModel(
      id: entity.id,
      patientId: entity.patientId,
      operatorId: entity.operatorId,
      operator:entity. operator,
      date: entity.date,
      treatmentPlan: entity.treatmentPlan,
    );
  }
  TreatmentPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    operatorId = json['operatorId'];
    operator = json['operator'] != null ? new BasicNameIdObjectModel.fromJson(json['operator']) : null;
    date = DateTime.tryParse(json['date']??"")?.toLocal();
    treatmentPlan = ((json['treatmentPlan'] ?? []) as List<dynamic>).map((e) => TeethTreatmentPlanModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    // data['operatorId'] = this.operatorId;
    if (this.operator != null) {
      //data['operator'] = this.operator!.toJson();
    }
    data['date'] = this.date==null?null:this.date!.toUtc().toIso8601String();
    data['treatmentPlan'] = (this.treatmentPlan ?? <TeethTreatmentPlanModel>[]).map((e) => (TeethTreatmentPlanModel.fromEntity(e)).toJson()).toList();
    return data;
  }

}
