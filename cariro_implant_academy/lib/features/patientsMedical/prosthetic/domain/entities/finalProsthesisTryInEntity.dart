import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisParentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';

class FinalProthesisTryInEntity extends FinalProthesisParentEntity {
  bool? finalProthesisTryIn;
  EnumFinalProthesisTryInStatus? finalProthesisTryInStatus;
  EnumFinalProthesisTryInNextVisit? finalProthesisTryInNextVisit;
  DateTime? finalProthesisTryInDate;

  FinalProthesisTryInEntity({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    this.finalProthesisTryIn,
    this.finalProthesisTryInStatus,
    this.finalProthesisTryInNextVisit,
    this.finalProthesisTryInDate,
  }) : super(
    id: id,
    patientId: patientId,
    patient: patient,
    searchTeethClassification: searchTeethClassification,
    website: website,
    finalProthesisTeeth: finalProthesisTeeth,
  );
  bool isNull() {
    return finalProthesisTryIn == null &&
        finalProthesisTryInStatus == null &&
        finalProthesisTryInNextVisit == null &&
        finalProthesisTryInDate == null;
  }
  @override
  List<Object?> get props {
    return [
      ...super.props,
      finalProthesisTryIn,
      finalProthesisTryInStatus,
      finalProthesisTryInNextVisit,
      finalProthesisTryInDate,
    ];
  }
}
