import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/ImplantModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/orthoTreatmentEntity.dart';

class OrthoTreatmentModel extends OrthoTreatmentEntity {
  OrthoTreatmentModel({
    super.id,
    super.patientId,
    super.tooth,
    super.notes,
    super.date,
    super.done,
    super.assistant,
    super.assistantId,
    super.doctor,
    super.doctorId,
    super.price,
    super.clinicReceiptModelId,

  });

  factory OrthoTreatmentModel.fromEntity(OrthoTreatmentEntity entity) {
    return OrthoTreatmentModel(
      id: entity.id,
      patientId: entity.patientId,
      tooth: entity.tooth,
      notes: entity.notes,
      date:entity.date,
      done:entity.done,
      assistant:entity.assistant,
      assistantId:entity.assistantId,
      doctor:entity.doctor,
      doctorId:entity.doctorId,
      price:entity.price,
    );
  }

  factory OrthoTreatmentModel.fromJson(Map<String, dynamic> map) {
    return OrthoTreatmentModel(
      id: map['id'],
      patientId: map['patientId'],
      tooth: map['tooth'],
      notes: map['notes'],
      date:DateTime.tryParse(map['date']??""),
      done:map['done'],
      assistant:map['assistant']==null?null:BasicNameIdObjectModel.fromJson(map['assistant']),
      assistantId:map['assistantId'],
      doctor:map['doctor']==null?null:BasicNameIdObjectModel.fromJson(map['doctor']),
      doctorId:map['doctorId'],
      price:map['price'],
      clinicReceiptModelId:map['clinicReceiptModelId'],
     );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['clinicReceiptModelId'] = this.clinicReceiptModelId;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['notes'] = this.notes;
    data['date'] = this.date?.toUtc().toIso8601String();
    data['done'] = this.done;
    data['assistantId'] = this.assistantId;
    data['doctorId'] = this.doctorId;
    data['price'] = this.price;

    return data;
  }
}
