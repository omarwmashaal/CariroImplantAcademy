import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/visitsDatasource.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class VisitsRepoImpl implements VisitsRepo{
  final VisitsDataSource visitsDataSource;
  VisitsRepoImpl({required this.visitsDataSource});
  @override
  Future<Either<Failure, List<VisitEntity>>> getAllSchedules(int month) async{
    try{
      final result = await  visitsDataSource.getAllSchedules(month);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<VisitEntity>>> getAllVisits(String? search) async{
    try{
      final result = await  visitsDataSource.getAllVisits(search);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<VisitEntity>>> getMySchedules(int month)async{
    try{
      final result = await  visitsDataSource.getMySchedules(month);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<VisitEntity>>> getPatientVisits(int patientId) async{
    try{
      final result = await  visitsDataSource.getPatientVisits(patientId);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> scheduleNewVisit(VisitEntity newVisit) async{
    try{
      final result = await  visitsDataSource.scheduleNewVisit(newVisit);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> patientEntersClinic(int patientId) async{
    try{
      final result = await  visitsDataSource.patientEntersClinic(patientId);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> patientLeavesClinic(int patientId) async{
    try{
      final result = await  visitsDataSource.patientLeavesClinic(patientId);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> patientVisits(int patientId) async{
    try{
      final result = await  visitsDataSource.patientVisits(patientId);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}