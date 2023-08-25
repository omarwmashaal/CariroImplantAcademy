import 'package:cariro_implant_academy/core/domain/repositories/inputValidationRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class InputValidationRepoImpl implements InputValidationRepo{
  @override
  Either<Failure, bool> validateStringToInt(String value) {
    try{
      int.parse(value);
      return Right(true);
    }catch(e){
      return Left(InputValidationFailure(failureMessage: "Invalid input"));
    }
  }

}