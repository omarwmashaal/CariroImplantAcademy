import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../entities/authenticationUserEntity.dart';
import '../repositories/authenticationRepo.dart';

class RegisterUserUseCase extends UseCases<NoParams, UserEntity>{
  AuthenticationRepo authenticationRepo;
  RegisterUserUseCase(this.authenticationRepo);
  @override
  Future<Either<Failure,NoParams>> call(params) async{
    if(params.roles?.isEmpty??true)
      {
        return Left(BadRequestFailure(failureMessage: "Role Can't be empty"));
      }
    if(params.roles!=null && (!params.roles!.contains("instructor")) && (!params.roles!.contains("candidate")))
      {
        if((params.email?.isEmpty??true) || !params.email!.contains("@"))
          {
            return Left(BadRequestFailure(failureMessage: "Please write correct email"));
          }
      }
    if(!params.roles!.contains("instructor"))
      {
        if(params.dateOfBirth==null)
          return Left(BadRequestFailure(failureMessage: "Please Date Of Birth"));

      }
    return await authenticationRepo.registerUser(params);
  }

}