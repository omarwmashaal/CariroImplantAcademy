import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'finalProsthesisParentEntity.dart';

import 'package:equatable/equatable.dart';

class FinalProthesisImpressionEntity extends FinalProthesisParentEntity
     {
  bool? finalProthesisImpression;
  EnumFinalProthesisImpressionStatus? finalProthesisImpressionStatus;
  EnumFinalProthesisImpressionNextVisit?
  finalProthesisImpressionNextVisit;
  DateTime? finalProthesisImpressionDate;

  FinalProthesisImpressionEntity({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    this.finalProthesisImpression,
    this.finalProthesisImpressionStatus,
    this.finalProthesisImpressionNextVisit,
    this.finalProthesisImpressionDate,
  }) : super(
    id: id,
    patientId: patientId,
    patient: patient,
    searchTeethClassification: searchTeethClassification,
    website: website,
    finalProthesisTeeth: finalProthesisTeeth,
  );
  bool isNull() {
    return finalProthesisImpression == null &&
        finalProthesisImpressionStatus == null &&
        finalProthesisImpressionNextVisit == null &&
        finalProthesisImpressionDate == null;
  }

  @override
  List<Object?> get props => [
    ...super.props,
    finalProthesisImpression,
    finalProthesisImpressionStatus,
    finalProthesisImpressionNextVisit,
    finalProthesisImpressionDate,
  ];
}

