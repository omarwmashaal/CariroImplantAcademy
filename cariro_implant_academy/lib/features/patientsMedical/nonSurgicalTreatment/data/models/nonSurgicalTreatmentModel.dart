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
    id,
    nextVisit,
    treatment,
    patientId,
  }) : super(
          date: date,
          operator: operator,
          nextVisit: nextVisit,
          operatorID: operatorID,
          supervisor: supervisor,
          supervisorID: supervisorID,
          id: id,
          treatment: treatment,
          patientId: patientId,
        );

  Map<String, dynamic> toMap() {
    return {
      'treatment': this.treatment,
      'id': this.id,
      //'id': this.id,
      'supervisorID': this.supervisorID,
      //'supervisor': this.supervisor,
      'operatorID': this.operatorID,
      'patientId': this.patientId,
      'date': this.date == null ? null : this.date!.toUtc().toIso8601String(),
      //  'operator': this.operator==null?null:BasicNameIdObjectModel.fromEntity(this.operator!).toMap(),
      'nextVisit': this.nextVisit == null ? null : this.nextVisit!.toUtc().toIso8601String(),
      // 'nextVisit': this.nextVisit,
    };
  }

  factory NonSurgicalTreatmentModel.fromMap(Map<String, dynamic> map) {
    return NonSurgicalTreatmentModel(
      treatment: map['treatment'] as String?,
      supervisorID: map['supervisorID'] as int?,
      patientId: map['patientId'] as int?,
      id: map['id'] as int?,
      supervisor: map['supervisor'] == null ? null : BasicNameIdObjectModel.fromJson(map['supervisor']),
      operatorID: map['operatorID'] as int?,
      operator: map['operator'] == null ? null : BasicNameIdObjectModel.fromJson(map['operator']),
      date: map['date'] == null ? null : DateTime.parse(map['date']),
      nextVisit: DateTime.tryParse(map['nextVisit'] ?? "")?.toLocal(),
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
      patientId: entity.patientId,
      id: entity.id,
    );
  }
}
