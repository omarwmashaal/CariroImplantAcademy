import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';

import '../Enum.dart';

class ProstheticTreatmentModel {
  int? id;
  int? patientId;
  DropDownDTO? patient;
  EnumProstheticDiagnosticDiagnosticImpressionDiagnostic? prostheticDiagnosticDiagnosticImpressionDiagnostic;
  EnumProstheticDiagnosticDiagnosticImpressionNextStep? prostheticDiagnosticDiagnosticImpressionNextStep;
  bool? prostheticDiagnosticDiagnosticImpressionNeedsRemake;
  EnumProstheticDiagnosticBiteDiagnostic? prostheticDiagnosticBiteDiagnostic;
  EnumProstheticDiagnosticBiteNextStep? prostheticDiagnosticBiteNextStep;
  bool? prostheticDiagnosticBiteNeedsRemake;
  EnumProstheticDiagnosticScanApplianceDiagnostic? prostheticDiagnosticScanApplianceDiagnostic;
  bool? prostheticDiagnosticScanApplianceNeedsRemake;
  List<int>? finalProthesisSingleBridgeTeeth;
  bool? finalProthesisSingleBridgeHealingCollar;
  EnumFinalProthesisSingleBridgeHealingCollarStatus? finalProthesisSingleBridgeHealingCollarStatus;
  bool? finalProthesisSingleBridgeImpression;
  EnumFinalProthesisSingleBridgeImpressionStatus? finalProthesisSingleBridgeImpressionStatus;
  bool? finalProthesisSingleBridgeTryIn;
  EnumFinalProthesisSingleBridgeTryInStatus? finalProthesisSingleBridgeTryInStatus;
  bool? finalProthesisSingleBridgeDelivery;
  EnumFinalProthesisSingleBridgeDeliveryStatus? finalProthesisSingleBridgeDeliveryStatus;

  ProstheticTreatmentModel({
    this.id,
    this.patientId,
    this.patient,
    this.prostheticDiagnosticDiagnosticImpressionDiagnostic,
    this.prostheticDiagnosticDiagnosticImpressionNextStep,
    this.prostheticDiagnosticDiagnosticImpressionNeedsRemake,
    this.prostheticDiagnosticBiteDiagnostic,
    this.prostheticDiagnosticBiteNextStep,
    this.prostheticDiagnosticBiteNeedsRemake,
    this.prostheticDiagnosticScanApplianceDiagnostic,
    this.prostheticDiagnosticScanApplianceNeedsRemake,
    this.finalProthesisSingleBridgeTeeth,
    this.finalProthesisSingleBridgeHealingCollar,
    this.finalProthesisSingleBridgeHealingCollarStatus,
    this.finalProthesisSingleBridgeImpression,
    this.finalProthesisSingleBridgeImpressionStatus,
    this.finalProthesisSingleBridgeTryIn,
    this.finalProthesisSingleBridgeTryInStatus,
    this.finalProthesisSingleBridgeDelivery,
    this.finalProthesisSingleBridgeDeliveryStatus,
  });

  ProstheticTreatmentModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.patientId = json['patientId'];
    this.patient = DropDownDTO.fromJson(json['patient']??Map<String,dynamic>());
    this.prostheticDiagnosticDiagnosticImpressionDiagnostic =json['prostheticDiagnosticDiagnosticImpressionDiagnostic']==null?null: EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[json['prostheticDiagnosticDiagnosticImpressionDiagnostic']];
    this.prostheticDiagnosticDiagnosticImpressionNextStep = json['prostheticDiagnosticDiagnosticImpressionNextStep']==null?null:EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[json['prostheticDiagnosticDiagnosticImpressionNextStep']];
    this.prostheticDiagnosticDiagnosticImpressionNeedsRemake = json['prostheticDiagnosticDiagnosticImpressionNeedsRemake']??false;
    this.prostheticDiagnosticBiteDiagnostic = json['prostheticDiagnosticBiteDiagnostic']==null?null:EnumProstheticDiagnosticBiteDiagnostic.values[json['prostheticDiagnosticBiteDiagnostic']];
    this.prostheticDiagnosticBiteNextStep =json['prostheticDiagnosticBiteNextStep']==null?null:EnumProstheticDiagnosticBiteNextStep.values[json['prostheticDiagnosticBiteNextStep']];
    this.prostheticDiagnosticBiteNeedsRemake = json['prostheticDiagnosticBiteNeedsRemake']??false;
    this.prostheticDiagnosticScanApplianceDiagnostic =json['prostheticDiagnosticScanApplianceDiagnostic']==null?null:EnumProstheticDiagnosticScanApplianceDiagnostic.values[json['prostheticDiagnosticScanApplianceDiagnostic']];
    this.prostheticDiagnosticScanApplianceNeedsRemake = json['prostheticDiagnosticScanApplianceNeedsRemake']??false;
    this.finalProthesisSingleBridgeTeeth = ((json['finalProthesisSingleBridgeTeeth']??[]) as List<dynamic>).map((e) => e as int).toList();
    this.finalProthesisSingleBridgeHealingCollar = json['finalProthesisSingleBridgeHealingCollar']??false;
    this.finalProthesisSingleBridgeHealingCollarStatus =json['finalProthesisSingleBridgeHealingCollarStatus']==null?null: EnumFinalProthesisSingleBridgeHealingCollarStatus.values[json['finalProthesisSingleBridgeHealingCollarStatus']];
    this.finalProthesisSingleBridgeImpression = json['finalProthesisSingleBridgeImpression']??false;
    this.finalProthesisSingleBridgeImpressionStatus =json['finalProthesisSingleBridgeImpressionStatus']==null?null: EnumFinalProthesisSingleBridgeImpressionStatus.values[json['finalProthesisSingleBridgeImpressionStatus']];
    this.finalProthesisSingleBridgeTryIn = json['finalProthesisSingleBridgeTryIn']??false;
    this.finalProthesisSingleBridgeTryInStatus = json['finalProthesisSingleBridgeTryInStatus']==null?null:EnumFinalProthesisSingleBridgeTryInStatus.values[json['finalProthesisSingleBridgeTryInStatus']];
    this.finalProthesisSingleBridgeDelivery = json['finalProthesisSingleBridgeDelivery']??false;
    this.finalProthesisSingleBridgeDeliveryStatus =json['finalProthesisSingleBridgeDeliveryStatus']==null?null: EnumFinalProthesisSingleBridgeDeliveryStatus.values[json['finalProthesisSingleBridgeDeliveryStatus']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['prostheticDiagnosticDiagnosticImpressionDiagnostic'] = this.prostheticDiagnosticDiagnosticImpressionDiagnostic!=null?this.prostheticDiagnosticDiagnosticImpressionDiagnostic!.index:null;
    data['prostheticDiagnosticDiagnosticImpressionNextStep'] = this.prostheticDiagnosticDiagnosticImpressionNextStep!=null?this.prostheticDiagnosticDiagnosticImpressionNextStep!.index:null;
    data['prostheticDiagnosticDiagnosticImpressionNeedsRemake'] = this.prostheticDiagnosticDiagnosticImpressionNeedsRemake??false;
    data['prostheticDiagnosticBiteDiagnostic'] = this.prostheticDiagnosticBiteDiagnostic!=null?this.prostheticDiagnosticBiteDiagnostic!.index:null;
    data['prostheticDiagnosticBiteNextStep'] = this.prostheticDiagnosticBiteNextStep!=null?this.prostheticDiagnosticBiteNextStep!.index:null;
    data['prostheticDiagnosticBiteNeedsRemake'] = this.prostheticDiagnosticBiteNeedsRemake??false;
    data['prostheticDiagnosticScanApplianceDiagnostic'] = this.prostheticDiagnosticScanApplianceDiagnostic!=null?this.prostheticDiagnosticScanApplianceDiagnostic!.index:null;
    data['prostheticDiagnosticScanApplianceNeedsRemake'] = this.prostheticDiagnosticScanApplianceNeedsRemake??false;
    data['finalProthesisSingleBridgeTeeth'] = this.finalProthesisSingleBridgeTeeth;
    data['finalProthesisSingleBridgeHealingCollar'] = this.finalProthesisSingleBridgeHealingCollar??false;
    data['finalProthesisSingleBridgeHealingCollarStatus'] = this.finalProthesisSingleBridgeHealingCollarStatus!=null?this.finalProthesisSingleBridgeHealingCollarStatus!.index:null;
    data['finalProthesisSingleBridgeImpression'] = this.finalProthesisSingleBridgeImpression??false;
    data['finalProthesisSingleBridgeImpressionStatus'] = this.finalProthesisSingleBridgeImpressionStatus!=null?this.finalProthesisSingleBridgeImpressionStatus!.index:null;
    data['finalProthesisSingleBridgeTryIn'] = this.finalProthesisSingleBridgeTryIn??false;
    data['finalProthesisSingleBridgeTryInStatus'] = this.finalProthesisSingleBridgeTryInStatus!=null?this.finalProthesisSingleBridgeTryInStatus!.index:null;
    data['finalProthesisSingleBridgeDelivery'] = this.finalProthesisSingleBridgeDelivery??false;
    data['finalProthesisSingleBridgeDeliveryStatus'] = this.finalProthesisSingleBridgeDeliveryStatus!=null?this.finalProthesisSingleBridgeDeliveryStatus!.index:null;
    return data;
  }
}
