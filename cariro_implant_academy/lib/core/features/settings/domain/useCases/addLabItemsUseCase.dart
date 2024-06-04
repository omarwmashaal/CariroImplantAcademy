import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

class UpdateLabItemsUseCase extends UseCases<NoParams, List<LabItemEntity>> {
  final SettingsRepository settingsRepository;

  UpdateLabItemsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<LabItemEntity> params) async {
    return await settingsRepository.updateLabItems(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Items:"),
          (r) => Right(r),
        ));
  }
}
