import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class UpdateDefaultProstheticComplicationsUseCase extends UseCases<NoParams, List<BasicNameIdObjectEntity>> {
  final SettingsRepository settingsRepository;
  UpdateDefaultProstheticComplicationsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return await settingsRepository.updateDefaultProstheticComplications(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Default Prosthetic Complications: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
