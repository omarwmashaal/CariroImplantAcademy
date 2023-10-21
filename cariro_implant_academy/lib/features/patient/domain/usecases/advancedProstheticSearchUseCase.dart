import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import '../repositories/patientInfoRepo.dart';

class AdvancedProstheticSearchUseCase extends UseCases<List<ProstheticTreatmentEntity>, AdvancedProstheticSearchParams> {
  final PatientInfoRepo patientInfoRepo;

  AdvancedProstheticSearchUseCase({required this.patientInfoRepo});

  @override
  Future<Either<Failure, List<ProstheticTreatmentEntity>>> call(AdvancedProstheticSearchParams params) async {
    return await patientInfoRepo.advancedProstheticSearch(params.query,params.from,params.to).then((value) => value.fold(
          (l) => Left(l..message = "Advanced Prosthetic Search:${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class AdvancedProstheticSearchParams{
  final ProstheticTreatmentEntity query;
  final DateTime? from;
  final DateTime? to;

  const AdvancedProstheticSearchParams({
    required this.query,
    this.from,
    this.to,
  });
}
