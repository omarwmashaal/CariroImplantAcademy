import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labStepEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class GetDefaultStepByNameUseCase extends UseCases<BasicNameIdObjectEntity,String > {
  final LabRequestRepository labRequestRepository;

  GetDefaultStepByNameUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, BasicNameIdObjectEntity>> call(String name) async {
    return await labRequestRepository.getDefaultStepByName(name).then((value) => value.fold(
          (l) => Left(l..message = "Get Default Step By Name: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
