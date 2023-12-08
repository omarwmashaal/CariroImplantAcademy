import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/ImplantModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';

class PedoModel extends PedoEntity {
  PedoModel({
    super.id,
    super.patientId,
    super.tooth,
    super.notes,
    super.firstStep,
    super.secondStep,
    super.date,
    super.done,
    super.assistant,
    super.assistantId,
    super.doctor,
    super.doctorId,
    super.price,
    super.secondStepPrice,
    super.firstStepPrice,
    super.clinicReceiptModelId,
  });

  factory PedoModel.fromEntity(PedoEntity entity) {
    return PedoModel(
      id: entity.id,
      patientId: entity.patientId,
      tooth: entity.tooth,
      notes: entity.notes,
      firstStep: entity.firstStep,
      secondStep: entity.secondStep,
      date:entity.date,
      done:entity.done,
      assistant:entity.assistant,
      assistantId:entity.assistantId,
      doctor:entity.doctor,
      doctorId:entity.doctorId,
      price:entity.price,
      firstStepPrice:entity.firstStepPrice,
      secondStepPrice:entity.secondStepPrice,
      clinicReceiptModelId:entity.clinicReceiptModelId,
    );
  }

  factory PedoModel.fromJson(Map<String, dynamic> map) {
    return PedoModel(
      id: map['id'],
      patientId: map['patientId'],
      tooth: map['tooth'],
      notes: map['notes'],
      secondStep: map['secondStep'] == null ? null : EnumClinicPedoSecondStep.values[map['secondStep']],
      firstStep: map['firstStep'] == null ? null : EnumClinicPedoFirstStep.values[map['firstStep']],

      date:DateTime.tryParse(map['date']??""),
      done:map['done'],
      assistant:map['assistant']==null?null:BasicNameIdObjectModel.fromJson(map['assistant']),
      assistantId:map['assistantId'],
      doctor:map['doctor']==null?null:BasicNameIdObjectModel.fromJson(map['doctor']),
      doctorId:map['doctorId'],
      price:map['price'],
      firstStepPrice:map['firstStepPrice'],
      secondStepPrice:map['secondStepPrice'],
      clinicReceiptModelId:map['clinicReceiptModelId'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['notes'] = this.notes;
    data['secondStep'] = this.secondStep?.index;
    data['firstStep'] = this.firstStep?.index;
    data['date'] = this.date?.toUtc().toIso8601String();
    data['done'] = this.done;
    data['assistantId'] = this.assistantId;
    data['doctorId'] = this.doctorId;
    data['price'] = this.price;
    data['secondStepPrice'] = this.secondStepPrice;
    data['firstStepPrice'] = this.firstStepPrice;
    data['clinicReceiptModelId'] = this.clinicReceiptModelId;
    return data;
  }
}
