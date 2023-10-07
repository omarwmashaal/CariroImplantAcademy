import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class AssignTaskToTechnicianUseCase extends UseCases<NoParams, AssignTaskToTechnicianParams> {
  final LabRequestRepository labRequestRepository;

  AssignTaskToTechnicianUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(AssignTaskToTechnicianParams params) async {
    return await labRequestRepository.assignTaskToTechnician(params.taskId,params.technicianId).then((value) => value.fold(
          (l) => Left(l..message = "Assign Task to technician: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class AssignTaskToTechnicianParams {
  final int taskId;
  final int technicianId;

  AssignTaskToTechnicianParams({
    required this.taskId,
    required this.technicianId,
  });
}
