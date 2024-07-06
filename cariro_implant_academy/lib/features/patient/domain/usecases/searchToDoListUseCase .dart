import 'package:dartz/dartz.dart';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/toDoListRepo.dart';

class SearchToDoListUseCase extends UseCases<List<ToDoListEntity>, SearchToDoListParams> {
  ToDoListRepo toDoListRepo;

  SearchToDoListUseCase(this.toDoListRepo);

  @override
  Future<Either<Failure, List<ToDoListEntity>>> call(params) async {
    return toDoListRepo.searchToDoLists(params).then((value) => value.fold(
          (l) => Left(l..message = "Get ToDoList UseCase: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class SearchToDoListParams {
  String? search;
  bool? overdue;
  bool? done;
  SearchToDoListParams({
    this.search,
    this.overdue,
    this.done,
  });
}
