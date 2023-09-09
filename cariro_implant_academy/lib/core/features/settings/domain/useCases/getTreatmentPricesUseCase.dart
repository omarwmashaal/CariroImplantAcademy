import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetTreatmentPricesUseCase extends UseCases<TreatmentPricesEntity, NoParams> {
  final SettingsRepository settingsRepository;

  GetTreatmentPricesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, TreatmentPricesEntity>> call(NoParams params) async {
    return await settingsRepository.getTreatmentPrices().then((value) => value.fold(
          (l) => Left(l..message = "Get Treatment Prices: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
