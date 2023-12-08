import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class ClinicImplantEntity extends Equatable {
  int? id;
  int? patientId;
  int? tooth;
  EnumClinicImplantTypes? type;
  String? notes;
  int? implantId;
  ImplantEntity? implant_;
  int? implantCompanyId;
  BasicNameIdObjectEntity? implantCompany_;
  int? implantLineId;
  BasicNameIdObjectEntity? implantLine_;
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
        this.type,
        this.notes,
        this.implantId,
        this.implant_,
        this.implantCompanyId,
        this.implantCompany_,
        this.implantLineId,
        this.implantLine_,
        this.date,
        this.done,
        this.assistant,
        this.assistantId,
        this.doctor,
        this.doctorId,
        this.clinicReceiptModelId,
        this.price,
      ];

  ClinicImplantEntity({
    this.id,
    this.patientId,
    this.tooth,
    this.type,
    this.notes,
    this.implantId,
    this.implant_,
    this.implantCompanyId,
    this.implantCompany_,
    this.implantLineId,
    this.implantLine_,
    this.date,
    this.done,
    this.assistant,
    this.assistantId,
    this.doctor,
    this.price,
    this.doctorId,
    this.clinicReceiptModelId,
  });
}
