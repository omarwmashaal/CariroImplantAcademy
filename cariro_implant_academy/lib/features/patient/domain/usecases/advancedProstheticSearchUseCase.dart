import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchResonseEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import '../repositories/patientInfoRepo.dart';

class AdvancedProstheticSearchUseCase extends UseCases<List<AdvancedProstheticSearchResponseEntity>, AdvancedProstheticSearchRequestEntity> {
  final PatientInfoRepo patientInfoRepo;

  AdvancedProstheticSearchUseCase({required this.patientInfoRepo});

  @override
  Future<Either<Failure, List<AdvancedProstheticSearchResponseEntity>>> call(AdvancedProstheticSearchRequestEntity params) async {
    return await patientInfoRepo.advancedProstheticSearch(params).then((value) => value.fold(
          (l) => Left(l..message = "Advanced Prosthetic Search:${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
