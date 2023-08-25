import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/data/patients/models/patientSearchResponseModel.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../domain/patients/entities/patientInfoEntity.dart';
import '../../../domain/patients/repositories/patientInfoRepo.dart';
import '../../../domain/patients/usecases/patientSearchUseCase.dart';
import '../dataSrouces/patientSearchDataSource.dart';

class PatientInfoRepoImpl implements PatientInfoRepo {
  PatientSearchDataSource dataSource;

  PatientInfoRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, List<PatientInfoEntity>>> searchPatients(PatientSearchParams params) async {
    try {
      final result = await dataSource.searchPatients(params);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }


  }

  @override
  Future<Either<Failure, PatientInfoEntity>> createPatient(PatientInfoEntity patient)async {
    try{
      final result = await dataSource.createPatient(PatientInfoModel.fromEntity(patient));
      return Right(result);
    }on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, PatientInfoEntity>> getPatient(int id) async {
    try {
      final result = await dataSource.getPatient(id);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, int>> getNextAvailableId() async {
    try {
      final result = await dataSource.getNextAvailableId();
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> checkDuplicateId(int id) async {
    try {
      final result = await dataSource.checkDuplicateId(id);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String?>> compareDuplicateNumber(String number) async{
    try {
      final result = await dataSource.checkDuplicateNumber(number);
      return Right(result);
    }on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
