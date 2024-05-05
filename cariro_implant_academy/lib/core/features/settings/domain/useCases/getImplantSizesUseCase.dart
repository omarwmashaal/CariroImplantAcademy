import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetImplantSizesUseCase extends LoadingUseCases<int> {
  final SettingsRepository settingsRepository;

  GetImplantSizesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<ImplantEntity>>> call(int id) async {
    return await settingsRepository.getImplants(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Implants: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
