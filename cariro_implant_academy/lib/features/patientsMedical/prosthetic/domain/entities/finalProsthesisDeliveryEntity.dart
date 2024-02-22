import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisParentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';

class FinalProthesisDeliveryEntity extends FinalProthesisParentEntity {
  EnumFinalProthesisDeliveryStatus? finalProthesisDeliveryStatus;
  EnumFinalProthesisDeliveryNextVisit? finalProthesisDeliveryNextVisit;

  FinalProthesisDeliveryEntity({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    int? operatorId,
    BasicNameIdObjectEntity? operator,
    DateTime?date,
    this.finalProthesisDeliveryStatus,
    this.finalProthesisDeliveryNextVisit,
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
        finalProthesisDeliveryStatus == null &&
        finalProthesisDeliveryNextVisit == null &&
        date == null;
  }
  @override
  List<Object?> get props {
    return [
      ...super.props,
      finalProthesisDeliveryStatus,
      finalProthesisDeliveryNextVisit,
    ];
  }
}
