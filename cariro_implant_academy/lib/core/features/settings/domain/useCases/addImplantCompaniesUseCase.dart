import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class AddImplantCompaniesUseCase extends UseCases<NoParams, String> {
  final SettingsRepository settingsRepository;

  AddImplantCompaniesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(String value) async {
    return await settingsRepository.addImplantCompanies(value).then((value) => value.fold(
          (l) => Left(l..message = "Add Implant Companies: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
