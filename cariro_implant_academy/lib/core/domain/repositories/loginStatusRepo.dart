import 'package:cariro_implant_academy/core/features/authentication/domain/entities/authenticationUserEntity.dart';
import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class CheckLoginStatusRepo{
  Future<Either<Failure,AuthenticationUserEntity>> checkLoginStatus();
}