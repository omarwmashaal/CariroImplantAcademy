import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class CheckLabRequestsUseCase extends UseCases<NoParams, int> {
  final LabRequestRepository labRequestRepository;

  CheckLabRequestsUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(int patientId) async {
    return await labRequestRepository.checkLabRequests(patientId).then((value) => value.fold(
          (l) => Left(l..message = "Check Lab Requests: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
