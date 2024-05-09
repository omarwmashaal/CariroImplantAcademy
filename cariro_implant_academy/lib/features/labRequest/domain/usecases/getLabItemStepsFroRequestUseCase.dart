import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/data/repositories/labRequestsRepository.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labstepItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class GetLabItemStepsFroRequestUseCase extends UseCases<List<LabStepItemEntity>, int> {
  final LabRequestRepository labRequestRepo;
  GetLabItemStepsFroRequestUseCase({required this.labRequestRepo});
  @override
  Future<Either<Failure, List<LabStepItemEntity>>> call(int id) async {
    return await labRequestRepo.getLabItemStepsFroRequest(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Request Steps: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
