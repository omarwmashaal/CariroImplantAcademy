import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';
import 'dentalExaminationEntity.dart';

class DentalExaminationBaseEntity extends Equatable{
  int? id;
  int? patientId;
  List<DentalExaminationEntity>? dentalExaminations;
  int? interarchSpaceRT;
  int? interarchSpaceLT;
  DateTime? date;
  String? operatorImplantNotes;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  EnumOralHygieneRating?  oralHygieneRating;

  DentalExaminationBaseEntity({
    this.id,
    this.patientId,
    this.dentalExaminations,
    this.interarchSpaceRT,
    this.interarchSpaceLT,
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
    interarchSpaceRT,
    interarchSpaceLT,
    date,
    operatorImplantNotes,
    operatorId,
    operator,
    oralHygieneRating,
  ];

}