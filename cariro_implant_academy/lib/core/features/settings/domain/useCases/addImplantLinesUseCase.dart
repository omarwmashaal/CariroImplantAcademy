import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class AddImplantLinesUseCase extends UseCases<NoParams, BasicNameIdObjectEntity> {
  final SettingsRepository settingsRepository;

  AddImplantLinesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(BasicNameIdObjectEntity value) async {
    return await settingsRepository.addImplantLines(value).then((value) => value.fold(
          (l) => Left(l..message = "Add Implant Lines: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
