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
    interarchSpaceRT,
    interarchSpaceLT,
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
          interarchSpaceLT: interarchSpaceLT,
          interarchSpaceRT: interarchSpaceRT,
          operatorImplantNotes: operatorImplantNotes,
          oralHygieneRating: oralHygieneRating,
        );


  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'patientId': this.patientId,
      'dentalExaminations': this.dentalExaminations==null?null:this.dentalExaminations!.map((e) => DentalExaminationModel.fromEntity(e).toMap()).toList(),
      'interarchspaceRT': this.interarchSpaceRT,
      'interarchspaceLT': this.interarchSpaceLT,
      'date': this.date==null? null:CIA_DateConverters.fromDateTimeToBackend(DateFormat("dd-MM-yyyy HH:mm").format(this.date!)),
      'operatorImplantNotes': this.operatorImplantNotes,
      'operatorId': this.operatorId,
     // 'operator': this.operator==null?null:BasicNameIdObjectModel,
      'oralHygieneRating': getEnumIndex(EnumOralHygieneRating.values, this.oralHygieneRating),
    };
  }

  factory DentalExaminationBaseModel.fromMap(Map<String, dynamic> map) {
    return DentalExaminationBaseModel(
      id: map['id'] as int?,
      patientId: map['patientId'] as int?,
      dentalExaminations: jsonToList(jsonList: map['dentalExaminations'], conversionMethod: DentalExaminationModel.fromMap),
      interarchSpaceRT: map['interarchspaceRT'] as int?,
      interarchSpaceLT: map['interarchspaceLT'] as int?,
      date: DateTime.parse(map['date']),
      operatorImplantNotes: map['operatorImplantNotes'] as String?,
      operatorId: map['operatorId'] as int?,
      operator: BasicNameIdObjectModel.fromJson(map['operator']),
      oralHygieneRating: mapToEnum(EnumOralHygieneRating.values, map['oralHygieneRating']),
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
      interarchSpaceLT: entity.interarchSpaceLT,
      interarchSpaceRT: entity.interarchSpaceRT,
      operatorImplantNotes: entity.operatorImplantNotes,
      oralHygieneRating: entity.oralHygieneRating,
    );
  }
}
