import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/authenticationUserEntity.dart';
import '../repositories/authenticationRepo.dart';

class RegisterUserUseCase extends UseCases<NoParams, UserEntity>{
  AuthenticationRepo authenticationRepo;
  RegisterUserUseCase(this.authenticationRepo);
  @override
  Future<Either<Failure,NoParams>> call(params) async{
    return await authenticationRepo.registerUser(params);
  }

}