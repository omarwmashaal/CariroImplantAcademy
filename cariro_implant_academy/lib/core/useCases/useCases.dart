import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
abstract class UseCases<Type,Params> {
  Future<Either<Failure,Type>> call(Params params);
}
class NoParams extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

