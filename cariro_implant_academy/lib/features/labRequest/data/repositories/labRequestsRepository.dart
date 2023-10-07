import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/data/datasource/labRequestDatasource.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labStepEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getAllRequestsUseCase.dart';
import 'package:dartz/dartz.dart';

class LabRequestRepoImpl implements LabRequestRepository{
  final LabRequestDatasource labRequestDatasource;
  LabRequestRepoImpl({required this.labRequestDatasource});
  @override
  Future<Either<Failure, NoParams>> addOrUpdateRequestReceipt(int id, List<LabStepEntity> steps)  async {
    try {
      final result = await labRequestDatasource.addOrUpdateRequestReceipt(id,steps);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addRequest(LabRequestEntity model)   async {
    try {
      final result = await labRequestDatasource.addRequest(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addToMyTasks(int id)  async {
    try {
      final result = await labRequestDatasource.addToMyTasks(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> assignTaskToTechnician(int id, int technicianId)   async {
    try {
      final result = await labRequestDatasource.assignTaskToTechnician(id,technicianId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }



  @override
  Future<Either<Failure, NoParams>> finishTask(int id, int? nextTaskId, int? assignToId, String? notes)   async {
    try {
      final result = await labRequestDatasource.finishTask(id,nextTaskId,assignToId,notes,);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LabRequestEntity>>> getAllLabRequests(GetAllRequestsParams params)   async {
    try {
      final result = await labRequestDatasource.getAllLabRequests(params);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, BasicNameIdObjectEntity>> getDefaultStepByName(String name)   async {
    try {
      final result = await labRequestDatasource.getDefaultStepByName(name);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getDefaultSteps()   async {
    try {
      final result = await labRequestDatasource.getDefaultSteps();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, LabRequestEntity>> getLabRequest(int id)   async {
    try {
      final result = await labRequestDatasource.getLabRequest(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LabRequestEntity>>> getPatientLabRequests(int id)   async {
    try {
      final result = await labRequestDatasource.getPatientLabRequests(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> markRequestAsDone(int id, String? notes)   async {
    try {
      final result = await labRequestDatasource.markRequestAsDone(id,notes);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> payForRequest(int id)   async {
    try {
      final result = await labRequestDatasource.payForRequest(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}