import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class GetLabRequestUseCase extends UseCases<LabRequestEntity,int > {
  final LabRequestRepository labRequestRepository;

  GetLabRequestUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, LabRequestEntity>> call(int id) async {
    return await labRequestRepository.getLabRequest(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Request: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
