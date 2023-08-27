import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class NonSurgicalTreatmentEntity extends Equatable{
  String? treatment;
  int? supervisorID;
  BasicNameIdObjectEntity? supervisor;
  int? operatorID;
  BasicNameIdObjectEntity? operator;
  DateTime? date;
  String? nextVisit;

  NonSurgicalTreatmentEntity({this.treatment,
    this.supervisorID,
    this.supervisor,
    this.operator,
    this.operatorID,
    this.date,
    this.nextVisit});

  @override
  // TODO: implement props
  List<Object?> get props =>[
    supervisorID,
    supervisor,
    operator,
    operatorID,
    date,
    nextVisit,
    treatment,
  ];


}