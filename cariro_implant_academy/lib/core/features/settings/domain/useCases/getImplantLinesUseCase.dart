import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetImplantLinesUseCase extends LoadingUseCases<int> {
  final SettingsRepository settingsRepository;

  GetImplantLinesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(int companyId) async {
    return await settingsRepository.getImplantLines(companyId).then((value) => value.fold(
          (l) => Left(l..message = "Get Implant Lines: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
