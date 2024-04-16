import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class CreateLabRequestUseCase extends UseCases<NoParams, LabRequestEntity> {
  final LabRequestRepository labRequestRepository;

  CreateLabRequestUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(LabRequestEntity params) async {
    if (params.designerId == null)
      params.status = EnumLabRequestStatus.InQueue;
    else
      params.status = EnumLabRequestStatus.InProgress;
    return await labRequestRepository.addRequest(params).then((value) => value.fold(
          (l) => Left(l..message = "Create Lab Request: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
