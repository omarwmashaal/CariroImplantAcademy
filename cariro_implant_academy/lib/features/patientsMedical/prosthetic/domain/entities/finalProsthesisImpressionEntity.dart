import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'finalProsthesisParentEntity.dart';

import 'package:equatable/equatable.dart';

class FinalProthesisImpressionEntity extends FinalProthesisParentEntity
     {
  EnumFinalProthesisImpressionStatus? finalProthesisImpressionStatus;
  EnumFinalProthesisImpressionNextVisit?
  finalProthesisImpressionNextVisit;

  FinalProthesisImpressionEntity({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    int? operatorId,
    BasicNameIdObjectEntity? operator,
    DateTime?date,
    List<int>? finalProthesisTeeth,
    this.finalProthesisImpressionStatus,
    this.finalProthesisImpressionNextVisit,
  }) : super(
    id: id,
    patientId: patientId,
    patient: patient,
    searchTeethClassification: searchTeethClassification,
    website: website,
    operator: operator,
    operatorId: operatorId,
    finalProthesisTeeth: finalProthesisTeeth,
    date: date,
  );
  bool isNull() {
    return
        finalProthesisImpressionStatus == null &&
        finalProthesisImpressionNextVisit == null &&
        date == null;
  }

  @override
  List<Object?> get props => [
    ...super.props,
    finalProthesisImpressionStatus,
    finalProthesisImpressionNextVisit,

  ];
}

