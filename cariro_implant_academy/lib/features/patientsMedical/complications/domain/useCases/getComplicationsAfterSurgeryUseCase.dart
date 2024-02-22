import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/repositories/complicationsRepository.dart';
import 'package:dartz/dartz.dart';

class GetComplicationsAfterSurgeryUseCase extends UseCases<List<ComplicationsAfterSurgeryEntity>, int> {
  final ComplicationsRepo complicationsRepo;

  GetComplicationsAfterSurgeryUseCase({required this.complicationsRepo});

  @override
  Future<Either<Failure, List<ComplicationsAfterSurgeryEntity>>> call(int id) async {
    return await complicationsRepo.getComplicationsAfterSurgery(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Complications After Surgery: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
