import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:dartz/dartz.dart';

import 'addImplantsUseCase.dart';

class EditTreatmentPricesUseCase extends UseCases<NoParams, List<TreatmentItemEntity>> {
  final SettingsRepository settingsRepository;

  EditTreatmentPricesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<TreatmentItemEntity> value) async {
    return await settingsRepository.editTreatmentPrices(value).then((value) => value.fold(
          (l) => Left(l..message = "Edit Treatment Prices: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
