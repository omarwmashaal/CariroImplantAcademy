import 'package:dartz/dartz.dart';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/repositories/complicationsRepository.dart';

class UpdateComplicationsAfterSurgeryUseCase extends UseCases<NoParams, UpdateSurgicalComplicationsParams> {
  final ComplicationsRepo complicationsRepo;

  UpdateComplicationsAfterSurgeryUseCase({required this.complicationsRepo});

  @override
  Future<Either<Failure, NoParams>> call(UpdateSurgicalComplicationsParams data) async {
    return await complicationsRepo.updateComplicationsAfterSurgery(data).then((value) => value.fold(
          (l) => Left(l..message = "Update Complications After Surgery: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class UpdateSurgicalComplicationsParams {
  final int id;
  final List<ComplicationsAfterSurgeryEntity> data;
  UpdateSurgicalComplicationsParams({
    required this.id,
    required this.data,
  });
}
