import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';
import 'dentalExaminationEntity.dart';

class DentalExaminationBaseEntity extends Equatable{
  int? id;
  int? patientId;
  List<DentalExaminationEntity>? dentalExaminations;
  DateTime? date;
  String? operatorImplantNotes;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  EnumOralHygieneRating?  oralHygieneRating;

  DentalExaminationBaseEntity({
    this.id,
    this.patientId,
    this.dentalExaminations,
    this.date,
    this.operatorImplantNotes,
    this.operatorId,
    this.operator,
    this.oralHygieneRating,
  }){
    if(dentalExaminations==null)
      dentalExaminations = [];
  }

  @override

  List<Object?> get props => [
    id,
    patientId,
    dentalExaminations,
    date,
    operatorImplantNotes,
    operatorId,
    operator,
    oralHygieneRating,
  ];

}