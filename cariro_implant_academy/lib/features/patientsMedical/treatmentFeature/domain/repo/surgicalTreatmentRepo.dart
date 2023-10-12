import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/surgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:dartz/dartz.dart';

abstract class SurgicalTreatmentRepo {
  Future<Either<Failure,SurgicalTreatmentEntity>> getSurgicalTreatment(int id);
  Future<Either<Failure,NoParams>> saveSurgicalTreatment(int id,SurgicalTreatmentEntity data);
  Future<Either<Failure,RequestChangeEntity>> addChangeRequest(RequestChangeEntity request);
  Future<Either<Failure,NoParams>> acceptChanges(RequestChangeEntity request);
}