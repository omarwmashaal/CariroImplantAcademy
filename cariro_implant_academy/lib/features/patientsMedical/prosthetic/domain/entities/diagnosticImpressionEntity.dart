import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticTreatmentDiagnosticParent.dart';

import '../enums/enum.dart';

class DiagnosticImpressionEntity extends ProstheticTreatmentDiagnosticParent {
  EnumProstheticDiagnosticDiagnosticImpressionDiagnostic? diagnostic;
  EnumProstheticDiagnosticDiagnosticImpressionNextStep? nextStep;

  DiagnosticImpressionEntity({
    super.date,
    super.id,
    super.needsRemake,
    super.operator,
    super.operatorId,
    super.patient,
    super.patientId,
    super.prostheticTreatmentId,
    this.diagnostic,
    this.nextStep,
  });

  @override
  List<Object?> get props => super.props
      ..addAll([
        diagnostic,
        nextStep,
      ]);


}
