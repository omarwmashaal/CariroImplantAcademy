import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';

import '../../features/patientsMedical/prosthetic/domain/enums/enum.dart';
import '../../core/constants/enums/enums.dart';
/*
class ProstheticTreatmentModel {
  int? id;
  int? patientId;
  DropDownDTO? patient;
  List<DiagnosticImpressionModel>? prostheticDiagnostic_DiagnosticImpression;
  List<BiteModel>? prostheticDiagnostic_Bite;
  List<ScanApplianceModel>? prostheticDiagnostic_ScanAppliance;

  ProstheticTreatmentModel({
    this.id,
    this.patientId,
    this.patient,
  });

  bool isNull() =>
      ((prostheticDiagnostic_DiagnosticImpression?.isEmpty ?? true) ||
          (prostheticDiagnostic_DiagnosticImpression?.any((element) => element.isNull()) ?? true)) &&
      ((prostheticDiagnostic_Bite?.isEmpty ?? true) || (prostheticDiagnostic_Bite?.any((element) => element.isNull()) ?? true)) &&
      ((prostheticDiagnostic_ScanAppliance?.isEmpty ?? true) || (prostheticDiagnostic_ScanAppliance?.any((element) => element.isNull()) ?? true));

  ProstheticTreatmentModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.patientId = json['patientId'];
    this.patient = DropDownDTO.fromJson(json['patient'] ?? Map<String, dynamic>());
    this.prostheticDiagnostic_DiagnosticImpression = ((json['prostheticDiagnostic_DiagnosticImpression'] ?? []) as List<dynamic>)
        .map((e) => DiagnosticImpressionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    this.prostheticDiagnostic_Bite =
        ((json['prostheticDiagnostic_Bite'] ?? []) as List<dynamic>).map((e) => BiteModel.fromJson(e as Map<String, dynamic>)).toList();
    this.prostheticDiagnostic_ScanAppliance = ((json['prostheticDiagnostic_ScanAppliance'] ?? []) as List<dynamic>)
        .map((e) => ScanApplianceModel.fromJson(e as Map<String, dynamic>))
        .toList();
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
    return data;
  }

  Compare(ProstheticTreatmentModel model) {
    return this.toJson() == model.toJson();
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

  bool isNull() => diagnostic == null && nextStep == null;
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

  bool isNull() => diagnostic == null && nextStep == null;
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

  bool isNull() => diagnostic == null;
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
    data['needsRemake'] = this.needsRemake;
    data['patientId'] = this.patientId;
    data['operatorId'] = this.operatorId;
    data['prostheticTreatmentId'] = this.prostheticTreatmentId;
    return data;
  }
}
*/