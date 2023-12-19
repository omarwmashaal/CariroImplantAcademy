import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

class UpdateLabItemsUseCase extends UseCases<NoParams, UpdateLabItemsParams> {
  final SettingsRepository settingsRepository;

  UpdateLabItemsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(UpdateLabItemsParams params) async {
    params.data.removeWhere((element) => element.isNull());
    return await settingsRepository.updateLabItems(params.shadeId, params.data).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Items:"),
          (r) => Right(r),
        ));
  }
}

class UpdateLabItemsParams {
  final int shadeId;
  final List<LabItemEntity> data;

  UpdateLabItemsParams({required this.shadeId, required this.data});
}
