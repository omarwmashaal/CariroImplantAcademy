import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/toDoListDatasource.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/toDoListRepo.dart';
import 'package:dartz/dartz.dart';

class ToDoListRepoImpl implements ToDoListRepo {
  final ToDoListDatasource toDoListDatasource;
  ToDoListRepoImpl({required this.toDoListDatasource});
  @override
  Future<Either<Failure, NoParams>> addToDoListItem(ToDoListEntity toDoListItem) async {
    try {
      final result = await toDoListDatasource.addToDoListItem(toDoListItem);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ToDoListEntity>>> getToDoLists(int? patientId) async {
    try {
      final result = await toDoListDatasource.getToDoLists(patientId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateToDoListItem(ToDoListEntity toDoListItem, bool delete) async {
    try {
      final result = await toDoListDatasource.updateToDoListItem(toDoListItem, delete);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ToDoListEntity>>> searchToDoLists(params) async {
    try {
      final result = await toDoListDatasource.searchToDoLists(params);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
