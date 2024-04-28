import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/postSurgicalTreatmentEntity.dart';
import 'package:dartz/dartz.dart';

abstract class PostSurgicalTreatmentRepo {
  Future<Either<Failure, PostSurgicalTreatmentEntity>> getPostSurgicalTreatment(int id);
  Future<Either<Failure, NoParams>> savePostSurgicalTreatment( PostSurgicalTreatmentEntity data);
  Future<Either<Failure, RequestChangeEntity>> addChangeRequest(RequestChangeEntity request);
  Future<Either<Failure, NoParams>> acceptChanges(RequestChangeEntity request);
}
