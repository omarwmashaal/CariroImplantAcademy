import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:intl/intl.dart';

import '../../../../../Helpers/CIA_DateConverters.dart';

class NonSurgicalTreatmentModel extends NonSurgicalTreatmentEntity {
  NonSurgicalTreatmentModel({
    supervisorID,
    supervisor,
    operator,
    operatorID,
    date,
    nextVisit,
    treatment,
  }) : super(
          date: date,
          operator: operator,
          nextVisit: nextVisit,
          operatorID: operatorID,
          supervisor: supervisor,
          supervisorID: supervisorID,
          treatment: treatment,
        );

  Map<String, dynamic> toMap() {
    return {
      'treatment': this.treatment,
      'supervisorID': this.supervisorID,
      //'supervisor': this.supervisor,
      'operatorID': this.operatorID,
      'date': this.date==null?null:this.date!.toUtc().toIso8601String(),
    //  'operator': this.operator==null?null:BasicNameIdObjectModel.fromEntity(this.operator!).toMap(),
     'nextVisit':this.nextVisit==null?null:this.nextVisit!.toUtc().toIso8601String(),
     // 'nextVisit': this.nextVisit,
    };
  }

  factory NonSurgicalTreatmentModel.fromMap(Map<String, dynamic> map) {
    return NonSurgicalTreatmentModel(
      treatment: map['treatment'] as String?,
      supervisorID: map['supervisorID'] as int?,
      supervisor: map['supervisor'] == null ? null : BasicNameIdObjectModel.fromJson(map['supervisor']),
      operatorID: map['operatorID'] as int?,
      operator: map['operator'] == null ? null : BasicNameIdObjectModel.fromJson(map['operator']),
      date:map['date']==null?null: DateTime.parse(map['date']),
      nextVisit: map['nextVisit'] as String?,
    );
  }

  factory NonSurgicalTreatmentModel.fromEntity(NonSurgicalTreatmentEntity entity) {
    return NonSurgicalTreatmentModel(
      date: entity.date,
      operator: entity.operator,
      nextVisit: entity.nextVisit,
      operatorID: entity.operatorID,
      supervisor: entity.supervisor,
      supervisorID: entity.supervisorID,
      treatment: entity.treatment,
    );
  }
}
