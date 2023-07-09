import 'package:cariro_implant_academy/domain/authentication/entities/UserEntity.dart';
import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class CheckLoginStatusRepo{
  Future<Either<Failure,UserEntity>> checkLoginStatus();
}