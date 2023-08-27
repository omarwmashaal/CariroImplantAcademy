import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientVisits/data/datasource/visitsDatasource.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/visitEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/repositories/visitsRepo.dart';
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
  Future<Either<Failure, List<VisitEntity>>> getAllVisits() async{
    try{
      final result = await  visitsDataSource.getAllVisits();
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

}