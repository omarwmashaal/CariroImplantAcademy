import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/datasources/treatmentPlanDataSource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class TreatmentPlanRepoImplementation implements TreatmentPlanRepo {
  final TreatmentPlanDataSource treatmentPlanDataSource;
  TreatmentPlanRepoImplementation({required this.treatmentPlanDataSource});
  @override
  Future<Either<Failure, TreatmentPlanEntity>> getTreatmentPlanData(int id) async {
    try {
      final result = await treatmentPlanDataSource.getTreatmentPlanData(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveTreatmentDetailsData(int id, List<TreatmentDetailsEntity> data) async {
    try {
      final result = await treatmentPlanDataSource.saveTreatmentDetailsData(id, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> consumeImplant(int id) async {
    try {
      final result = await treatmentPlanDataSource.consumeImplant(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TreatmentDetailsEntity>>> getTreatmentDetails(int id) async {
    try {
      final result = await treatmentPlanDataSource.getPatientTreatmentDetails(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveTreatmentPlan(int id, TreatmentPlanEntity data) async {
    try {
      final result = await treatmentPlanDataSource.saveTreatmentPlan(id, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TreatmentItemEntity>>> getTreatmentItems() async {
    try {
      final result = await treatmentPlanDataSource.getTreatmentItems();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
