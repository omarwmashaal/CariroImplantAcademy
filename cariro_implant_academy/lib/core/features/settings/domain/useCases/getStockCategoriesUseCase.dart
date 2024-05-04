import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../../../../constants/enums/enums.dart';

class GetStockCategoriesUseCase extends LoadingUseCases<Website> {
  final SettingsRepository settingsRepository;

  GetStockCategoriesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(params) async {
    return await settingsRepository.getStockCategories(params).then((value) => value.fold(
          (l) => Left(l..message = "Get Stock Categories: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
