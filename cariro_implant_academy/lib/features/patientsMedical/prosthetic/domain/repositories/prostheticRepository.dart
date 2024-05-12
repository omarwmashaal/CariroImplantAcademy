import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:dartz/dartz.dart';

import '../entities/prostheticFinalEntity.dart';

abstract class ProstheticRepository {
  Future<Either<Failure, List<ProstheticStepEntity>>> getPatientProstheticTreatmentDiagnostic(int id);
  Future<Either<Failure, List<ProstheticStepEntity>>> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id);
  Future<Either<Failure, List<ProstheticStepEntity>>> getPatientProstheticTreatmentFinalProthesisFullArch(int id);
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentDiagnostic(List<ProstheticStepEntity> data);
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentFinalProthesisSingleBridge(List<ProstheticStepEntity> data);
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentFinalProthesisFullArch(List<ProstheticStepEntity> data);
}
