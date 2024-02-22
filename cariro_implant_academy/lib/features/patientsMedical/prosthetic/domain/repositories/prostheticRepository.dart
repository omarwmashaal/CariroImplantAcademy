import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:dartz/dartz.dart';

import '../entities/prostheticFinalEntity.dart';

abstract class ProstheticRepository {
  Future<Either<Failure, ProstheticTreatmentEntity>> getPatientProstheticTreatmentDiagnostic(int id);
  Future<Either<Failure, ProstheticTreatmentFinalEntity>> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id);
  Future<Either<Failure, ProstheticTreatmentFinalEntity>> getPatientProstheticTreatmentFinalProthesisFullArch(int id);
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentDiagnostic(ProstheticTreatmentEntity data);
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentFinalProthesisSingleBridge(ProstheticTreatmentFinalEntity data);
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentFinalProthesisFullArch(ProstheticTreatmentFinalEntity data);
}
