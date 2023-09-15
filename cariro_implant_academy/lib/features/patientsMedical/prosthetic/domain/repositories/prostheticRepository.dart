import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:dartz/dartz.dart';

abstract class ProstheticRepository{
  Future<Either<Failure,ProstheticTreatmentEntity>> getPatientProstheticTreatmentDiagnostic(int id);
  Future<Either<Failure,ProstheticTreatmentEntity>> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id);
  Future<Either<Failure,ProstheticTreatmentEntity>> getPatientProstheticTreatmentFinalProthesisFullArch(int id);
  Future<Either<Failure,NoParams>> updatePatientProstheticTreatmentDiagnostic(ProstheticTreatmentEntity data);
  Future<Either<Failure,NoParams>> updatePatientProstheticTreatmentFinalProthesisSingleBridge(ProstheticTreatmentEntity data);
  Future<Either<Failure,NoParams>> updatePatientProstheticTreatmentFinalProthesisFullArch(ProstheticTreatmentEntity data);
}