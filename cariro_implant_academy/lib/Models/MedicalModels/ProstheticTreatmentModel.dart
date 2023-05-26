import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';

import '../Enum.dart';

class ProstheticTreatmentModel {
  int? id;
  int? patientId;
  DropDownDTO? patient;
  List<DiagnosticImpressionModel>? prostheticDiagnostic_DiagnosticImpression;
  List<BiteModel>? prostheticDiagnostic_Bite;
  List<ScanApplianceModel>? prostheticDiagnostic_ScanAppliance;

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

  ProstheticTreatmentModel({
    this.id,
    this.patientId,
    this.patient,
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
  });

  ProstheticTreatmentModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.patientId = json['patientId'];
    this.patient = DropDownDTO.fromJson(json['patient'] ?? Map<String, dynamic>());
    this.prostheticDiagnostic_DiagnosticImpression = ((json['prostheticDiagnostic_DiagnosticImpression'] ?? []) as List<dynamic>)
        .map((e) => DiagnosticImpressionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    this.prostheticDiagnostic_Bite =
        ((json['prostheticDiagnostic_Bite'] ?? []) as List<dynamic>).map((e) => BiteModel.fromJson(e as Map<String, dynamic>)).toList();
    this.prostheticDiagnostic_ScanAppliance =
        ((json['prostheticDiagnostic_ScanAppliance'] ?? []) as List<dynamic>).map((e) => ScanApplianceModel.fromJson(e as Map<String, dynamic>)).toList();

    this.finalProthesisSingleBridgeTeeth = ((json['finalProthesisSingleBridgeTeeth'] ?? []) as List<dynamic>).map((e) => e as int).toList();
    this.finalProthesisSingleBridgeHealingCollar = json['finalProthesisSingleBridgeHealingCollar'] ?? false;
    this.finalProthesisSingleBridgeHealingCollarStatus = json['finalProthesisSingleBridgeHealingCollarStatus'] == null
        ? null
        : EnumFinalProthesisSingleBridgeHealingCollarStatus.values[json['finalProthesisSingleBridgeHealingCollarStatus']];
    this.finalProthesisSingleBridgeHealingCollarNextVisit = json['finalProthesisSingleBridgeHealingCollarNextVisit'] == null
        ? null
        : EnumFinalProthesisSingleBridgeHealingCollarNextVisit.values[json['finalProthesisSingleBridgeHealingCollarNextVisit']];
    this.finalProthesisSingleBridgeImpression = json['finalProthesisSingleBridgeImpression'] ?? false;
    this.finalProthesisSingleBridgeImpressionStatus = json['finalProthesisSingleBridgeImpressionStatus'] == null
        ? null
        : EnumFinalProthesisSingleBridgeImpressionStatus.values[json['finalProthesisSingleBridgeImpressionStatus']];
    this.finalProthesisSingleBridgeImpressionNextVisit = json['finalProthesisSingleBridgeImpressionNextVisit'] == null
        ? null
        : EnumFinalProthesisSingleBridgeImpressionNextVisit.values[json['finalProthesisSingleBridgeImpressionNextVisit']];
    this.finalProthesisSingleBridgeTryIn = json['finalProthesisSingleBridgeTryIn'] ?? false;
    this.finalProthesisSingleBridgeTryInStatus = json['finalProthesisSingleBridgeTryInStatus'] == null
        ? null
        : EnumFinalProthesisSingleBridgeTryInStatus.values[json['finalProthesisSingleBridgeTryInStatus']];
    this.finalProthesisSingleBridgeTryInNextVisit = json['finalProthesisSingleBridgeTryInNextVisit'] == null
        ? null
        : EnumFinalProthesisSingleBridgeTryInNextVisit.values[json['finalProthesisSingleBridgeTryInNextVisit']];
    this.finalProthesisSingleBridgeDelivery = json['finalProthesisSingleBridgeDelivery'] ?? false;
    this.finalProthesisSingleBridgeDeliveryStatus = json['finalProthesisSingleBridgeDeliveryStatus'] == null
        ? null
        : EnumFinalProthesisSingleBridgeDeliveryStatus.values[json['finalProthesisSingleBridgeDeliveryStatus']];
    this.finalProthesisSingleBridgeDeliveryNextVisit = json['finalProthesisSingleBridgeDeliveryNextVisit'] == null
        ? null
        : EnumFinalProthesisSingleBridgeDeliveryNextVisit.values[json['finalProthesisSingleBridgeDeliveryNextVisit']];

    this.finalProthesisFullArchHealingCollar = json['finalProthesisFullArchHealingCollar'] ?? false;
    this.finalProthesisFullArchHealingCollarStatus = json['finalProthesisFullArchHealingCollarStatus'] == null
        ? null
        : EnumFinalProthesisSingleBridgeHealingCollarStatus.values[json['finalProthesisFullArchHealingCollarStatus']];
    this.finalProthesisFullArchHealingCollarNextVisit = json['finalProthesisFullArchHealingCollarNextVisit'] == null
        ? null
        : EnumFinalProthesisSingleBridgeHealingCollarNextVisit.values[json['finalProthesisFullArchHealingCollarNextVisit']];
    this.finalProthesisFullArchImpression = json['finalProthesisFullArchImpression'] ?? false;
    this.finalProthesisFullArchImpressionStatus = json['finalProthesisFullArchImpressionStatus'] == null
        ? null
        : EnumFinalProthesisSingleBridgeImpressionStatus.values[json['finalProthesisFullArchImpressionStatus']];
    this.finalProthesisFullArchImpressionNextVisit = json['finalProthesisFullArchImpressionNextVisit'] == null
        ? null
        : EnumFinalProthesisSingleBridgeImpressionNextVisit.values[json['finalProthesisFullArchImpressionNextVisit']];
    this.finalProthesisFullArchTryIn = json['finalProthesisFullArchTryIn'] ?? false;
    this.finalProthesisFullArchTryInStatus =
        json['finalProthesisFullArchTryInStatus'] == null ? null : EnumFinalProthesisSingleBridgeTryInStatus.values[json['finalProthesisFullArchTryInStatus']];

    this.finalProthesisFullArchTryInNextVisit =
        json['finalProthesisFullArchTryInNextVisit'] == null ? null : EnumFinalProthesisSingleBridgeTryInNextVisit.values[json['finalProthesisFullArchTryInNextVisit']];
    this.finalProthesisFullArchDelivery = json['finalProthesisFullArchDelivery'] ?? false;
    this.finalProthesisFullArchDeliveryStatus = json['finalProthesisFullArchDeliveryStatus'] == null
        ? null
        : EnumFinalProthesisSingleBridgeDeliveryStatus.values[json['finalProthesisFullArchDeliveryStatus']];
    this.finalProthesisFullArchDeliveryNextVisit = json['finalProthesisFullArchDeliveryNextVisit'] == null
        ? null
        : EnumFinalProthesisSingleBridgeDeliveryNextVisit.values[json['finalProthesisFullArchDeliveryNextVisit']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['prostheticDiagnostic_DiagnosticImpression'] =
        this.prostheticDiagnostic_DiagnosticImpression == null ? [] : this.prostheticDiagnostic_DiagnosticImpression!.map((e) => e.toJson()).toList();
    data['prostheticDiagnostic_Bite'] = this.prostheticDiagnostic_Bite == null ? [] : this.prostheticDiagnostic_Bite!.map((e) => e.toJson()).toList();
    data['prostheticDiagnostic_ScanAppliance'] =
        this.prostheticDiagnostic_ScanAppliance == null ? [] : this.prostheticDiagnostic_ScanAppliance!.map((e) => e.toJson()).toList();
    data['finalProthesisSingleBridgeTeeth'] = this.finalProthesisSingleBridgeTeeth;
    data['finalProthesisSingleBridgeHealingCollar'] = this.finalProthesisSingleBridgeHealingCollar ?? false;
    data['finalProthesisSingleBridgeHealingCollarStatus'] =
        this.finalProthesisSingleBridgeHealingCollarStatus != null ? this.finalProthesisSingleBridgeHealingCollarStatus!.index : null;
    data['finalProthesisSingleBridgeHealingCollarNextVisit'] =
        this.finalProthesisSingleBridgeHealingCollarNextVisit != null ? this.finalProthesisSingleBridgeHealingCollarNextVisit!.index : null;
    data['finalProthesisSingleBridgeImpression'] = this.finalProthesisSingleBridgeImpression ?? false;
    data['finalProthesisSingleBridgeImpressionStatus'] =
        this.finalProthesisSingleBridgeImpressionStatus != null ? this.finalProthesisSingleBridgeImpressionStatus!.index : null;
    data['finalProthesisSingleBridgeImpressionNextVisit'] =
        this.finalProthesisSingleBridgeImpressionNextVisit != null ? this.finalProthesisSingleBridgeImpressionNextVisit!.index : null;
    data['finalProthesisSingleBridgeTryIn'] = this.finalProthesisSingleBridgeTryIn ?? false;
    data['finalProthesisSingleBridgeTryInStatus'] =
        this.finalProthesisSingleBridgeTryInStatus != null ? this.finalProthesisSingleBridgeTryInStatus!.index : null;
    data['finalProthesisSingleBridgeTryInNextVisit'] =
        this.finalProthesisSingleBridgeTryInNextVisit != null ? this.finalProthesisSingleBridgeTryInNextVisit!.index : null;
    data['finalProthesisSingleBridgeDelivery'] = this.finalProthesisSingleBridgeDelivery ?? false;
    data['finalProthesisSingleBridgeDeliveryStatus'] =
        this.finalProthesisSingleBridgeDeliveryStatus != null ? this.finalProthesisSingleBridgeDeliveryStatus!.index : null;
    data['finalProthesisSingleBridgeDeliveryNextVisit'] =
        this.finalProthesisSingleBridgeDeliveryNextVisit != null ? this.finalProthesisSingleBridgeDeliveryNextVisit!.index : null;
    data['finalProthesisFullArchHealingCollar'] = this.finalProthesisFullArchHealingCollar ?? false;
    data['finalProthesisFullArchHealingCollarStatus'] =
        this.finalProthesisFullArchHealingCollarStatus != null ? this.finalProthesisFullArchHealingCollarStatus!.index : null;
    data['finalProthesisFullArchHealingCollarNextVisit'] =
        this.finalProthesisFullArchHealingCollarNextVisit != null ? this.finalProthesisFullArchHealingCollarNextVisit!.index : null;
    data['finalProthesisFullArchImpression'] = this.finalProthesisFullArchImpression ?? false;
    data['finalProthesisFullArchImpressionStatus'] =
        this.finalProthesisFullArchImpressionStatus != null ? this.finalProthesisFullArchImpressionStatus!.index : null;
    data['finalProthesisFullArchImpressionNextVisit'] =
        this.finalProthesisFullArchImpressionNextVisit != null ? this.finalProthesisFullArchImpressionNextVisit!.index : null;
    data['finalProthesisFullArchTryIn'] = this.finalProthesisFullArchTryIn ?? false;
    data['finalProthesisFullArchTryInStatus'] = this.finalProthesisFullArchTryInStatus != null ? this.finalProthesisFullArchTryInStatus!.index : null;
    data['finalProthesisFullArchTryInNextVisit'] = this.finalProthesisFullArchTryInNextVisit != null ? this.finalProthesisFullArchTryInNextVisit!.index : null;
    data['finalProthesisFullArchDelivery'] = this.finalProthesisFullArchDelivery ?? false;
    data['finalProthesisFullArchDeliveryStatus'] = this.finalProthesisFullArchDeliveryStatus != null ? this.finalProthesisFullArchDeliveryStatus!.index : null;
    data['finalProthesisFullArchDeliveryNextVisit'] = this.finalProthesisFullArchDeliveryNextVisit != null ? this.finalProthesisFullArchDeliveryNextVisit!.index : null;
    return data;
  }
}

class DiagnosticImpressionModel extends _ProstheticTreatmentDiagnosticParentModel {
  EnumProstheticDiagnosticDiagnosticImpressionDiagnostic? diagnostic;
  EnumProstheticDiagnosticDiagnosticImpressionNextStep? nextStep;

