import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/authenticationUserEntity.dart';
import '../repositories/authenticationRepo.dart';

class LoginUseCase extends UseCases<AuthenticationUserEntity, LoginParams>{
  AuthenticationRepo authenticationRepo;
  LoginUseCase(this.authenticationRepo);
  @override
  Future<Either<Failure,AuthenticationUserEntity>> call(params) async{
    return await authenticationRepo.login(params);
  }

}
class LoginParams extends Equatable{
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'password': this.password,
    };
  }

}