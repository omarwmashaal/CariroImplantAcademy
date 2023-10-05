import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/authenticationUserEntity.dart';
import '../repositories/authenticationRepo.dart';

class ResetPasswordForUserUseCase extends UseCases<NoParams, int>{
  AuthenticationRepo authenticationRepo;
  ResetPasswordForUserUseCase(this.authenticationRepo);
  @override
  Future<Either<Failure,NoParams>> call(params) async{
    return await authenticationRepo.resetPasswordForUser(params);
  }

}