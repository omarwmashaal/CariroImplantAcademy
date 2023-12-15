import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/data/datasources/nonSurgicalTreatmentDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/repositories/nonSurgicalTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/saveNonSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:dartz/dartz.dart';

class NonSurgicalTreatmentRepoImpl implements NonSurgicalTreatmentRepo {
  final NonSurgicalTreatmentDatasource nonSurgicalTreatmentDatasource;

  NonSurgicalTreatmentRepoImpl({required this.nonSurgicalTreatmentDatasource});

  @override
  Future<Either<Failure, List<int>>> checkNonSurgicalTreatmentTeethStatus(String data) async {
    try {
      final result = await nonSurgicalTreatmentDatasource.checkNonSurgicalTreatmentTeethStatus(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<NonSurgicalTreatmentEntity>>> getAllNonSurgicalTreatments(int id) async {
    try {
      final result = await nonSurgicalTreatmentDatasource.getAllNonSurgicalTreatments(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NonSurgicalTreatmentEntity>> getNonSurgicalTreatment(int id) async {
    try {
      final result = await nonSurgicalTreatmentDatasource.getNonSurgicalTreatment(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveNonSurgicalTreatment(SaveNonSurgicalTreatmentParams data) async {
    try {
      final result = await nonSurgicalTreatmentDatasource.saveNonSurgicalTreatment(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, TeethTreatmentPlanEntity?>> getPaidPlanItem({required int patientId, required int tooth}) async {
    try {
      final result = await nonSurgicalTreatmentDatasource.getPaidPlanItem(patientId, tooth);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateNonSurgicalTreatmentNotes(int id, String notes) async {
    try {
      final result = await nonSurgicalTreatmentDatasource.updateNonSurgicalTreatmentNotes(id, notes);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
