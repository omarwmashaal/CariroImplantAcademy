import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/settingsDatasource.dart';

class SettingsRepoImpl implements SettingsRepository{
  final SettingsDatasource settingsDatasource;
  SettingsRepoImpl({required this.settingsDatasource});
  @override
  Future<Either<Failure, TreatmentPricesEntity>> getTreatmentPrices()  async {
    try {
      final result = await settingsDatasource.getTreatmentPrices();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}