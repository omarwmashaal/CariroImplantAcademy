import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class AddToMyTasksUseCase extends UseCases<NoParams, int> {
  final LabRequestRepository labRequestRepository;

  AddToMyTasksUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(int params) async {
    return await labRequestRepository.addToMyTasks(params).then((value) => value.fold(
          (l) => Left(l..message = "Add to my tasks: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