  DiagnosticImpressionModel();

  DiagnosticImpressionModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    this.nextStep = json['nextStep'] == null ? null : EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[json['nextStep']!];
    this.diagnostic = json['diagnostic'] == null ? null : EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[json['diagnostic']!];
  }

  Map<String, dynamic> toJson() {
    var data = super.toJson();
    data['nextStep'] = this.nextStep == null ? null : this.nextStep!.index;
    data['diagnostic'] = this.diagnostic == null ? null : this.diagnostic!.index;
    return data;
  }
}

class BiteModel extends _ProstheticTreatmentDiagnosticParentModel {
  EnumProstheticDiagnosticBiteDiagnostic? diagnostic;
  EnumProstheticDiagnosticBiteNextStep? nextStep;

  BiteModel();

  BiteModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    this.nextStep = json['nextStep'] == null ? null : EnumProstheticDiagnosticBiteNextStep.values[json['nextStep']!];
    this.diagnostic = json['diagnostic'] == null ? null : EnumProstheticDiagnosticBiteDiagnostic.values[json['diagnostic']!];
  }

  Map<String, dynamic> toJson() {
    var data = super.toJson();
    data['nextStep'] = this.nextStep == null ? null : this.nextStep!.index;
    data['diagnostic'] = this.diagnostic == null ? null : this.diagnostic!.index;
    return data;
  }
}

