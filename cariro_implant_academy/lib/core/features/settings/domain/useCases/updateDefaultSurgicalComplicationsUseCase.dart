import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class UpdateDefaultSurgicalComplicationsUseCase extends UseCases<NoParams,List<BasicNameIdObjectEntity>> {
  final SettingsRepository settingsRepository;
  UpdateDefaultSurgicalComplicationsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return await settingsRepository.updateDefaultSurgicalComplications(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Default Surgical Complications: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
