import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/data/models/patientSearchResponseModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/exception.dart';
import '../../domain/entities/advancedPatientSearchEntity.dart';
import '../../domain/entities/patientInfoEntity.dart';
import '../../domain/repositories/patientInfoRepo.dart';
import '../../domain/usecases/patientSearchUseCase.dart';
import '../datasources/patientSearchDataSource.dart';

class PatientInfoRepoImpl implements PatientInfoRepo {
  PatientSearchDataSource dataSource;

  PatientInfoRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, List<PatientInfoEntity>>> searchPatients(PatientSearchParams params) async {
    try {
      final result = await dataSource.searchPatients(params);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, PatientInfoEntity>> createPatient(PatientInfoEntity patient) async {
    try {
      final result = await dataSource.createPatient(patient);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, PatientInfoEntity>> getPatient(int id) async {
    try {
      final result = await dataSource.getPatient(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, int>> getNextAvailableId() async {
    try {
      final result = await dataSource.getNextAvailableId();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> checkDuplicateId(int id) async {
    try {
      final result = await dataSource.checkDuplicateId(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String?>> compareDuplicateNumber(String number) async {
    try {
      final result = await dataSource.checkDuplicateNumber(number);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, PatientInfoEntity>> updatePatientData(PatientInfoEntity patient) async {
    try {
      final result = await dataSource.updatePatientData(patient);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<AdvancedPatientSearchEntity>>> advancedSearchPatients(AdvancedPatientSearchEntity params) async {
    try {
      final result = await dataSource.advancedSearchPatients(params);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<AdvancedTreatmentSearchEntity>>> advancedTreatmentSearch(AdvancedTreatmentSearchEntity params) async {
    try {
      final result = await dataSource.advancedTreatmentSearch(params);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ProstheticTreatmentEntity>>> advancedProstheticSearch(ProstheticTreatmentEntity query,DateTime? from, DateTime? to) async {
    try {
      final result = await dataSource.advancedProstheticSearch(query,from,to);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
  @override
  Future<Either<Failure, NoParams>> setPatientOut(int id,String outReason) async {
    try {
      final result = await dataSource.setPatientOut(id,outReason);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
