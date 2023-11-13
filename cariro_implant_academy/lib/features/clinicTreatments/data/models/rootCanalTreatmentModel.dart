import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/ImplantModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/restorationEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/rootCanalTreatmentEntity.dart';

class RootCanalTreatmentModel extends RootCanalTreatmentEntity {
  RootCanalTreatmentModel({
    super.id,
    super.patientId,
    super.tooth,
    super.type,
    super.length,
    super.notes,
    super.date,
    super.done,
    super.assistant,
    super.assistantId,
    super.doctor,
    super.doctorId,
    super.canalNumber,
    super.price,
  });

  factory RootCanalTreatmentModel.fromEntity(RootCanalTreatmentEntity entity) {
    return RootCanalTreatmentModel(
      id: entity.id,
      patientId: entity.patientId,
      tooth: entity.tooth,
      length: entity.length,
      notes: entity.notes,
      type: entity.type,
      date:entity.date,
      done:entity.done,
      assistant:entity.assistant,
      assistantId:entity.assistantId,
      doctor:entity.doctor,
      doctorId:entity.doctorId,
      canalNumber:entity.canalNumber,
      price:entity.price,
    );
  }

  factory RootCanalTreatmentModel.fromJson(Map<String, dynamic> map) {
    return RootCanalTreatmentModel(
      id: map['id'],
      patientId: map['patientId'],
      tooth: map['tooth'],
      length: map['length'],
      notes: map['notes'],
      type: map['type'] == null ? null : EnumClinicRootCanalTreatmentType.values[map['type']],
      date:DateTime.tryParse(map['date']??""),
      done:map['done'],
      assistant:map['assistant']==null?null:BasicNameIdObjectModel.fromJson(map['assistant']),
      assistantId:map['assistantId'],
      doctor:map['doctor']==null?null:BasicNameIdObjectModel.fromJson(map['doctor']),
      doctorId:map['doctorId'],
      canalNumber:map['canalNumber'],
      price:map['price'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['length'] = this.length;
    data['notes'] = this.notes;
    data['type'] = this.type?.index;
    data['date'] = this.date?.toUtc().toIso8601String();
    data['done'] = this.done;
    data['assistantId'] = this.assistantId;
    data['doctorId'] = this.doctorId;
    data['canalNumber'] = this.canalNumber;
    data['price'] = this.price;
    return data;
  }
}
