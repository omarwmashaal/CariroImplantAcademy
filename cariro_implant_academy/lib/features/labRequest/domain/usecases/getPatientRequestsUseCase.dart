import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class GetPatientLabRequestsUseCase extends UseCases<List<LabRequestEntity>,int > {
  final LabRequestRepository labRequestRepository;

  GetPatientLabRequestsUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, List<LabRequestEntity>>> call(int id) async {
    return await labRequestRepository.getPatientLabRequests(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Patient Lab Requests: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
