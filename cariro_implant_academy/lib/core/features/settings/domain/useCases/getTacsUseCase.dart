import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetTacsUseCase extends LoadingUseCases {
  final SettingsRepository settingsRepository;
  GetTacsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, List<TacCompanyEntity>>> call(NoParams) async {
    return await settingsRepository.getTacs().then((value) => value.fold(
          (l) => Left(l..message = "Get Tacs: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
