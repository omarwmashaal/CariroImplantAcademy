import 'package:cariro_implant_academy/core/constants/enums/enums.dart';

import '../../../../../Helpers/CIA_DateConverters.dart';
import '../../../../../Models/Enum.dart';
import '../../domain/entities/diabeticEntity.dart';

class DiabeticModel extends DiabeticEntity {
  DiabeticModel({
    lastReading,
    when,
    randomInClinic,
    status,
    type,
  }) : super(
          status: status,
          lastReading: lastReading,
          when: when,
          type: type,
          randomInClinic: randomInClinic,
        );

  DiabeticModel.fromJson(Map<String, dynamic> json) {
    lastReading = json['lastReading'] as int?;
    when = CIA_DateConverters.fromBackendToDateOnly(json['when']);
    randomInClinic = json['randomInClinic'];
    status = mapToEnum(DiabetesEnum.values, json["status"]);
    type = mapToEnum(DiabetesMeasureType.values, json["type"]);
  }

  DiabeticModel.fromEntity(DiabeticEntity diabeticEntity) {
    lastReading = diabeticEntity.lastReading;
    when = diabeticEntity.when;
    randomInClinic = diabeticEntity.randomInClinic;
    status = diabeticEntity.status;
    type = diabeticEntity.type;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastReading'] = this.lastReading;
    data['when'] = CIA_DateConverters.fromDateOnlyToBackend(this.when);
    data['randomInClinic'] = this.randomInClinic;
    data['status'] = this.status == null ? null : this.status!.index;
    data['type'] = this.type == null ? null : this.type!.index;
    return data;
  }
}
