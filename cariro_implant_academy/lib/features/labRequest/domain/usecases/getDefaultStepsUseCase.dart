import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labStepEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class GetDefaultStepsUseCase extends LoadingUseCases {
  final LabRequestRepository labRequestRepository;

  GetDefaultStepsUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(params) async {
    return await labRequestRepository.getDefaultSteps().then((value) => value.fold(
          (l) => Left(l..message = "Get Default Steps: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
