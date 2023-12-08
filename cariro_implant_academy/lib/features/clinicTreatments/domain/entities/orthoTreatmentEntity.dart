import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class OrthoTreatmentEntity extends Equatable {
  int? id;
  int? patientId;
  int? tooth;
  String? notes;
  bool? done;
  DateTime? date;
  int? assistantId;
  BasicNameIdObjectEntity? assistant;
  int? doctorId;
  BasicNameIdObjectEntity? doctor;
  int? price;
  int? clinicReceiptModelId;

  @override
  List<Object?> get props => [
        this.id,
        this.patientId,
        this.tooth,
        this.notes,
    this.date,
    this.done,
    this.assistant,
    this.assistantId,
    this.doctor,
    this.doctorId,
    this.price,
    this.clinicReceiptModelId,
      ];

  OrthoTreatmentEntity({
    this.id,
    this.patientId,
    this.tooth,
    this.notes,
    this.date,
    this.done,
    this.assistant,
    this.assistantId,
    this.doctor,
    this.doctorId,
    this.price,
    this.clinicReceiptModelId,
  });
}
