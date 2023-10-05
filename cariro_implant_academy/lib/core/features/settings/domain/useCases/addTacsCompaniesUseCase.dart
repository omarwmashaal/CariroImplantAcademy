import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../entities/tacEntity.dart';

class AddTacsCompaniesUseCase extends UseCases<NoParams, List<TacCompanyEntity>> {
  final SettingsRepository settingsRepository;

  AddTacsCompaniesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<TacCompanyEntity> value) async {
    return await settingsRepository.addTacsCompanies(value).then((value) => value.fold(
          (l) => Left(l..message = "Add Tacs Companies: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

