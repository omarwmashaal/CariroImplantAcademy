import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

import '../enums/enum.dart';
import 'biteEntity.dart';
import 'diagnosticImpressionEntity.dart';
import 'scanApplianceEntity.dart';

class ProstheticTreatmentEntity extends Equatable {
  int? id;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  EnumTeethClassification? searchTeethClassification;
  List<DiagnosticImpressionEntity>? prostheticDiagnostic_DiagnosticImpression;
  List<BiteEntity>? prostheticDiagnostic_Bite;
  List<ScanApplianceEntity>? prostheticDiagnostic_ScanAppliance;
  DiagnosticImpressionEntity? searchProstheticDiagnostic_DiagnosticImpression;
  BiteEntity? searchProstheticDiagnostic_Bite;
  ScanApplianceEntity? searchProstheticDiagnostic_ScanAppliance;

  List<int>? finalProthesisSingleBridgeTeeth;
  bool? finalProthesisSingleBridgeHealingCollar;
  EnumFinalProthesisSingleBridgeHealingCollarStatus? finalProthesisSingleBridgeHealingCollarStatus;
  EnumFinalProthesisSingleBridgeHealingCollarNextVisit? finalProthesisSingleBridgeHealingCollarNextVisit;
  bool? finalProthesisSingleBridgeImpression;
  EnumFinalProthesisSingleBridgeImpressionStatus? finalProthesisSingleBridgeImpressionStatus;
  EnumFinalProthesisSingleBridgeImpressionNextVisit? finalProthesisSingleBridgeImpressionNextVisit;
  bool? finalProthesisSingleBridgeTryIn;
  EnumFinalProthesisSingleBridgeTryInStatus? finalProthesisSingleBridgeTryInStatus;
  EnumFinalProthesisSingleBridgeTryInNextVisit? finalProthesisSingleBridgeTryInNextVisit;
  bool? finalProthesisSingleBridgeDelivery;
  EnumFinalProthesisSingleBridgeDeliveryStatus? finalProthesisSingleBridgeDeliveryStatus;
  EnumFinalProthesisSingleBridgeDeliveryNextVisit? finalProthesisSingleBridgeDeliveryNextVisit;

  bool? finalProthesisFullArchHealingCollar;
  EnumFinalProthesisSingleBridgeHealingCollarStatus? finalProthesisFullArchHealingCollarStatus;
  EnumFinalProthesisSingleBridgeHealingCollarNextVisit? finalProthesisFullArchHealingCollarNextVisit;
  bool? finalProthesisFullArchImpression;
  EnumFinalProthesisSingleBridgeImpressionStatus? finalProthesisFullArchImpressionStatus;
  EnumFinalProthesisSingleBridgeImpressionNextVisit? finalProthesisFullArchImpressionNextVisit;
  bool? finalProthesisFullArchTryIn;
  EnumFinalProthesisSingleBridgeTryInStatus? finalProthesisFullArchTryInStatus;
  EnumFinalProthesisSingleBridgeTryInNextVisit? finalProthesisFullArchTryInNextVisit;
  bool? finalProthesisFullArchDelivery;
  EnumFinalProthesisSingleBridgeDeliveryStatus? finalProthesisFullArchDeliveryStatus;
  EnumFinalProthesisSingleBridgeDeliveryNextVisit? finalProthesisFullArchDeliveryNextVisit;

  ProstheticTreatmentEntity({
    this.id,
    this.patientId,
    this.patient,
    this.searchTeethClassification,
    this.prostheticDiagnostic_DiagnosticImpression,
    this.prostheticDiagnostic_Bite,
    this.prostheticDiagnostic_ScanAppliance,
    this.finalProthesisSingleBridgeTeeth,
    this.finalProthesisSingleBridgeHealingCollar,
    this.finalProthesisSingleBridgeHealingCollarStatus,
    this.finalProthesisSingleBridgeHealingCollarNextVisit,
    this.finalProthesisSingleBridgeImpression,
    this.finalProthesisSingleBridgeImpressionStatus,
    this.finalProthesisSingleBridgeImpressionNextVisit,
    this.finalProthesisSingleBridgeTryIn,
    this.finalProthesisSingleBridgeTryInStatus,
    this.finalProthesisSingleBridgeTryInNextVisit,
    this.finalProthesisSingleBridgeDelivery,
    this.finalProthesisSingleBridgeDeliveryStatus,
    this.finalProthesisSingleBridgeDeliveryNextVisit,
    this.finalProthesisFullArchHealingCollar,
    this.finalProthesisFullArchHealingCollarStatus,
    this.finalProthesisFullArchHealingCollarNextVisit,
    this.finalProthesisFullArchImpression,
    this.finalProthesisFullArchImpressionStatus,
    this.finalProthesisFullArchImpressionNextVisit,
    this.finalProthesisFullArchTryIn,
    this.finalProthesisFullArchTryInStatus,
    this.finalProthesisFullArchTryInNextVisit,
    this.finalProthesisFullArchDelivery,
    this.finalProthesisFullArchDeliveryStatus,
    this.finalProthesisFullArchDeliveryNextVisit,
    this.searchProstheticDiagnostic_Bite,
    this.searchProstheticDiagnostic_DiagnosticImpression,
    this.searchProstheticDiagnostic_ScanAppliance,
  });

  @override
  List<Object?> get props => [

    this.id,
    this.patientId,
    this.patient,
    this.prostheticDiagnostic_DiagnosticImpression,
    this.prostheticDiagnostic_Bite,
    this.prostheticDiagnostic_ScanAppliance,
    this.finalProthesisSingleBridgeTeeth,
    this.finalProthesisSingleBridgeHealingCollar,
    this.finalProthesisSingleBridgeHealingCollarStatus,
    this.finalProthesisSingleBridgeHealingCollarNextVisit,
    this.finalProthesisSingleBridgeImpression,
    this.finalProthesisSingleBridgeImpressionStatus,
    this.finalProthesisSingleBridgeImpressionNextVisit,
    this.finalProthesisSingleBridgeTryIn,
    this.finalProthesisSingleBridgeTryInStatus,
    this.finalProthesisSingleBridgeTryInNextVisit,
    this.finalProthesisSingleBridgeDelivery,
    this.finalProthesisSingleBridgeDeliveryStatus,
    this.searchTeethClassification,
    this.finalProthesisSingleBridgeDeliveryNextVisit,
    this.finalProthesisFullArchHealingCollar,
    this.finalProthesisFullArchHealingCollarStatus,
    this.finalProthesisFullArchHealingCollarNextVisit,
    this.finalProthesisFullArchImpression,
    this.finalProthesisFullArchImpressionStatus,
    this.finalProthesisFullArchImpressionNextVisit,
    this.finalProthesisFullArchTryIn,
    this.finalProthesisFullArchTryInStatus,
    this.finalProthesisFullArchTryInNextVisit,
    this.finalProthesisFullArchDelivery,
    this.finalProthesisFullArchDeliveryStatus,
    this.finalProthesisFullArchDeliveryNextVisit,
    this.searchProstheticDiagnostic_Bite,
    this.searchProstheticDiagnostic_DiagnosticImpression,
    this.searchProstheticDiagnostic_ScanAppliance,
      ];
}
