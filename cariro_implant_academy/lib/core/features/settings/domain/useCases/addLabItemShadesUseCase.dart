import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemShadeEntity.dart';
import 'package:dartz/dartz.dart';

class UpdateLabItemsShadesUseCase extends UseCases<NoParams, List<LabItemShadeEntity>> {
  final SettingsRepository settingsRepository;

  UpdateLabItemsShadesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<LabItemShadeEntity> params) async {
    return await settingsRepository.updateLabItemsShades(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Items Shades:"),
          (r) => Right(r),
        ));
  }
}


