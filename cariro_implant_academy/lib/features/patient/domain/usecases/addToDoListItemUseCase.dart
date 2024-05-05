import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/toDoListRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';

class AddToDoListItemUseCase extends UseCases<NoParams, ToDoListEntity> {
  ToDoListRepo toDoListRepo;

  AddToDoListItemUseCase(this.toDoListRepo);

  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return toDoListRepo.addToDoListItem(params).then((value) => value.fold(
          (l) => Left(l..message = "Add ToDoListItem UseCase: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
