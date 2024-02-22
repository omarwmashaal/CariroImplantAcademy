import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';
import 'finalProsthesisParentEntity.dart';

class FinalProthesisHealingCollarEntity extends FinalProthesisParentEntity {
  EnumFinalProthesisHealingCollarStatus? finalProthesisHealingCollarStatus;
  EnumFinalProthesisHealingCollarNextVisit? finalProthesisHealingCollarNextVisit;

  FinalProthesisHealingCollarEntity({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    DateTime?date,
    int? operatorId,
    BasicNameIdObjectEntity? operator,
    List<int>? finalProthesisTeeth,
    this.finalProthesisHealingCollarStatus,
    this.finalProthesisHealingCollarNextVisit,
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
        finalProthesisHealingCollarStatus == null &&
        finalProthesisHealingCollarNextVisit == null &&
        date == null;
  }

  @override
  List<Object?> get props => [
        ...super.props,
        finalProthesisHealingCollarStatus,
        finalProthesisHealingCollarNextVisit,
      ];
}
