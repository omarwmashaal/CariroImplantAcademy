import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class LabStepEntity extends Equatable {
  int? id;
  int? technicianId;
  BasicNameIdObjectEntity? technician;
  DateTime? date;
  LabStepStatus? status;
  int? requestId;
  BasicNameIdObjectEntity? request;
  int? stepId;
  BasicNameIdObjectEntity? step;
  String? notes;
  int? price;

  LabStepEntity({
    this.id,
    this.technicianId,
    this.technician,
    this.date,
    this.status,
    this.requestId,
    this.step,
    this.stepId,
    this.notes = "",
    this.price = 0,
    this.request,
  }) {
    technician = BasicNameIdObjectEntity();
    status = LabStepStatus.NotYet;
    request = BasicNameIdObjectEntity();
    //step = DropDownDTO();
  }

  @override
  List<Object?> get props => [
        this.id,
        this.technicianId,
        this.technician,
        this.date,
        this.status,
        this.requestId,
        this.step,
        this.stepId,
        this.notes,
        this.price,
        this.request,
      ];
}
