import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';

class RestorationEntity extends Equatable {
  int? id;
  int? patientId;
  int? tooth;
  EnumClinicRestorationType? type;
  EnumClinicRestorationStatus? status;
  EnumClinicRestorationClass? restorationClass;
  bool? done;
  DateTime? date;
  int? assistantId;
  BasicNameIdObjectEntity? assistant;
  int? doctorId;
  BasicNameIdObjectEntity? doctor;

  RestorationEntity({
    this.id,
    this.patientId,
    this.status,
    this.type,
    this.tooth,
    this.restorationClass,
    this.date,
    this.done,
    this.assistant,
    this.assistantId,
    this.doctor,
    this.doctorId,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.patientId,
        this.status,
        this.type,
        this.tooth,
        this.restorationClass,
    this.date,
    this.done,
    this.assistant,
    this.assistantId,
    this.doctor,
    this.doctorId,
      ];
}
