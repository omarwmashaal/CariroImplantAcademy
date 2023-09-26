import 'package:cariro_implant_academy/core/error/failure.dart';import 'package:dartz/dartz.dart';

import '../entities/patientInfoEntity.dart';
import '../usecases/patientSearchUseCase.dart';

abstract class PatientInfoRepo{
  Future<Either<Failure,List<PatientInfoEntity>>> searchPatients(PatientSearchParams params);
  Future<Either<Failure,PatientInfoEntity>> getPatient(int id);
  Future<Either<Failure,PatientInfoEntity>> createPatient(PatientInfoEntity patient);
  Future<Either<Failure,PatientInfoEntity>> updatePatientData(PatientInfoEntity patient);
  Future<Either<Failure,int>> getNextAvailableId();
  Future<Either<Failure,bool>> checkDuplicateId(int id);
  Future<Either<Failure,String?>> compareDuplicateNumber(String number);

}