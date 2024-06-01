import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemCompanyEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';

class UpdateLabItemsCompaniesUseCase extends UseCases<NoParams, List<LabItemCompanyEntity>> {
  final SettingsRepository settingsRepository;

  UpdateLabItemsCompaniesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<LabItemCompanyEntity> params) async {
    return await settingsRepository.updateLabItemsCompanies(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Items Companies:"),
          (r) => Right(r),
        ));
  }
}
