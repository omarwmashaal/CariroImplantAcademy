import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterProsthesisUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterSurgeryUseCase.dart';
import 'package:dartz/dartz.dart';

import '../entities/complicationsAfterProsthesisEntity.dart';

abstract class ComplicationsRepo {
  Future<Either<Failure, List<ComplicationsAfterSurgeryEntity>>> getComplicationsAfterSurgery(int id);
  Future<Either<Failure, List<int>>> getSurgeryTeethForComplications(int id);
  Future<Either<Failure, List<ComplicationsAfterProsthesisEntity>>> getComplicationsAfterProsthesis(int id);
  Future<Either<Failure, NoParams>> updateComplicationsAfterSurgery(UpdateSurgicalComplicationsParams data);
  Future<Either<Failure, NoParams>> updateComplicationsAfterProsthesis(UpdateProstheticComplicationsParams data);
}