class ScanApplianceModel extends _ProstheticTreatmentDiagnosticParentModel {
  EnumProstheticDiagnosticScanApplianceDiagnostic? diagnostic;

  ScanApplianceModel();

  ScanApplianceModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    this.diagnostic = json['diagnostic'] == null ? null : EnumProstheticDiagnosticScanApplianceDiagnostic.values[json['diagnostic']!];
  }

  Map<String, dynamic> toJson() {
    var data = super.toJson();
    data['diagnostic'] = this.diagnostic == null ? null : this.diagnostic!.index;
    return data;
  }
}

class _ProstheticTreatmentDiagnosticParentModel {
  int? id;
  int? prostheticTreatmentId;
  int? patientId;
  DropDownDTO? patient;
  String? date;
  int? operatorId;
  DropDownDTO? operator;
  bool? needsRemake;

  _ProstheticTreatmentDiagnosticParentModel({
    this.date,
    this.id,
    this.needsRemake,
    this.operator,
    this.operatorId,
    this.patient,
    this.patientId,
    this.prostheticTreatmentId,
  }) {
    if (operator == null) operator = DropDownDTO();
  }

  fromJson(Map<String, dynamic> json) {
    this.date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    this.id = json['id'];
    this.needsRemake = json['needsRemake'] ?? false;
    this.operator = DropDownDTO.fromJson(json['operator'] ?? Map<String, dynamic>());
    this.operatorId = json['operatorId'];
    this.patientId = json['patientId'];
    this.prostheticTreatmentId = json['prostheticTreatmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = CIA_DateConverters.fromDateTimeToBackend(this.date);
    data['id'] = this.id;
    data['needsRemake'] = this.needsRemake ?? false;
    data['patientId'] = this.patientId;
    data['operatorId'] = this.operatorId;
    data['prostheticTreatmentId'] = this.prostheticTreatmentId;
    return data;
  }
}
