import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/ImplantModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/restorationEntity.dart';

class RestorationModel extends RestorationEntity {
  RestorationModel({
    super.id,
    super.patientId,
    super.tooth,
    super.restorationClass,
    super.status,
    super.type,
    super.date,
    super.done,
    super.assistant,
    super.assistantId,
    super.doctor,
    super.doctorId,
  });

  factory RestorationModel.fromEntity(RestorationEntity entity) {
    return RestorationModel(
      id:entity.id,
      patientId:entity.patientId,
      tooth:entity.tooth,
      restorationClass:entity.restorationClass,
      status:entity.status,
      type:entity.type,
      date:entity.date,
      done:entity.done,
      assistant:entity.assistant,
      assistantId:entity.assistantId,
      doctor:entity.doctor,
      doctorId:entity.doctorId,
    );
  }

  factory RestorationModel.fromJson(Map<String, dynamic> map) {
    return RestorationModel(
      id:map['id'],
      patientId:map['patientId'],
      tooth:map['tooth'],
      restorationClass:map['class']==null?null:EnumClinicRestorationClass.values[map['class']],
      status:map['status']==null?null:EnumClinicRestorationStatus.values[map['status']],
      type:map['type']==null?null:EnumClinicRestorationType.values[map['type']],
      date:DateTime.tryParse(map['date']??""),
      done:map['done'],
      assistant:map['assistant']==null?null:BasicNameIdObjectModel.fromJson(map['assistant']),
      assistantId:map['assistantId'],
      doctor:map['doctor']==null?null:BasicNameIdObjectModel.fromJson(map['doctor']),
      doctorId:map['doctorId'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['class'] = this.restorationClass?.index;
    data['status'] = this.status?.index;
    data['type'] = this.type?.index;
    data['date'] = this.date?.toUtc().toIso8601String();
    data['done'] = this.done;
    data['assistantId'] = this.assistantId;
    data['doctorId'] = this.doctorId;
    return data;
  }
}
