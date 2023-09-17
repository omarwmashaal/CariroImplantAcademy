import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../usecases/addRangeToMyPatientsUseCase.dart';

abstract class AddOrRemoveMyPatientsRepo {
  Future<Either<Failure,bool>> addToMyPatientsRange(AddRangePatientsParams params);
  Future<Either<Failure,bool>> addToMyPatients(int id);
  Future<Either<Failure,bool>> removeFromMyPatients(int id);

}