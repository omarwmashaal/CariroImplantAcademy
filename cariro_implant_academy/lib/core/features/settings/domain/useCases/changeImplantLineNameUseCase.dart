import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class ChangeImplantLineNameUseCase extends UseCases<NoParams, BasicNameIdObjectEntity> {
  final SettingsRepository settingsRepository;

  ChangeImplantLineNameUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(BasicNameIdObjectEntity value) async {
    return await settingsRepository.changeImplantLineName(value).then((value) => value.fold(
          (l) => Left(l..message = "Change Implant Line Name: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
