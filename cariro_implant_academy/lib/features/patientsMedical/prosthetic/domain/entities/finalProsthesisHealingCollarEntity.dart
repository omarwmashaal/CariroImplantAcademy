import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';
import 'finalProsthesisParentEntity.dart';

class FinalProthesisHealingCollarEntity extends FinalProthesisParentEntity {
  bool? finalProthesisHealingCollar;
  EnumFinalProthesisHealingCollarStatus? finalProthesisHealingCollarStatus;
  EnumFinalProthesisHealingCollarNextVisit? finalProthesisHealingCollarNextVisit;
  DateTime? finalProthesisHealingCollarDate;

  FinalProthesisHealingCollarEntity({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    this.finalProthesisHealingCollar,
    this.finalProthesisHealingCollarStatus,
    this.finalProthesisHealingCollarNextVisit,
    this.finalProthesisHealingCollarDate,
  }) : super(
          id: id,
          patientId: patientId,
          patient: patient,
          searchTeethClassification: searchTeethClassification,
          website: website,
          finalProthesisTeeth: finalProthesisTeeth,
        );
  bool isNull() {
    return finalProthesisHealingCollar == null &&
        finalProthesisHealingCollarStatus == null &&
        finalProthesisHealingCollarNextVisit == null &&
        finalProthesisHealingCollarDate == null;
  }
  @override
  List<Object?> get props => [
        ...super.props,
        finalProthesisHealingCollar,
        finalProthesisHealingCollarStatus,
        finalProthesisHealingCollarNextVisit,
        finalProthesisHealingCollarDate,
      ];
}
