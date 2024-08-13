import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/labSizesThresholdEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetLabThresholdSettingsUseCase extends UseCases<List<LabSizesThresholdEntity>, int> {
  final SettingsRepository settingsRepository;
  GetLabThresholdSettingsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, List<LabSizesThresholdEntity>>> call(int parentId) async {
    return await settingsRepository.getLabThresholds(parentId).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Threshold Settings: $l"),
          (r) => Right(r),
        ));
  }
}
