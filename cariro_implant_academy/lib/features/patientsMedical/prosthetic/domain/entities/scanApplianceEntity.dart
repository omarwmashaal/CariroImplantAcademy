import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticTreatmentDiagnosticParent.dart';

import '../enums/enum.dart';

class ScanApplianceEntity extends ProstheticTreatmentDiagnosticParent {
  EnumProstheticDiagnosticScanApplianceDiagnostic? diagnostic;

  ScanApplianceEntity({
    super.date,
    super.id,
    super.needsRemake,
    super.operator,
    super.operatorId,
    super.patient,
    super.patientId,
    super.prostheticTreatmentId,
    super.scanned,
    this.diagnostic,
  });

  @override
  List<Object?> get props => super.props
    ..addAll([
      diagnostic,
    ]);

  bool isNull() => diagnostic == null;
}
