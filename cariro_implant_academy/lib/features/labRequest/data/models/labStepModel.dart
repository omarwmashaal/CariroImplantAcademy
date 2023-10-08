import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labStepEntity.dart';

import '../../../../core/constants/enums/enums.dart';

class LabStepModel extends LabStepEntity {
  LabStepModel({
    super.id,
    super.technicianId,
    super.technician,
    super.date,
    super.status,
    super.requestId,
    super.step,
    super.stepId,
    super.notes = "",
    super.price = 0,
    super.request,
  });

  factory LabStepModel.fromEntity(LabStepEntity entity) {
    return LabStepModel(
      id: entity.id,
      technicianId: entity.technicianId,
      technician: entity.technician,
      date: entity.date,
      status: entity.status,
      requestId: entity.requestId,
      step: entity.step,
      stepId: entity.stepId,
      notes: entity.notes = "",
      price: entity.price = 0,
      request: entity.request,
    );
  }

  LabStepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notes = json['notes'];
    price = json['price'];
    technicianId = json['technicianId'];
    technician = BasicNameIdObjectModel.fromJson(json['technician'] ?? Map<String, dynamic>());
    date = DateTime.tryParse(json['date']??"")?.toLocal();
    status = LabStepStatus.values[json['status'] ?? 2];
    requestId = json['requestId'];
    request = BasicNameIdObjectModel.fromJson(json['request'] ?? Map<String, dynamic>());
    stepId = json['stepId'];
    step = BasicNameIdObjectModel.fromJson(json['step'] ?? Map<String, dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notes'] = this.notes;
    data['price'] = this.price;
    data['technicianId'] = this.technicianId;
    data['status'] = (this.status ?? LabStepStatus.NotYet).index;
    data['stepId'] = this.stepId;
    return data;
  }
}
