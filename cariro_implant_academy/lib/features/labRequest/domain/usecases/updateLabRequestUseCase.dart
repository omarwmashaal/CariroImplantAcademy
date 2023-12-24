import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class UpdateLabRequestUseCase extends UseCases<NoParams, LabRequestEntity> {
  final LabRequestRepository labRequestRepository;

  UpdateLabRequestUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(LabRequestEntity params) async {
    return await labRequestRepository.updateLabRequest(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Request: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
