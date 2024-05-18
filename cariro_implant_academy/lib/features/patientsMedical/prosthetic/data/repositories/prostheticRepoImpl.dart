import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/datasources/prostheticDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticFinalEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class ProstheticRepoImpl implements ProstheticRepository {
  final ProstheticDatasource prostheticDatasource;
  ProstheticRepoImpl({required this.prostheticDatasource});
  @override
  Future<Either<Failure, List<ProstheticStepEntity>>> getPatientProstheticTreatmentDiagnostic(int id) async {
    try {
      final result = await prostheticDatasource.getPatientProstheticTreatmentDiagnostic(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ProstheticStepEntity>>> getPatientProstheticTreatmentFinalProthesisFullArch(int id) async {
    try {
      final result = await prostheticDatasource.getPatientProstheticTreatmentFinalProthesis(id, false);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ProstheticStepEntity>>> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id) async {
    try {
      final result = await prostheticDatasource.getPatientProstheticTreatmentFinalProthesis(id, true);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentDiagnostic(int patientId, List<ProstheticStepEntity> data) async {
    try {
      final result = await prostheticDatasource.updatePatientProstheticTreatmentDiagnostic(patientId, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentFinalProthesisFullArch(int patientId, List<ProstheticStepEntity> data) async {
    try {
      final result = await prostheticDatasource.updatePatientProstheticTreatmentFinalProthesisFullArch(patientId, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentFinalProthesisSingleBridge(int patientId, List<ProstheticStepEntity> data) async {
    try {
      final result = await prostheticDatasource.updatePatientProstheticTreatmentFinalProthesisSingleBridge(patientId, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
