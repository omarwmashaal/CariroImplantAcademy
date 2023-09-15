import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class GetPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase extends UseCases<ProstheticTreatmentEntity, int> {
  final ProstheticRepository prostheticRepository;

  GetPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, ProstheticTreatmentEntity>> call(int id) async {
    return  await  prostheticRepository.getPatientProstheticTreatmentFinalProthesisSingleBridge(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Single Bridge: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
