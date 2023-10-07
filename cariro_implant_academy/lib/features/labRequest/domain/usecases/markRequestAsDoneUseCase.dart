import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class MarkRequestAsDoneUseCase extends UseCases<NoParams, MarkRequestAsDoneParams> {
  final LabRequestRepository labRequestRepository;

  MarkRequestAsDoneUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(MarkRequestAsDoneParams params) async {
    return await labRequestRepository.markRequestAsDone(params.requestId,params.notes).then((value) => value.fold(
          (l) => Left(l..message = "Mark Request As Done: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class MarkRequestAsDoneParams {
  final int requestId;
  final String? notes;

  MarkRequestAsDoneParams({
    required this.requestId,
    this.notes,
  });
}
