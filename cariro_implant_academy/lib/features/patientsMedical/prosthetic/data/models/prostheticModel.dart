import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/scanApplianceModel.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/prostheticEntity.dart';
import '../../domain/enums/enum.dart';
import 'biteModel.dart';
import 'diagnosticImpressionModel.dart';


class ProstheticTreatmentModel extends ProstheticTreatmentEntity {

  ProstheticTreatmentModel({

    super.id,
    super.patientId,
    super.patient,
    super.prostheticDiagnostic_DiagnosticImpression,
    super.prostheticDiagnostic_Bite,
    super.prostheticDiagnostic_ScanAppliance,
    super.finalProthesisSingleBridgeTeeth,
    super.finalProthesisSingleBridgeHealingCollar,
    super.finalProthesisSingleBridgeHealingCollarStatus,
    super.finalProthesisSingleBridgeHealingCollarNextVisit,
    super.finalProthesisSingleBridgeImpression,
    super.finalProthesisSingleBridgeImpressionStatus,
    super.finalProthesisSingleBridgeImpressionNextVisit,
    super.finalProthesisSingleBridgeTryIn,
    super.finalProthesisSingleBridgeTryInStatus,
    super.finalProthesisSingleBridgeTryInNextVisit,
    super.finalProthesisSingleBridgeDelivery,
    super.finalProthesisSingleBridgeDeliveryStatus,
    super.finalProthesisSingleBridgeDeliveryNextVisit,
    super.finalProthesisFullArchHealingCollar,
    super.finalProthesisFullArchHealingCollarStatus,
    super.finalProthesisFullArchHealingCollarNextVisit,
    super.finalProthesisFullArchImpression,
    super.finalProthesisFullArchImpressionStatus,
    super.finalProthesisFullArchImpressionNextVisit,
    super.finalProthesisFullArchTryIn,
    super.finalProthesisFullArchTryInStatus,
    super.finalProthesisFullArchTryInNextVisit,
    super.finalProthesisFullArchDelivery,
    super.finalProthesisFullArchDeliveryStatus,
    super.finalProthesisFullArchDeliveryNextVisit,
  });

  factory ProstheticTreatmentModel.fromEntity(ProstheticTreatmentEntity entity)
  {
    return ProstheticTreatmentModel(
      id:entity.id,
      patientId:entity.patientId,
      patient:entity.patient,
      finalProthesisSingleBridgeTeeth:entity.finalProthesisSingleBridgeTeeth,
      finalProthesisSingleBridgeHealingCollar:entity.finalProthesisSingleBridgeHealingCollar,
      finalProthesisSingleBridgeHealingCollarStatus:entity.finalProthesisSingleBridgeHealingCollarStatus,
      finalProthesisSingleBridgeHealingCollarNextVisit:entity.finalProthesisSingleBridgeHealingCollarNextVisit,
      finalProthesisSingleBridgeImpression:entity.finalProthesisSingleBridgeImpression,
      finalProthesisSingleBridgeImpressionStatus:entity.finalProthesisSingleBridgeImpressionStatus,
      finalProthesisSingleBridgeImpressionNextVisit:entity.finalProthesisSingleBridgeImpressionNextVisit,
      finalProthesisSingleBridgeTryIn:entity.finalProthesisSingleBridgeTryIn,
      finalProthesisSingleBridgeTryInStatus:entity.finalProthesisSingleBridgeTryInStatus,
      finalProthesisSingleBridgeTryInNextVisit:entity.finalProthesisSingleBridgeTryInNextVisit,
      finalProthesisSingleBridgeDelivery:entity.finalProthesisSingleBridgeDelivery,
      finalProthesisSingleBridgeDeliveryStatus:entity.finalProthesisSingleBridgeDeliveryStatus,
      finalProthesisSingleBridgeDeliveryNextVisit:entity.finalProthesisSingleBridgeDeliveryNextVisit,
      finalProthesisFullArchHealingCollar:entity.finalProthesisFullArchHealingCollar,
      finalProthesisFullArchHealingCollarStatus:entity.finalProthesisFullArchHealingCollarStatus,
      finalProthesisFullArchHealingCollarNextVisit:entity.finalProthesisFullArchHealingCollarNextVisit,
      finalProthesisFullArchImpression:entity.finalProthesisFullArchImpression,
      finalProthesisFullArchImpressionStatus:entity.finalProthesisFullArchImpressionStatus,
      finalProthesisFullArchImpressionNextVisit:entity.finalProthesisFullArchImpressionNextVisit,
      finalProthesisFullArchTryIn:entity.finalProthesisFullArchTryIn,
      finalProthesisFullArchTryInStatus:entity.finalProthesisFullArchTryInStatus,
      finalProthesisFullArchTryInNextVisit:entity.finalProthesisFullArchTryInNextVisit,
      finalProthesisFullArchDelivery:entity.finalProthesisFullArchDelivery,
      finalProthesisFullArchDeliveryStatus:entity.finalProthesisFullArchDeliveryStatus,
      finalProthesisFullArchDeliveryNextVisit:entity.finalProthesisFullArchDeliveryNextVisit,
      prostheticDiagnostic_Bite: entity.prostheticDiagnostic_Bite,
      prostheticDiagnostic_DiagnosticImpression: entity.prostheticDiagnostic_DiagnosticImpression,
      prostheticDiagnostic_ScanAppliance: entity.prostheticDiagnostic_ScanAppliance
    );
  }
  ProstheticTreatmentModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.patientId = json['patientId'];
    this.patient = BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
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
    this.prostheticDiagnostic_DiagnosticImpression == null ? [] : this.prostheticDiagnostic_DiagnosticImpression!.map((e) => DiagnosticImpressionModel.fromEntity(e).toJson()).toList();
    data['prostheticDiagnostic_Bite'] = this.prostheticDiagnostic_Bite == null ? [] : this.prostheticDiagnostic_Bite!.map((e) => BiteModel.fromEntity(e).toJson()).toList();
    data['prostheticDiagnostic_ScanAppliance'] =
    this.prostheticDiagnostic_ScanAppliance == null ? [] : this.prostheticDiagnostic_ScanAppliance!.map((e) => ScanApplianceModel.fromEntity(e).toJson()).toList();
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





