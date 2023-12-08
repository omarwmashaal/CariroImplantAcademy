import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/datasources/clinicTreatmentDatasource.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicDoctorPercentageEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/repositories/clinicTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class ClinicTreatmentRepoImpl implements ClinicTreatmentRepo {
  final ClinicTreatmentDatasource clinicTreatmentDatasource;

  ClinicTreatmentRepoImpl({required this.clinicTreatmentDatasource});

  @override
  Future<Either<Failure, ClinicTreatmentEntity>> getTreatment(int id) async {
    try {
      final result = await clinicTreatmentDatasource.getTreatment(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateTreatment(int id, ClinicTreatmentEntity model)async {
    try {
      final result = await clinicTreatmentDatasource.updateTreatment(id,model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ClinicDoctorPercentageEntity>>> getDoctorPercentageForPatient(int id) async {
    try {
      final result = await clinicTreatmentDatasource.getDoctorPercentageForPatient(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateClinicReceipt(int patientId, int treatmentId) async {
    try {
      final result = await clinicTreatmentDatasource.updateClinicReceipt(patientId,treatmentId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
