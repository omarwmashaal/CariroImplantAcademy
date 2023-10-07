import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class FinishTaskUseCase extends UseCases<NoParams, FinishTaskParams> {
  final LabRequestRepository labRequestRepository;

  FinishTaskUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(FinishTaskParams params) async {
    return await labRequestRepository
        .finishTask(
          params.id,
          params.nextTaskId,
          params.assignToId,
          params.notes,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Finish Task: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class FinishTaskParams {
  final int id;
  final int? nextTaskId;
  final int? assignToId;
  final String? notes;

  FinishTaskParams({
    this.nextTaskId,
    required this.id,
    this.notes = "",
    this.assignToId,
  });
}
