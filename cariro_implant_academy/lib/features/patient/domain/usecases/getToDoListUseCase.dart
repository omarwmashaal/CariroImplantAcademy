import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/toDoListRepo.dart';
import 'package:dartz/dartz.dart';

class GetToDoListUseCase extends UseCases<List<ToDoListEntity>, int?> {
  ToDoListRepo toDoListRepo;

  GetToDoListUseCase(this.toDoListRepo);

  @override
  Future<Either<Failure, List<ToDoListEntity>>> call(params) async {
    return toDoListRepo.getToDoLists(params).then((value) => value.fold(
          (l) => Left(l..message = "Get ToDoList UseCase: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
