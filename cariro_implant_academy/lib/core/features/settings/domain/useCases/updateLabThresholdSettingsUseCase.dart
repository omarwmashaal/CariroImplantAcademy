import 'package:dartz/dartz.dart';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/labSizesThresholdEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:get/get.dart';

class UpdateLabThresholdSettingsUseCase extends UseCases<NoParams, UpdateLabThresholdSettingsParams> {
  final SettingsRepository settingsRepository;
  UpdateLabThresholdSettingsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(UpdateLabThresholdSettingsParams params) async {
    params.data.removeWhere((element) => element.size == null || element.size == "");
    List<LabSizesThresholdEntity> distinctParams = params.data.where((x) => x.id != null).toList();
    params.data.forEach((x) {
      if (distinctParams.firstWhereOrNull((element) => element.size?.removeAllWhitespace == x.size?.removeAllWhitespace) == null) {
        distinctParams.add(x);
      }
    });
    params.data = distinctParams;
    return await settingsRepository.updateLabThresholds(params.parentId, params.data).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Threshold Settings: $l"),
          (r) => Right(r),
        ));
  }
}

class UpdateLabThresholdSettingsParams {
  final int parentId;
  List<LabSizesThresholdEntity> data;
  UpdateLabThresholdSettingsParams({
    required this.parentId,
    required this.data,
  });
}
