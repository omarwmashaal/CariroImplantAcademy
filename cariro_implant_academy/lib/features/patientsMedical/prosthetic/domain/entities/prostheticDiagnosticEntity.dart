import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

import 'biteEntity.dart';
import 'diagnosticImpressionEntity.dart';
import 'scanApplianceEntity.dart';

class ProstheticTreatmentEntity extends Equatable {
  int? id;
  int? patientId;
  String? secondaryId;
  DateTime? date;
  BasicNameIdObjectEntity? patient;
  List<DiagnosticImpressionEntity>? prostheticDiagnostic_DiagnosticImpression;
  List<BiteEntity>? prostheticDiagnostic_Bite;
  List<ScanApplianceEntity>? prostheticDiagnostic_ScanAppliance;

  //search section

  DiagnosticImpressionEntity? searchProstheticDiagnostic_DiagnosticImpression;
  BiteEntity? searchProstheticDiagnostic_Bite;
  ScanApplianceEntity? searchProstheticDiagnostic_ScanAppliance;
  EnumTeethClassification? searchTeethClassification;
  ProstheticTreatmentEntity({
    this.id,
    this.date,
    this.patientId,
    this.secondaryId,
    this.patient,
    this.searchTeethClassification,
    this.prostheticDiagnostic_DiagnosticImpression,
    this.prostheticDiagnostic_Bite,
    this.prostheticDiagnostic_ScanAppliance,
    this.searchProstheticDiagnostic_Bite,
    this.searchProstheticDiagnostic_DiagnosticImpression,
    this.searchProstheticDiagnostic_ScanAppliance,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        patientId,
        secondaryId,
        patient,
        prostheticDiagnostic_DiagnosticImpression,
        prostheticDiagnostic_Bite,
        prostheticDiagnostic_ScanAppliance,
        searchTeethClassification,
        searchProstheticDiagnostic_Bite,
        searchProstheticDiagnostic_DiagnosticImpression,
        searchProstheticDiagnostic_ScanAppliance,
      ];
}
