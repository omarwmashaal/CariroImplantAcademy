import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/entities/bloodPressureEntity.dart';

import '../../../../../Helpers/CIA_DateConverters.dart';
import '../../../../../Models/Enum.dart';
import '../../../../../core/constants/enums/enums.dart';

class BloodPressureModel extends BloodPressureEntity {
  BloodPressureModel({
    lastReading,
    when,
    drug,
    status,
    readingInClinic,
  }) : super(
          lastReading: lastReading,
          when: when,
    readingInClinic: readingInClinic,
    drug: drug,status: status
        );

  BloodPressureModel.fromJson(Map<String, dynamic> map) {
    drug = map['drug'];
    lastReading = map['lastReading'];
    readingInClinic = map['readingInClinic'];
    when = CIA_DateConverters.fromBackendToDateOnly(map['when']);
    status=mapToEnum(BloodPressureEnum.values, map['status']);
  }
  BloodPressureModel.fromEntity(BloodPressureEntity bloodPressureEntity)
  {
    when = bloodPressureEntity.when;
    lastReading =bloodPressureEntity.lastReading;
    status = bloodPressureEntity.status;
    readingInClinic = bloodPressureEntity.readingInClinic;
    drug = bloodPressureEntity.drug;

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastReading'] = this.lastReading;
    data['when'] = CIA_DateConverters.fromDateOnlyToBackend(this.when);
    data['drug'] = this.drug;
    data['readingInClinic'] = this.readingInClinic;
    data['status'] = getEnumIndex<BloodPressureEnum>(BloodPressureEnum.values, this.status);
    return data;
  }

}
