import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/saveNonSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:dartz/dartz.dart';

abstract class NonSurgicalTreatmentRepo{
  Future<Either<Failure,NonSurgicalTreatmentEntity>> getNonSurgicalTreatment(int id);
  Future<Either<Failure,List<NonSurgicalTreatmentEntity>>> getAllNonSurgicalTreatments(int id);
  Future<Either<Failure,NoParams>> saveNonSurgicalTreatment(SaveNonSurgicalTreatmentParams data);
  Future<Either<Failure,List<int>>> checkNonSurgicalTreatmentTeethStatus(String data);
  Future<Either<Failure,List<TreatmentDetailsEntity>>> getPaidPlanItem({required int patientId,required int tooth});
}