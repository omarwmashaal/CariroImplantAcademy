import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneCompanyEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetMembranesUseCase extends LoadingUseCases<int> {
  final SettingsRepository settingsRepository;

  GetMembranesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<MembraneEntity>>> call(int id) async {
    return await settingsRepository.getMembranes(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Membranes: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
