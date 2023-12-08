
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class FinalProthesisParentEntity extends Equatable {
  int? id;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  EnumTeethClassification? searchTeethClassification;
  Website website;
  List<int>? finalProthesisTeeth;

  FinalProthesisParentEntity({
    this.id,
    this.patientId,
    this.patient,
    this.searchTeethClassification,
    this.website = Website.CIA,
    this.finalProthesisTeeth,
  });

  @override
  List<Object?> get props {
    return [
      id,
      patientId,
      patient,
      searchTeethClassification,
      website,
      finalProthesisTeeth,
    ];
  }
}