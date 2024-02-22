import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/repositories/complicationsRepository.dart';
import 'package:dartz/dartz.dart';

class GetComplicationsAfterProsthesisUseCase extends UseCases<List<ComplicationsAfterProsthesisEntity>, int> {
  final ComplicationsRepo complicationsRepo;

  GetComplicationsAfterProsthesisUseCase({required this.complicationsRepo});

  @override
  Future<Either<Failure, List<ComplicationsAfterProsthesisEntity>>> call(int id) async {
    return await complicationsRepo.getComplicationsAfterProsthesis(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Prosthesis After Prosthesis: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
