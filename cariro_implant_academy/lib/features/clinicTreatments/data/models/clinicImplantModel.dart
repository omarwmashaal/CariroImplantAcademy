import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/ImplantModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';

class ClinicImplantModel extends ClinicImplantEntity {
  ClinicImplantModel({
    super.id,
    super.patientId,
    super.tooth,
    super.type,
    super.notes,
    super.implantId,
    super.implant_,
    super.implantCompanyId,
    super.implantCompany_,
    super.implantLineId,
    super.implantLine_,
    super.date,
    super.done,
    super.assistant,
    super.assistantId,
    super.doctor,
    super.doctorId,
    super.price,
    super.clinicReceiptModelId,
  });

  factory ClinicImplantModel.fromEntity(ClinicImplantEntity entity) {
    return ClinicImplantModel(
      id: entity.id,
      patientId: entity.patientId,
      tooth: entity.tooth,
      type: entity.type,
      notes: entity.notes,
      implantId: entity.implantId,
      implant_: entity.implant_,
      implantCompanyId: entity.implantCompanyId,
      implantCompany_: entity.implantCompany_,
      implantLineId: entity.implantLineId,
      implantLine_: entity.implantLine_,
      date:entity.date,
      done:entity.done,
      assistant:entity.assistant,
      assistantId:entity.assistantId,
      doctor:entity.doctor,
      doctorId:entity.doctorId,
      price:entity.price,
      clinicReceiptModelId:entity.clinicReceiptModelId,
    );
  }

  factory ClinicImplantModel.fromJson(Map<String, dynamic> map) {
    return ClinicImplantModel(
      id: map['id'],
      clinicReceiptModelId: map['clinicReceiptModelId'],
      patientId: map['patientId'],
      tooth: map['tooth'],
      type: map['type']==null?null:EnumClinicImplantTypes.values[map['type']],
      notes: map['notes'],
      implantId: map['implantId'],
      implant_:map['implant_']==null?null: ImplantModel.fromJson(map['implant_']),
      implantCompanyId: map['implantCompanyId'],
      implantCompany_: map['implantCompany_']==null?null: BasicNameIdObjectModel.fromJson(map['implantCompany_']),
      implantLineId: map['implantLineId'],
      implantLine_: map['implantLine_']==null?null: BasicNameIdObjectModel.fromJson(map['implantLine_']),
      date:DateTime.tryParse(map['date']??""),
      done:map['done'],
      assistant:map['assistant']==null?null:BasicNameIdObjectModel.fromJson(map['assistant']),
      assistantId:map['assistantId'],
      doctor:map['doctor']==null?null:BasicNameIdObjectModel.fromJson(map['doctor']),
      doctorId:map['doctorId'],
      price:map['price'],

    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['clinicReceiptModelId'] = this.clinicReceiptModelId;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['type'] = this.type?.index;
    data['notes'] = this.notes;
    data['implantId'] = this.implantId;
    data['implantCompanyId'] = this.implantCompanyId;
    data['implantLineId'] = this.implantLineId;
    data['date'] = this.date?.toUtc().toIso8601String();
    data['done'] = this.done;
    data['assistantId'] = this.assistantId;
    data['doctorId'] = this.doctorId;
    data['price'] = this.price;
    return data;
  }
}
