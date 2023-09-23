import 'package:cariro_implant_academy/domain/authentication/entities/authenticationUserEntity.dart';
import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class CheckLoginStatusRepo{
  Future<Either<Failure,AuthenticationUserEntity>> checkLoginStatus();
}