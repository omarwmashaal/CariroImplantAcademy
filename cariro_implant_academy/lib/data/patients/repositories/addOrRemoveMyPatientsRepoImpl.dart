import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';


import 'package:dartz/dartz.dart';

import '../../../domain/patients/repositories/addOrRemoveMyPatientsRangeRepo.dart';
import '../../../domain/patients/usecases/addRangeToMyPatientsUseCase.dart';
import '../dataSrouces/addOrRemoveMyPatientsDataSource.dart';


class AddOrRemoveMyPatientsRepoImpl implements AddOrRemoveMyPatientsRepo{
  final AddOrRemoveMyPatientsDataSource dataSource;
  AddOrRemoveMyPatientsRepoImpl(this.dataSource);
  @override
  Future<Either<Failure, bool>> addToMyPatientsRange(AddRangePatientsParams params) async{
    try {
      final result = await dataSource.addToMyPatientsRange(params);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }

  }

  @override
  Future<Either<Failure, bool>> addToMyPatients(int id) async{
    try {
      final result = await dataSource.addToMyPatients(id);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> removeFromMyPatients(int id) {
    // TODO: implement removeFromMyPatients
    throw UnimplementedError();
  }

}