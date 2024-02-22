import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:equatable/equatable.dart';

class ComplicationsAfterProsthesisEntity extends Equatable {
  int? id;
  int? patientId;
  PatientInfoEntity? patient;
  bool? screwLoosness;
  bool? crownFall;
  bool? fracturedZirconia;
  bool? fracturedPrintedPMMA;
  bool? foodImpaction;
  bool? pain;
  DateTime? date;
  int? tooth;
  String? name;
  String? notes;
  int? operatorId;
  BasicNameIdObjectEntity? operator;

  ComplicationsAfterProsthesisEntity({
    this.id,
    this.patientId,
    this.patient,
    this.screwLoosness,
    this.crownFall,
    this.fracturedZirconia,
    this.fracturedPrintedPMMA,
    this.foodImpaction,
    this.pain,
    this.date,
    this.name,
    this.notes,
    this.operator,
    this.operatorId,
    this.tooth,
  });

  @override
  List<Object?> get props => [
        id,
        patientId,
        patient,
        screwLoosness,
        crownFall,
        fracturedZirconia,
        fracturedPrintedPMMA,
        foodImpaction,
        date,
        pain,
        name,
        notes,
        operator,
        operatorId,
        tooth,
      ];

  bool isNull() =>
      screwLoosness == null &&
      crownFall == null &&
      fracturedPrintedPMMA == null &&
      fracturedZirconia == null &&
      foodImpaction == null &&
      pain == null;
}
