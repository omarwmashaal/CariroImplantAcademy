import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/repositories/complicationsRepository.dart';
import 'package:dartz/dartz.dart';

class UpdateComplicationsAfterProsthesisUseCase extends UseCases<NoParams, UpdateProstheticComplicationsParams> {
  final ComplicationsRepo complicationsRepo;

  UpdateComplicationsAfterProsthesisUseCase({required this.complicationsRepo});

  @override
  Future<Either<Failure, NoParams>> call(UpdateProstheticComplicationsParams data) async {
    return await complicationsRepo.updateComplicationsAfterProsthesis(data).then((value) => value.fold(
          (l) => Left(l..message = "Update Complications After Prosthesis: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class UpdateProstheticComplicationsParams {
  final int id;
  final List<ComplicationsAfterProsthesisEntity> data;
  UpdateProstheticComplicationsParams({
    required this.id,
    required this.data,
  });
}
