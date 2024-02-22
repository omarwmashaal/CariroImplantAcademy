import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:equatable/equatable.dart';

class ComplicationsAfterSurgeryEntity extends Equatable {
  int? id;
  int? patientId;
  PatientInfoEntity? patient;
  bool? swelling;
  bool? openWound;
  bool? numbness;
  bool? oroantralCommunication;
  bool? pusInImplantSite;
  bool? pusInDonorSite;
  bool? sinusElevationFailure;
  bool? gbrFailure;
  DateTime? date;
  int? tooth;
  String? name;
  String? notes;
  int? operatorId;
  BasicNameIdObjectEntity? operator;

  ComplicationsAfterSurgeryEntity({
    this.id,
    this.patientId,
    this.tooth,
    this.patient,
    this.swelling,
    this.date,
    this.openWound,
    this.numbness,
    this.oroantralCommunication,
    this.pusInImplantSite,
    this.pusInDonorSite,
    this.sinusElevationFailure,
    this.gbrFailure,
    this.name,
    this.notes,
    this.operator,
    this.operatorId,
  });

  @override
  List<Object?> get props => [
        id,
        patientId,
        patient,
        swelling,
        openWound,
        numbness,
        oroantralCommunication,
        pusInImplantSite,
        pusInDonorSite,
        sinusElevationFailure,
        tooth,
        gbrFailure,
        date,
        name,
        notes,
        operator,
        operatorId,
      ];

  bool isNull() =>
      swelling == null &&
      openWound == null &&
      numbness == null &&
      oroantralCommunication == null &&
      pusInImplantSite == null &&
      pusInDonorSite == null &&
      sinusElevationFailure == null &&
      gbrFailure == null;
}
