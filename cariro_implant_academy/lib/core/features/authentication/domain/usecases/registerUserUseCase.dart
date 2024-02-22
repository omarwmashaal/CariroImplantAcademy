import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../entities/authenticationUserEntity.dart';
import '../repositories/authenticationRepo.dart';

class RegisterUserUseCase extends UseCases<UserEntity, UserEntity>{
  AuthenticationRepo authenticationRepo;
  RegisterUserUseCase(this.authenticationRepo);
  @override
  Future<Either<Failure,UserEntity>> call(params) async{

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
    if(params.roles!.contains("candidate"))
      {
        if((params.facebookLink?.isNotEmpty??false) && ( !Uri.parse(params.facebookLink!).isAbsolute ||!(params.facebookLink!.toLowerCase().contains("fb.com/") ||params.facebookLink!.toLowerCase().contains("facebook.com/") )))
          {
            return Left(BadRequestFailure(failureMessage: "Please write correct Facebook Link, the link must start with \"http://\" or \"https://\" and contains \"facebook.com\" or \"fb.com\"!"));
          }
        else if((params.instagramLink?.isNotEmpty??false) && ( !Uri.parse(params.instagramLink!).isAbsolute ||!(params.instagramLink!.toLowerCase().contains("instagram.com/") )))
          {
            return Left(BadRequestFailure(failureMessage: "Please write correct Instagram Link, the link must start with \"http://\" or \"https://\" and contains \"instagram.com\"!"));
          }
      }
    /*if(!params.roles!.contains("instructor"))
      {
        if(params.dateOfBirth==null)
          return Left(BadRequestFailure(failureMessage: "Please Date Of Birth"));

      }*/
    return await authenticationRepo.registerUser(params);
  }

}