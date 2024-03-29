import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class PedoEntity extends Equatable {
  int? id;
  int? patientId;
  int? tooth;
  String? notes;
  EnumClinicPedoFirstStep? firstStep;
  EnumClinicPedoSecondStep? secondStep;
  bool? done;
  DateTime? date;
  int? assistantId;
  BasicNameIdObjectEntity? assistant;
  int? doctorId;
  BasicNameIdObjectEntity? doctor;
  int? price;
  int? firstStepPrice;
  int? secondStepPrice;
  int? clinicReceiptModelId;

  @override
  List<Object?> get props => [
        this.id,
        this.patientId,
        this.tooth,
        this.notes,
        this.firstStep,
        this.secondStep,
    this.date,
    this.done,
    this.assistant,
    this.assistantId,
    this.doctor,
    this.doctorId,
    this.price,
    this.firstStepPrice,
    this.secondStepPrice,
    this.clinicReceiptModelId,
      ];

  PedoEntity({
    this.id,
    this.patientId,
    this.tooth,
    this.notes,
    this.firstStep,
    this.secondStep,
    this.date,
    this.done,
    this.assistant,
    this.assistantId,
    this.doctor,
    this.doctorId,
    this.price,
    this.firstStepPrice,
    this.secondStepPrice,
    this.clinicReceiptModelId,
  });
}
