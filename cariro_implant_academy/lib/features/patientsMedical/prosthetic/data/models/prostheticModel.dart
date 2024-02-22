import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/scanApplianceModel.dart';

import '../../domain/entities/prostheticDiagnosticEntity.dart';
import 'biteModel.dart';
import 'diagnosticImpressionModel.dart';

class ProstheticTreatmentModel extends ProstheticTreatmentEntity {
  ProstheticTreatmentModel({
    super.id,
    super.date,
    super.patientId,
    super.secondaryId,
    super.patient,
    super.prostheticDiagnostic_DiagnosticImpression,
    super.prostheticDiagnostic_Bite,
    super.prostheticDiagnostic_ScanAppliance,
    super.searchProstheticDiagnostic_Bite,
    super.searchProstheticDiagnostic_DiagnosticImpression,
    super.searchProstheticDiagnostic_ScanAppliance,
    super.searchTeethClassification,
  });

  factory ProstheticTreatmentModel.fromEntity(ProstheticTreatmentEntity entity) {
    return ProstheticTreatmentModel(
      id: entity.id,
      date: entity.date,
      patientId: entity.patientId,
      secondaryId: entity.secondaryId,
      patient: entity.patient,
      searchTeethClassification: entity.searchTeethClassification,
      prostheticDiagnostic_Bite: entity.prostheticDiagnostic_Bite,
      prostheticDiagnostic_DiagnosticImpression: entity.prostheticDiagnostic_DiagnosticImpression,
      prostheticDiagnostic_ScanAppliance: entity.prostheticDiagnostic_ScanAppliance,
      searchProstheticDiagnostic_Bite: entity.searchProstheticDiagnostic_Bite,
      searchProstheticDiagnostic_DiagnosticImpression: entity.searchProstheticDiagnostic_DiagnosticImpression,
      searchProstheticDiagnostic_ScanAppliance: entity.searchProstheticDiagnostic_ScanAppliance,
    );
  }

  ProstheticTreatmentModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.date = DateTime.tryParse(json['date'] ?? "")?.toLocal();
    this.secondaryId = json['secondaryId'];
    this.patientId = json['patientId'];
    this.patient = BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    this.prostheticDiagnostic_DiagnosticImpression = ((json['prostheticDiagnostic_DiagnosticImpression'] ?? []) as List<dynamic>)
        .map((e) => DiagnosticImpressionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    this.prostheticDiagnostic_Bite =
        ((json['prostheticDiagnostic_Bite'] ?? []) as List<dynamic>).map((e) => BiteModel.fromJson(e as Map<String, dynamic>)).toList();
    this.prostheticDiagnostic_ScanAppliance = ((json['prostheticDiagnostic_ScanAppliance'] ?? []) as List<dynamic>)
        .map((e) => ScanApplianceModel.fromJson(e as Map<String, dynamic>))
        .toList();

    this.searchProstheticDiagnostic_DiagnosticImpression = json['searchProstheticDiagnostic_DiagnosticImpression'] == null
        ? null
        : DiagnosticImpressionModel.fromJson(json['searchProstheticDiagnostic_DiagnosticImpression'] as Map<String, dynamic>);
    this.searchProstheticDiagnostic_Bite =
        json['searchProstheticDiagnostic_Bite'] == null ? null : BiteModel.fromJson(json['searchProstheticDiagnostic_Bite'] as Map<String, dynamic>);
    this.searchProstheticDiagnostic_ScanAppliance = json['searchProstheticDiagnostic_ScanAppliance'] == null
        ? null
        : ScanApplianceModel.fromJson(json['searchProstheticDiagnostic_ScanAppliance'] as Map<String, dynamic>);

    this.searchTeethClassification =
        json['searchTeethClassification'] == null ? null : EnumTeethClassification.values[json['searchTeethClassification']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date?.toUtc().toIso8601String();
    data['patientId'] = this.patientId;
    data['prostheticDiagnostic_DiagnosticImpression'] = this.prostheticDiagnostic_DiagnosticImpression == null
        ? []
        : this.prostheticDiagnostic_DiagnosticImpression!.map((e) => DiagnosticImpressionModel.fromEntity(e).toJson()).toList();
    data['prostheticDiagnostic_Bite'] =
        this.prostheticDiagnostic_Bite == null ? [] : this.prostheticDiagnostic_Bite!.map((e) => BiteModel.fromEntity(e).toJson()).toList();
    data['prostheticDiagnostic_ScanAppliance'] = this.prostheticDiagnostic_ScanAppliance == null
        ? []
        : this.prostheticDiagnostic_ScanAppliance!.map((e) => ScanApplianceModel.fromEntity(e).toJson()).toList();
    data['searchProstheticDiagnostic_DiagnosticImpression'] = this.searchProstheticDiagnostic_DiagnosticImpression == null
        ? null
        : DiagnosticImpressionModel.fromEntity(this.searchProstheticDiagnostic_DiagnosticImpression!).toJson();

    data['searchProstheticDiagnostic_Bite'] =
        this.searchProstheticDiagnostic_Bite == null ? null : BiteModel.fromEntity(this.searchProstheticDiagnostic_Bite!).toJson();

    data['searchProstheticDiagnostic_ScanAppliance'] = this.searchProstheticDiagnostic_ScanAppliance == null
        ? null
        : ScanApplianceModel.fromEntity(this.searchProstheticDiagnostic_ScanAppliance!).toJson();

    return data;
  }

  bool isNull() =>
      ((prostheticDiagnostic_DiagnosticImpression?.isEmpty ?? true) ||
          (prostheticDiagnostic_DiagnosticImpression?.any((element) => element.isNull()) ?? true)) &&
      ((prostheticDiagnostic_Bite?.isEmpty ?? true) || (prostheticDiagnostic_Bite?.any((element) => element.isNull()) ?? true)) &&
      ((prostheticDiagnostic_ScanAppliance?.isEmpty ?? true) || (prostheticDiagnostic_ScanAppliance?.any((element) => element.isNull()) ?? true));
}
