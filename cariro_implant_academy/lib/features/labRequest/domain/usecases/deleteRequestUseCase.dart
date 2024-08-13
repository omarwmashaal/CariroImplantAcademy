import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class DeleteLabRequestUseCase extends UseCases<NoParams, int> {
  final LabRequestRepository labRequestRepository;

  DeleteLabRequestUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(int id) async {
    return await labRequestRepository.deleteLabRequest(id).then((value) => value.fold(
          (l) => Left(l..message = "Delete Lab Request: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
