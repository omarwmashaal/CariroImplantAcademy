import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../domain/entities/BasicNameIdObjectEntity.dart';
import '../domain/useCases/loadUsersUseCase.dart';
abstract class UseCases<Type,Params> {
  Future<Either<Failure,Type>> call(Params params);
}
abstract class LoadingUseCases<T> {
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> call(T params);
}
class NoParams extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class LoadParams<T extends Enum> {
  final T type;
  final String query;

  LoadParams({required this.type, required this.query});
}
