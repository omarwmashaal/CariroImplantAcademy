import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/labPricesForDoctorEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';

class UpdateLabOptionsPriceListUseCase extends UseCases<NoParams, List<LabPriceForDoctorEntity>> {
  final SettingsRepository settingsRepository;

  UpdateLabOptionsPriceListUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<LabPriceForDoctorEntity> params) async {
    return await settingsRepository.updateLabOptionsDoctorPriceList(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Options Price List: $l"),
          (r) => Right(r),
        ));
  }
}
