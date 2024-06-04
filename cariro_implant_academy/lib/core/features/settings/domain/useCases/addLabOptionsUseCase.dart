import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labOptionEntity.dart';
import 'package:dartz/dartz.dart';

class UpdateLabOptionsUseCase extends UseCases<NoParams, List<LabOptionEntity>> {
  final SettingsRepository settingsRepository;

  UpdateLabOptionsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<LabOptionEntity> params) async {
    params.removeWhere((element) =>( element.name?.isEmpty ?? true) || element.labItemParentId==null);
    return await settingsRepository.updateLabOptions(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Options:"),
          (r) => Right(r),
        ));
  }
}
