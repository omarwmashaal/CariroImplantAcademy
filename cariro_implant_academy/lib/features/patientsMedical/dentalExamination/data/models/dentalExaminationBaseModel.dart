import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/helpers/jsonHelpers.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationBaseEntity.dart';
import 'package:intl/intl.dart';

import 'dentalExaminationModel.dart';

class DentalExaminationBaseModel extends DentalExaminationBaseEntity {
  DentalExaminationBaseModel({
    id,
    patientId,
    dentalExaminations,
    date,
    operatorImplantNotes,
    operatorId,
    operator,
    oralHygieneRating,
  }) : super(
          id: id,
          patientId: patientId,
          operatorId: operatorId,
          operator: operator,
          date: date,
          dentalExaminations: dentalExaminations,
          operatorImplantNotes: operatorImplantNotes,
          oralHygieneRating: oralHygieneRating,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'patientId': this.patientId,
      'dentalExaminations': this.dentalExaminations == null ? null : this.dentalExaminations!.map((e) => DentalExaminationModel.fromEntity(e).toMap()).toList(),
      'date': this.date == null ? null : CIA_DateConverters.fromDateTimeToBackend(DateFormat("dd-MM-yyyy HH:mm").format(this.date!)),
      'operatorImplantNotes': this.operatorImplantNotes,
      'operatorId': this.operatorId,
      'date': this.date == null ? null : this.date!.toUtc().toIso8601String(),
      // 'operator': this.operator==null?null:BasicNameIdObjectModel,
      'oralHygieneRating': getEnumIndex(EnumOralHygieneRating.values, this.oralHygieneRating),
    };
  }

  factory DentalExaminationBaseModel.fromMap(Map<String, dynamic> map) {
    return DentalExaminationBaseModel(
      id: map['id'] as int?,
      patientId: map['patientId'] as int?,
      dentalExaminations:
          map['dentalExaminations'] == null ? [] : jsonToList(jsonList: map['dentalExaminations'], conversionMethod: DentalExaminationModel.fromMap),
      date: DateTime.tryParse(map['date'] ?? "")?.toLocal(),
      operatorImplantNotes: map['operatorImplantNotes'] as String?,
      operatorId: map['operatorId'] as int?,
      operator: map['operator'] == null ? null : BasicNameIdObjectModel.fromJson(map['operator']),
      oralHygieneRating: map['oralHygieneRating'] == null ? null : mapToEnum(EnumOralHygieneRating.values, map['oralHygieneRating']),
    );
  }

  factory DentalExaminationBaseModel.fromEntity(DentalExaminationBaseEntity entity) {
    return DentalExaminationBaseModel(
      id: entity.id,
      patientId: entity.patientId,
      operatorId: entity.operatorId,
      operator: entity.operator,
      date: entity.date,
      dentalExaminations: entity.dentalExaminations,
      operatorImplantNotes: entity.operatorImplantNotes,
      oralHygieneRating: entity.oralHygieneRating,
    );
  }
}
