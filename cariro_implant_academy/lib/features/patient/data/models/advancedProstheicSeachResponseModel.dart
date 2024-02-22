import 'package:cariro_implant_academy/Models/MedicalModels/ProstheticTreatmentModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchResonseEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/models/complicationsAfterProsthesisModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/biteModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/diagnosticImpressionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisDeliveryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisHeallingCollarModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisImporessionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisTryInModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/scanApplianceModel.dart';

class AdvancedProstheicSeachResponseModel extends AdvancedProstheticSearchResponseEntity {
  AdvancedProstheicSeachResponseModel({
    super.id,
    super.tooth,
    super.secondaryId,
    super.patientName,
    super.diagnosticImpression,
    super.bite,
    super.scanAppliance,
    super.singleAndBridge_HealingCollar,
    super.singleAndBridge_Impression,
    super.singleAndBridge_TryIn,
    super.singleAndBridge_Delivery,
    super.fullArch_HealingCollar,
    super.fullArch_Impression,
    super.fullArch_TryIn,
    super.fullArch_Delivery,
    super.str_complicationsAfterProsthesis,
  });

  factory AdvancedProstheicSeachResponseModel.fromJson(Map<String, dynamic> data) {
    return AdvancedProstheicSeachResponseModel(
      diagnosticImpression: data['diagnosticImpression'] == null ? null : DiagnosticImpressionModel.fromJson(data['diagnosticImpression']),
      bite: data['bite'] == null ? null : BiteModel.fromJson(data['bite']),
      scanAppliance: data['scanAppliance'] == null ? null : ScanApplianceModel.fromJson(data['scanAppliance']),
      singleAndBridge_HealingCollar:
          data['singleAndBridge_HealingCollar'] == null ? null : FinalProthesisHealingCollarModel.fromMap(data['singleAndBridge_HealingCollar']),
      singleAndBridge_Impression:
          data['singleAndBridge_Impression'] == null ? null : FinalProthesisImpressionModel.fromMap(data['singleAndBridge_Impression']),
      singleAndBridge_TryIn: data['singleAndBridge_TryIn'] == null ? null : FinalProthesisTryInModel.fromMap(data['singleAndBridge_TryIn']),
      singleAndBridge_Delivery:
          data['singleAndBridge_Delivery'] == null ? null : FinalProthesisDeliveryModel.fromMap(data['singleAndBridge_Delivery']),
      fullArch_HealingCollar:
          data['fullArch_HealingCollar'] == null ? null : FinalProthesisHealingCollarModel.fromMap(data['fullArch_HealingCollar']),
      fullArch_Impression: data['fullArch_Impression'] == null ? null : FinalProthesisImpressionModel.fromMap(data['fullArch_Impression']),
      fullArch_TryIn: data['fullArch_TryIn'] == null ? null : FinalProthesisTryInModel.fromMap(data['fullArch_TryIn']),
      fullArch_Delivery: data['fullArch_Delivery'] == null ? null : FinalProthesisDeliveryModel.fromMap(data['fullArch_Delivery']),
      str_complicationsAfterProsthesis: data['str_ComplicationsAfterProsthesis'],
      id: data['id'],
      patientName: data['patientName'],
      secondaryId: data['secondaryId'],
      tooth: data['tooth'],
    );
  }
}
