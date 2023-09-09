import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failure.dart';

abstract class SettingsRepository{
  Future<Either<Failure,TreatmentPricesEntity>> getTreatmentPrices();
}