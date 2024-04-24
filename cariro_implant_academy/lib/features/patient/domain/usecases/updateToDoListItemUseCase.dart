import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/toDoListRepo.dart';
import 'package:dartz/dartz.dart';


class UpdateToDoListItemUseCase extends UseCases<NoParams, UpdateToDoListItemParams> {
  ToDoListRepo toDoListRepo;

  UpdateToDoListItemUseCase(this.toDoListRepo);

  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return toDoListRepo.updateToDoListItem(params.toDoListEntity,params.delete).then((value) => value.fold(
          (l) => Left(l..message = "Update ToDoListItem UseCase: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class UpdateToDoListItemParams {
  final ToDoListEntity toDoListEntity;
  final bool delete;
  UpdateToDoListItemParams({required this.toDoListEntity, this.delete = false});
}
