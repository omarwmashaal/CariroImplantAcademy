import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchResonseEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:dartz/dartz.dart';

import '../entities/advancedPatientSearchEntity.dart';
import '../entities/advancedTreatmentSearchEntity.dart';
import '../entities/patientInfoEntity.dart';
import '../usecases/patientSearchUseCase.dart';

abstract class PatientInfoRepo {
  Future<Either<Failure, List<PatientInfoEntity>>> searchPatients(PatientSearchParams params);
  Future<Either<Failure, PatientInfoEntity>> getPatient(int id);
  Future<Either<Failure, PatientInfoEntity>> createPatient(PatientInfoEntity patient);
  Future<Either<Failure, PatientInfoEntity>> updatePatientData(PatientInfoEntity patient);
  Future<Either<Failure, int>> getNextAvailableId();
  Future<Either<Failure, bool>> checkDuplicateId(String id);
  Future<Either<Failure, NoParams>> setPatientOut(int id, String outReason);
  Future<Either<Failure, String?>> compareDuplicateNumber(String number);
  Future<Either<Failure, List<AdvancedPatientSearchEntity>>> advancedSearchPatients(AdvancedPatientSearchEntity params);
  Future<Either<Failure, List<AdvancedTreatmentSearchEntity>>> advancedTreatmentSearch(AdvancedTreatmentSearchEntity params);
  Future<Either<Failure, List<AdvancedProstheticSearchResponseEntity>>> advancedProstheticSearch(AdvancedProstheticSearchRequestEntity query);
}
