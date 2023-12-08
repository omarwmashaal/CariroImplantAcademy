import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class ScalingEntity extends Equatable {
  int? id;
  int? patientId;
  int? tooth;
  String? notes;
  EnumClinicScalingType? type;
  bool? done;
  DateTime? date;
  int? assistantId;
  BasicNameIdObjectEntity? assistant;
  int? doctorId;
  BasicNameIdObjectEntity? doctor;
  int? stepNumber;
  int? price;
  int? clinicReceiptModelId;

  @override
  List<Object?> get props => [
        this.id,
        this.patientId,
        this.tooth,
        this.notes,
        this.type,
        this.date,
        this.done,
        this.assistant,
        this.assistantId,
        this.doctor,
        this.doctorId,
        this.stepNumber,
    this.price,
    this.clinicReceiptModelId,
      ];

  ScalingEntity({
    this.id,
    this.patientId,
    this.tooth,
    this.notes,
    this.type,
    this.date,
    this.done,
    this.assistant,
    this.assistantId,
    this.doctor,
    this.doctorId,
    this.stepNumber,
    this.price,
    this.clinicReceiptModelId,
  });
}
