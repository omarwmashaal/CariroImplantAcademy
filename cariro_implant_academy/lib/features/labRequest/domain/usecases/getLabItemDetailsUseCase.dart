import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/useCases/useCases.dart';

class GetLabItemDetailsUseCase extends UseCases<LabItemEntity, int> {
  final LabRequestRepository labRequestRepository;

  GetLabItemDetailsUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, LabItemEntity>> call(int id) async {
    return await labRequestRepository.getLabItemDetails(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Item Details: $l"),
          (r) => Right(r),
        ));
  }
}
