import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';

class GetLabItemsCompaniesUseCase extends UseCases<List<BasicNameIdObjectEntity>, int> {
  final SettingsRepository settingsRepository;

  GetLabItemsCompaniesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(int id) async {
    return await settingsRepository.getLabItemCompanies(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Companies:"),
          (r) => Right(r),
        ));
  }
}
