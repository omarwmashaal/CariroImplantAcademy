import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/saveNonSurgicalTreatmentUseCase.dart';
import 'package:dartz/dartz.dart';
import '../../../treatmentFeature/domain/entities/teethTreatmentPlan.dart';

abstract class NonSurgicalTreatmentRepo{
  Future<Either<Failure,NonSurgicalTreatmentEntity>> getNonSurgicalTreatment(int id);
  Future<Either<Failure,List<NonSurgicalTreatmentEntity>>> getAllNonSurgicalTreatments(int id);
  Future<Either<Failure,NoParams>> saveNonSurgicalTreatment(SaveNonSurgicalTreatmentParams data);
  Future<Either<Failure,NoParams>> updateNonSurgicalTreatmentNotes(int id,String notes);
  Future<Either<Failure,List<int>>> checkNonSurgicalTreatmentTeethStatus(String data);
  Future<Either<Failure,TeethTreatmentPlanEntity?>> getPaidPlanItem({required int patientId,required int tooth});
}