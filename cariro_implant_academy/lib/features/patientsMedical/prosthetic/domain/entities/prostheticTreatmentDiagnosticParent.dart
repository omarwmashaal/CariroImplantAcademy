import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class ProstheticTreatmentDiagnosticParent  extends Equatable{
  int? id;
  int? prostheticTreatmentId;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  DateTime? date;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  bool? needsRemake;

  ProstheticTreatmentDiagnosticParent({
    this.date,
    this.id,
    this.needsRemake,
    this.operator,
    this.operatorId,
    this.patient,
    this.patientId,
    this.prostheticTreatmentId,
  }) {
    if (operator == null) operator = BasicNameIdObjectEntity();
  }

  /*fromJson(Map<String, dynamic> json) {
    this.date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    this.id = json['id'];
    this.needsRemake = json['needsRemake'] ?? false;
    this.operator = BasicNameIdObjectEntity.fromJson(json['operator'] ?? Map<String, dynamic>());
    this.operatorId = json['operatorId'];
    this.patientId = json['patientId'];
    this.prostheticTreatmentId = json['prostheticTreatmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = CIA_DateConverters.fromDateTimeToBackend(this.date);
    data['id'] = this.id;
    data['needsRemake'] = this.needsRemake ?? false;
    data['patientId'] = this.patientId;
    data['operatorId'] = this.operatorId;
    data['prostheticTreatmentId'] = this.prostheticTreatmentId;
    return data;
  }
*/
  @override
  // TODO: implement props
  List<Object?> get props => [
    date,
    id,
    needsRemake,
    operator,
    operatorId,
    patient,
    patientId,
    prostheticTreatmentId,];
}