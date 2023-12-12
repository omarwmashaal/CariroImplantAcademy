import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisParentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';

import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';

class FinalProthesisDeliveryEntity extends FinalProthesisParentEntity {
  bool? finalProthesisDelivery;
  EnumFinalProthesisDeliveryStatus? finalProthesisDeliveryStatus;
  EnumFinalProthesisDeliveryNextVisit? finalProthesisDeliveryNextVisit;
  DateTime? finalProthesisDeliveryDate;

  FinalProthesisDeliveryEntity({
    int? id,
    int? patientId,
    BasicNameIdObjectEntity? patient,
    EnumTeethClassification? searchTeethClassification,
    Website website = Website.CIA,
    List<int>? finalProthesisTeeth,
    int? operatorId,
    BasicNameIdObjectEntity? operator,
    this.finalProthesisDelivery,
    this.finalProthesisDeliveryStatus,
    this.finalProthesisDeliveryNextVisit,
    this.finalProthesisDeliveryDate,
  }) : super(
    id: id,
    patientId: patientId,
    patient: patient,
    searchTeethClassification: searchTeethClassification,
    website: website,
    operator: operator,
    operatorId: operatorId,
    finalProthesisTeeth: finalProthesisTeeth,
  );
  bool isNull() {
    return finalProthesisDelivery == null &&
        finalProthesisDeliveryStatus == null &&
        finalProthesisDeliveryNextVisit == null &&
        finalProthesisDeliveryDate == null;
  }
  @override
  List<Object?> get props {
    return [
      ...super.props,
      finalProthesisDelivery,
      finalProthesisDeliveryStatus,
      finalProthesisDeliveryNextVisit,
      finalProthesisDeliveryDate,
    ];
  }
}
