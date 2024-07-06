import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/data/models/toDoListModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/searchToDoListUseCase%20.dart';
import 'package:dartz/dartz.dart';

abstract class ToDoListRepo {
  Future<Either<Failure, List<ToDoListEntity>>> getToDoLists(int? patientId);
  Future<Either<Failure, List<ToDoListEntity>>> searchToDoLists(SearchToDoListParams params);
  Future<Either<Failure, NoParams>> updateToDoListItem(ToDoListEntity toDoListItem, bool delete);
  Future<Either<Failure, NoParams>> addToDoListItem(ToDoListEntity toDoListItem);
}
