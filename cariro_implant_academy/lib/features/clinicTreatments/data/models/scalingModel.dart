import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/ImplantModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/restorationEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/rootCanalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/scalingEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/tmdEntity.dart';

class ScalingModel extends ScalingEntity {
  ScalingModel({
    super.id,
    super.patientId,
    super.tooth,
    super.notes,
    super.type,
    super.date,
    super.done,
    super.assistant,
    super.assistantId,
    super.doctor,
    super.doctorId,
    super.stepNumber,
    super.price,
    super.clinicReceiptModelId,
  });

  factory ScalingModel.fromEntity(ScalingEntity entity) {
    return ScalingModel(
      id: entity.id,
      patientId: entity.patientId,
      tooth: entity.tooth,
      notes: entity.notes,
      type: entity.type,
      date:entity.date,
      done:entity.done,
      assistant:entity.assistant,
      assistantId:entity.assistantId,
      doctor:entity.doctor,
      doctorId:entity.doctorId,
      stepNumber:entity.stepNumber,
      price:entity.price,
      clinicReceiptModelId:entity.clinicReceiptModelId,
    );
  }

  factory ScalingModel.fromJson(Map<String, dynamic> map) {
    return ScalingModel(
      id: map['id'],
      patientId: map['patientId'],
      tooth: map['tooth'],
      notes: map['notes'],
      type: map['type'] == null ? null : EnumClinicScalingType.values[map['type']],
      date:DateTime.tryParse(map['date']??""),
      done:map['done'],
      assistant:map['assistant']==null?null:BasicNameIdObjectModel.fromJson(map['assistant']),
      assistantId:map['assistantId'],
      doctor:map['doctor']==null?null:BasicNameIdObjectModel.fromJson(map['doctor']),
      doctorId:map['doctorId'],
      stepNumber:map['stepNumber'],
      price:map['price'],
      clinicReceiptModelId:map['clinicReceiptModelId'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['notes'] = this.notes;
    data['type'] = this.type?.index;
    data['date'] = this.date?.toUtc().toIso8601String();
    data['done'] = this.done;
    data['assistantId'] = this.assistantId;
    data['doctorId'] = this.doctorId;
    data['stepNumber'] = this.stepNumber;
    data['price'] = this.price;
    data['clinicReceiptModelId'] = this.clinicReceiptModelId;
    return data;
  }
}
