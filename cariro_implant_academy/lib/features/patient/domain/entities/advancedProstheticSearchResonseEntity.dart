import 'package:cariro_implant_academy/Models/MedicalModels/ProstheticTreatmentModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/biteModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/diagnosticImpressionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/scanApplianceModel.dart';
import 'package:equatable/equatable.dart';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisDeliveryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisHealingCollarEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisTryInEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticFinalEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';

import '../../../patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';

class AdvancedProstheticSearchResponseEntity extends Equatable {
  int? id;
  int? tooth;
  String? secondaryId;
  String? patientName;
  DiagnosticImpressionModel? diagnosticImpression;
  BiteModel? bite;
  ScanApplianceModel? scanAppliance;
  FinalProthesisHealingCollarEntity? singleAndBridge_HealingCollar;
  FinalProthesisImpressionEntity? singleAndBridge_Impression;
  FinalProthesisTryInEntity? singleAndBridge_TryIn;
  FinalProthesisDeliveryEntity? singleAndBridge_Delivery;
  FinalProthesisHealingCollarEntity? fullArch_HealingCollar;
  FinalProthesisImpressionEntity? fullArch_Impression;
  FinalProthesisTryInEntity? fullArch_TryIn;
  FinalProthesisDeliveryEntity? fullArch_Delivery;
  String? str_complicationsAfterProsthesis;
  AdvancedProstheticSearchResponseEntity({
    this.id,
    this.tooth,
    this.secondaryId,
    this.patientName,
    this.diagnosticImpression,
    this.bite,
    this.scanAppliance,
    this.singleAndBridge_HealingCollar,
    this.singleAndBridge_Impression,
    this.singleAndBridge_TryIn,
    this.singleAndBridge_Delivery,
    this.fullArch_HealingCollar,
    this.fullArch_Impression,
    this.fullArch_TryIn,
    this.fullArch_Delivery,
    this.str_complicationsAfterProsthesis,
  });

  @override
  List<Object?> get props => [
        id,
        tooth,
        secondaryId,
        patientName,
        diagnosticImpression,
        bite,
        scanAppliance,
        singleAndBridge_HealingCollar,
        singleAndBridge_Impression,
        singleAndBridge_TryIn,
        singleAndBridge_Delivery,
        fullArch_HealingCollar,
        fullArch_Impression,
        fullArch_TryIn,
        fullArch_Delivery,
        str_complicationsAfterProsthesis,
      ];
}
