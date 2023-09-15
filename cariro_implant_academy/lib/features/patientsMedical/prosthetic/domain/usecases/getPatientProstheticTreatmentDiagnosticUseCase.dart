import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class GetPatientProstheticTreatmentDiagnosticUseCase extends UseCases<ProstheticTreatmentEntity, int> {
  final ProstheticRepository prostheticRepository;

  GetPatientProstheticTreatmentDiagnosticUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, ProstheticTreatmentEntity>> call(int id) async {
    return  await  prostheticRepository.getPatientProstheticTreatmentDiagnostic(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Diagnostics: ${l.message ?? ""}"),
          (r) {
            r.prostheticDiagnostic_DiagnosticImpression = (r.prostheticDiagnostic_DiagnosticImpression??[]).map((e) => DiagnosticImpressionEntity(
              id: e.id,
              patientId: e.patientId,
              operator: e.operator,
              date: e.date,
              operatorId: e.operatorId,
              diagnostic: e.diagnostic,
              needsRemake: e.needsRemake,
              nextStep: e.nextStep,
              patient: e.patient,
              prostheticTreatmentId: e.prostheticTreatmentId,
            )).toList();
            r.prostheticDiagnostic_Bite = (r.prostheticDiagnostic_Bite??[]).map((e) => BiteEntity(
              id: e.id,
              patientId: e.patientId,
              operator: e.operator,
              date: e.date,
              operatorId: e.operatorId,
              diagnostic: e.diagnostic,
              needsRemake: e.needsRemake,
              nextStep: e.nextStep,
              patient: e.patient,
              prostheticTreatmentId: e.prostheticTreatmentId,
            )).toList();
            r.prostheticDiagnostic_ScanAppliance = (r.prostheticDiagnostic_ScanAppliance??[]).map((e) => ScanApplianceEntity(
              id: e.id,
              patientId: e.patientId,
              operator: e.operator,
              date: e.date,
              operatorId: e.operatorId,
              diagnostic: e.diagnostic,
              needsRemake: e.needsRemake,
              patient: e.patient,
              prostheticTreatmentId: e.prostheticTreatmentId,
            )).toList();
            return Right(r);
          },
        ));
  }
}
